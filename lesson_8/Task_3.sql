# 3. Переписать запросы, заданые к ДЗ урока 6 с использованием JOIN (четыре запроса).

# 3.1. Пусть задан некоторый пользователь. 
# Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользоваетелем.

SELECT 
  m.from_user_id,
  CONCAT(u.firstname, ' ', u.lastname) AS friend
  FROM messages AS m
    INNER JOIN users AS u ON u.id = m.from_user_id
    INNER JOIN (
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
    ) AS f ON f.friend_id = m.from_user_id  # Сообщения должны приходить от друга
  WHERE m.to_user_id = 10                   # Сообщения должны приходить пользователю
  GROUP BY from_user_id
  ORDER BY COUNT(*) DESC
  LIMIT 1;

# 3.2. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT (
    ( SELECT COUNT(*) 
        FROM likes AS l
             INNER JOIN media AS m ON m.id = l.item_id
             INNER JOIN like_types AS t ON t.id = l.like_type_id AND t.name = 'media'
             INNER JOIN ( 
               SELECT user_id 
                 FROM profiles  
                 ORDER BY birthday DESC
                 LIMIT 10 
             ) AS f ON f.user_id = m.user_id
    ) + 
    ( SELECT COUNT(*) 
        FROM likes AS l
             INNER JOIN posts AS p ON p.id = l.item_id
             INNER JOIN like_types AS t ON t.id = l.like_type_id AND t.name = 'posts'
             INNER JOIN ( 
               SELECT user_id 
                 FROM profiles  
                 ORDER BY birthday DESC
                 LIMIT 10 
             ) AS f ON f.user_id = p.user_id
    ) + 
    ( SELECT COUNT(*) 
        FROM likes AS l
             INNER JOIN like_types AS t ON t.id = l.like_type_id AND t.name = 'users'
             INNER JOIN ( 
               SELECT user_id 
                 FROM profiles  
                 ORDER BY birthday DESC
                 LIMIT 10 
             ) AS f ON f.user_id = l.item_id
    )  
  ) AS cnt
FROM DUAL;

# 3.3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT p.sex, COUNT(*)
  FROM likes AS l
       INNER JOIN profiles AS p ON p.user_id = l.user_id
 GROUP BY p.sex
 ORDER BY COUNT(*) DESC
 LIMIT 1;


# 3.4. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT p.user_id, IFNULL(SUM(t.cnt), 0)
  FROM profiles AS p
       LEFT JOIN (
          # Лайки
          SELECT user_id, 1 AS cnt
            FROM likes
          UNION ALL
          # Сообщения
          SELECT from_user_id, 1
            FROM messages   
          UNION ALL
          # Сообщества
          SELECT user_id, 1
            FROM communities_users
          UNION ALL
          # Друзья
          SELECT user_id, 1
            FROM friendship 
            WHERE confirmed_at IS NOT NULL 
              AND status IS NOT NULL
          UNION ALL
          SELECT friend_id, 1
            FROM friendship 
            WHERE confirmed_at IS NOT NULL 
              AND status IS NOT NULL
          UNION ALL
          # Медиа
          SELECT user_id, 1
            FROM media
          UNION ALL
          # Посты
          SELECT user_id, 1
            FROM posts
       ) AS t ON t.user_id = p.user_id
  GROUP BY p.user_id
  ORDER BY IFNULL(SUM(t.cnt), 0)
  LIMIT 10;
