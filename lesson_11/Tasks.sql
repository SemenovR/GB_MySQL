# Тема 9 “Оптимизация запросов”
# 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и 
# products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор 
# первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS log;
CREATE TABLE log (
   date_time DATETIME NOT NULL DEFAULT NOW(),
   table_name VARCHAR(50) NOT NULL,
   table_id BIGINT UNSIGNED NOT NULL,
   name VARCHAR(255)
) ENGINE=ARCHIVE;
 
DELIMITER //

DROP TRIGGER IF EXISTS log_users_insert//

CREATE TRIGGER log_users_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
  INSERT INTO log 
    VALUES (NOW(), 'USERS', NEW.ID, NEW.name) ;
END//

DROP TRIGGER IF EXISTS log_catalogs_insert//

CREATE TRIGGER log_catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
  INSERT INTO log 
    VALUES (NOW(), 'CATALOGS', NEW.ID, NEW.name) ;
END//

DROP TRIGGER IF EXISTS log_products_insert//

CREATE TRIGGER log_products_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN
  INSERT INTO log 
    VALUES (NOW(), 'PRODUCTS', NEW.ID, NEW.name) ;
END//

DELIMITER ;

# 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
 

# Тема 10 “NoSQL”
# 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

# Создаём коллекцию
HINCRBY IP 192.168.1.1 1
HINCRBY IP 192.168.1.2 1
HINCRBY IP 192.168.1.3 1

# Получаем значения
HGET IP 192.168.1.1
HGET IP 192.168.1.2
HGET IP 192.168.1.3

# 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, 
# поиск электронного адреса пользователя по его имени.

# Одновременно задаём два набора - один имя/адрес, второй адрес/имя
HSET name_addr Roma roma@mail.ru
HSET addr_name roma@mail.ru Roma

# Теперь можно искать значения либо по имени, либо по адресу
HGET name_addr Roma
HGET addr_name roma@mail.ru

# 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

use test

db.test.insert(
  {
    catalog: "Процессоры",
    products: [
      {
        name: "Intel Core i3-8100",     
        description: "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
        price: "7890",
        created_at: '2019-09-21-16.03.04',
        updated_at: '2019-09-21-16.03.04'
      }, 
      {
        name: "Intel Core i5-7400",     
        description: "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
        price: "12700",
        created_at: '2019-09-21-16.03.04',
        updated_at: '2019-09-21-16.03.04'
      }
    ]
  }
)

