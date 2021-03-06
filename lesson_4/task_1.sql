-- Меняем ключ
DESC messages;
ALTER TABLE messages DROP PRIMARY KEY;
ALTER TABLE messages ADD PRIMARY KEY (from_user_id, to_user_id, created_at);

-- Добавляем таблицу posts
CREATE TABLE posts (
  id int(10) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id int(10) unsigned NOT NULL,
  body text COLLATE utf8_unicode_ci NOT NULL,
  created_at datetime DEFAULT current_timestamp()
);

-- newsline добавлять не стал, т.к. posts - то же самое

-- Таблица лайков
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  item_id INT UNSIGNED NOT NULL,
  like_type_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица типов лайков
CREATE TABLE like_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

