# 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в
# интернет магазине.

# Не знаю какой из запросов будет работать быстрее, поэтому перечислю два варианта. 

# Первый через JOIN
SELECT DISTINCT u.name
  FROM users AS u
  INNER JOIN orders AS o ON o.user_id = u.id;

# Второй через EXISTS
SELECT u.name
  FROM users AS u
  WHERE EXISTS (SELECT 1 FROM orders WHERE user_id = u.id LIMIT 1);


# 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.name, c.name
  FROM products AS p
  LEFT JOIN catalogs AS c ON c.id = p.catalog_id;

# 3. Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label,
# name). Поля from, to и label содержат английские названия городов, поле name — русское.
# Выведите список рейсов flights с русскими названиями городов.

SELECT f.id, cf.name, ct.name
  FROM flights AS f
  LEFT JOIN cities AS cf ON cf.label = f.from
  LEFT JOIN cities AS ct ON ct.label = f.to; 
