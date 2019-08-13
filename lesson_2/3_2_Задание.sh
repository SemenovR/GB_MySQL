#Создаём дамп
mysqldump example > example.sql
#Разворачиваем содержимое дампа в новую БД
mysql sample < example.sql

