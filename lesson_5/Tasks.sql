# Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”

# 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
# Заполните их текущими датой и временем.

UPDATE users 
   SET created_at = now(),  
   	   updated_at = now();

# 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
# и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля 
# к типу DATETIME, сохранив введеные ранее значения.

ALTER TABLE users 
	RENAME COLUMN created_at TO created_at_old, 
	RENAME COLUMN updated_at TO updated_at_old;

ALTER TABLE users 
	ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
	ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

UPDATE users
   SET created_at = str_to_date(created_at_old,'%d.%m.%Y %H:%i'), 
       updated_at = str_to_date(updated_at_old,'%d.%m.%Y %H:%i');

ALTER TABLE users 
	DROP COLUMN created_at_old, 
	DROP COLUMN updated_at_old;

# 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
# 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи 
# таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны 
# выводиться в конце, после всех записей.

SELECT * 
    FROM storehouses_products
    ORDER BY 
 	    CASE  
  	    	WHEN value = 0 THEN 'Z'
  	    	ELSE value
      	END;

# 4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде 
# списка английских названий ('may', 'august').

SELECT name
  	FROM users
  	WHERE 
  		CASE MONTH(birthday_at)
  			WHEN 01 THEN 'january'
			WHEN 02 THEN 'february'
			WHEN 03 THEN 'march'
			WHEN 04 THEN 'april'
			WHEN 05 THEN 'may'
			WHEN 06 THEN 'june'
			WHEN 07 THEN 'july'
			WHEN 08 THEN 'august'
			WHEN 09 THEN 'september'
			WHEN 10 THEN 'october'
			WHEN 11 THEN 'november'
			WHEN 12 THEN 'december'
  		END IN ('may', 'august');

# 5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2);
# Отсортируйте записи в порядке, заданном в списке IN.

SELECT * 
 	FROM catalogs 
 	WHERE id IN (5, 1, 2)
 	ORDER BY 
 		CASE id
 			WHEN 5 THEN 1
 			WHEN 1 THEN 2
 			WHEN 2 THEN 3
 		END;

#Практическое задание по теме “Агрегация данных”

# 1. Подсчитайте средний возраст пользователей в таблице users

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age
	FROM users;

# 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
# Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT WEEKDAY(DATE_ADD(birthday_at, INTERVAL(YEAR(NOW()) - YEAR(birthday_at)) YEAR)) AS week_day, 
	   COUNT(*) AS cnt
	FROM users
	GROUP BY week_day;

# 3. Подсчитайте произведение чисел в столбце таблицы

SELECT ROUND(EXP(SUM(LOG(n))), 0)
	FROM (
		SELECT 1 AS n FROM DUAL
		UNION
		SELECT 2 FROM DUAL
		UNION
		SELECT 3 FROM DUAL
		UNION
		SELECT 4 FROM DUAL
		UNION
		SELECT 5 FROM DUAL ) AS t;

