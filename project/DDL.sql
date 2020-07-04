/* 
 * База данных сайта www.dns-shop.ru
 * В данном проекте решается только та часть работы онлайн-магазина, 
 * которая ответственна за отображение каталога товаров и сопутствующих данных.
 * Здесь не затронуты, например, такие аспекты как склад, заказ товаров и т.д. 
 * На основе этой базы дальше можно углубляться в процесс реализации онлайн-магазина. 
 */
DROP DATABASE IF EXISTS dns;
CREATE DATABASE dns;
USE dns;

/*
 * Справочник типов медиа-файлов
 */
CREATE TABLE media_types (
  id   INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. типа медиа',
  name VARCHAR(30) NOT NULL UNIQUE COMMENT 'Название типа медиа',
  INDEX media_types_name_idx(name)
)
COMMENT = 'Типы медиа';

/*
 * Информация о самих медиа-файлах. Здесь хранится только путь к файлу, а не сам файл.
 */
CREATE TABLE media (
  id            INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. медиа',
  media_type_id INT UNSIGNED NOT NULL COMMENT 'Тип медиа',
  file_name     VARCHAR(255) NOT NULL COMMENT 'Имя файла', 
  size          INT UNSIGNED NOT NULL COMMENT 'Размер файла',
  meta_data     JSON COMMENT 'Мета-данные файла',
  CONSTRAINT media_media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
)
COMMENT = 'Медиа-контент';

/*
 * Справочник производителей товаров
 */
CREATE TABLE manufacturers (
  id       INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. производителя',
  name     VARCHAR(50) NOT NULL UNIQUE COMMENT 'Название производителя',
  media_id INT UNSIGNED COMMENT 'Логотип',
  CONSTRAINT manufacturers_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
      ON DELETE SET NULL,
  INDEX manufacturers_name_idx(name)
)
COMMENT = 'Производители';

/*
 * Справочник стран
 */
CREATE TABLE countries (
  id   INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. страны',
  name VARCHAR(50) NOT NULL UNIQUE COMMENT 'Название страны',
  INDEX countries_name_idx(name)
)
COMMENT = 'Страны';

/*
 * Иерархический каталог товаров
 */
CREATE TABLE catalogs (
  id        INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. каталога товаров',
  parent_id INT UNSIGNED COMMENT 'Ид. родительского каталога',
  name      VARCHAR(100) NOT NULL COMMENT 'Название каталога',
  CONSTRAINT catalogs_parent_id_fk 
    FOREIGN KEY (parent_id) REFERENCES catalogs(id),
  INDEX catalogs_name_idx(name)
)
COMMENT = 'Каталог товаров';

/*
 * Информация о самих товарах
 */
CREATE TABLE products (
  id              INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. товара',
  catalog_id      INT UNSIGNED NOT NULL COMMENT 'Ид. каталога товара',
  manufacturer_id INT UNSIGNED NOT NULL COMMENT 'Ид. производителя',
  country_id      INT UNSIGNED NOT NULL COMMENT 'Ид. страны',
  product_code    INT UNSIGNED NOT NULL UNIQUE COMMENT 'Код товара',
  name            VARCHAR(255) NOT NULL COMMENT 'Название товара',
  description     TEXT COMMENT 'Описание товара',
  CONSTRAINT products_catalog_id_fk 
    FOREIGN KEY (catalog_id) REFERENCES catalogs(id),
  CONSTRAINT products_manufacturer_id_fk 
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id),
  CONSTRAINT products_country_id_fk 
    FOREIGN KEY (country_id) REFERENCES countries(id),
  INDEX products_name_idx(name),
  INDEX products_product_code_idx(product_code)
)
COMMENT = 'Товары';

/*
 * Ценовая информация товаров. 
 * Предполагается что при каждом изменении цены будет создаваться новая строчка.
 * Тем самым здесь будет храниться история о ценах. 
 * В последствии, при развитии проекта, на идентификаторы этих цен могут быть завязаны покупки. 
 */
CREATE TABLE product_prices (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. цены',
  product_id INT UNSIGNED NOT NULL COMMENT 'Ид. товара',
  price      FLOAT(15,2) UNSIGNED NOT NULL COMMENT 'Цена',
  discount   FLOAT(15,2) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Скидка',
  warranty   TINYINT UNSIGNED COMMENT 'Гарантия',
  start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата начала действия',
  end_date   DATETIME COMMENT 'Дата окончания действия',
  CONSTRAINT product_prices_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id),
  # Как правило, для поиска актуального периода его ищут по дате окончания
  INDEX product_prices_end_date_idx(end_date),
  # Пользователи часто ищут товары по цене
  INDEX product_prices_price_idx(price)
)
COMMENT = 'Цены на товары';

/*
 * Коллекции изображений товаров
 */
CREATE TABLE product_images (
  product_id INT UNSIGNED NOT NULL COMMENT 'Ид. товара',
  media_id   INT UNSIGNED NOT NULL COMMENT 'Ид. изображения',
  PRIMARY KEY (product_id, media_id),
  CONSTRAINT product_images_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON DELETE CASCADE,
  CONSTRAINT product_images_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
)
COMMENT = 'Изображения товаров';

/*
 * Справочник типов характеристик товаров
 */
CREATE TABLE feature_types (
  id   INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. типа характеристики',
  name VARCHAR(50) NOT NULL UNIQUE COMMENT 'Название типа характеристики'
)
COMMENT = 'Типы характеристик';

/*
 * Справочник самих характеристик
 */
CREATE TABLE features (
  id               INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. характеристики',
  feature_types_id INT UNSIGNED NOT NULL COMMENT 'Ид. типа характеристики',
  name             VARCHAR(50) NOT NULL COMMENT 'Название характеристики',
  description      TEXT COMMENT 'Описание характеристики',
  CONSTRAINT features_feature_types_id_fk 
    FOREIGN KEY (feature_types_id) REFERENCES feature_types(id)
)
COMMENT = 'Характеристики';

/*
 * Описание характеристик товаров
 */
CREATE TABLE product_features (
  product_id INT UNSIGNED NOT NULL COMMENT 'Ид. товара',
  feature_id INT UNSIGNED NOT NULL COMMENT 'Ид. характеристики',
  value      VARCHAR(255) COMMENT 'Значение характеристики',
  PRIMARY KEY (product_id, feature_id),
  CONSTRAINT product_features_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON DELETE CASCADE,
  CONSTRAINT product_features_feature_id_fk 
    FOREIGN KEY (feature_id) REFERENCES features(id),
  INDEX product_features_feature_id_value_idx(feature_id, value)
)
COMMENT = 'Характеристики товаров';

/*
 * Справочник городов
 */
CREATE TABLE cities (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. города',
  country_id INT UNSIGNED NOT NULL COMMENT 'Ид. страны',
  name       VARCHAR(50) COMMENT 'Название города',
  CONSTRAINT cities_country_id_fk 
    FOREIGN KEY (country_id) REFERENCES countries(id),
  INDEX cities_name_idx(name)
)
COMMENT = 'Города';

/*
 * Справочник магазинов DNS
 */
CREATE TABLE shops (
  id      INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. магазина',
  city_id INT UNSIGNED NOT NULL COMMENT 'Ид. города',
  address VARCHAR(255) NOT NULL COMMENT 'Адрес',
  name    VARCHAR(50)  NOT NULL COMMENT 'Название',
  CONSTRAINT shops_city_id_fk 
    FOREIGN KEY (city_id) REFERENCES cities(id)
)
COMMENT = 'Магазины';

/*
 * Пользователи
 */
CREATE TABLE users (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. пользователя',
  email      VARCHAR(100) NOT NULL UNIQUE COMMENT 'Электронная почта',
  phone      VARCHAR(11) NOT NULL UNIQUE COMMENT 'Телефон',
  nickname   VARCHAR(50) NOT NULL UNIQUE COMMENT 'Никнейм',
  first_name VARCHAR(100) NOT NULL COMMENT 'Имя',
  last_name  VARCHAR(100) COMMENT 'Фамилия',
  birthday   DATE COMMENT 'Дата рождения',
  city_id    INT UNSIGNED COMMENT 'Город',
  shop_id    INT UNSIGNED COMMENT 'Магазин по умолчанию',
  sex        ENUM('M', 'F') COMMENT 'Пол',
  reg_date   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата регистрации',
  password   VARCHAR(224) NOT NULL COMMENT 'Пароль',
  CONSTRAINT users_city_id_fk 
    FOREIGN KEY (city_id) REFERENCES cities(id)
      ON DELETE SET NULL,
  CONSTRAINT users_shop_id_fk 
    FOREIGN KEY (shop_id) REFERENCES shops(id)
      ON DELETE SET NULL,
  INDEX users_email_idx(email),
  INDEX users_phone_idx(phone),
  INDEX users_nickname_idx(nickname)
)
COMMENT = 'Пользователи';

/*
 * Отзывы пользователей о товарах
 */
CREATE TABLE product_reviews (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Ид. отзыва о товаре',
  product_id INT UNSIGNED NOT NULL COMMENT 'Ид. товара',
  use_id     INT UNSIGNED NOT NULL COMMENT 'Ид. пользователя',
  review     TEXT COMMENT 'Текст отзыва',
  rating     TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Оценка',
  date       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата отзыва',
  CONSTRAINT product_reviews_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id)
      ON DELETE CASCADE,
  CONSTRAINT product_reviews_use_id_fk 
    FOREIGN KEY (use_id) REFERENCES users(id)
      ON DELETE CASCADE
)
COMMENT = 'Отзывы о товарах';

/*
 * Представление отражающее средние рейтинги товаров
 */
CREATE VIEW view_reviews AS 
SELECT product_id,                        #Идентификатор товара
       IFNULL(AVG(rating), 0) AS rating,  #Средний рейтинг
       COUNT(id) AS review_count          #Число отзывов
  FROM product_reviews
 GROUP BY product_id 
 ORDER BY product_id;
 
/*
 * Представление отражающее данные продуктов
 */
CREATE VIEW view_product AS 
SELECT p.id,                          #Идентификатор товара
       p.name,                        #Название товара
       p.product_code,                #Код товара
       p.description,                 #Описание товара
       m.name AS manufact,            #Производитель
       e.file_name AS logo,           #Логотип производителя
       c.name AS country,             #Страна производства
       ft.name AS ft_name,            #Название типа характеристики
       f.name AS f_name,              #Название характеристики
       f.description AS f_descr,      #Описание характеристики
       pf.value,                      #Значение характеристики
       r.price AS old_price,          #Старая цена
       r.discount,                    #Скидка
       r.price - r.discount AS price, #Новая цена
       r.warranty,                    #Гарантия
       v.rating,                      #Средний рейтинг
       v.review_count                 #Число отзывов
  FROM products AS p
       LEFT JOIN product_features AS pf
         ON pf.product_id = p.id
       LEFT JOIN features AS f
         ON f.id = pf.feature_id
       LEFT JOIN feature_types AS ft
         ON ft.id = f.feature_types_id
       LEFT JOIN manufacturers AS m
         ON m.id = p.manufacturer_id
       LEFT JOIN media AS e
         ON e.id = m.media_id
       LEFT JOIN countries AS c
         ON c.id = p.country_id
       LEFT JOIN product_prices AS r
         ON r.product_id = p.id
        AND r.end_date IS NULL
       LEFT JOIN view_reviews AS v
         ON v.product_id = p.id
 ORDER BY p.name, 
          ft.name, 
          f.name;
        
/*
 * Таблица для логирования критичных параметров профиля пользователя
 */
CREATE TABLE log (
  date_time  DATETIME NOT NULL DEFAULT NOW() COMMENT 'Дата изменения',
  user_id    INT UNSIGNED NOT NULL COMMENT 'Ид. пользователя',
  field      VARCHAR(30) NOT NULL COMMENT 'Поле',
  value      VARCHAR(224) COMMENT 'Значение',
  operation  ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL COMMENT 'Операция'
) 
ENGINE = ARCHIVE
COMMENT = 'Логирование';
 
DELIMITER //

CREATE TRIGGER log_users_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
  INSERT INTO log VALUES (NOW(), NEW.id, 'EMAIL', NEW.email, 'INSERT');
  INSERT INTO log VALUES (NOW(), NEW.id, 'PHONE', NEW.phone, 'INSERT');
  INSERT INTO log VALUES (NOW(), NEW.id, 'NICKNAME', NEW.nickname, 'INSERT');
  INSERT INTO log VALUES (NOW(), NEW.id, 'FIRST_NAME', NEW.first_name, 'INSERT');
  INSERT INTO log VALUES (NOW(), NEW.id, 'LAST_NAME', NEW.last_name, 'INSERT');
  INSERT INTO log VALUES (NOW(), NEW.id, 'BIRTHDAY', NEW.birthday, 'INSERT');
  INSERT INTO log VALUES (NOW(), NEW.id, 'PASSWORD', NEW.password, 'INSERT');
END//

CREATE TRIGGER log_users_update AFTER UPDATE ON users
FOR EACH ROW
BEGIN
  IF NEW.email <> OLD.email THEN
    INSERT INTO log VALUES (NOW(), NEW.id, 'EMAIL', NEW.email, 'INSERT');
  END IF;
  IF NEW.phone <> OLD.phone THEN
    INSERT INTO log VALUES (NOW(), NEW.id, 'PHONE', NEW.phone, 'INSERT');
  END IF;
  IF NEW.nickname <> OLD.nickname THEN
    INSERT INTO log VALUES (NOW(), NEW.id, 'NICKNAME', NEW.nickname, 'INSERT');
  END IF;
  IF NEW.first_name <> OLD.first_name THEN
    INSERT INTO log VALUES (NOW(), NEW.id, 'FIRST_NAME', NEW.first_name, 'INSERT');
  END IF;
  IF NEW.last_name <> OLD.last_name THEN
    INSERT INTO log VALUES (NOW(), NEW.id, 'LAST_NAME', NEW.last_name, 'INSERT');
  END IF;
  IF NEW.birthday <> OLD.birthday THEN
    INSERT INTO log VALUES (NOW(), NEW.id, 'BIRTHDAY', NEW.birthday, 'INSERT');
  END IF;
  IF NEW.password <> OLD.password THEN
    INSERT INTO log VALUES (NOW(), NEW.id, 'PASSWORD', NEW.password, 'INSERT');
  END IF;
END//

CREATE TRIGGER log_users_delete AFTER DELETE ON users
FOR EACH ROW
BEGIN
  #Строка удаляется целиком
  INSERT INTO log VALUES (NOW(), OLD.id, 'USERS', NULL, 'DELETE');
END//

DELIMITER ;
