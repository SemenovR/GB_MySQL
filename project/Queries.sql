/*
 * Первый запрос, результат которого видит пользователь - каталог товаров верхнего уровня
 */
SELECT id, 
       name
  FROM catalogs
 WHERE parent_id = 1;
 
/*
 * Затем, при наведении мышки на один из элементов каталога выпадает список сгруппированный по второму уровню вложенности
 */
SELECT c2.id,
       c2.name,
       c3.id, 
       c3.name
  FROM catalogs AS c2
       INNER JOIN catalogs AS c3
          ON c3.parent_id = c2.id 
         AND c2.parent_id = 5
 ORDER BY c2.name, 
          c3.name;

/*
 * При выборе элемента каталога последнего уровня, открывается список товаров с ценами и оценками пользователей.
 * Предположим что пользователь хочет увидеть самые дорогие товары, поэтому отсортируем по цене в обратном порядке
 */
SELECT p.product_code,                #Код товара
       p.name,                        #Название товара
       r.price AS old_price,          #Старая цена
       r.discount,                    #Скидка
       r.price - r.discount AS price, #Новая цена
       v.rating,                      #Средний рейтинг
       v.review_count                 #Число отзывов
  FROM products AS p
       LEFT JOIN product_prices AS r
         ON r.product_id = p.id
        AND r.end_date IS NULL
       LEFT JOIN view_reviews AS v    #Здесь нам пригодилось представление
         ON v.product_id = p.id
 WHERE p.catalog_id = 4
 ORDER BY price DESC; 

/*
 * Отображение характеристик товара
 */
SELECT ft.name AS ft_name,  #Название типа характеристики
       f.name AS f_name,    #Название характеристики
       f.description,       #Описание характеристики
       pf.value             #Значение характеристики
  FROM product_features AS pf
       INNER JOIN features AS f
          ON f.id = pf.feature_id
       INNER JOIN feature_types AS ft
          ON ft.id = f.feature_types_id
 WHERE pf.product_id = 1;
 
 /*
  * Отображение отзывов по товару
  */
SELECT pr.rating,
       pr.review,
       u.nickname
  FROM product_reviews AS pr
       INNER JOIN users AS u 
          ON u.id = pr.use_id
  WHERE pr.product_id = 1;
  
/*
 * Для отражения полного пути каталога для выбранного товара используется рекурсивный запрос 
 */
WITH RECURSIVE rec (id, name, parent_id) AS (
  SELECT id,
         name,
         parent_id
    FROM catalogs
   WHERE id = 4
   UNION ALL
  SELECT c.id,
         c.name,
         c.parent_id
    FROM catalogs AS c
         INNER JOIN rec
            ON c.id = rec.parent_id
)
SELECT id, 
       name 
  FROM rec;
  
/*
 * Получение каталога в виде дерева с уровнями 
 */
WITH RECURSIVE rec (id, name, parent_id, level) AS (
  SELECT id,
         name,
         parent_id,
         @min_price := 1 AS level
    FROM catalogs
   WHERE id = 1
   UNION ALL
  SELECT c.id,
         c.name,
         c.parent_id,
         @min_price := rec.level + 1 AS level
    FROM catalogs AS c
         INNER JOIN rec
            ON c.parent_id = rec.id
)
SELECT * 
  FROM rec;
