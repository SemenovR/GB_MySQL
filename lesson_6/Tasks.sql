# 1. Проанализировать запросы, которые выполнялись на занятии, 
# определить возможные корректировки и/или улучшения (JOIN пока не применять).

# Предлагаю запрос такого вида
SELECT COUNT(id) AS news, MONTHNAME(created_at) AS month 
  FROM media
  GROUP BY month
  ORDER BY FIELD(month, 
    'January', 'February', 'March', 'April', 'May', 'June', 
    'July', 'August', 'September', 'October', 'November', 'December') DESC;
    
# переписать в следующем виде
SELECT COUNT(id) AS news, MONTHNAME(created_at) AS month 
  FROM media
  GROUP BY month, MONTH(created_at)
  ORDER BY MONTH(created_at) DESC;

# 2. Пусть задан некоторый пользователь. 
# Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользоваетелем.

SELECT 
  from_user_id,
  (SELECT CONCAT(firstname, ' ', lastname) 
     FROM users 
     WHERE id = m.from_user_id) AS friend
  FROM messages AS m
  WHERE to_user_id = 10   # Сообщения должны приходить пользователю
    AND from_user_id IN ( # Сообщения должны приходить от друга
      SELECT friend_id    # Выбираем всех друзей пользователя
        FROM friendship 
        WHERE user_id = 10
          AND confirmed_at IS NOT NULL 
          AND status IS NOT NULL
      UNION
      SELECT user_id 
        FROM friendship 
        WHERE friend_id = 10
          AND confirmed_at IS NOT NULL 
          AND status IS NOT NULL
    )
  GROUP BY from_user_id
  ORDER BY COUNT(*) DESC
  LIMIT 1;

# 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT SUM(cnt)
  FROM (
    SELECT 
      (SELECT COUNT(*) 
         FROM likes
         WHERE item_id IN (
             SELECT id 
               FROM media
               WHERE user_id = p.user_id
           )
      ) AS cnt
    FROM profiles AS p
    ORDER BY birthday DESC
    LIMIT 10 
  ) AS t;

# 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
  CONCAT('Больше всего лайков поставили ',
    CASE (sex)
      WHEN 'm' THEN 'мужчины'
      WHEN 'f' THEN 'женщины'
    END
  ) AS res
  FROM profiles AS p
  GROUP BY sex
  ORDER BY 
    SUM((SELECT COUNT(*) 
           FROM likes
           WHERE item_id IN (
             SELECT id 
               FROM media
               WHERE user_id = p.user_id
           )
    )) DESC
  LIMIT 1;


# 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT
  user_id,
  # Лайки
  (SELECT COUNT(*) 
     FROM likes
     WHERE item_id IN (
       SELECT id 
         FROM media
         WHERE user_id = p.user_id
     )
  ) +
  # Сообщения
  (SELECT COUNT(*)
     FROM messages
     WHERE from_user_id = p.user_id   
  ) + 
  # Сообщества
  (SELECT COUNT(*)
     FROM communities_users
     WHERE user_id = p.user_id   
  ) + 
  # Друзья
  (SELECT COUNT(*)
     FROM (
       SELECT friend_id
         FROM friendship 
         WHERE user_id = p.user_id
           AND confirmed_at IS NOT NULL 
           AND status IS NOT NULL
       UNION
       SELECT user_id 
         FROM friendship 
         WHERE friend_id = p.user_id
           AND confirmed_at IS NOT NULL 
           AND status IS NOT NULL
     ) AS f
  ) +
  # Медиа
  (SELECT COUNT(*)
     FROM media
     WHERE user_id = p.user_id   
  ) +
  # Посты
  (SELECT COUNT(*)
     FROM posts
     WHERE user_id = p.user_id   
  )
  AS cnt
  FROM profiles AS p
  ORDER BY cnt
  LIMIT 10;

