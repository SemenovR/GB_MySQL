/*
 * media_types
 */
INSERT INTO media_types (id, name) VALUES (1, 'Логотип производителя');
INSERT INTO media_types (id, name) VALUES (2, 'Изображение товара');
INSERT INTO media_types (id, name) VALUES (3, 'Видео товара');

/*
 * media
 */
INSERT INTO media (id, media_type_id, file_name, size) VALUES (1, 1, 'C:\Logo\logo1.jpg', 100);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (2, 1, 'C:\Logo\logo2.jpg', 110);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (3, 1, 'C:\Logo\logo3.jpg', 111);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (4, 1, 'C:\Logo\logo4.jpg', 114);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (5, 1, 'C:\Logo\logo5.jpg', 110);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (6, 2, 'C:\Images\img1.jpg', 200);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (7, 2, 'C:\Images\img2.jpg', 220);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (8, 2, 'C:\Images\img3.jpg', 230);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (9, 2, 'C:\Images\img4.jpg', 240);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (10, 2, 'C:\Images\img5.jpg', 250);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (11, 2, 'C:\Images\img6.jpg', 250);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (12, 2, 'C:\Images\img7.jpg', 250);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (13, 2, 'C:\Images\img8.jpg', 250);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (14, 2, 'C:\Images\img9.jpg', 250);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (15, 2, 'C:\Images\img10.jpg', 250);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (16, 2, 'C:\Images\img11.jpg', 250);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (17, 2, 'C:\Images\img12.jpg', 250);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (18, 2, 'C:\Images\img13.jpg', 250);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (19, 2, 'C:\Images\img14.jpg', 250);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (20, 2, 'C:\Images\img15.jpg', 250);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (21, 3, 'C:\Video\video1.mov', 1220);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (22, 3, 'C:\Video\video2.mov', 1320);
INSERT INTO media (id, media_type_id, file_name, size) VALUES (23, 3, 'C:\Video\video3.mov', 1420);

/*  
 * manufacturers
 */
INSERT INTO manufacturers (id, name, media_id) VALUES (1, 'Intel', 1);
INSERT INTO manufacturers (id, name, media_id) VALUES (2, 'Asus', 2);
INSERT INTO manufacturers (id, name, media_id) VALUES (3, 'Apple', 3);
INSERT INTO manufacturers (id, name, media_id) VALUES (4, 'Samsung', 4);
INSERT INTO manufacturers (id, name, media_id) VALUES (5, 'Huawei', 5);

/*  
 * countries
 */
INSERT INTO countries (id, name) VALUES (1, 'Россия');
INSERT INTO countries (id, name) VALUES (2, 'Китай');
INSERT INTO countries (id, name) VALUES (3, 'США');
INSERT INTO countries (id, name) VALUES (4, 'Малайзия');
INSERT INTO countries (id, name) VALUES (5, 'Вьетнам');
INSERT INTO countries (id, name) VALUES (6, 'Индия');

/*  
 * catalogs
 */
INSERT INTO catalogs (id, parent_id, name) VALUES (1, NULL, 'Каталог товаров');
INSERT INTO catalogs (id, parent_id, name) VALUES (2, 1, 'Смартфоны, планшеты и фототехника');
INSERT INTO catalogs (id, parent_id, name) VALUES (3, 2, 'Смартфоны и гаджеты');
INSERT INTO catalogs (id, parent_id, name) VALUES (4, 3, 'Смартфоны');
INSERT INTO catalogs (id, parent_id, name) VALUES (5, 1, 'Компьютеры');
INSERT INTO catalogs (id, parent_id, name) VALUES (6, 5, 'Комплектующие для ПК');
INSERT INTO catalogs (id, parent_id, name) VALUES (7, 6, 'Процессоры');
INSERT INTO catalogs (id, parent_id, name) VALUES (8, 6, 'Материнские платы');
INSERT INTO catalogs (id, parent_id, name) VALUES (9, 1, 'Бытовая техника');
INSERT INTO catalogs (id, parent_id, name) VALUES (10, 1, 'Аксессуары');
INSERT INTO catalogs (id, parent_id, name) VALUES (11, 5, 'Компьютеры, ноутбуки и ПО');
INSERT INTO catalogs (id, parent_id, name) VALUES (12, 11, 'Системные блоки');
INSERT INTO catalogs (id, parent_id, name) VALUES (13, 11, 'Ноутбуки');
INSERT INTO catalogs (id, parent_id, name) VALUES (14, 11, 'Моноблоки');
INSERT INTO catalogs (id, parent_id, name) VALUES (15, 6, 'Видеокарты');
INSERT INTO catalogs (id, parent_id, name) VALUES (16, 6, 'Оперативная память');

/*  
 * products
 */
INSERT INTO products (id, catalog_id, manufacturer_id, country_id, product_code, name, description) 
  VALUES (1, 4, 3, 2, 1285374, '6.5" Смартфон Apple iPhone Xs Max 256 ГБ серый', 'Смартфон Apple iPhone Xs Max оснащен высокопроизводительным 7-нанометровым процессором Apple A12 Bionic с тактовой частотой 2.5 ГГц и 4 ГБ оперативной памяти.');
INSERT INTO products (id, catalog_id, manufacturer_id, country_id, product_code, name, description)
  VALUES (2, 4, 3, 2, 1158132, '4.7" Смартфон Apple iPhone 8 256 ГБ золотистый', '4.7" Смартфон Apple iPhone 8 256 ГБ золотистого цвета выделяется особым дизайном. Он позволит получить максимум возможностей, удобен в использовании.');
INSERT INTO products (id, catalog_id, manufacturer_id, country_id, product_code, name, description)
  VALUES (3, 4, 4, 5, 1385617, '6.8" Смартфон Samsung Galaxy Note 10+ 256 ГБ белый', 'Представляем Samsung Galaxy Note 10+. Мощность ноутбука, игровая консоль, профессиональная камера и умное электронное перо. Все это - в одном супермощном устройстве.');
INSERT INTO products (id, catalog_id, manufacturer_id, country_id, product_code, name, description)
  VALUES (4, 4, 4, 6, 1333357, '5" Смартфон Samsung Galaxy J2 Core 8 ГБ золотистый', 'Смартфон Samsung SM-J260F Galaxy J2 Core - отличный пример оптимального сочетания элегантного дизайна и достойного функционала.');
INSERT INTO products (id, catalog_id, manufacturer_id, country_id, product_code, name, description)
  VALUES (5, 4, 5, 2, 1348307, '6.47" Смартфон Huawei P30 Pro 256 ГБ голубой', '6.47″ Смартфон Huawei P30 Pro 256 ГБ обладает тонким металлическим корпусом с задней панелью из 3D-стекла.');
INSERT INTO products (id, catalog_id, manufacturer_id, country_id, product_code, name, description)
  VALUES (6, 7, 1, 4, 1308287, 'Процессор Intel Core i9-9980XE BOX', 'Неважно, работаете ли вы над полнометражным фильмом или свежим эпизодом для своего видеоблога на YouTube, процессоры Intel Core серии X с разблокированным множителем адаптируют производительность в соответствии с вашими потребностями');
INSERT INTO products (id, catalog_id, manufacturer_id, country_id, product_code, name, description)
  VALUES (7, 7, 1, 4, 1075335, 'Процессор Intel Xeon E5-2630 v4 OEM', 'Процессор Intel Xeon E5-2630 предназначен для высокопроизводительных серверных, характеризуется универсальностью, поддерживает рабочие нагрузки систем хранений.');
INSERT INTO products (id, catalog_id, manufacturer_id, country_id, product_code, name, description)
  VALUES (8, 8, 2, 2, 1007231, 'Материнская плата ASUS A68HM-K', 'Материнская плата ASUS A68HM-K с сокетом FM2+ обладает графическим интерфейсом EZ Tuning, что позволяет даже новичку оптимизировать систему под свои потребности и создавать RAID-массивы в режимах 0, 1, 10, JBOD.');
INSERT INTO products (id, catalog_id, manufacturer_id, country_id, product_code, name, description)
  VALUES (9, 8, 2, 2, 1290802, 'Материнская плата ASUS PRIME A320M-R', 'Соответствующая форм-фактору Micro-ATX материнская плата ASUS PRIME A320M-R может устанавливаться в большинство моделей корпусов, производящихся в настоящее время.');
INSERT INTO products (id, catalog_id, manufacturer_id, country_id, product_code, name, description)
  VALUES (10, 8, 2, 2, 1042379, 'Материнская плата ASUS H110M-K', 'Революционная высокопроизводительная материнская плата ASUS H110M-K расширит возможности вашего компьютера. ');

/*  
 * product_prices
 */
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (1, 1, 98999, 0, 12, '2019-01-01', NULL);
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (2, 2, 49999, 0, 12, '2019-01-01', NULL);
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (3, 3, 89999, 0, 12, '2019-01-01', NULL);
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (4, 4, 5999, 0, 12, '2019-01-01', NULL);
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (5, 5, 59999, 0, 12, '2019-01-01', NULL);
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (6, 6, 170999, 0, 12, '2019-01-01', NULL);
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (7, 7, 49799, 0, 12, '2019-01-01', NULL);
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (8, 8, 3299, 0, 12, '2019-01-01', NULL);
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (9, 9, 3850, 0, 12, '2019-01-01', NULL);
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (10, 10, 4550, 0, 12, '2019-01-01', NULL);
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (11, 8, 5550, 0, 12, '2017-01-01', '2019-12-31');
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (12, 9, 5000, 500, 12, '2018-01-01', '2019-12-31');
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (13, 10, 6000, 0, 12, '2017-01-01', '2018-12-31');
INSERT INTO product_prices (id, product_id, price, discount, warranty, start_date, end_date) 
  VALUES (14, 10, 6000, 1000, 12, '2018-01-01', '2019-01-01');

/*  
 * product_prices
 */
INSERT INTO product_images (product_id, media_id) VALUES (1, 6);
INSERT INTO product_images (product_id, media_id) VALUES (1, 7);
INSERT INTO product_images (product_id, media_id) VALUES (1, 21);
INSERT INTO product_images (product_id, media_id) VALUES (2, 8);
INSERT INTO product_images (product_id, media_id) VALUES (2, 22);
INSERT INTO product_images (product_id, media_id) VALUES (3, 9);
INSERT INTO product_images (product_id, media_id) VALUES (3, 23);
INSERT INTO product_images (product_id, media_id) VALUES (4, 10);
INSERT INTO product_images (product_id, media_id) VALUES (5, 11);
INSERT INTO product_images (product_id, media_id) VALUES (6, 12);
INSERT INTO product_images (product_id, media_id) VALUES (7, 13);
INSERT INTO product_images (product_id, media_id) VALUES (7, 14);
INSERT INTO product_images (product_id, media_id) VALUES (8, 15);
INSERT INTO product_images (product_id, media_id) VALUES (9, 16);
INSERT INTO product_images (product_id, media_id) VALUES (9, 17);
INSERT INTO product_images (product_id, media_id) VALUES (10, 18);
INSERT INTO product_images (product_id, media_id) VALUES (10, 19);
INSERT INTO product_images (product_id, media_id) VALUES (10, 20);

/*
 * feature_types
 */
INSERT INTO feature_types (id, name) VALUES (1, 'Общие параметры');
INSERT INTO feature_types (id, name) VALUES (2, 'Внешний вид');
INSERT INTO feature_types (id, name) VALUES (3, 'Экран');
INSERT INTO feature_types (id, name) VALUES (4, 'Корпус и защита');
INSERT INTO feature_types (id, name) VALUES (5, 'Система');
INSERT INTO feature_types (id, name) VALUES (6, 'Основная (тыловая) камера');
INSERT INTO feature_types (id, name) VALUES (7, 'Коммуникации');
INSERT INTO feature_types (id, name) VALUES (8, 'Ядро и архитектура');
INSERT INTO feature_types (id, name) VALUES (9, 'Частота и возможность разгона');
INSERT INTO feature_types (id, name) VALUES (10, 'Параметры оперативной памяти');
INSERT INTO feature_types (id, name) VALUES (11, 'Форм-фактор и размеры');
INSERT INTO feature_types (id, name) VALUES (12, 'Чипсет');
INSERT INTO feature_types (id, name) VALUES (13, 'Память');

/*
 * features
 */
INSERT INTO features (id, feature_types_id, name, description) VALUES (1, 1, 'Год выпуска', 'Дата выпуска');
INSERT INTO features (id, feature_types_id, name, description) VALUES (2, 2, 'Цвет, заявленный производителем', 'Цвет, заявленный производителем');
INSERT INTO features (id, feature_types_id, name, description) VALUES (3, 3, 'Диагональ экрана', 'Смартфоны с малой диагональю идеально подойдут в тех случаях, когда важна компактность устройства. Большая диагональ предпочтительна при частом просмотре видео, документов, веб-серфинге. Однако телефоны с большей диагональю сильнее расходуют аппаратные ресурсы и заряд батареи.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (4, 3, 'Разрешение экрана', 'Количество точек по вертикали и горизонтали, из которых состоит экран. Чем больше этих точек, тем четче будет изображение.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (5, 4, 'Материал корпуса', 'Производители смартфонов используют самые разнообразные материалы для изготовления корпуса, такие как металл, стекло или пластик. Пластик уступает металлу и закаленному стеклу, но у него есть важные преимущества над более прочными материалами. Главное качество пластика — его пропускные способности. Импульсы от станций сотовой связи, хот-спотов Wi-Fi и прочие сигналы лучше проходят к приемникам телефонов именно через пластиковые корпуса. Кроме того, пластик легче других материалов, и это позволяет производителям делать большие устройства со сравнительно малым для их габаритов весом. Не менее популярен в сегменте топовых гаджетов и алюминий. Данный металл достаточно легкий и практичный, чтобы полноценно использовать его в качестве корпуса мобильных аппаратов. С другой стороны, материал быстро покрывается царапинами. Придется или смириться с этим, или своевременно позаботиться о защитном чехле, пленке и т.д. Корпус, изготовленный из стекла, приятный на ощупь, комфортен при держании в руках. Износоустойчив, практически не подвержен царапинам и потертостям. Имеет хорошую проводимость сигнала и низкую стоимость. При выборе смартфона учитывайте, что каждый материал имеет свои плюсы и минусы. И часть из них нивелируются с помощью защитных кейсов, бамперов, пленок.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (6, 5, 'Версия ОС', 'Комплекс программ, с помощью которых происходит общее управление смартфоном и его взаимодействие с пользователем. С помощью операционной системы обеспечивается запуск и работа всех дополнительных программ. Указанная версия ОС устанавливается на фабрике при сборке оборудования с опциональной возможностью обновления (если это предусмотрено производителем оборудования). В зависимости от партии версия ОС "из коробки" может отличаться от заявленной. Какую конкретно версию операционной системы вы получите, приобретая смартфон, вы можете узнать непосредственно в магазинах сети ДНС.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (7, 5, 'Модель процессора', 'Модель процессора архитектуры ARM, отличающейся высокой энергоэффективностью, широким спектром поддерживаемых технологий и программных продуктов.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (8, 6, 'Количество основных (тыловых) камер', 'Существуют различные цели, для которых может применяться тыловая камера с несколькими модулями. К примеру, в Xiaomi с двойной матрицей можно делать фото со сменным фокусом. Также можно сделать две камеры с разным полем зрения, из снимков которых будет склеиваться бесшовная широкоугольная панорама. Кому-то из покупателей хочется получить оптический зум, пусть и всего двукратный. Другие ориентируются на возможности по размытию фона. В принципе, использовать двойной или тройной модуль можно многими способами, все ограничивается лишь фантазией разработчиков.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (9, 7, 'NFC', 'Технология беспроводной высокочастотной связи малого радиуса действия, которая дает возможность обмена данными между устройствами, находящимися на расстоянии около 10 сантиметров. Смартфон оснащается модулем NFC, что делает возможным абоненту вести оплату за товары и услуги, приближая телефон к устройствам считывания.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (10, 1, 'Модель', 'Фактическая модель товара, заявленная производителем. Включает в себя название марки, серии, артикула, обладает определенным набором характеристик.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (11, 1, 'Сокет', 'Сокет - это разъем, в который устанавливается центральный процессор. Модель сокета, это первое, на что необходимо обратить внимание при подборе материнской платы и системы охлаждения к процессору.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (12, 8, 'Ядро', 'Ядро — это часть процессора, отвечающая за выполнение одной последовательности команд; соответственно, наличие нескольких ядер позволяет CPU работать одновременно с несколькими задачами, что положительно сказывается на производительности. Обычно ядер — чётное количество; трёхъядерная архитектура встречается относительно редко и является скорее исключением, а одноядерные чипы практически полностью вышли из употребления. В настольных процессорах 2 ядра, как правило, характерны для бюджетных моделей и недорогих решений среднего класса, 4 — для среднего уровня, 6 и более — для продвинутого, включая процессоры для серверов и рабочих станций. В то же время отметим, что фактические возможности CPU зависят не только от количества ядер, но и от ряда особенностей и технологических ухищрений: к примеру, технология Hyper-threading позволяет заметно повысить производительность по сравнению с аналогичными моделями.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (13, 9, 'Базовая частота процессора (МГц)', 'Чем выше частота, тем выше производительность центрального процессора. Это справедливо только для определенного производителя и конкретной линейки (а также архитектуры) процессоров.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (14, 9, 'Максимальная частота в турбо режиме (МГц)', 'Как известно, не все приложения хорошо оптимизированы под многоядерные процессоры, поэтому производители с недавних пор начали оснащать свои CPU интересной и весьма полезной технологией - динамическим увеличением частоты процессора в зависимости от нагрузки в рамках конкретного теплового пакета. Это значит, что если для работы программы требуется только одно или два ядра, когда у вашего CPU их целых четыре, то за счет того, что процессор будет нагружен только на половину, увеличивается частота рабочих ядер до определенного порога энергопотребления, которое равно энергопотреблению при полной загрузке всех четырех ядер. За счет этого можно существенно повысить производительность в программах с ограниченной поддержкой многопоточности.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (15, 1, 'Код производителя', NULL);
INSERT INTO features (id, feature_types_id, name, description) VALUES (16, 10, 'Тип памяти', 'Характеристика указывает тип оперативной памяти, с которой работает данный процессор. Оперативная память компьютера относится к типу DRAM - энергозависимая память с произвольным доступом. DRAM делится на подтипы (различные версии памяти DDR), которые отличаются как разъемом, так и скоростью передачи данных (с каждым поколением скорость увеличивается).');
INSERT INTO features (id, feature_types_id, name, description) VALUES (17, 11, 'Форм-фактор', 'Форм-фактор материнской платы. Форм-фактор определяет габариты, установочные отверстия, разъемы питания материнской платы, а также требования к системе охлаждения. При выборе комплектующих для компьютера необходимо помнить, что корпус компьютера должен поддерживать форм-фактор материнской платы. Возможные форм-факторы материнских плат: ATX, microATX, EATX, BTX, mBTX, mini-ITX');
INSERT INTO features (id, feature_types_id, name, description) VALUES (18, 12, 'Чипсет', 'Чипсет - центр материнской платы, точка, в котором соединяются все шины интерфейсов подключаемых к материнской плате комплектующих. Он является так же связующим звеном большинства узлов ПК с центральным процессором. В современных компьютерах, чипсет уже играет не такую важную роль, как в ранние годы. К примеру графическое ядро интегрированного видеоускорителя уже перебралось в центральный процессор, контроллер оперативной памяти сделал это еще раньше. Постепенно различные блоки и части чипсета будут интегрироваться в CPU все интенсивнее.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (19, 13, 'Форм фактор поддерживаемой памяти', 'Оперативная память подразделяется на мобильную (SODIMM) и для обычных ПК (DIMM), поэтому будьте предельно внимательны при выборе!');
INSERT INTO features (id, feature_types_id, name, description) VALUES (20, 13, 'Максимальный объем памяти', 'Максимальный объем памяти, поддерживаемый материнской платой, также необходима поддержка данного объема процессором, модули памяти подбираются обычно одинаковые, при установке разных возможно проблемы в работе системы.');
INSERT INTO features (id, feature_types_id, name, description) VALUES (21, 1, 'Год релиза', 'Релиз – в переводе с английского "выпуск".');

/*
 * product_features
 */
INSERT INTO product_features (product_id, feature_id, value) VALUES (1, 1, '2018');
INSERT INTO product_features (product_id, feature_id, value) VALUES (1, 15, '[MT532RU/A]');
INSERT INTO product_features (product_id, feature_id, value) VALUES (1, 2, 'серый космос');
INSERT INTO product_features (product_id, feature_id, value) VALUES (1, 3, '6.5"');
INSERT INTO product_features (product_id, feature_id, value) VALUES (1, 4, '2688x1242');
INSERT INTO product_features (product_id, feature_id, value) VALUES (1, 5, 'металл, стекло');
INSERT INTO product_features (product_id, feature_id, value) VALUES (1, 6, 'iOS 12');
INSERT INTO product_features (product_id, feature_id, value) VALUES (1, 7, 'A12 Bionic');
INSERT INTO product_features (product_id, feature_id, value) VALUES (1, 8, '2');
INSERT INTO product_features (product_id, feature_id, value) VALUES (1, 9, 'есть');
INSERT INTO product_features (product_id, feature_id, value) VALUES (2, 1, '2017');
INSERT INTO product_features (product_id, feature_id, value) VALUES (2, 15, '[MQ7E2RU/A]');
INSERT INTO product_features (product_id, feature_id, value) VALUES (2, 2, 'золотой');
INSERT INTO product_features (product_id, feature_id, value) VALUES (2, 3, '4.7"');
INSERT INTO product_features (product_id, feature_id, value) VALUES (2, 4, '1334x750');
INSERT INTO product_features (product_id, feature_id, value) VALUES (2, 5, 'стекло');
INSERT INTO product_features (product_id, feature_id, value) VALUES (2, 6, 'iOS 11');
INSERT INTO product_features (product_id, feature_id, value) VALUES (2, 7, 'A11 Bionic');
INSERT INTO product_features (product_id, feature_id, value) VALUES (2, 8, '1');
INSERT INTO product_features (product_id, feature_id, value) VALUES (2, 9, 'есть');
INSERT INTO product_features (product_id, feature_id, value) VALUES (3, 1, '2019');
INSERT INTO product_features (product_id, feature_id, value) VALUES (3, 15, '[SM-N975FZWDSER]');
INSERT INTO product_features (product_id, feature_id, value) VALUES (3, 2, 'белый');
INSERT INTO product_features (product_id, feature_id, value) VALUES (3, 3, '6.8"');
INSERT INTO product_features (product_id, feature_id, value) VALUES (3, 4, '3040x1440');
INSERT INTO product_features (product_id, feature_id, value) VALUES (3, 5, 'металл, стекло');
INSERT INTO product_features (product_id, feature_id, value) VALUES (3, 6, 'Android 9.0 Pie');
INSERT INTO product_features (product_id, feature_id, value) VALUES (3, 7, 'Exynos 9825');
INSERT INTO product_features (product_id, feature_id, value) VALUES (3, 8, '4');
INSERT INTO product_features (product_id, feature_id, value) VALUES (3, 9, 'есть');
INSERT INTO product_features (product_id, feature_id, value) VALUES (4, 1, '2018');
INSERT INTO product_features (product_id, feature_id, value) VALUES (4, 15, '[SM-J260FZDRSER]');
INSERT INTO product_features (product_id, feature_id, value) VALUES (4, 2, 'золотой');
INSERT INTO product_features (product_id, feature_id, value) VALUES (4, 3, '5"');
INSERT INTO product_features (product_id, feature_id, value) VALUES (4, 4, '960x540');
INSERT INTO product_features (product_id, feature_id, value) VALUES (4, 5, 'пластик');
INSERT INTO product_features (product_id, feature_id, value) VALUES (4, 6, 'Android 8.1 Oreo Go');
INSERT INTO product_features (product_id, feature_id, value) VALUES (4, 7, 'Exynos 4 Quad 7570');
INSERT INTO product_features (product_id, feature_id, value) VALUES (4, 8, '1');
INSERT INTO product_features (product_id, feature_id, value) VALUES (4, 9, 'нет');
INSERT INTO product_features (product_id, feature_id, value) VALUES (5, 1, '2019');
INSERT INTO product_features (product_id, feature_id, value) VALUES (5, 15, '[51093NCH]');
INSERT INTO product_features (product_id, feature_id, value) VALUES (5, 2, 'светло-голубой');
INSERT INTO product_features (product_id, feature_id, value) VALUES (5, 3, '6.47"');
INSERT INTO product_features (product_id, feature_id, value) VALUES (5, 4, '2340x1080');
INSERT INTO product_features (product_id, feature_id, value) VALUES (5, 5, 'металл, стекло');
INSERT INTO product_features (product_id, feature_id, value) VALUES (5, 6, 'Android 9.0 Pie');
INSERT INTO product_features (product_id, feature_id, value) VALUES (5, 7, 'HiSilicon Kirin 980');
INSERT INTO product_features (product_id, feature_id, value) VALUES (5, 8, '3');
INSERT INTO product_features (product_id, feature_id, value) VALUES (5, 9, 'есть');
INSERT INTO product_features (product_id, feature_id, value) VALUES (6, 10, 'Intel Core i9-9980XE');
INSERT INTO product_features (product_id, feature_id, value) VALUES (6, 15, '[BX80673I99980X]');
INSERT INTO product_features (product_id, feature_id, value) VALUES (6, 21, '2018');
INSERT INTO product_features (product_id, feature_id, value) VALUES (6, 11, 'LGA 2066');
INSERT INTO product_features (product_id, feature_id, value) VALUES (6, 12, 'Skylake-X');
INSERT INTO product_features (product_id, feature_id, value) VALUES (6, 13, '3000 МГц');
INSERT INTO product_features (product_id, feature_id, value) VALUES (6, 14, '4400 МГц');
INSERT INTO product_features (product_id, feature_id, value) VALUES (6, 16, 'DDR4');
INSERT INTO product_features (product_id, feature_id, value) VALUES (7, 10, 'Intel Xeon E5-2630 v4');
INSERT INTO product_features (product_id, feature_id, value) VALUES (7, 15, '[CM8066002032301]');
INSERT INTO product_features (product_id, feature_id, value) VALUES (7, 11, 'LGA 2011-3');
INSERT INTO product_features (product_id, feature_id, value) VALUES (7, 12, 'Broadwell-EP');
INSERT INTO product_features (product_id, feature_id, value) VALUES (7, 13, '2200 МГц');
INSERT INTO product_features (product_id, feature_id, value) VALUES (7, 14, '3100 МГц');
INSERT INTO product_features (product_id, feature_id, value) VALUES (7, 16, 'DDR4');
INSERT INTO product_features (product_id, feature_id, value) VALUES (8, 10, 'ASUS A68HM-K');
INSERT INTO product_features (product_id, feature_id, value) VALUES (8, 21, '2014');
INSERT INTO product_features (product_id, feature_id, value) VALUES (8, 17, 'Micro-ATX');
INSERT INTO product_features (product_id, feature_id, value) VALUES (8, 18, 'AMD A68H');
INSERT INTO product_features (product_id, feature_id, value) VALUES (8, 19, 'DIMM');
INSERT INTO product_features (product_id, feature_id, value) VALUES (8, 20, '32 ГБ');
INSERT INTO product_features (product_id, feature_id, value) VALUES (9, 10, 'ASUS PRIME A320M-R');
INSERT INTO product_features (product_id, feature_id, value) VALUES (9, 21, '2018');
INSERT INTO product_features (product_id, feature_id, value) VALUES (9, 17, 'Micro-ATX');
INSERT INTO product_features (product_id, feature_id, value) VALUES (9, 18, 'AMD A320');
INSERT INTO product_features (product_id, feature_id, value) VALUES (9, 19, 'DIMM');
INSERT INTO product_features (product_id, feature_id, value) VALUES (9, 20, '32 ГБ');
INSERT INTO product_features (product_id, feature_id, value) VALUES (10, 10, 'ASUS H110M-K');
INSERT INTO product_features (product_id, feature_id, value) VALUES (10, 21, '2015');
INSERT INTO product_features (product_id, feature_id, value) VALUES (10, 17, 'Micro-ATX');
INSERT INTO product_features (product_id, feature_id, value) VALUES (10, 18, 'LGA 1151');
INSERT INTO product_features (product_id, feature_id, value) VALUES (10, 19, 'DIMM');
INSERT INTO product_features (product_id, feature_id, value) VALUES (10, 20, '32 ГБ');

/*
 * cities
 */
INSERT INTO cities (id, country_id, name) VALUES (1, 1, 'Москва');
INSERT INTO cities (id, country_id, name) VALUES (2, 1, 'Санкт-Петербург');
INSERT INTO cities (id, country_id, name) VALUES (3, 1, 'Сургут');
INSERT INTO cities (id, country_id, name) VALUES (4, 1, 'Тюмень');
INSERT INTO cities (id, country_id, name) VALUES (5, 1, 'Екатеринбург');

/*
 * shops
 */
INSERT INTO shops (id, city_id, address, name) VALUES (1, 1, 'Бульвар Адмирала Ушакова - 117042, Москва г., Венёвская, ул, дом 4', 'Москва ТЦ Южное Бутово');
INSERT INTO shops (id, city_id, address, name) VALUES (2, 1, 'Киевское шоссе 22-й км. (п. Московский), домовл. 4, строен. 1, блок А, этаж 1', 'Москва БП Румянцево');
INSERT INTO shops (id, city_id, address, name) VALUES (3, 2, 'ул. Маршала Казакова, д. 35', 'М. Автово Ярмарка «Юнона»');
INSERT INTO shops (id, city_id, address, name) VALUES (4, 2, 'Комендантский проспект - ул. Комендантская площадь, д. 1, лит. А', 'М. Комендантский проспект ГИПЕР ТРК «Атмосфера»');
INSERT INTO shops (id, city_id, address, name) VALUES (5, 3, 'ул. Генерала Иванова, д.1', 'ТРЦ «Вершина» Гипер');
INSERT INTO shops (id, city_id, address, name) VALUES (6, 4, 'г. Тюмень, ул. Профсоюзная д.1, к.1', 'Тюмень Окей на Профсоюзной');
INSERT INTO shops (id, city_id, address, name) VALUES (7, 5, 'ул. Малышева, 5, 1й этаж', '«ТРЦ Алатырь». Цифровая и бытовая техника.');

/*
 * users
 */
INSERT INTO users (id, email, phone, nickname, first_name, last_name, birthday, city_id, shop_id, sex, reg_date, password) 
  VALUES (1, 'leo@mail.ru', '89225780315', 'Leo', 'Леонид', NULL, '2000-01-01', 1, 1, 'M', '2018-02-03', SHA2('qwerty', 224));
INSERT INTO users (id, email, phone, nickname, first_name, last_name, birthday, city_id, shop_id, sex, reg_date, password) 
  VALUES (2, 'f34f34f34@mail.ru', '89225759994', 'Helen', 'Елена', 'Иванова', '1987-10-02', 1, 1, 'F', '2017-02-03', SHA2('12345', 224));
INSERT INTO users (id, email, phone, nickname, first_name, last_name, birthday, city_id, shop_id, sex, reg_date, password) 
  VALUES (3, 'noname@mail.ru', '89295959594', 'Noname', 'Без имени', NULL, NULL, 1, 2, NULL, '2019-02-03', SHA2('1q2w3e4r', 224));
INSERT INTO users (id, email, phone, nickname, first_name, last_name, birthday, city_id, shop_id, sex, reg_date, password) 
  VALUES (4, 'ererer@mail.ru', '89295945664', 'User1', 'Юзер1', NULL, NULL, 2, 3, NULL, '2019-01-03', SHA2('1q22344r', 224));
INSERT INTO users (id, email, phone, nickname, first_name, last_name, birthday, city_id, shop_id, sex, reg_date, password) 
  VALUES (5, 'error@mail.ru', '89293243664', 'error', 'Ошибка', NULL, NULL, 3, 5, 'M', '2019-01-03', SHA2('1445е522344r', 224));
INSERT INTO users (id, email, phone, nickname, first_name, last_name, birthday, city_id, shop_id, sex, reg_date, password) 
  VALUES (6, 'goga@mail.ru', '89295943444', 'Goga', 'Григорий', NULL, NULL, 3, 5, NULL, '2017-01-03', SHA2('1q225ее45нr', 224));
INSERT INTO users (id, email, phone, nickname, first_name, last_name, birthday, city_id, shop_id, sex, reg_date, password) 
  VALUES (7, 'nadia@mail.ru', '89395945664', 'Nadia', 'Надя', NULL, NULL, 4, 6, 'F', '2014-01-03', SHA2('4g46gh5tr', 224));
INSERT INTO users (id, email, phone, nickname, first_name, last_name, birthday, city_id, shop_id, sex, reg_date, password) 
  VALUES (8, 'maha@mail.ru', '89295945452', 'Maha', 'Маша', NULL, NULL, 5, 7, 'F', '2015-01-01', SHA2('gg54', 224));
INSERT INTO users (id, email, phone, nickname, first_name, last_name, birthday, city_id, shop_id, sex, reg_date, password) 
  VALUES (9, 'kostian@mail.ru', '89295934364', 'Kostian', 'Константин', NULL, NULL, 5, NULL, 'M', '2016-03-03', SHA2('045t4tok', 224));
INSERT INTO users (id, email, phone, nickname, first_name, last_name, birthday, city_id, shop_id, sex, reg_date, password) 
  VALUES (10, 'user2@mail.ru', '89295945444', 'User2', 'Юзер2', NULL, NULL, 5, NULL, NULL, '2013-01-03', SHA2('J!orfork', 224));


/*
 * product_reviews
 */
INSERT INTO product_reviews (id, product_id, use_id, review, rating) VALUES (1, 1, 1, 'Ужас!', 0);
INSERT INTO product_reviews (id, product_id, use_id, review, rating) VALUES (2, 1, 2, 'Нормально. Работает', 5);
INSERT INTO product_reviews (id, product_id, use_id, review, rating) VALUES (3, 1, 3, 'Дорого. А так нормально', 4);
INSERT INTO product_reviews (id, product_id, use_id, review, rating) VALUES (4, 3, 4, 'Не рекомендую', 1);
INSERT INTO product_reviews (id, product_id, use_id, review, rating) VALUES (5, 3, 5, 'Из достоинств - белый', 2);
INSERT INTO product_reviews (id, product_id, use_id, review, rating) VALUES (6, 4, 6, 'Дёшево и сердито', 4);
INSERT INTO product_reviews (id, product_id, use_id, review, rating) VALUES (7, 5, 7, 'Супер!', 5);
INSERT INTO product_reviews (id, product_id, use_id, review, rating) VALUES (8, 6, 8, 'Купил. Установил. Забыл', 5);
INSERT INTO product_reviews (id, product_id, use_id, review, rating) VALUES (9, 7, 9, 'Сгорел в первый же день', 0);
INSERT INTO product_reviews (id, product_id, use_id, review, rating) VALUES (10, 8, 9, 'Работает', 4);

