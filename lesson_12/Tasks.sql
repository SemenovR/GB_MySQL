# 1. Проверить, исправить при необходимости и оптимизировать следующий запрос:

SELECT CONCAT(u.firstname, ' ', u.lastname) AS user, 
       COUNT(l.id) + COUNT(m.id) + COUNT(t.id) AS overall_activity
  FROM users AS u
       LEFT JOIN likes AS l
         ON l.user_id = u.id
       LEFT JOIN media AS m
         ON m.user_id = u.id
       LEFT JOIN messages AS t
         ON t.from_user_id = u.id
 GROUP BY u.id
 ORDER BY overall_activity
 LIMIT 10;

# Запрос работает неправильно. 
# Во-первых таблицу messages заменил на posts.
# Во-вторых не учитвается что несколько JOIN будут создавать дублирование записей, 
# поэтому добавил DISTINCT в COUNT.

SELECT CONCAT(u.firstname, ' ', u.lastname) AS user, 
       COUNT(DISTINCT l.id) + COUNT(DISTINCT m.id) + COUNT(DISTINCT p.id) AS overall_activity
  FROM users AS u
       LEFT JOIN likes AS l
         ON l.user_id = u.id
       LEFT JOIN media AS m
         ON m.user_id = u.id
       LEFT JOIN posts AS p
         ON p.user_id = u.id
 GROUP BY u.id
 ORDER BY overall_activity
 LIMIT 10;

# У меня сразу получился хороший план, т.к. все индексы были до этого созданы.
# По таблице users используется Full Index Scan по Primary Key, но по-другому 
# не получится т.к. нам в любом случае нужно перебрать всех пользователей, чтобы 
# посчитать активность.

EXPLAIN
SELECT CONCAT(u.firstname, ' ', u.lastname) AS user, 
       COUNT(DISTINCT l.id) + COUNT(DISTINCT m.id) + COUNT(DISTINCT p.id) AS overall_activity
  FROM users AS u
       LEFT JOIN likes AS l
         ON l.user_id = u.id
       LEFT JOIN media AS m
         ON m.user_id = u.id
       LEFT JOIN posts AS p
         ON p.user_id = u.id
 GROUP BY u.id
 ORDER BY overall_activity
 LIMIT 10;

*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: u
   partitions: NULL
         type: index
possible_keys: PRIMARY,email,phone,users_lastname_firstname_idx
          key: PRIMARY
      key_len: 4
          ref: NULL
         rows: 1000
     filtered: 100.00
        Extra: Using temporary; Using filesort
*************************** 2. row ***************************
           id: 1
  select_type: SIMPLE
        table: l
   partitions: NULL
         type: ref
possible_keys: likes_user_id_like_type_id_item_id_idx,likes_user_id_idx
          key: likes_user_id_idx
      key_len: 4
          ref: vk.u.id
         rows: 1
     filtered: 100.00
        Extra: Using index
*************************** 3. row ***************************
           id: 1
  select_type: SIMPLE
        table: m
   partitions: NULL
         type: ref
possible_keys: media_user_id_fk
          key: media_user_id_fk
      key_len: 4
          ref: vk.u.id
         rows: 2
     filtered: 100.00
        Extra: Using index
*************************** 4. row ***************************
           id: 1
  select_type: SIMPLE
        table: p
   partitions: NULL
         type: ref
possible_keys: posts_user_id_fk
          key: posts_user_id_fk
      key_len: 4
          ref: vk.u.id
         rows: 2
     filtered: 100.00
        Extra: Using index
4 rows in set, 1 warning (0,00 sec)


# 2. (по желанию) Попытаться улучшить результат оптимизации примера, 
# который рассмотрен на занятии

# У меня уже был индекс по likes_item_id_like_type_id_idx по таблице likes, 
# поэтому в плане для таблицы users используется этот индекс через Full Index Scan
# (см. plan_1.jpg). Что теоретически должно положительно сказаться на выборке.

# Но если отключить индексы по likes и привести к тому же плану что был на занятии (см. plan_2.jpg),
# то окажется что в количественном выражении вариант с Full Table Scan ничем не отличается
# от варианта с Full Index Scan.

# Тогда я решил кардинально изменить запрос:

SELECT COUNT(*) 
  FROM (
    SELECT l.id
        FROM likes AS l
             INNER JOIN media AS m ON m.id = l.item_id
             INNER JOIN ( 
               SELECT user_id 
                 FROM profiles  
                 ORDER BY birthday DESC
                 LIMIT 10 
             ) AS f ON f.user_id = m.user_id
		WHERE l.like_type_id = 1
    UNION ALL
    SELECT l.id
        FROM likes AS l
             INNER JOIN posts AS p ON p.id = l.item_id
             INNER JOIN ( 
               SELECT user_id 
                 FROM profiles  
                 ORDER BY birthday DESC
                 LIMIT 10 
             ) AS f ON f.user_id = p.user_id
		WHERE l.like_type_id = 4
    UNION ALL
    SELECT l.id
        FROM likes AS l
             INNER JOIN ( 
               SELECT user_id 
                 FROM profiles  
                 ORDER BY birthday DESC
                 LIMIT 10 
             ) AS f ON f.user_id = l.item_id
		WHERE l.like_type_id = 2
  ) AS t;

# Получился план отражённый в plan_3.jpg. 
# Мне кажется, что не смотря на визуальную большую сложность (как запроса, так и плана)
# работать в реальной ситуации этот запрос должен быстрее.
# Логика у меня следующая. 
# 1. Не нашёл достоверной информации, но теоретически UNION ALL наверное может выполнять 
# параллельно свои разные части. 
# 2. Судя по плану в plan_3.jpg, подзапрос из profiles превращается в materialized view и используется
# одновременно 3 раза. Т.е. выборка из profiles выполняется не 3 раза, а 1.
# 3. Благодаря тому что здесь нет JOIN с соединением через OR, то индексы здесь везде используются
# по максимуму.
# 4. Благодаря тому что каждый тип лайков соединяется со своим profiles из 10-ти строк, то 
# нет большого переменожения строк из-за JOIN. См. сравнение в plan_4.jpg. 
# Получается что новый запрос выбирает так строки: 10 * 1 + 10 * 2 * 1 + 10 * 2 * 1 = 50.
# Тогда как для старого запроса строки выбираются так: 10 * 2 * 2 * 100 = 4000.
# 5. И в результате того что мы сразу соединяем пользователей с нужным типом лайка, нет 
# необходимости в группировке - можно просто посчитать количество. Тогда как в старом варианте
# полученные несколько тысяч строк нужно ещё сгруппировать с COUNT по DISTINCT.
# 6. Правда не понял почему результирующая стоимость в plan_3.jpg равна 8.80. Она даже меньше 
# чем например выполнение блока query_block #4, где получилось значение 16.66.

