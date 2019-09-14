# Практическое задание по теме “Хранимые процедуры и функции, триггеры"

# 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего
# времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 
# функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — 
# "Доброй ночи".

DELIMITER //

DROP PROCEDURE IF EXISTS hello//
CREATE PROCEDURE hello()
BEGIN
  DECLARE tm INT DEFAULT HOUR(NOW());
  SELECT CASE WHEN tm BETWEEN 06 AND 11 THEN 'Доброе утро'
              WHEN tm BETWEEN 12 AND 17 THEN 'Добрый день'
              WHEN tm BETWEEN 18 AND 23 THEN 'Добрый вечер'
              WHEN tm BETWEEN 00 AND 05 THEN 'Доброй ночи'
         END AS hello;
END//

CALL hello()//

# 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
# Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное
# значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля 
# были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

DELIMITER //

DROP TRIGGER IF EXISTS check_products_insert//

CREATE TRIGGER check_products_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND 
     NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert products canceled';
  END IF;
END//

DROP TRIGGER IF EXISTS check_products_update//

CREATE TRIGGER check_products_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND 
     NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Update products canceled';
  END IF;
END//

# 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами 
# Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. Вызов 
# функции FIBONACCI(10) должен возвращать число 55.

DELIMITER //

DROP FUNCTION IF EXISTS fibonacci//

CREATE FUNCTION fibonacci(n INT)
RETURNS INT DETERMINISTIC
BEGIN
  DECLARE a, c INT DEFAULT 0;
  DECLARE b INT DEFAULT 1;
  
  WHILE n > 0 DO
    SET n = n - 1;
    SET c = a;
    SET a = b;
    SET b = c + b;
  END WHILE;
  RETURN a;
END//

SELECT fibonacci(10)//

