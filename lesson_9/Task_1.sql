# Практическое задание по теме “Транзакции, переменные, представления”

# 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
# Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;

INSERT INTO sample.users(id, name) 
  SELECT id, name 
    FROM shop.users
   WHERE id = 1;

DELETE FROM shop.users
 WHERE id = 1;

COMMIT;

# 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и 
# соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW prod_cat (​product_name, catalog_name)
AS SELECT p.name, 
          c.name
    FROM products AS p
         LEFT JOIN catalogs AS c 
           ON c.id = p.catalog_id;

# 3. (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые 
# календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
# Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
# если дата присутствует в исходном таблице и 0, если она отсутствует.

CREATE OR REPLACE VIEW numerics (n)
AS SELECT 0 UNION ALL
   SELECT 1 UNION ALL
   SELECT 2 UNION ALL
   SELECT 3 UNION ALL
   SELECT 4 UNION ALL
   SELECT 5 UNION ALL
   SELECT 6 UNION ALL
   SELECT 7 UNION ALL
   SELECT 8 UNION ALL
   SELECT 9;
 
CREATE OR REPLACE VIEW dates
AS SELECT CONCAT(y1.n, y2.n, y3.n, y4.n, '-', m1.n, m2.n, '-', d1.n, d2.n) AS d
     FROM numerics AS y1,
          numerics AS y2,
          numerics AS y3,
          numerics AS y4,
          numerics AS m1,
          numerics AS m2,
          numerics AS d1,
          numerics AS d2;
 
SELECT d.d, 
       IF (t.created_at IS NULL, 0, 1)
FROM dates AS d
     LEFT JOIN ( SELECT '2018-08-01' AS created_at FROM DUAL
                 UNION ALL
                 SELECT '2016-08-04' FROM DUAL
                 UNION ALL
                 SELECT '2018-08-16' FROM DUAL
                 UNION ALL
                 SELECT '2018-08-17' FROM DUAL 
               ) AS t
       ON d.d = t.created_at
WHERE d.d BETWEEN '2018-08-01' AND '2018-08-31'
ORDER BY d.d;


# 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, 
# который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

CREATE OR REPLACE VIEW last_5
AS SELECT id
     FROM storehouses
    WHERE created_at
    ORDER BY created_at DESC
    LIMIT 5;
 
DELETE FROM storehouses 
 WHERE id NOT IN (SELECT id FROM last_5);


