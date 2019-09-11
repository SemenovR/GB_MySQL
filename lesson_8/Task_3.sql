# 3. Переписать запросы, заданые к ДЗ урока 6 с использованием JOIN (четыре запроса).

# 3.1. Пусть задан некоторый пользователь. 
# Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользоваетелем.

SELECT m.from_user_id,
       CONCAT(u.firstname, ' ', u.lastname) AS friend,
       COUNT(f1.user_id) + COUNT(f2.user_id) AS cnt
  FROM messages AS m
       INNER JOIN users AS u 
          ON u.id = m.from_user_id
       LEFT JOIN friendship f1 
         ON f1.friend_id = m.from_user_id 
        AND f1.user_id = 10 
        AND f1.confirmed_at IS NOT NULL 
        AND f1.status IS NOT NULL
       LEFT JOIN friendship f2 
         ON f2.user_id = m.from_user_id 
        AND f2.friend_id = 10 
        AND f2.confirmed_at IS NOT NULL 
        AND f2.status IS NOT NULL
  WHERE m.to_user_id = 10
  GROUP BY from_user_id
  ORDER BY cnt DESC
  LIMIT 1;

# 3.2. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT f.user_id, 
       f.birthday,
       COUNT(DISTINCT lm.id, tm.id) + 
       COUNT(DISTINCT lp.id, tp.id) + 
       COUNT(DISTINCT lu.id, tu.id) AS cnt
  FROM profiles AS f
       LEFT JOIN media AS m         # Медиа
         ON m.user_id = f.user_id 
       LEFT JOIN likes AS lm
         ON lm.item_id = m.id 
       LEFT JOIN like_types AS tm 
         ON tm.id = lm.like_type_id 
        AND tm.name = 'media'
       LEFT JOIN posts AS p         # Посты
         ON p.user_id = f.user_id 
       LEFT JOIN likes AS lp
         ON lp.item_id = p.id 
       LEFT JOIN like_types AS tp 
         ON tp.id = lp.like_type_id 
        AND tp.name = 'posts'
       LEFT JOIN likes AS lu        # Пользователи
         ON lu.item_id = f.user_id 
       LEFT JOIN like_types AS tu 
         ON tu.id = lu.like_type_id 
        AND tu.name = 'users'
 GROUP BY f.user_id
 ORDER BY f.birthday DESC
 LIMIT 10;

# 3.3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT p.sex, 
       COUNT(*) AS cnt
  FROM likes AS l
       INNER JOIN profiles AS p 
          ON p.user_id = l.user_id
 GROUP BY p.sex
 ORDER BY cnt DESC
 LIMIT 1;


# 3.4. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT p.user_id, 
       COUNT(DISTINCT l.id) + 
       COUNT(DISTINCT m.from_user_id, m.to_user_id, m.created_at) + 
       COUNT(DISTINCT cu.community_id, cu.user_id) + 
       COUNT(DISTINCT f1.user_id, f1.friend_id) + 
       COUNT(DISTINCT f2.user_id, f2.friend_id) + 
       COUNT(DISTINCT e.id) + 
       COUNT(DISTINCT o.id) AS cnt
  FROM profiles AS p
       LEFT JOIN likes AS l               # Лайки 
         ON l.user_id = p.user_id
       LEFT JOIN messages AS m            # Сообщения 
         ON m.from_user_id = p.user_id
       LEFT JOIN communities_users AS cu  # Сообщества 
         ON cu.user_id = p.user_id
       LEFT JOIN friendship AS f1         # Друзья 1 
         ON f1.user_id = p.user_id
        AND f1.confirmed_at IS NOT NULL 
        AND f1.status IS NOT NULL
       LEFT JOIN friendship AS f2         # Друзья 2 
         ON f2.friend_id = p.user_id
        AND f2.confirmed_at IS NOT NULL 
        AND f2.status IS NOT NULL
       LEFT JOIN media AS e               # Медиа 
         ON e.user_id = p.user_id
       LEFT JOIN posts AS o               # Посты 
         ON o.user_id = p.user_id
  GROUP BY p.user_id
  ORDER BY cnt
  LIMIT 10;

