-- CRUD операции
-- однострочная и многострочная вставка

USE vk;
SHOW TABLES;
DESC media_types;
SELECT * FROM media_types;
INSERT INTO media_types VALUES (6, 'games');

-- проверка уникальности
INSERT INTO media_types (name) VALUES ('games');

-- ключевое слово DEFAULT
INSERT INTO media_types VALUES (DEFAULT, 'games');
INSERT INTO media_types (name) VALUES ('games1'), ('games2');
SELECT * FROM media_types;

-- игнорирует ошибки
INSERT IGNORE INTO media_types (name) VALUES ('games');
-- просмотреть предупреждения
SHOW WARNINGS;

-- SET указывает на имена столбцов явно
INSERT INTO media_types SET name = 'games3';

-- REPLACE копия INSERT IGNORE но работает немного по другому 
REPLACE INTO media_types (name) VALUES ('games3');

-- вывести всё
SELECT * FROM media_types;
SELECT ALL * FROM media_types;

-- вывести только уникальные строки
SELECT DISTINCT * FROM media_types;

-- использование LIMIT
SELECT ALL * FROM media_types LIMIT 1;

-- обновление данных
UPDATE media_types SET id = id * 10 WHERE id = 13;

-- применение с IGNORE
UPDATE media_types SET name = 'games4' WHERE name = 'games3';
UPDATE IGNORE media_types SET name = 'games4' WHERE name = 'games3';
SHOW WARNINGS:

-- удаление по условию
DELETE FROM media_types WHERE name = 'games4';

-- удаление слимитом LIMIT
DELETE FROM media_types LIMIT 1;

-- удалить все записи
DELETE FROM media_types;
-- и смотрим счётчик
INSERT INTO media_types VALUES (DEFAULT, 'game');

-- более быстый способ
TRUNCATE media_types;
-- сбрасывает счётчики, проверим
INSERT INTO media_types VALUES (DEFAULT, 'game');

