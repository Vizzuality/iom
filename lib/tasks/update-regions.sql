ALTER TABLE projects_regions ADD CONSTRAINT region_id_fk 
    FOREIGN KEY (region_id) REFERENCES regions (id) ON UPDATE NO ACTION ON DELETE NO ACTION;
INSERT INTO countries(id,name,center_lat,center_lon) VALUES (247,'South Sudan',7.089264,30.849609);
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10000,'Christmas Island',1,9,
        ST_GeomFromtext('POINT(105.690449 -10.447525)',4326),-10.447525,
        105.690449,'9/10000');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10001,'Cocos (Keeling) Islands',1,9,
        ST_GeomFromtext('POINT(96.868917 -12.172936)',4326),-12.172936,
        96.868917,'9/10001');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10002,'Norfolk Island',1,9,
        ST_GeomFromtext('POINT(167.954712 -29.040835)',4326),-29.040835,
        167.954712,'9/10002');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10003,'Goycay',1,3,
        ST_GeomFromtext('POINT(47.833333 40.583333)',4326),40.583333,
        47.833333,'3/10003');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10004,'Lacin',1,3,
        ST_GeomFromtext('POINT(46.416667 39.666667)',4326),39.666667,
        46.416667,'3/10004');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10005,'Lankaran Sahari',1,3,
        ST_GeomFromtext('POINT(48.916667 38.916667)',4326),38.916667,
        48.916667,'3/10005');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10006,'Naftalan Sahari',1,3,
        ST_GeomFromtext('POINT(46.716667 40.483333)',4326),40.483333,
        46.716667,'3/10006');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10007,'Saki Sahari',1,3,
        ST_GeomFromtext('POINT(47.166667 41.183333)',4326),41.183333,
        47.166667,'3/10007');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10008,'Susa Sahari',1,3,
        ST_GeomFromtext('POINT(46.666667 39.666667)',4326),39.666667,
        46.666667,'3/10008');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10009,'Xankandi Sahari',1,3,
        ST_GeomFromtext('POINT(46.8 39.816667)',4326),39.816667,
        46.8,'3/10009');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10010,'Yevlax Sahari',1,3,
        ST_GeomFromtext('POINT(47.166667 40.583333)',4326),40.583333,
        47.166667,'3/10010');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10011,'Brcko district',1,16,
        ST_GeomFromtext('POINT(18.830671 44.824256)',4326),44.824256,
        18.830671,'16/10011');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10012,'Chobe',1,182,
        ST_GeomFromtext('POINT(24.529194 -18.750162)',4326),-18.750162,
        24.529194,'182/10012');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10013,'Boucle du Mouhoun',1,210,
        ST_GeomFromtext('POINT(-3.419553 12.4166)',4326),12.4166,
        -3.419553,'210/10013');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10014,'Cascades',1,210,
        ST_GeomFromtext('POINT(-4.562443 10.407299)',4326),10.407299,
        -4.562443,'210/10014');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10015,'Centre',1,210,
        ST_GeomFromtext('POINT(-1.443541 12.342546)',4326),12.342546,
        -1.443541,'210/10015');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10016,'Centre-Est',1,210,
        ST_GeomFromtext('POINT(-0.149499 11.524767)',4326),11.524767,
        -0.149499,'210/10016');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10017,'Centre-Nord',1,210,
        ST_GeomFromtext('POINT(-0.905662 13.172446)',4326),13.172446,
        -0.905662,'210/10017');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10018,'Centre-Ouest',1,210,
        ST_GeomFromtext('POINT(-2.302099 11.880169)',4326),11.880169,
        -2.302099,'210/10018');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10019,'Centre-Sud',1,210,
        ST_GeomFromtext('POINT(-1.055353 11.516503)',4326),11.516503,
        -1.055353,'210/10019');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10020,'Est',1,210,
        ST_GeomFromtext('POINT(0.905662 12.436553)',4326),12.436553,
        0.905662,'210/10020');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10021,'Hauts-Bassins',1,210,
        ST_GeomFromtext('POINT(-4.233336 11.4942)',4326),11.4942,
        -4.233336,'210/10021');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10022,'Nord',1,210,
        ST_GeomFromtext('POINT(-2.302446 13.718252)',4326),13.718252,
        -2.302446,'210/10022');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10023,'Plateau Central',1,210,
        ST_GeomFromtext('POINT(-0.753281 12.253765)',4326),12.253765,
        -0.753281,'210/10023');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10024,'Sahel',1,210,
        ST_GeomFromtext('POINT(-0.149499 14.100086)',4326),14.100086,
        -0.149499,'210/10024');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10025,'Sud-Ouest',1,210,
        ST_GeomFromtext('POINT(-3.258363 10.423149)',4326),10.423149,
        -3.258363,'210/10025');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10026,'Aksai Chin',1,30,
        ST_GeomFromtext('POINT(79.107684 35.13022)',4326),35.13022,
        79.107684,'30/10026');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10027,'Hong Kong',1,30,
        ST_GeomFromtext('POINT(114.109497 22.396428)',4326),22.396428,
        114.109497,'30/10027');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10028,'Macau',1,30,
        ST_GeomFromtext('POINT(113.554994 22.163845)',4326),22.163845,
        113.554994,'30/10028');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10029,'Grande Comore',1,37,
        ST_GeomFromtext('POINT(43.333333 -11.583333)',4326),-11.583333,
        43.333333,'37/10029');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10030,'Anjouan',1,37,
        ST_GeomFromtext('POINT(44.416667 -12.25)',4326),-12.25,
        44.416667,'37/10030');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10031,'Domoni',1,37,
        ST_GeomFromtext('POINT(44.530278 -12.258611)',4326),-12.258611,
        44.530278,'37/10031');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10032,'Fomboni',1,37,
        ST_GeomFromtext('POINT(43.739654 -12.288336)',4326),-12.288336,
        43.739654,'37/10032');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10033,'Moheli',1,37,
        ST_GeomFromtext('POINT(43.75 -12.25)',4326),-12.25,
        43.75,'37/10033');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10034,'Moroni',1,37,
        ST_GeomFromtext('POINT(43.252927 -11.701232)',4326),-11.701232,
        43.252927,'37/10034');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10035,'Moutsamoudou',1,37,
        ST_GeomFromtext('POINT(44.4 -12.166667)',4326),-12.166667,
        44.4,'37/10035');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10036,'Brazzaville',1,27,
        ST_GeomFromtext('POINT(15.283333 -4.266667)',4326),-4.266667,
        15.283333,'27/10036');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10037,'Pointe-Noire',1,27,
        ST_GeomFromtext('POINT(11.86364 -4.77867)',4326),-4.77867,
        11.86364,'27/10037');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10038,'Artemisa',1,80,
        ST_GeomFromtext('POINT(-82.7 22.88333)',4326),22.88333,
        -82.7,'80/10038');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10039,'Mayabeque',1,41,
        ST_GeomFromtext('POINT(-81.95 22.88333)',4326),22.88333,
        -81.95,'41/10039');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10040,'Hovedstaden',1,45,
        ST_GeomFromtext('POINT(12.333333 55.833333)',4326),55.833333,
        12.333333,'45/10040');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10041,'Midtjylland',1,45,
        ST_GeomFromtext('POINT(9.5 56.166667)',4326),56.166667,
        9.5,'45/10041');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10042,'Nordjylland',1,45,
        ST_GeomFromtext('POINT(9.666667 57.0)',4326),57.0,
        9.666667,'45/10042');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10043,'Sjaelland',1,45,
        ST_GeomFromtext('POINT(11.833333 55.416667)',4326),55.416667,
        11.833333,'45/10043');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10044,'Syddanmark',1,45,
        ST_GeomFromtext('POINT(9.666667 55.333333)',4326),55.333333,
        9.666667,'45/10044');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10045,'Faroe Islands',1,45,
        ST_GeomFromtext('POINT(-7.0 62.0)',4326),62.0,
        -7.0,'45/10045');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10046,'Arta',1,46,
        ST_GeomFromtext('POINT(42.75 11.5)',4326),11.5,
        42.75,'46/10046');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10047,'Luxor',1,50,
        ST_GeomFromtext('POINT(32.65 25.7)',4326),25.7,
        32.65,'50/10047');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10048,'Aland',1,60,
        ST_GeomFromtext('POINT(20.0 60.25)',4326),60.25,
        20.0,'60/10048');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10049,'South Karelia',1,60,
        ST_GeomFromtext('POINT(28.0 60.833333)',4326),60.833333,
        28.0,'60/10049');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10050,'South Ostrobothnia',1,60,
        ST_GeomFromtext('POINT(23.25 62.5)',4326),62.5,
        23.25,'60/10050');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10051,'South Savo',1,60,
        ST_GeomFromtext('POINT(27.833333 61.75)',4326),61.75,
        27.833333,'60/10051');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10052,'Kanta-Hame',1,60,
        ST_GeomFromtext('POINT(24.25 60.833333)',4326),60.833333,
        24.25,'60/10052');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10053,'Kainuu',1,60,
        ST_GeomFromtext('POINT(28.0 64.5)',4326),64.5,
        28.0,'60/10053');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10054,'Central Ostrobothnia',1,60,
        ST_GeomFromtext('POINT(24.0 63.5)',4326),63.5,
        24.0,'60/10054');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10055,'Central Finland',1,60,
        ST_GeomFromtext('POINT(24.0 63.5)',4326),63.5,
        24.0,'60/10055');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10056,'Kymenlaakso',1,60,
        ST_GeomFromtext('POINT(27.0 60.5)',4326),60.5,
        27.0,'60/10056');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10057,'Lappi',1,60,
        ST_GeomFromtext('POINT(27.0 68.0)',4326),68.0,
        27.0,'60/10057');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10058,'Paijat-Hame',1,60,
        ST_GeomFromtext('POINT(25.833333 61.25)',4326),61.25,
        25.833333,'60/10058');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10059,'Tampere',1,60,
        ST_GeomFromtext('POINT(23.716667 61.7)',4326),61.7,
        23.716667,'60/10059');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10060,'Ostrobothnia',1,60,
        ST_GeomFromtext('POINT(22.0 63.0)',4326),63.0,
        22.0,'60/10060');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10061,'North Karelia',1,60,
        ST_GeomFromtext('POINT(30.0 63.0)',4326),63.0,
        30.0,'60/10061');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10062,'North Ostrobothnia',1,60,
        ST_GeomFromtext('POINT(26.0 65.0)',4326),65.0,
        26.0,'60/10062');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10063,'North Savo',1,60,
        ST_GeomFromtext('POINT(27.5 63.0)',4326),63.0,
        27.5,'60/10063');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10064,'Satakunta',1,60,
        ST_GeomFromtext('POINT(22.0 61.333333)',4326),61.333333,
        22.0,'60/10064');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10065,'Newland',1,60,
        ST_GeomFromtext('POINT(24.5 60.25)',4326),60.25,
        24.5,'60/10065');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10066,'Southwest Finland',1,60,
        ST_GeomFromtext('POINT(22.25 60.5)',4326),60.5,
        22.25,'60/10066');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10067,'Guadeloupe',1,65,
        ST_GeomFromtext('POINT(-61.583333 16.25)',4326),16.25,
        -61.583333,'65/10067');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10068,'French Guiana',1,65,
        ST_GeomFromtext('POINT(-53.0 4.0)',4326),4.0,
        -53.0,'65/10068');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10069,'Reunion',1,65,
        ST_GeomFromtext('POINT(55.6 -21.1)',4326),-21.1,
        55.6,'65/10069');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10070,'Martinique',1,65,
        ST_GeomFromtext('POINT(-61.0 14.666667)',4326),14.666667,
        -61.0,'65/10070');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10071,'Mayotte',1,65,
        ST_GeomFromtext('POINT(45.166244 -12.8275)',4326),-12.8275,
        45.166244,'65/10071');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10072,'Bassas da India',1,65,
        ST_GeomFromtext('POINT(39.693532 -21.495934)',4326),-21.495934,
        39.693532,'65/10072');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10073,'French Polynesia',1,65,
        ST_GeomFromtext('POINT(-149.459115 -17.65692)',4326),-17.65692,
        -149.459115,'65/10073');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10074,'French Southern and Antarctic Lands',1,65,
        ST_GeomFromtext('POINT(69.348582 -49.280364)',4326),-49.280364,
        69.348582,'65/10074');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10075,'Glorioso Island',1,65,
        ST_GeomFromtext('POINT(47.299211 -11.567695)',4326),-11.567695,
        47.299211,'65/10075');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10076,'Juan de Nova Island',1,65,
        ST_GeomFromtext('POINT(42.739372 -17.055097)',4326),-17.055097,
        42.739372,'65/10076');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10077,'New Caledonia',1,65,
        ST_GeomFromtext('POINT(165.47385 -21.441103)',4326),-21.441103,
        165.47385,'65/10077');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10078,'Saint Pierre and Miquelon',1,65,
        ST_GeomFromtext('POINT(-56.27111 46.783333)',4326),46.783333,
        -56.27111,'65/10078');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10079,'Tromelin Island',1,65,
        ST_GeomFromtext('POINT(54.521547 -15.890964)',4326),-15.890964,
        54.521547,'65/10079');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10080,'Wallis and Futuna',1,65,
        ST_GeomFromtext('POINT(-177.169938 -13.856022)',4326),-13.856022,
        -177.169938,'65/10080');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10081,'Europa Island',1,65,
        ST_GeomFromtext('POINT(40.363333 -22.368333)',4326),-22.368333,
        40.363333,'65/10081');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10082,'Achaia',1,74,
        ST_GeomFromtext('POINT(22.0 38.0)',4326),38.0,
        22.0,'74/10082');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10083,'Aitolia kai Akarnania',1,74,
        ST_GeomFromtext('POINT(21.5 38.5)',4326),38.5,
        21.5,'74/10083');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10084,'Argolis',1,74,
        ST_GeomFromtext('POINT(22.833333 37.666667)',4326),37.666667,
        22.833333,'74/10084');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10085,'Arkadia',1,74,
        ST_GeomFromtext('POINT(22.25 37.583333)',4326),37.583333,
        22.25,'74/10085');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10086,'Arta',1,74,
        ST_GeomFromtext('POINT(21.0 39.166667)',4326),39.166667,
        21.0,'74/10086');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10087,'Attiki',1,74,
        ST_GeomFromtext('POINT(23.5 38.083333)',4326),38.083333,
        23.5,'74/10087');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10088,'Chalkidiki',1,74,
        ST_GeomFromtext('POINT(23.5 40.416667)',4326),40.416667,
        23.5,'74/10088');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10089,'Chania',1,74,
        ST_GeomFromtext('POINT(24.0 35.333333)',4326),35.333333,
        24.0,'74/10089');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10090,'Chios',1,74,
        ST_GeomFromtext('POINT(26.0 38.416667)',4326),38.416667,
        26.0,'74/10090');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10091,'Dodekanisos',1,74,
        ST_GeomFromtext('POINT(27.083333 36.833333)',4326),36.833333,
        27.083333,'74/10091');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10092,'Drama',1,74,
        ST_GeomFromtext('POINT(24.25 41.25)',4326),41.25,
        24.25,'74/10092');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10093,'Evros',1,74,
        ST_GeomFromtext('POINT(26.0 41.0)',4326),41.0,
        26.0,'74/10093');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10094,'Evrytania',1,74,
        ST_GeomFromtext('POINT(21.666667 39.0)',4326),39.0,
        21.666667,'74/10094');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10095,'Evvoia',1,74,
        ST_GeomFromtext('POINT(24.0 38.5)',4326),38.5,
        24.0,'74/10095');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10096,'Florina',1,74,
        ST_GeomFromtext('POINT(21.416667 40.75)',4326),40.75,
        21.416667,'74/10096');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10097,'Fokidos',1,74,
        ST_GeomFromtext('POINT(22.25 38.5)',4326),38.5,
        22.25,'74/10097');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10098,'Fthiotis',1,74,
        ST_GeomFromtext('POINT(22.416667 38.833333)',4326),38.833333,
        22.416667,'74/10098');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10099,'Grevena',1,74,
        ST_GeomFromtext('POINT(21.416667 40.083333)',4326),40.083333,
        21.416667,'74/10099');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10100,'Ileia',1,74,
        ST_GeomFromtext('POINT(21.583333 37.75)',4326),37.75,
        21.583333,'74/10100');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10101,'Imathia',1,74,
        ST_GeomFromtext('POINT(22.25 40.5)',4326),40.5,
        22.25,'74/10101');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10102,'Ioannina',1,74,
        ST_GeomFromtext('POINT(20.666667 39.75)',4326),39.75,
        20.666667,'74/10102');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10103,'Irakleion',1,74,
        ST_GeomFromtext('POINT(25.166667 35.166667)',4326),35.166667,
        25.166667,'74/10103');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10104,'Karditsa',1,74,
        ST_GeomFromtext('POINT(21.75 39.333333)',4326),39.333333,
        21.75,'74/10104');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10105,'Kastoria',1,74,
        ST_GeomFromtext('POINT(21.166667 40.5)',4326),40.5,
        21.166667,'74/10105');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10106,'Kavala',1,74,
        ST_GeomFromtext('POINT(24.5 41.0)',4326),41.0,
        24.5,'74/10106');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10107,'Kefallinia',1,74,
        ST_GeomFromtext('POINT(20.5 38.25)',4326),38.25,
        20.5,'74/10107');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10108,'Kerkyra',1,74,
        ST_GeomFromtext('POINT(19.75 39.666667)',4326),39.666667,
        19.75,'74/10108');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10109,'Kilkis',1,74,
        ST_GeomFromtext('POINT(22.666667 41.0)',4326),41.0,
        22.666667,'74/10109');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10110,'Korinthia',1,74,
        ST_GeomFromtext('POINT(22.666667 37.916667)',4326),37.916667,
        22.666667,'74/10110');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10111,'Kozani',1,74,
        ST_GeomFromtext('POINT(21.716667 40.333333)',4326),40.333333,
        21.716667,'74/10111');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10112,'Kyklades',1,74,
        ST_GeomFromtext('POINT(24.916667 37.416667)',4326),37.416667,
        24.916667,'74/10112');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10113,'Lakonia',1,74,
        ST_GeomFromtext('POINT(22.583333 37.0)',4326),37.0,
        22.583333,'74/10113');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10114,'Larisa',1,74,
        ST_GeomFromtext('POINT(22.5 39.5)',4326),39.5,
        22.5,'74/10114');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10115,'Lasithi',1,74,
        ST_GeomFromtext('POINT(25.833333 35.083333)',4326),35.083333,
        25.833333,'74/10115');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10116,'Lefkada',1,74,
        ST_GeomFromtext('POINT(20.666667 38.75)',4326),38.75,
        20.666667,'74/10116');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10117,'Lesvos',1,74,
        ST_GeomFromtext('POINT(26.333333 39.166667)',4326),39.166667,
        26.333333,'74/10117');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10118,'Magnisia',1,74,
        ST_GeomFromtext('POINT(22.75 39.25)',4326),39.25,
        22.75,'74/10118');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10119,'Messinia',1,74,
        ST_GeomFromtext('POINT(21.833333 37.25)',4326),37.25,
        21.833333,'74/10119');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10120,'Pella',1,74,
        ST_GeomFromtext('POINT(22.25 40.833333)',4326),40.833333,
        22.25,'74/10120');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10121,'Pieria',1,74,
        ST_GeomFromtext('POINT(22.416667 40.25)',4326),40.25,
        22.416667,'74/10121');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10122,'Preveza',1,74,
        ST_GeomFromtext('POINT(20.666667 39.166667)',4326),39.166667,
        20.666667,'74/10122');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10123,'Rethymnis',1,74,
        ST_GeomFromtext('POINT(24.583333 35.25)',4326),35.25,
        24.583333,'74/10123');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10124,'Rodopi',1,74,
        ST_GeomFromtext('POINT(25.5 41.083333)',4326),41.083333,
        25.5,'74/10124');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10125,'Samos',1,74,
        ST_GeomFromtext('POINT(26.75 37.75)',4326),37.75,
        26.75,'74/10125');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10126,'Serres',1,74,
        ST_GeomFromtext('POINT(23.5 41.166667)',4326),41.166667,
        23.5,'74/10126');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10127,'Thesprotia',1,74,
        ST_GeomFromtext('POINT(20.333333 39.5)',4326),39.5,
        20.333333,'74/10127');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10128,'Thessaloniki',1,74,
        ST_GeomFromtext('POINT(23.0 40.666667)',4326),40.666667,
        23.0,'74/10128');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10129,'Trikala',1,74,
        ST_GeomFromtext('POINT(21.5 39.666667)',4326),39.666667,
        21.5,'74/10129');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10130,'Voiotia',1,74,
        ST_GeomFromtext('POINT(23.0 38.333333)',4326),38.333333,
        23.0,'74/10130');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10131,'Xanthi',1,74,
        ST_GeomFromtext('POINT(24.833333 41.166667)',4326),41.166667,
        24.833333,'74/10131');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10132,'Zakynthos',1,74,
        ST_GeomFromtext('POINT(20.75 37.75)',4326),37.75,
        20.75,'74/10132');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10133,'Kujalleq',1,71,
        ST_GeomFromtext('POINT(-45.0 61.0)',4326),61.0,
        -45.0,'71/10133');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10134,'Qaasuitsup',1,71,
        ST_GeomFromtext('POINT(-57.0 76.0)',4326),76.0,
        -57.0,'71/10134');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10135,'Qeqqata',1,71,
        ST_GeomFromtext('POINT(-48.0 66.5)',4326),66.5,
        -48.0,'71/10135');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10136,'Sermersooq',1,71,
        ST_GeomFromtext('POINT(-40.0 66.0)',4326),66.0,
        -40.0,'71/10136');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10137,'Beyla',1,76,
        ST_GeomFromtext('POINT(-8.416667 8.916667)',4326),8.916667,
        -8.416667,'76/10137');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10138,'Boffa',1,76,
        ST_GeomFromtext('POINT(-14.166667 10.333333)',4326),10.333333,
        -14.166667,'76/10138');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10139,'Boke',1,76,
        ST_GeomFromtext('POINT(-14.416667 11.083333)',4326),11.083333,
        -14.416667,'76/10139');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10140,'Conakry',1,76,
        ST_GeomFromtext('POINT(-13.666667 9.5)',4326),9.5,
        -13.666667,'76/10140');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10141,'Coyah',1,76,
        ST_GeomFromtext('POINT(-13.416667 9.75)',4326),9.75,
        -13.416667,'76/10141');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10142,'Dabola',1,76,
        ST_GeomFromtext('POINT(-11.116667 10.6)',4326),10.6,
        -11.116667,'76/10142');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10143,'Dalaba',1,76,
        ST_GeomFromtext('POINT(-12.3 10.75)',4326),10.75,
        -12.3,'76/10143');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10144,'Dinguiraye',1,76,
        ST_GeomFromtext('POINT(-10.916667 11.5)',4326),11.5,
        -10.916667,'76/10144');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10145,'Dubreka',1,76,
        ST_GeomFromtext('POINT(-13.416667 10.25)',4326),10.25,
        -13.416667,'76/10145');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10146,'Faranah',1,76,
        ST_GeomFromtext('POINT(-10.833333 10.0)',4326),10.0,
        -10.833333,'76/10146');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10147,'Forecariah',1,76,
        ST_GeomFromtext('POINT(-13.1 9.433333)',4326),9.433333,
        -13.1,'76/10147');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10148,'Fria',1,76,
        ST_GeomFromtext('POINT(-13.583333 10.416667)',4326),10.416667,
        -13.583333,'76/10148');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10149,'Gaoual',1,76,
        ST_GeomFromtext('POINT(-13.2 11.75)',4326),11.75,
        -13.2,'76/10149');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10150,'Gueckedou',1,76,
        ST_GeomFromtext('POINT(-10.25 8.666667)',4326),8.666667,
        -10.25,'76/10150');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10151,'Kankan',1,76,
        ST_GeomFromtext('POINT(-9.0 10.0)',4326),10.0,
        -9.0,'76/10151');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10152,'Kerouane',1,76,
        ST_GeomFromtext('POINT(-9.083333 9.166667)',4326),9.166667,
        -9.083333,'76/10152');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10153,'Kindia',1,76,
        ST_GeomFromtext('POINT(-12.8 10.083333)',4326),10.083333,
        -12.8,'76/10153');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10154,'Kissidougou',1,76,
        ST_GeomFromtext('POINT(-9.916667 9.25)',4326),9.25,
        -9.916667,'76/10154');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10155,'Koubia',1,76,
        ST_GeomFromtext('POINT(-11.833333 11.583333)',4326),11.583333,
        -11.833333,'76/10155');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10156,'Koundara',1,76,
        ST_GeomFromtext('POINT(-13.166667 12.416667)',4326),12.416667,
        -13.166667,'76/10156');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10157,'Kouroussa',1,76,
        ST_GeomFromtext('POINT(-9.916667 10.666667)',4326),10.666667,
        -9.916667,'76/10157');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10158,'Labe',1,76,
        ST_GeomFromtext('POINT(-12.25 11.5)',4326),11.5,
        -12.25,'76/10158');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10159,'Lelouma',1,76,
        ST_GeomFromtext('POINT(-12.666667 11.416667)',4326),11.416667,
        -12.666667,'76/10159');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10160,'Lola',1,76,
        ST_GeomFromtext('POINT(-8.333333 7.833333)',4326),7.833333,
        -8.333333,'76/10160');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10161,'Macenta',1,76,
        ST_GeomFromtext('POINT(-9.416667 8.5)',4326),8.5,
        -9.416667,'76/10161');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10162,'Mali',1,76,
        ST_GeomFromtext('POINT(-12.083333 12.083333)',4326),12.083333,
        -12.083333,'76/10162');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10163,'Mamou',1,76,
        ST_GeomFromtext('POINT(-12.0 10.5)',4326),10.5,
        -12.0,'76/10163');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10164,'Mandiana',1,76,
        ST_GeomFromtext('POINT(-8.75 10.5)',4326),10.5,
        -8.75,'76/10164');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10165,'Nzerekore',1,76,
        ST_GeomFromtext('POINT(-8.833333 7.833333)',4326),7.833333,
        -8.833333,'76/10165');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10166,'Pita',1,76,
        ST_GeomFromtext('POINT(-12.583333 10.833333)',4326),10.833333,
        -12.583333,'76/10166');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10167,'Siguiri',1,76,
        ST_GeomFromtext('POINT(-9.5 11.666667)',4326),11.666667,
        -9.5,'76/10167');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10168,'Telimele',1,76,
        ST_GeomFromtext('POINT(-13.333333 10.916667)',4326),10.916667,
        -13.333333,'76/10168');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10169,'Tougue',1,76,
        ST_GeomFromtext('POINT(-11.6 11.466667)',4326),11.466667,
        -11.6,'76/10169');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10170,'Yomou',1,76,
        ST_GeomFromtext('POINT(-9.166667 7.5)',4326),7.5,
        -9.166667,'76/10170');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10171,'Alborz',1,84,
        ST_GeomFromtext('POINT(50.809563 36.011171)',4326),36.011171,
        50.809563,'84/10171');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10172,'Ardabil',1,84,
        ST_GeomFromtext('POINT(48.0 38.5)',4326),38.5,
        48.0,'84/10172');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10173,'Bushehr',1,84,
        ST_GeomFromtext('POINT(51.5 28.75)',4326),28.75,
        51.5,'84/10173');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10174,'Chahar Mahal va Bakhtiari',1,84,
        ST_GeomFromtext('POINT(50.75 32.166667)',4326),32.166667,
        50.75,'84/10174');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10175,'Azarbayjan-e Sharqi (East Azerbaijan)',1,84,
        ST_GeomFromtext('POINT(46.75 38.0)',4326),38.0,
        46.75,'84/10175');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10176,'Esfahan',1,84,
        ST_GeomFromtext('POINT(52.166667 33.0)',4326),33.0,
        52.166667,'84/10176');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10177,'Fars',1,84,
        ST_GeomFromtext('POINT(53.0 29.0)',4326),29.0,
        53.0,'84/10177');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10178,'Qazvin',1,84,
        ST_GeomFromtext('POINT(49.75 36.0)',4326),36.0,
        49.75,'84/10178');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10179,'Qom',1,84,
        ST_GeomFromtext('POINT(51.0 34.75)',4326),34.75,
        51.0,'84/10179');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10180,'Gilan',1,84,
        ST_GeomFromtext('POINT(49.5 37.16667)',4326),37.16667,
        49.5,'84/10180');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10181,'Golestan',1,84,
        ST_GeomFromtext('POINT(55.0 37.25)',4326),37.25,
        55.0,'84/10181');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10182,'Hamadan',1,84,
        ST_GeomFromtext('POINT(48.583333 34.833333)',4326),34.833333,
        48.583333,'84/10182');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10183,'Hormozgan',1,84,
        ST_GeomFromtext('POINT(56.5 27.75)',4326),27.75,
        56.5,'84/10183');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10184,'Ilam',1,84,
        ST_GeomFromtext('POINT(47.0 33.166667)',4326),33.166667,
        47.0,'84/10184');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10185,'Kerman',1,84,
        ST_GeomFromtext('POINT(57.25 29.75)',4326),29.75,
        57.25,'84/10185');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10186,'Kermanshah',1,84,
        ST_GeomFromtext('POINT(46.75 34.41667)',4326),34.41667,
        46.75,'84/10186');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10187,'Khorasan-e Jonubi (South Khorasan)',1,84,
        ST_GeomFromtext('POINT(59.5 32.5)',4326),32.5,
        59.5,'84/10187');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10188,'Khorasan-e Razavi (Razavi Khorasan)',1,84,
        ST_GeomFromtext('POINT(59.0 35.25)',4326),35.25,
        59.0,'84/10188');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10189,'Khorasan-e Shomali (North Khorasan)',1,84,
        ST_GeomFromtext('POINT(57.0 37.5)',4326),37.5,
        57.0,'84/10189');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10190,'Khuzestan',1,84,
        ST_GeomFromtext('POINT(49.0 31.5)',4326),31.5,
        49.0,'84/10190');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10191,'Kohgiluyeh va Bowyer Ahmad',1,84,
        ST_GeomFromtext('POINT(50.666667 30.833333)',4326),30.833333,
        50.666667,'84/10191');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10192,'Kordestan',1,84,
        ST_GeomFromtext('POINT(47.0 35.666667)',4326),35.666667,
        47.0,'84/10192');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10193,'Lorestan',1,84,
        ST_GeomFromtext('POINT(48.5 33.5)',4326),33.5,
        48.5,'84/10193');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10194,'Markazi',1,84,
        ST_GeomFromtext('POINT(49.833333 34.333333)',4326),34.333333,
        49.833333,'84/10194');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10195,'Mazandaran',1,84,
        ST_GeomFromtext('POINT(52.333333 36.25)',4326),36.25,
        52.333333,'84/10195');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10196,'Semnan',1,84,
        ST_GeomFromtext('POINT(55.0 35.5)',4326),35.5,
        55.0,'84/10196');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10197,'Sistan va Baluchestan',1,84,
        ST_GeomFromtext('POINT(60.5 28.5)',4326),28.5,
        60.5,'84/10197');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10198,'Azarbayjan-e Gharbi (West Azerbaijan)',1,84,
        ST_GeomFromtext('POINT(45.0 37.666667)',4326),37.666667,
        45.0,'84/10198');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10199,'Tehran',1,84,
        ST_GeomFromtext('POINT(51.41667 35.66667)',4326),35.66667,
        51.41667,'84/10199');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10200,'Yazd',1,84,
        ST_GeomFromtext('POINT(55.583333 32.5)',4326),32.5,
        55.583333,'84/10200');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10201,'Zanjan',1,84,
        ST_GeomFromtext('POINT(48.333333 36.5)',4326),36.5,
        48.333333,'84/10201');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10202,'Carlow',1,51,
        ST_GeomFromtext('POINT(-6.833333 52.666667)',4326),52.666667,
        -6.833333,'51/10202');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10203,'Cavan',1,51,
        ST_GeomFromtext('POINT(-7.25 53.916667)',4326),53.916667,
        -7.25,'51/10203');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10204,'Clare',1,51,
        ST_GeomFromtext('POINT(-9.0 52.833333)',4326),52.833333,
        -9.0,'51/10204');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10205,'Cork',1,51,
        ST_GeomFromtext('POINT(-8.583333 51.966667)',4326),51.966667,
        -8.583333,'51/10205');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10206,'Donegal',1,51,
        ST_GeomFromtext('POINT(-8.0 54.916667)',4326),54.916667,
        -8.0,'51/10206');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10207,'Dublin*',1,51,
        ST_GeomFromtext('POINT(-6.249222 53.355118)',4326),53.355118,
        -6.249222,'51/10207');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10208,'Dun Laoghaire-Rathdown',1,51,
        ST_GeomFromtext('POINT(-6.191306 53.261412)',4326),53.261412,
        -6.191306,'51/10208');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10209,'Fingal',1,51,
        ST_GeomFromtext('POINT(-6.266791 53.500232)',4326),53.500232,
        -6.266791,'51/10209');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10210,'Galway',1,51,
        ST_GeomFromtext('POINT(-9.0 53.333333)',4326),53.333333,
        -9.0,'51/10210');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10211,'Galway*',1,51,
        ST_GeomFromtext('POINT(-9.050037 53.287697)',4326),53.287697,
        -9.050037,'51/10211');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10212,'Kerry',1,51,
        ST_GeomFromtext('POINT(-9.75 52.166667)',4326),52.166667,
        -9.75,'51/10212');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10213,'Kildare',1,51,
        ST_GeomFromtext('POINT(-6.75 53.166667)',4326),53.166667,
        -6.75,'51/10213');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10214,'Kilkenny',1,51,
        ST_GeomFromtext('POINT(-7.25 52.583333)',4326),52.583333,
        -7.25,'51/10214');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10215,'Laois',1,51,
        ST_GeomFromtext('POINT(-7.4 53.0)',4326),53.0,
        -7.4,'51/10215');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10216,'Leitrim',1,51,
        ST_GeomFromtext('POINT(-8.0 54.116667)',4326),54.116667,
        -8.0,'51/10216');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10217,'Limerick',1,51,
        ST_GeomFromtext('POINT(-8.75 52.5)',4326),52.5,
        -8.75,'51/10217');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10218,'Limerick*',1,51,
        ST_GeomFromtext('POINT(-8.650239 52.668065)',4326),52.668065,
        -8.650239,'51/10218');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10219,'Longford',1,51,
        ST_GeomFromtext('POINT(-7.75 53.666667)',4326),53.666667,
        -7.75,'51/10219');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10220,'Louth',1,51,
        ST_GeomFromtext('POINT(-6.5 53.833333)',4326),53.833333,
        -6.5,'51/10220');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10221,'Mayo',1,51,
        ST_GeomFromtext('POINT(-9.25 53.9)',4326),53.9,
        -9.25,'51/10221');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10222,'Meath',1,51,
        ST_GeomFromtext('POINT(-6.666667 53.666667)',4326),53.666667,
        -6.666667,'51/10222');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10223,'Monaghan',1,51,
        ST_GeomFromtext('POINT(-7.0 54.25)',4326),54.25,
        -7.0,'51/10223');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10224,'North Tipperary',1,51,
        ST_GeomFromtext('POINT(-8.068028 52.833878)',4326),52.833878,
        -8.068028,'51/10224');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10225,'Offaly',1,51,
        ST_GeomFromtext('POINT(-7.5 53.25)',4326),53.25,
        -7.5,'51/10225');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10226,'Roscommon',1,51,
        ST_GeomFromtext('POINT(-8.25 53.75)',4326),53.75,
        -8.25,'51/10226');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10227,'Sligo',1,51,
        ST_GeomFromtext('POINT(-8.666667 54.25)',4326),54.25,
        -8.666667,'51/10227');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10228,'South Dublin',1,51,
        ST_GeomFromtext('POINT(-6.404097 53.283537)',4326),53.283537,
        -6.404097,'51/10228');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10229,'South Tipperary',1,51,
        ST_GeomFromtext('POINT(-7.884521 52.466863)',4326),52.466863,
        -7.884521,'51/10229');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10230,'Waterford',1,51,
        ST_GeomFromtext('POINT(-7.5 52.25)',4326),52.25,
        -7.5,'51/10230');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10231,'Waterford*',1,51,
        ST_GeomFromtext('POINT(-7.108426 52.241824)',4326),52.241824,
        -7.108426,'51/10231');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10232,'Westmeath',1,51,
        ST_GeomFromtext('POINT(-7.5 53.5)',4326),53.5,
        -7.5,'51/10232');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10233,'Wexford',1,51,
        ST_GeomFromtext('POINT(-6.666667 52.5)',4326),52.5,
        -6.666667,'51/10233');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10234,'Wicklow',1,51,
        ST_GeomFromtext('POINT(-6.416667 53.0)',4326),53.0,
        -6.416667,'51/10234');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10235,'Yanggang',1,94,
        ST_GeomFromtext('POINT(128.203611 41.214167)',4326),41.214167,
        128.203611,'94/10235');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10236,'Nasŏn-si',1,94,
        ST_GeomFromtext('POINT(130.366389 42.336111)',4326),42.336111,
        130.366389,'94/10236');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10237,'Mubarak al Kabir',1,97,
        ST_GeomFromtext('POINT(48.05 29.225)',4326),29.225,
        48.05,'97/10237');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10238,'Chuy',1,93,
        ST_GeomFromtext('POINT(74.5 42.416667)',4326),42.416667,
        74.5,'93/10238');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10239,'Adazu Novads',1,101,
        ST_GeomFromtext('POINT(24.37944 57.10917)',4326),57.10917,
        24.37944,'101/10239');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10240,'Aglonas Novads',1,101,
        ST_GeomFromtext('POINT(27.10056 56.10667)',4326),56.10667,
        27.10056,'101/10240');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10241,'Aizkraukles Novads',1,101,
        ST_GeomFromtext('POINT(25.23222 56.63861)',4326),56.63861,
        25.23222,'101/10241');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10242,'Aizputes Novads',1,101,
        ST_GeomFromtext('POINT(21.56889 56.71667)',4326),56.71667,
        21.56889,'101/10242');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10243,'Aknistes Novads',1,101,
        ST_GeomFromtext('POINT(25.80889 56.14639)',4326),56.14639,
        25.80889,'101/10243');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10244,'Alojas Novads',1,101,
        ST_GeomFromtext('POINT(24.83528 57.80083)',4326),57.80083,
        24.83528,'101/10244');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10245,'Alsungas Novads',1,101,
        ST_GeomFromtext('POINT(21.55444 56.97556)',4326),56.97556,
        21.55444,'101/10245');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10246,'Aluksnes Novads',1,101,
        ST_GeomFromtext('POINT(27.1525 57.41111)',4326),57.41111,
        27.1525,'101/10246');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10247,'Amatas Novads',1,101,
        ST_GeomFromtext('POINT(25.31556 57.10167)',4326),57.10167,
        25.31556,'101/10247');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10248,'Apes Novads',1,101,
        ST_GeomFromtext('POINT(26.52056 57.46694)',4326),57.46694,
        26.52056,'101/10248');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10249,'Auces Novads',1,101,
        ST_GeomFromtext('POINT(22.96278 56.46306)',4326),56.46306,
        22.96278,'101/10249');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10250,'Babites Novads',1,101,
        ST_GeomFromtext('POINT(23.76611 56.88889)',4326),56.88889,
        23.76611,'101/10250');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10251,'Baldones Novads',1,101,
        ST_GeomFromtext('POINT(24.3725 56.73111)',4326),56.73111,
        24.3725,'101/10251');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10252,'Baltinavas Novads',1,101,
        ST_GeomFromtext('POINT(27.61 56.91694)',4326),56.91694,
        27.61,'101/10252');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10253,'Balvu Novads',1,101,
        ST_GeomFromtext('POINT(27.39028 57.02861)',4326),57.02861,
        27.39028,'101/10253');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10254,'Bauskas Novads',1,101,
        ST_GeomFromtext('POINT(24.28444 56.39639)',4326),56.39639,
        24.28444,'101/10254');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10255,'Beverinas Novads',1,101,
        ST_GeomFromtext('POINT(25.59444 57.52306)',4326),57.52306,
        25.59444,'101/10255');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10256,'Brocenu Novads',1,101,
        ST_GeomFromtext('POINT(22.65667 56.71417)',4326),56.71417,
        22.65667,'101/10256');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10257,'Burtnieku Novads',1,101,
        ST_GeomFromtext('POINT(25.35528 57.70056)',4326),57.70056,
        25.35528,'101/10257');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10258,'Carnikavas Novads',1,101,
        ST_GeomFromtext('POINT(24.24583 57.11722)',4326),57.11722,
        24.24583,'101/10258');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10259,'Cesu Novads',1,101,
        ST_GeomFromtext('POINT(25.41139 57.24194)',4326),57.24194,
        25.41139,'101/10259');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10260,'Cesvaines Novads',1,101,
        ST_GeomFromtext('POINT(26.27667 57.0075)',4326),57.0075,
        26.27667,'101/10260');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10261,'Ciblas Novads',1,101,
        ST_GeomFromtext('POINT(27.86944 56.59278)',4326),56.59278,
        27.86944,'101/10261');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10262,'Dagdas Novads',1,101,
        ST_GeomFromtext('POINT(27.64444 56.12028)',4326),56.12028,
        27.64444,'101/10262');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10263,'Daugavpils Novads',1,101,
        ST_GeomFromtext('POINT(26.66222 55.93639)',4326),55.93639,
        26.66222,'101/10263');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10264,'Dobeles Novads',1,101,
        ST_GeomFromtext('POINT(23.19306 56.62556)',4326),56.62556,
        23.19306,'101/10264');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10265,'Dundagas Novads',1,101,
        ST_GeomFromtext('POINT(22.39472 57.56667)',4326),57.56667,
        22.39472,'101/10265');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10266,'Durbes Novads',1,101,
        ST_GeomFromtext('POINT(21.39528 56.6075)',4326),56.6075,
        21.39528,'101/10266');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10267,'Engures Novads',1,101,
        ST_GeomFromtext('POINT(23.28389 57.0275)',4326),57.0275,
        23.28389,'101/10267');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10268,'Erglu Novads',1,101,
        ST_GeomFromtext('POINT(25.67333 56.89806)',4326),56.89806,
        25.67333,'101/10268');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10269,'Garkalnes Novads',1,101,
        ST_GeomFromtext('POINT(24.37056 57.01778)',4326),57.01778,
        24.37056,'101/10269');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10270,'Grobinas Novads',1,101,
        ST_GeomFromtext('POINT(21.23556 56.48694)',4326),56.48694,
        21.23556,'101/10270');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10271,'Gulbenes Novads',1,101,
        ST_GeomFromtext('POINT(26.59917 57.18111)',4326),57.18111,
        26.59917,'101/10271');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10272,'Iecavas Novads',1,101,
        ST_GeomFromtext('POINT(24.20667 56.60944)',4326),56.60944,
        24.20667,'101/10272');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10273,'Ikskiles Novads',1,101,
        ST_GeomFromtext('POINT(24.58361 56.86028)',4326),56.86028,
        24.58361,'101/10273');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10274,'Ilukstes Novads',1,101,
        ST_GeomFromtext('POINT(26.14833 56.01167)',4326),56.01167,
        26.14833,'101/10274');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10275,'Incukalna Novads',1,101,
        ST_GeomFromtext('POINT(24.65083 57.10222)',4326),57.10222,
        24.65083,'101/10275');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10276,'Jaunjelgavas Novads',1,101,
        ST_GeomFromtext('POINT(25.29583 56.51417)',4326),56.51417,
        25.29583,'101/10276');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10277,'Jaunpiebalgas Novads',1,101,
        ST_GeomFromtext('POINT(25.97361 57.15)',4326),57.15,
        25.97361,'101/10277');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10278,'Jaunpils Novads',1,101,
        ST_GeomFromtext('POINT(22.92694 56.75917)',4326),56.75917,
        22.92694,'101/10278');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10279,'Jekabpils',1,101,
        ST_GeomFromtext('POINT(25.86917 56.50111)',4326),56.50111,
        25.86917,'101/10279');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10280,'Jekabpils Novads',1,101,
        ST_GeomFromtext('POINT(25.98806 56.28361)',4326),56.28361,
        25.98806,'101/10280');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10281,'Jelgavas Novads',1,101,
        ST_GeomFromtext('POINT(23.63278 56.55833)',4326),56.55833,
        23.63278,'101/10281');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10282,'Kandavas Novads',1,101,
        ST_GeomFromtext('POINT(22.705 56.95667)',4326),56.95667,
        22.705,'101/10282');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10283,'Karsavas Novads',1,101,
        ST_GeomFromtext('POINT(27.67639 56.76333)',4326),56.76333,
        27.67639,'101/10283');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10284,'Keguma Novads',1,101,
        ST_GeomFromtext('POINT(24.74722 56.66833)',4326),56.66833,
        24.74722,'101/10284');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10285,'Kekavas Novads',1,101,
        ST_GeomFromtext('POINT(24.22639 56.79806)',4326),56.79806,
        24.22639,'101/10285');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10286,'Kocenu Novads',1,101,
        ST_GeomFromtext('POINT(25.19056 57.5375)',4326),57.5375,
        25.19056,'101/10286');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10287,'Kokneses Novads',1,101,
        ST_GeomFromtext('POINT(25.46333 56.71028)',4326),56.71028,
        25.46333,'101/10287');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10288,'Kraslavas Novads',1,101,
        ST_GeomFromtext('POINT(27.32111 55.92333)',4326),55.92333,
        27.32111,'101/10288');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10289,'Krimuldas Novads',1,101,
        ST_GeomFromtext('POINT(24.79306 57.21306)',4326),57.21306,
        24.79306,'101/10289');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10290,'Krustpils Novads',1,101,
        ST_GeomFromtext('POINT(26.17278 56.54917)',4326),56.54917,
        26.17278,'101/10290');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10291,'Kuldigas Novads',1,101,
        ST_GeomFromtext('POINT(21.9825 56.94639)',4326),56.94639,
        21.9825,'101/10291');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10292,'Lielvardes Novads',1,101,
        ST_GeomFromtext('POINT(24.95556 56.7175)',4326),56.7175,
        24.95556,'101/10292');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10293,'Ligatnes Novads',1,101,
        ST_GeomFromtext('POINT(25.05917 57.18917)',4326),57.18917,
        25.05917,'101/10293');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10294,'Limbazu Novads',1,101,
        ST_GeomFromtext('POINT(24.70444 57.49333)',4326),57.49333,
        24.70444,'101/10294');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10295,'Livanu Novads',1,101,
        ST_GeomFromtext('POINT(26.35056 56.37139)',4326),56.37139,
        26.35056,'101/10295');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10296,'Lubanas Novads',1,101,
        ST_GeomFromtext('POINT(26.73556 56.9275)',4326),56.9275,
        26.73556,'101/10296');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10297,'Ludzas Novads',1,101,
        ST_GeomFromtext('POINT(27.83389 56.38611)',4326),56.38611,
        27.83389,'101/10297');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10298,'Madonas Novads',1,101,
        ST_GeomFromtext('POINT(26.27056 56.80917)',4326),56.80917,
        26.27056,'101/10298');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10299,'Malpils Novads',1,101,
        ST_GeomFromtext('POINT(24.97306 56.99444)',4326),56.99444,
        24.97306,'101/10299');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10300,'Marupes Novads',1,101,
        ST_GeomFromtext('POINT(23.95889 56.88639)',4326),56.88639,
        23.95889,'101/10300');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10301,'Mazsalacas Novads',1,101,
        ST_GeomFromtext('POINT(25.03306 57.91194)',4326),57.91194,
        25.03306,'101/10301');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10302,'Nauksenu Novads',1,101,
        ST_GeomFromtext('POINT(25.45028 57.915)',4326),57.915,
        25.45028,'101/10302');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10303,'Neretas Novads',1,101,
        ST_GeomFromtext('POINT(25.155 56.31528)',4326),56.31528,
        25.155,'101/10303');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10304,'Nicas Novads',1,101,
        ST_GeomFromtext('POINT(21.09 56.34917)',4326),56.34917,
        21.09,'101/10304');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10305,'Ogres Novads',1,101,
        ST_GeomFromtext('POINT(25.13222 56.85167)',4326),56.85167,
        25.13222,'101/10305');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10306,'Olaines Novads',1,101,
        ST_GeomFromtext('POINT(23.94806 56.79139)',4326),56.79139,
        23.94806,'101/10306');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10307,'Ozolnieku Novads',1,101,
        ST_GeomFromtext('POINT(23.92806 56.65139)',4326),56.65139,
        23.92806,'101/10307');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10308,'Pargaujas Novads',1,101,
        ST_GeomFromtext('POINT(25.06611 57.36833)',4326),57.36833,
        25.06611,'101/10308');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10309,'Pavilostas Novads',1,101,
        ST_GeomFromtext('POINT(21.22389 56.80639)',4326),56.80639,
        21.22389,'101/10309');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10310,'Plavinu Novads',1,101,
        ST_GeomFromtext('POINT(25.7225 56.67861)',4326),56.67861,
        25.7225,'101/10310');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10311,'Preilu Novads',1,101,
        ST_GeomFromtext('POINT(26.71556 56.26556)',4326),56.26556,
        26.71556,'101/10311');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10312,'Priekules Novads',1,101,
        ST_GeomFromtext('POINT(21.565 56.4325)',4326),56.4325,
        21.565,'101/10312');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10313,'Priekulu Novads',1,101,
        ST_GeomFromtext('POINT(25.46361 57.35417)',4326),57.35417,
        25.46361,'101/10313');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10314,'Raunas Novads',1,101,
        ST_GeomFromtext('POINT(25.65639 57.33222)',4326),57.33222,
        25.65639,'101/10314');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10315,'Rezeknes Novads',1,101,
        ST_GeomFromtext('POINT(27.25056 56.50028)',4326),56.50028,
        27.25056,'101/10315');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10316,'Riebinu Novads',1,101,
        ST_GeomFromtext('POINT(26.82556 56.35806)',4326),56.35806,
        26.82556,'101/10316');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10317,'Rojas Novads',1,101,
        ST_GeomFromtext('POINT(22.82647 57.45111)',4326),57.45111,
        22.82647,'101/10317');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10318,'Ropazu Novads',1,101,
        ST_GeomFromtext('POINT(24.59639 56.96639)',4326),56.96639,
        24.59639,'101/10318');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10319,'Rucavas Novads',1,101,
        ST_GeomFromtext('POINT(21.20972 56.21167)',4326),56.21167,
        21.20972,'101/10319');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10320,'Rugaju Novads',1,101,
        ST_GeomFromtext('POINT(27.0975 56.9825)',4326),56.9825,
        27.0975,'101/10320');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10321,'Rujienas Novads',1,101,
        ST_GeomFromtext('POINT(25.22417 57.93528)',4326),57.93528,
        25.22417,'101/10321');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10322,'Rundales Novads',1,101,
        ST_GeomFromtext('POINT(23.97472 56.41056)',4326),56.41056,
        23.97472,'101/10322');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10323,'Salacgrivas Novads',1,101,
        ST_GeomFromtext('POINT(24.45194 57.74028)',4326),57.74028,
        24.45194,'101/10323');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10324,'Salas Novads',1,101,
        ST_GeomFromtext('POINT(25.70639 56.48222)',4326),56.48222,
        25.70639,'101/10324');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10325,'Salaspils Novads',1,101,
        ST_GeomFromtext('POINT(24.35056 56.87444)',4326),56.87444,
        24.35056,'101/10325');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10326,'Saldus Novads',1,101,
        ST_GeomFromtext('POINT(22.3875 56.58194)',4326),56.58194,
        22.3875,'101/10326');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10327,'Saulkrastu Novads',1,101,
        ST_GeomFromtext('POINT(24.42611 57.25139)',4326),57.25139,
        24.42611,'101/10327');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10328,'Sejas Novads',1,101,
        ST_GeomFromtext('POINT(24.54611 57.21222)',4326),57.21222,
        24.54611,'101/10328');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10329,'Siguldas Novads',1,101,
        ST_GeomFromtext('POINT(24.86389 57.12972)',4326),57.12972,
        24.86389,'101/10329');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10330,'Skriveru Novads',1,101,
        ST_GeomFromtext('POINT(25.09694 56.6725)',4326),56.6725,
        25.09694,'101/10330');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10331,'Skrundas Novads',1,101,
        ST_GeomFromtext('POINT(21.98889 56.66111)',4326),56.66111,
        21.98889,'101/10331');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10332,'Smiltenes Novads',1,101,
        ST_GeomFromtext('POINT(26.01083 57.40667)',4326),57.40667,
        26.01083,'101/10332');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10333,'Stopinu Novads',1,101,
        ST_GeomFromtext('POINT(24.32361 56.93778)',4326),56.93778,
        24.32361,'101/10333');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10334,'Strencu Novads',1,101,
        ST_GeomFromtext('POINT(25.78306 57.62611)',4326),57.62611,
        25.78306,'101/10334');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10335,'Talsu Novads',1,101,
        ST_GeomFromtext('POINT(22.60583 57.25806)',4326),57.25806,
        22.60583,'101/10335');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10336,'Tervetes Novads',1,101,
        ST_GeomFromtext('POINT(23.31694 56.42611)',4326),56.42611,
        23.31694,'101/10336');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10337,'Tukuma Novads',1,101,
        ST_GeomFromtext('POINT(23.06056 56.92472)',4326),56.92472,
        23.06056,'101/10337');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10338,'Vainodes Novads',1,101,
        ST_GeomFromtext('POINT(21.82833 56.45056)',4326),56.45056,
        21.82833,'101/10338');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10339,'Valkas Novads',1,101,
        ST_GeomFromtext('POINT(25.94417 57.7175)',4326),57.7175,
        25.94417,'101/10339');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10340,'Valmiera',1,101,
        ST_GeomFromtext('POINT(25.41972 57.5325)',4326),57.5325,
        25.41972,'101/10340');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10342,'Varaklanu Novads',1,101,
        ST_GeomFromtext('POINT(26.63444 56.63333)',4326),56.63333,
        26.63444,'101/10342');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10343,'Varkavas Novads',1,101,
        ST_GeomFromtext('POINT(26.50278 56.22556)',4326),56.22556,
        26.50278,'101/10343');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10344,'Vecpiebalgas Novads',1,101,
        ST_GeomFromtext('POINT(25.70361 57.09917)',4326),57.09917,
        25.70361,'101/10344');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10345,'Vecumnieku Novads',1,101,
        ST_GeomFromtext('POINT(24.63444 56.49611)',4326),56.49611,
        24.63444,'101/10345');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10346,'Ventspils Novads',1,101,
        ST_GeomFromtext('POINT(21.86139 57.32056)',4326),57.32056,
        21.86139,'101/10346');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10347,'Viesites Novads',1,101,
        ST_GeomFromtext('POINT(25.51944 56.29889)',4326),56.29889,
        25.51944,'101/10347');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10348,'Vilakas Novads',1,101,
        ST_GeomFromtext('POINT(27.65417 57.18222)',4326),57.18222,
        27.65417,'101/10348');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10349,'Vilanu Novads',1,101,
        ST_GeomFromtext('POINT(26.89611 56.56333)',4326),56.56333,
        26.89611,'101/10349');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10350,'Zilupes Novads',1,101,
        ST_GeomFromtext('POINT(28.11111 56.3225)',4326),56.3225,
        28.11111,'101/10350');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10351,'Ventspils',1,101,
        ST_GeomFromtext('POINT(21.60167 57.40611)',4326),57.40611,
        21.60167,'101/10351');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10352,'Riga',1,101,
        ST_GeomFromtext('POINT(24.12167 56.97778)',4326),56.97778,
        24.12167,'101/10352');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10354,'Rezekne',1,101,
        ST_GeomFromtext('POINT(27.34 56.51028)',4326),56.51028,
        27.34,'101/10354');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10355,'Jelgava',1,101,
        ST_GeomFromtext('POINT(23.71639 56.65111)',4326),56.65111,
        23.71639,'101/10355');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10356,'Liepaja',1,101,
        ST_GeomFromtext('POINT(21.03667 56.54194)',4326),56.54194,
        21.03667,'101/10356');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10357,'Jurmala',1,101,
        ST_GeomFromtext('POINT(23.695308 56.951983)',4326),56.951983,
        23.695308,'101/10357');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10358,'Daugavpils',1,101,
        ST_GeomFromtext('POINT(26.53889 55.88139)',4326),55.88139,
        26.53889,'101/10358');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10359,'Al Jabal al Gharbi',1,107,
        ST_GeomFromtext('POINT(13.0 30.46666)',4326),30.46666,
        13.0,'107/10359');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10360,'Kuala Lumpur',1,128,
        ST_GeomFromtext('POINT(101.683333 3.116667)',4326),3.116667,
        101.683333,'128/10360');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10361,'Labuan',1,128,
        ST_GeomFromtext('POINT(115.2 5.333333)',4326),5.333333,
        115.2,'128/10361');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10362,'Putrajaya',1,128,
        ST_GeomFromtext('POINT(101.7 2.916667)',4326),2.916667,
        101.7,'128/10362');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10363,'Agalega Islands',1,122,
        ST_GeomFromtext('POINT(56.616667 -10.4)',4326),-10.4,
        56.616667,'122/10363');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10364,'Cargados Carajos Shoals',1,122,
        ST_GeomFromtext('POINT(59.633333 -16.633333)',4326),-16.633333,
        59.633333,'122/10364');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10365,'Aruba',1,161,
        ST_GeomFromtext('POINT(-69.968338 12.52111)',4326),12.52111,
        -69.968338,'161/10365');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10366,'Curacao',1,161,
        ST_GeomFromtext('POINT(-68.882439 12.122428)',4326),12.122428,
        -68.882439,'161/10366');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10367,'Netherlands Antilles',1,161,
        ST_GeomFromtext('POINT(-69.159026 12.140192)',4326),12.140192,
        -69.159026,'161/10367');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10368,'Sint Maarten',1,161,
        ST_GeomFromtext('POINT(-63.052251 18.08255)',4326),18.08255,
        -63.052251,'161/10368');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10369,'Tasman',1,120,
        ST_GeomFromtext('POINT(172.734718 -41.212211)',4326),-41.212211,
        172.734718,'120/10369');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10370,'Tokelau',1,120,
        ST_GeomFromtext('POINT(-171.814882 -9.189564)',4326),-9.189564,
        -171.814882,'120/10370');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10371,'Svalbard and Jan Mayen Islands',1,115,
        ST_GeomFromtext('POINT(17.998671 79.008619)',4326),79.008619,
        17.998671,'115/10371');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10372,'Bouvet Island',1,115,
        ST_GeomFromtext('POINT(3.413194 -54.423197)',4326),-54.423197,
        3.413194,'115/10372');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10373,'Al Buraymi',1,125,
        ST_GeomFromtext('POINT(56.100269 24.100141)',4326),24.100141,
        56.100269,'125/10373');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10374,'Angaur',1,231,
        ST_GeomFromtext('POINT(134.15 6.9)',4326),6.9,
        134.15,'231/10374');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10375,'Hatohobei',1,231,
        ST_GeomFromtext('POINT(131.175 3.0)',4326),3.0,
        131.175,'231/10375');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10376,'Sonsorol',1,231,
        ST_GeomFromtext('POINT(132.216667 5.333333)',4326),5.333333,
        132.216667,'231/10376');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10860,'National Capital',1,167,
        ST_GeomFromtext('POINT(147.166667 -9.416667)',4326),-9.416667,
        147.166667,'167/10860');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10377,'Autonomous region in Muslim Mindanao (ARMM)',1,173,
        ST_GeomFromtext('POINT(124.286569 8.029957)',4326),8.029957,
        124.286569,'173/10377');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10378,'Cordillera Administrative region (CAR)',1,173,
        ST_GeomFromtext('POINT(121.07937 17.437496)',4326),17.437496,
        121.07937,'173/10378');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10379,'National Capital Region (NCR)',1,173,
        ST_GeomFromtext('POINT(121.022257 14.609054)',4326),14.609054,
        121.022257,'173/10379');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10380,'Region I (Ilocos region)',1,173,
        ST_GeomFromtext('POINT(120.620456 16.081511)',4326),16.081511,
        120.620456,'173/10380');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10381,'Region II (Cagayan Valley)',1,173,
        ST_GeomFromtext('POINT(121.805755 18.22961)',4326),18.22961,
        121.805755,'173/10381');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10382,'Region III (Central Luzon)',1,173,
        ST_GeomFromtext('POINT(120.689526 15.476582)',4326),15.476582,
        120.689526,'173/10382');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10383,'Region IV-A (Calabarzon)',1,173,
        ST_GeomFromtext('POINT(121.44605 14.382686)',4326),14.382686,
        121.44605,'173/10383');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10384,'Region IV-B (Mimaropa)',1,173,
        ST_GeomFromtext('POINT(119.54153 10.790036)',4326),10.790036,
        119.54153,'173/10384');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10385,'Region IX (Zamboanga Peninsula)',1,173,
        ST_GeomFromtext('POINT(122.898681 7.885756)',4326),7.885756,
        122.898681,'173/10385');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10386,'Region V (Bicol region)',1,173,
        ST_GeomFromtext('POINT(123.617577 13.084367)',4326),13.084367,
        123.617577,'173/10386');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10387,'Region VI (Western Visayas)',1,173,
        ST_GeomFromtext('POINT(122.537274 11.004984)',4326),11.004984,
        122.537274,'173/10387');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10388,'Region VII (Central Visayas)',1,173,
        ST_GeomFromtext('POINT(123.563155 9.946004)',4326),9.946004,
        123.563155,'173/10388');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10389,'Region VIII (Eastern Visayas)',1,173,
        ST_GeomFromtext('POINT(124.935856 11.502178)',4326),11.502178,
        124.935856,'173/10389');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10390,'Region X (Northern Mindanao)',1,173,
        ST_GeomFromtext('POINT(124.685651 8.316943)',4326),8.316943,
        124.685651,'173/10390');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10391,'Region XI (Davao Region)',1,173,
        ST_GeomFromtext('POINT(125.527701 7.088604)',4326),7.088604,
        125.527701,'173/10391');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10392,'Region XII (Soccsksargen)',1,173,
        ST_GeomFromtext('POINT(124.685651 6.270692)',4326),6.270692,
        124.685651,'173/10392');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10393,'Region XIII (Caraga)',1,173,
        ST_GeomFromtext('POINT(125.740688 8.801456)',4326),8.801456,
        125.740688,'173/10393');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10394,'Doha',1,169,
        ST_GeomFromtext('POINT(51.5 25.3)',4326),25.3,
        51.5,'169/10394');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10395,'Al Daayen',1,169,
        ST_GeomFromtext('POINT(51.45 25.516667)',4326),25.516667,
        51.45,'169/10395');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10396,'Al Khor',1,169,
        ST_GeomFromtext('POINT(51.316667 25.766667)',4326),25.766667,
        51.316667,'169/10396');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10397,'Al Wakra',1,169,
        ST_GeomFromtext('POINT(51.333333 24.85)',4326),24.85,
        51.333333,'169/10397');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10398,'Al Rayyan',1,169,
        ST_GeomFromtext('POINT(51.05 25.2)',4326),25.2,
        51.05,'169/10398');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10399,'Al Shamal',1,169,
        ST_GeomFromtext('POINT(51.2 25.983333)',4326),25.983333,
        51.2,'169/10399');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10400,'Umm Slal',1,169,
        ST_GeomFromtext('POINT(51.333333 25.466667)',4326),25.466667,
        51.333333,'169/10400');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (0,'Altai Territory',1,175,
        ST_GeomFromtext('POINT(87.0 51.0)',4326),51.0,
        87.0,'175/0');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10401,'Magadan Region',1,175,
        ST_GeomFromtext('POINT(154.0 63.0)',4326),63.0,
        154.0,'175/10401');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10402,'Moscow region',1,175,
        ST_GeomFromtext('POINT(37.5 55.75)',4326),55.75,
        37.5,'175/10402');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10403,'Trans-Baikal Territory',1,175,
        ST_GeomFromtext('POINT(112.905171 51.179059)',4326),51.179059,
        112.905171,'175/10403');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10404,'Eastern',1,176,
        ST_GeomFromtext('POINT(30.5 -1.75)',4326),-1.75,
        30.5,'176/10404');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10405,'Southern',1,176,
        ST_GeomFromtext('POINT(29.666667 -2.333333)',4326),-2.333333,
        29.666667,'176/10405');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10406,'Northern',1,176,
        ST_GeomFromtext('POINT(29.916667 -1.583333)',4326),-1.583333,
        29.916667,'176/10406');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10407,'Western',1,176,
        ST_GeomFromtext('POINT(29.333333 -2.166667)',4326),-2.166667,
        29.333333,'176/10407');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10408,'Kigali',1,176,
        ST_GeomFromtext('POINT(30.083333 -1.916667)',4326),-1.916667,
        30.083333,'176/10408');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10409,'Backa North',1,238,
        ST_GeomFromtext('POINT(19.665556 46.100278)',4326),46.100278,
        19.665556,'238/10409');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10410,'Backa South',1,238,
        ST_GeomFromtext('POINT(19.85 45.25)',4326),45.25,
        19.85,'238/10410');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10411,'Bor',1,238,
        ST_GeomFromtext('POINT(22.1 44.083333)',4326),44.083333,
        22.1,'238/10411');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10412,'Branicevo',1,238,
        ST_GeomFromtext('POINT(21.183333 44.616667)',4326),44.616667,
        21.183333,'238/10412');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10413,'Central Banat',1,238,
        ST_GeomFromtext('POINT(20.383333 45.366667)',4326),45.366667,
        20.383333,'238/10413');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10414,'Jablanica',1,238,
        ST_GeomFromtext('POINT(21.95 43.0)',4326),43.0,
        21.95,'238/10414');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10415,'Kolubara',1,238,
        ST_GeomFromtext('POINT(19.883333 44.266667)',4326),44.266667,
        19.883333,'238/10415');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10416,'Kosovo',1,238,
        ST_GeomFromtext('POINT(21.166667 42.666667)',4326),42.666667,
        21.166667,'238/10416');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10417,'Kosovska Mitrovica',1,238,
        ST_GeomFromtext('POINT(20.866667 42.883333)',4326),42.883333,
        20.866667,'238/10417');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10418,'Kosovska Pomoravlje',1,238,
        ST_GeomFromtext('POINT(21.48 42.47)',4326),42.47,
        21.48,'238/10418');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10419,'Macva',1,238,
        ST_GeomFromtext('POINT(19.70003 44.75405)',4326),44.75405,
        19.70003,'238/10419');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10420,'Morava',1,238,
        ST_GeomFromtext('POINT(20.35 43.883333)',4326),43.883333,
        20.35,'238/10420');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10421,'Nisava',1,238,
        ST_GeomFromtext('POINT(21.9 43.3)',4326),43.3,
        21.9,'238/10421');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10422,'North Banat',1,238,
        ST_GeomFromtext('POINT(20.45 45.833333)',4326),45.833333,
        20.45,'238/10422');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10423,'Pcinja',1,238,
        ST_GeomFromtext('POINT(21.9 42.55)',4326),42.55,
        21.9,'238/10423');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10424,'Pec',1,238,
        ST_GeomFromtext('POINT(20.3 42.666667)',4326),42.666667,
        20.3,'238/10424');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10425,'Pirot',1,238,
        ST_GeomFromtext('POINT(22.6 43.166667)',4326),43.166667,
        22.6,'238/10425');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10426,'Podunavlje',1,238,
        ST_GeomFromtext('POINT(20.933333 44.666667)',4326),44.666667,
        20.933333,'238/10426');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10427,'Pomoravlje',1,238,
        ST_GeomFromtext('POINT(21.25 43.966667)',4326),43.966667,
        21.25,'238/10427');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10428,'Prizren',1,238,
        ST_GeomFromtext('POINT(20.733333 42.216667)',4326),42.216667,
        20.733333,'238/10428');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10429,'Rasina',1,238,
        ST_GeomFromtext('POINT(21.316667 43.583333)',4326),43.583333,
        21.316667,'238/10429');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10430,'Raska',1,238,
        ST_GeomFromtext('POINT(20.6871 43.723433)',4326),43.723433,
        20.6871,'238/10430');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10431,'South Banat',1,238,
        ST_GeomFromtext('POINT(20.633333 44.866667)',4326),44.866667,
        20.633333,'238/10431');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10432,'Srem',1,238,
        ST_GeomFromtext('POINT(19.616667 44.983333)',4326),44.983333,
        19.616667,'238/10432');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10433,'Sumadija',1,238,
        ST_GeomFromtext('POINT(20.883333 43.983333)',4326),43.983333,
        20.883333,'238/10433');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10434,'Toplica',1,238,
        ST_GeomFromtext('POINT(21.6 43.233333)',4326),43.233333,
        21.6,'238/10434');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10435,'West Backa',1,238,
        ST_GeomFromtext('POINT(19.116667 45.783333)',4326),45.783333,
        19.116667,'238/10435');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10436,'Zajecar',1,238,
        ST_GeomFromtext('POINT(22.3 43.916667)',4326),43.916667,
        22.3,'238/10436');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10437,'Zlatibor',1,238,
        ST_GeomFromtext('POINT(19.85 43.85)',4326),43.85,
        19.85,'238/10437');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10438,'Ajdovscina',1,184,
        ST_GeomFromtext('POINT(13.928611 45.906944)',4326),45.906944,
        13.928611,'184/10438');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10439,'Apace',1,184,
        ST_GeomFromtext('POINT(15.908503 46.697718)',4326),46.697718,
        15.908503,'184/10439');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10440,'Beltinci',1,184,
        ST_GeomFromtext('POINT(16.232222 46.614722)',4326),46.614722,
        16.232222,'184/10440');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10441,'Benedikt',1,184,
        ST_GeomFromtext('POINT(15.889132 46.617405)',4326),46.617405,
        15.889132,'184/10441');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10442,'Bistrica ob Sotli',1,184,
        ST_GeomFromtext('POINT(15.647246 46.060006)',4326),46.060006,
        15.647246,'184/10442');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10443,'Bled',1,184,
        ST_GeomFromtext('POINT(14.010278 46.384444)',4326),46.384444,
        14.010278,'184/10443');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10444,'Bloke',1,184,
        ST_GeomFromtext('POINT(14.5325 45.780556)',4326),45.780556,
        14.5325,'184/10444');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10445,'Bohinj',1,184,
        ST_GeomFromtext('POINT(13.923889 46.295)',4326),46.295,
        13.923889,'184/10445');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10446,'Borovnica',1,184,
        ST_GeomFromtext('POINT(14.379444 45.914444)',4326),45.914444,
        14.379444,'184/10446');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10447,'Bovec',1,184,
        ST_GeomFromtext('POINT(13.608056 46.3575)',4326),46.3575,
        13.608056,'184/10447');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10448,'Braslovce',1,184,
        ST_GeomFromtext('POINT(15.036818 46.277677)',4326),46.277677,
        15.036818,'184/10448');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10449,'Brda',1,184,
        ST_GeomFromtext('POINT(13.543333 46.0075)',4326),46.0075,
        13.543333,'184/10449');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10450,'Brezice',1,184,
        ST_GeomFromtext('POINT(15.628056 45.928889)',4326),45.928889,
        15.628056,'184/10450');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10451,'Brezovica',1,184,
        ST_GeomFromtext('POINT(14.424444 45.948889)',4326),45.948889,
        14.424444,'184/10451');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10452,'Cankova',1,184,
        ST_GeomFromtext('POINT(16.031667 46.728889)',4326),46.728889,
        16.031667,'184/10452');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10453,'Celje',1,184,
        ST_GeomFromtext('POINT(15.270278 46.25)',4326),46.25,
        15.270278,'184/10453');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10454,'Cerklje na Gorenjskem',1,184,
        ST_GeomFromtext('POINT(14.5 46.25)',4326),46.25,
        14.5,'184/10454');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10455,'Cerknica',1,184,
        ST_GeomFromtext('POINT(14.366667 45.8)',4326),45.8,
        14.366667,'184/10455');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10456,'Cerkno',1,184,
        ST_GeomFromtext('POINT(13.973056 46.125)',4326),46.125,
        13.973056,'184/10456');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10457,'Cerkvenjak',1,184,
        ST_GeomFromtext('POINT(15.958333 46.553333)',4326),46.553333,
        15.958333,'184/10457');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10458,'Cirkulane',1,184,
        ST_GeomFromtext('POINT(15.994755 46.34418)',4326),46.34418,
        15.994755,'184/10458');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10459,'Crensovci',1,184,
        ST_GeomFromtext('POINT(16.299444 46.557222)',4326),46.557222,
        16.299444,'184/10459');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10460,'Crna na Koroskem',1,184,
        ST_GeomFromtext('POINT(14.821389 46.464167)',4326),46.464167,
        14.821389,'184/10460');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10461,'Crnomelj',1,184,
        ST_GeomFromtext('POINT(15.198333 45.523889)',4326),45.523889,
        15.198333,'184/10461');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10462,'Destrnik',1,184,
        ST_GeomFromtext('POINT(15.8975 46.473889)',4326),46.473889,
        15.8975,'184/10462');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10463,'Divaca',1,184,
        ST_GeomFromtext('POINT(14.0225 45.684444)',4326),45.684444,
        14.0225,'184/10463');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10464,'Dobje',1,184,
        ST_GeomFromtext('POINT(15.401348 46.133215)',4326),46.133215,
        15.401348,'184/10464');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10465,'Dobrepolje',1,184,
        ST_GeomFromtext('POINT(14.748333 45.804444)',4326),45.804444,
        14.748333,'184/10465');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10466,'Dobrna',1,184,
        ST_GeomFromtext('POINT(15.246667 46.343889)',4326),46.343889,
        15.246667,'184/10466');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10467,'Dobrova-Polhov Gradec',1,184,
        ST_GeomFromtext('POINT(14.336944 46.053056)',4326),46.053056,
        14.336944,'184/10467');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10468,'Dobrovnik/Dobronak',1,184,
        ST_GeomFromtext('POINT(16.351944 46.650556)',4326),46.650556,
        16.351944,'184/10468');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10469,'Dol pri Ljubljani',1,184,
        ST_GeomFromtext('POINT(14.673611 46.0975)',4326),46.0975,
        14.673611,'184/10469');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10470,'Dolenjske Toplice',1,184,
        ST_GeomFromtext('POINT(15.049722 45.715)',4326),45.715,
        15.049722,'184/10470');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10471,'Domzale',1,184,
        ST_GeomFromtext('POINT(14.641944 46.128056)',4326),46.128056,
        14.641944,'184/10471');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10472,'Dornava',1,184,
        ST_GeomFromtext('POINT(16.000556 46.438333)',4326),46.438333,
        16.000556,'184/10472');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10473,'Dravograd',1,184,
        ST_GeomFromtext('POINT(15.033333 46.583333)',4326),46.583333,
        15.033333,'184/10473');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10474,'Duplek',1,184,
        ST_GeomFromtext('POINT(15.77 46.515556)',4326),46.515556,
        15.77,'184/10474');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10475,'Gorenja Vas-Poljane',1,184,
        ST_GeomFromtext('POINT(14.125556 46.116667)',4326),46.116667,
        14.125556,'184/10475');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10476,'Gorisnica',1,184,
        ST_GeomFromtext('POINT(16.006672 46.406008)',4326),46.406008,
        16.006672,'184/10476');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10477,'Gorje',1,184,
        ST_GeomFromtext('POINT(13.997767 46.411078)',4326),46.411078,
        13.997767,'184/10477');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10478,'Gornja Radgona',1,184,
        ST_GeomFromtext('POINT(15.961111 46.654722)',4326),46.654722,
        15.961111,'184/10478');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10479,'Gornji Grad',1,184,
        ST_GeomFromtext('POINT(14.800833 46.289167)',4326),46.289167,
        14.800833,'184/10479');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10480,'Gornji Petrovci',1,184,
        ST_GeomFromtext('POINT(16.213333 46.8175)',4326),46.8175,
        16.213333,'184/10480');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10481,'Grad',1,184,
        ST_GeomFromtext('POINT(16.098333 46.786944)',4326),46.786944,
        16.098333,'184/10481');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10482,'Grosuplje',1,184,
        ST_GeomFromtext('POINT(14.665278 45.936389)',4326),45.936389,
        14.665278,'184/10482');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10483,'Hajdina',1,184,
        ST_GeomFromtext('POINT(15.839167 46.415278)',4326),46.415278,
        15.839167,'184/10483');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10484,'Hoce-Slivnica',1,184,
        ST_GeomFromtext('POINT(15.660833 46.476389)',4326),46.476389,
        15.660833,'184/10484');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10485,'Hodos',1,184,
        ST_GeomFromtext('POINT(16.325 46.826389)',4326),46.826389,
        16.325,'184/10485');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10486,'Horjul',1,184,
        ST_GeomFromtext('POINT(14.284706 46.024852)',4326),46.024852,
        14.284706,'184/10486');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10487,'Hrastnik',1,184,
        ST_GeomFromtext('POINT(15.099722 46.133333)',4326),46.133333,
        15.099722,'184/10487');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10488,'Hrpelje-Kozina',1,184,
        ST_GeomFromtext('POINT(14.004722 45.572778)',4326),45.572778,
        14.004722,'184/10488');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10489,'Idrija',1,184,
        ST_GeomFromtext('POINT(14.0 46.0)',4326),46.0,
        14.0,'184/10489');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10490,'Ig',1,184,
        ST_GeomFromtext('POINT(14.514444 45.935833)',4326),45.935833,
        14.514444,'184/10490');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10491,'Ilirska Bistrica',1,184,
        ST_GeomFromtext('POINT(14.290556 45.5675)',4326),45.5675,
        14.290556,'184/10491');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10492,'Ivancna Gorica',1,184,
        ST_GeomFromtext('POINT(14.807222 45.912222)',4326),45.912222,
        14.807222,'184/10492');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10493,'Izola/Isola',1,184,
        ST_GeomFromtext('POINT(13.656546 45.511226)',4326),45.511226,
        13.656546,'184/10493');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10494,'Jesenice',1,184,
        ST_GeomFromtext('POINT(14.072455 46.452527)',4326),46.452527,
        14.072455,'184/10494');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10495,'Jezersko',1,184,
        ST_GeomFromtext('POINT(14.499167 46.376389)',4326),46.376389,
        14.499167,'184/10495');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10496,'Jursinci',1,184,
        ST_GeomFromtext('POINT(15.976389 46.4875)',4326),46.4875,
        15.976389,'184/10496');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10497,'Kamnik',1,184,
        ST_GeomFromtext('POINT(14.667214 46.244061)',4326),46.244061,
        14.667214,'184/10497');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10498,'Kanal',1,184,
        ST_GeomFromtext('POINT(13.643056 46.089722)',4326),46.089722,
        13.643056,'184/10498');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10499,'Kidricevo',1,184,
        ST_GeomFromtext('POINT(15.756944 46.398889)',4326),46.398889,
        15.756944,'184/10499');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10500,'Kobarid',1,184,
        ST_GeomFromtext('POINT(13.549167 46.249167)',4326),46.249167,
        13.549167,'184/10500');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10501,'Kobilje',1,184,
        ST_GeomFromtext('POINT(16.393333 46.685833)',4326),46.685833,
        16.393333,'184/10501');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10502,'Kocevje',1,184,
        ST_GeomFromtext('POINT(14.906944 45.630278)',4326),45.630278,
        14.906944,'184/10502');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10503,'Komen',1,184,
        ST_GeomFromtext('POINT(13.748889 45.818611)',4326),45.818611,
        13.748889,'184/10503');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10504,'Komenda',1,184,
        ST_GeomFromtext('POINT(14.544563 46.20241)',4326),46.20241,
        14.544563,'184/10504');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10505,'Koper-Capodistria',1,184,
        ST_GeomFromtext('POINT(13.826667 45.518333)',4326),45.518333,
        13.826667,'184/10505');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10506,'Kosanjevica na Krki',1,184,
        ST_GeomFromtext('POINT(15.421691 45.844959)',4326),45.844959,
        15.421691,'184/10506');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10507,'Kostel',1,184,
        ST_GeomFromtext('POINT(14.871111 45.489444)',4326),45.489444,
        14.871111,'184/10507');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10508,'Kozje',1,184,
        ST_GeomFromtext('POINT(15.556944 46.072222)',4326),46.072222,
        15.556944,'184/10508');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10509,'Kranj',1,184,
        ST_GeomFromtext('POINT(14.356464 46.246914)',4326),46.246914,
        14.356464,'184/10509');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10510,'Kranjska Gora',1,184,
        ST_GeomFromtext('POINT(13.838611 46.460278)',4326),46.460278,
        13.838611,'184/10510');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10511,'Krizevci',1,184,
        ST_GeomFromtext('POINT(16.130556 46.553333)',4326),46.553333,
        16.130556,'184/10511');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10512,'Krsko',1,184,
        ST_GeomFromtext('POINT(15.454722 45.9325)',4326),45.9325,
        15.454722,'184/10512');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10513,'Kungota',1,184,
        ST_GeomFromtext('POINT(15.609722 46.649444)',4326),46.649444,
        15.609722,'184/10513');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10514,'Kuzma',1,184,
        ST_GeomFromtext('POINT(16.095278 46.841111)',4326),46.841111,
        16.095278,'184/10514');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10515,'Lasko',1,184,
        ST_GeomFromtext('POINT(15.3 46.133333)',4326),46.133333,
        15.3,'184/10515');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10516,'Lenart',1,184,
        ST_GeomFromtext('POINT(15.843056 46.560833)',4326),46.560833,
        15.843056,'184/10516');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10517,'Lendava/Lendva',1,184,
        ST_GeomFromtext('POINT(16.456944 46.5575)',4326),46.5575,
        16.456944,'184/10517');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10518,'Litija',1,184,
        ST_GeomFromtext('POINT(14.973889 46.038611)',4326),46.038611,
        14.973889,'184/10518');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10519,'Ljubljana',1,184,
        ST_GeomFromtext('POINT(14.577778 46.05)',4326),46.05,
        14.577778,'184/10519');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10520,'Ljubno',1,184,
        ST_GeomFromtext('POINT(14.839444 46.373889)',4326),46.373889,
        14.839444,'184/10520');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10521,'Ljutomer',1,184,
        ST_GeomFromtext('POINT(16.176667 46.510278)',4326),46.510278,
        16.176667,'184/10521');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10522,'Logatec',1,184,
        ST_GeomFromtext('POINT(14.195833 45.921389)',4326),45.921389,
        14.195833,'184/10522');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10523,'Log-Dragomer',1,184,
        ST_GeomFromtext('POINT(14.385314 46.018475)',4326),46.018475,
        14.385314,'184/10523');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10524,'Loska Dolina',1,184,
        ST_GeomFromtext('POINT(14.504167 45.666111)',4326),45.666111,
        14.504167,'184/10524');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10525,'Loski Potok',1,184,
        ST_GeomFromtext('POINT(14.645278 45.66)',4326),45.66,
        14.645278,'184/10525');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10526,'Lovrenc na Pohorju',1,184,
        ST_GeomFromtext('POINT(15.385354 46.522702)',4326),46.522702,
        15.385354,'184/10526');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10527,'Luce',1,184,
        ST_GeomFromtext('POINT(14.733031 46.351187)',4326),46.351187,
        14.733031,'184/10527');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10528,'Lukovica',1,184,
        ST_GeomFromtext('POINT(14.768611 46.183333)',4326),46.183333,
        14.768611,'184/10528');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10529,'Majsperk',1,184,
        ST_GeomFromtext('POINT(15.75815 46.332306)',4326),46.332306,
        15.75815,'184/10529');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10530,'Makole',1,184,
        ST_GeomFromtext('POINT(15.668553 46.31794)',4326),46.31794,
        15.668553,'184/10530');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10531,'Maribor',1,184,
        ST_GeomFromtext('POINT(15.643056 46.556111)',4326),46.556111,
        15.643056,'184/10531');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10532,'Markovci',1,184,
        ST_GeomFromtext('POINT(15.950653 46.392082)',4326),46.392082,
        15.950653,'184/10532');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10533,'Medvode',1,184,
        ST_GeomFromtext('POINT(14.419444 46.119722)',4326),46.119722,
        14.419444,'184/10533');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10534,'Menges',1,184,
        ST_GeomFromtext('POINT(14.56246 46.161464)',4326),46.161464,
        14.56246,'184/10534');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10535,'Metlika',1,184,
        ST_GeomFromtext('POINT(15.310745 45.656448)',4326),45.656448,
        15.310745,'184/10535');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10536,'Mezica',1,184,
        ST_GeomFromtext('POINT(14.855 46.522778)',4326),46.522778,
        14.855,'184/10536');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10537,'Miklavz na Dravskem Polju',1,184,
        ST_GeomFromtext('POINT(15.70952 46.486274)',4326),46.486274,
        15.70952,'184/10537');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10538,'Miren-Kostanjevica',1,184,
        ST_GeomFromtext('POINT(13.639722 45.835833)',4326),45.835833,
        13.639722,'184/10538');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10539,'Mirna Pec',1,184,
        ST_GeomFromtext('POINT(15.084343 45.853434)',4326),45.853434,
        15.084343,'184/10539');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10540,'Mislinja',1,184,
        ST_GeomFromtext('POINT(15.223889 46.451111)',4326),46.451111,
        15.223889,'184/10540');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10541,'Mokronog-Trebelno',1,184,
        ST_GeomFromtext('POINT(15.146611 45.943706)',4326),45.943706,
        15.146611,'184/10541');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10542,'Moravce',1,184,
        ST_GeomFromtext('POINT(14.755 46.133611)',4326),46.133611,
        14.755,'184/10542');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10543,'Moravske Toplice',1,184,
        ST_GeomFromtext('POINT(16.273611 46.7175)',4326),46.7175,
        16.273611,'184/10543');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10544,'Mozirje',1,184,
        ST_GeomFromtext('POINT(14.956692 46.358485)',4326),46.358485,
        14.956692,'184/10544');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10545,'Murska Sobota',1,184,
        ST_GeomFromtext('POINT(16.160556 46.651389)',4326),46.651389,
        16.160556,'184/10545');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10546,'Muta',1,184,
        ST_GeomFromtext('POINT(15.136111 46.630556)',4326),46.630556,
        15.136111,'184/10546');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10547,'Naklo',1,184,
        ST_GeomFromtext('POINT(14.286667 46.293611)',4326),46.293611,
        14.286667,'184/10547');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10548,'Nazarje',1,184,
        ST_GeomFromtext('POINT(14.909167 46.281667)',4326),46.281667,
        14.909167,'184/10548');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10549,'Nova Gorica',1,184,
        ST_GeomFromtext('POINT(13.720833 45.973056)',4326),45.973056,
        13.720833,'184/10549');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10550,'Novo Mesto',1,184,
        ST_GeomFromtext('POINT(15.198333 45.785101)',4326),45.785101,
        15.198333,'184/10550');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10551,'Odranci',1,184,
        ST_GeomFromtext('POINT(16.275833 46.591111)',4326),46.591111,
        16.275833,'184/10551');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10552,'Oplotnica',1,184,
        ST_GeomFromtext('POINT(15.452276 46.37877)',4326),46.37877,
        15.452276,'184/10552');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10553,'Ormoz',1,184,
        ST_GeomFromtext('POINT(16.166667 46.433333)',4326),46.433333,
        16.166667,'184/10553');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10554,'Osilnica',1,184,
        ST_GeomFromtext('POINT(14.728333 45.548889)',4326),45.548889,
        14.728333,'184/10554');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10555,'Pesnica',1,184,
        ST_GeomFromtext('POINT(15.712778 46.625833)',4326),46.625833,
        15.712778,'184/10555');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10556,'Piran/Pirano',1,184,
        ST_GeomFromtext('POINT(13.626944 45.482778)',4326),45.482778,
        13.626944,'184/10556');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10557,'Pivka',1,184,
        ST_GeomFromtext('POINT(14.235556 45.682778)',4326),45.682778,
        14.235556,'184/10557');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10558,'Podcetrtek',1,184,
        ST_GeomFromtext('POINT(15.577028 46.144763)',4326),46.144763,
        15.577028,'184/10558');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10559,'Podlehnik',1,184,
        ST_GeomFromtext('POINT(15.866529 46.316106)',4326),46.316106,
        15.866529,'184/10559');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10560,'Podvelka',1,184,
        ST_GeomFromtext('POINT(15.355859 46.600757)',4326),46.600757,
        15.355859,'184/10560');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10561,'Poljcane',1,184,
        ST_GeomFromtext('POINT(15.57176 46.31862)',4326),46.31862,
        15.57176,'184/10561');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10562,'Polzela',1,184,
        ST_GeomFromtext('POINT(15.08452 46.304293)',4326),46.304293,
        15.08452,'184/10562');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10563,'Postojna',1,184,
        ST_GeomFromtext('POINT(14.170833 45.785556)',4326),45.785556,
        14.170833,'184/10563');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10564,'Prebold',1,184,
        ST_GeomFromtext('POINT(15.092651 46.217298)',4326),46.217298,
        15.092651,'184/10564');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10565,'Preddvor',1,184,
        ST_GeomFromtext('POINT(14.483611 46.314444)',4326),46.314444,
        14.483611,'184/10565');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10566,'Prevalje',1,184,
        ST_GeomFromtext('POINT(14.901161 46.551995)',4326),46.551995,
        14.901161,'184/10566');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10567,'Ptuj',1,184,
        ST_GeomFromtext('POINT(15.876667 46.434167)',4326),46.434167,
        15.876667,'184/10567');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10568,'Puconci',1,184,
        ST_GeomFromtext('POINT(16.138889 46.745278)',4326),46.745278,
        16.138889,'184/10568');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10569,'Race-Fram',1,184,
        ST_GeomFromtext('POINT(15.65 46.45)',4326),46.45,
        15.65,'184/10569');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10570,'Radece',1,184,
        ST_GeomFromtext('POINT(15.140833 46.065556)',4326),46.065556,
        15.140833,'184/10570');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10571,'Radenci',1,184,
        ST_GeomFromtext('POINT(16.048333 46.627222)',4326),46.627222,
        16.048333,'184/10571');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10572,'Radlje ob Dravi',1,184,
        ST_GeomFromtext('POINT(15.250934 46.607247)',4326),46.607247,
        15.250934,'184/10572');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10573,'Radovljica',1,184,
        ST_GeomFromtext('POINT(14.194167 46.337778)',4326),46.337778,
        14.194167,'184/10573');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10574,'Ravne na Koroskem',1,184,
        ST_GeomFromtext('POINT(14.975429 46.531793)',4326),46.531793,
        14.975429,'184/10574');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10575,'Razkrizje',1,184,
        ST_GeomFromtext('POINT(16.271944 46.523821)',4326),46.523821,
        16.271944,'184/10575');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10576,'Recica ob Savinji',1,184,
        ST_GeomFromtext('POINT(14.922562 46.323891)',4326),46.323891,
        14.922562,'184/10576');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10577,'Rence-Vogrsko',1,184,
        ST_GeomFromtext('POINT(13.688382 45.904908)',4326),45.904908,
        13.688382,'184/10577');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10578,'Ribnica',1,184,
        ST_GeomFromtext('POINT(14.747222 45.72)',4326),45.72,
        14.747222,'184/10578');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10579,'Ribnica na Pohorju',1,184,
        ST_GeomFromtext('POINT(15.260707 46.525328)',4326),46.525328,
        15.260707,'184/10579');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10580,'Rogaska Slatina',1,184,
        ST_GeomFromtext('POINT(15.629444 46.246667)',4326),46.246667,
        15.629444,'184/10580');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10581,'Rogasovci',1,184,
        ST_GeomFromtext('POINT(16.024444 46.8025)',4326),46.8025,
        16.024444,'184/10581');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10582,'Rogatec',1,184,
        ST_GeomFromtext('POINT(15.740833 46.241944)',4326),46.241944,
        15.740833,'184/10582');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10583,'Ruse',1,184,
        ST_GeomFromtext('POINT(15.490442 46.518001)',4326),46.518001,
        15.490442,'184/10583');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10584,'Salovci',1,184,
        ST_GeomFromtext('POINT(16.278333 46.831111)',4326),46.831111,
        16.278333,'184/10584');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10585,'Selnica ob Dravi',1,184,
        ST_GeomFromtext('POINT(15.495392 46.581681)',4326),46.581681,
        15.495392,'184/10585');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10586,'Semic',1,184,
        ST_GeomFromtext('POINT(15.134722 45.651389)',4326),45.651389,
        15.134722,'184/10586');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10587,'Sempeter-Vrtojba',1,184,
        ST_GeomFromtext('POINT(13.652222 45.911944)',4326),45.911944,
        13.652222,'184/10587');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10588,'Sencur',1,184,
        ST_GeomFromtext('POINT(14.438056 46.214722)',4326),46.214722,
        14.438056,'184/10588');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10589,'Sentilj',1,184,
        ST_GeomFromtext('POINT(15.7175 46.688333)',4326),46.688333,
        15.7175,'184/10589');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10590,'Sentjernej',1,184,
        ST_GeomFromtext('POINT(15.333611 45.823611)',4326),45.823611,
        15.333611,'184/10590');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10591,'Sentjur',1,184,
        ST_GeomFromtext('POINT(15.430556 46.178889)',4326),46.178889,
        15.430556,'184/10591');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10592,'Sentrupert',1,184,
        ST_GeomFromtext('POINT(15.090961 45.976977)',4326),45.976977,
        15.090961,'184/10592');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10593,'Sevnica',1,184,
        ST_GeomFromtext('POINT(15.3 46.0)',4326),46.0,
        15.3,'184/10593');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10594,'Sezana',1,184,
        ST_GeomFromtext('POINT(13.886389 45.734722)',4326),45.734722,
        13.886389,'184/10594');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10595,'Skocjan',1,184,
        ST_GeomFromtext('POINT(15.301389 45.919722)',4326),45.919722,
        15.301389,'184/10595');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10596,'Skofja Loka',1,184,
        ST_GeomFromtext('POINT(14.281667 46.163056)',4326),46.163056,
        14.281667,'184/10596');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10597,'Skofljica',1,184,
        ST_GeomFromtext('POINT(14.577222 45.958333)',4326),45.958333,
        14.577222,'184/10597');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10598,'Slovenj Gradec',1,184,
        ST_GeomFromtext('POINT(15.083611 46.488611)',4326),46.488611,
        15.083611,'184/10598');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10599,'Slovenska Bistrica',1,184,
        ST_GeomFromtext('POINT(15.559366 46.403859)',4326),46.403859,
        15.559366,'184/10599');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10600,'Slovenske Konjice',1,184,
        ST_GeomFromtext('POINT(15.455556 46.325)',4326),46.325,
        15.455556,'184/10600');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10601,'Smarje pri Jelsah',1,184,
        ST_GeomFromtext('POINT(15.524985 46.210745)',4326),46.210745,
        15.524985,'184/10601');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10602,'Smarjeske Toplice',1,184,
        ST_GeomFromtext('POINT(15.241043 45.888083)',4326),45.888083,
        15.241043,'184/10602');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10603,'Smartno ob Paki',1,184,
        ST_GeomFromtext('POINT(15.030556 46.343056)',4326),46.343056,
        15.030556,'184/10603');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10604,'Smartno pri Litiji',1,184,
        ST_GeomFromtext('POINT(14.869596 46.025227)',4326),46.025227,
        14.869596,'184/10604');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10605,'Sodrazica',1,184,
        ST_GeomFromtext('POINT(14.622134 45.756436)',4326),45.756436,
        14.622134,'184/10605');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10606,'Solcava',1,184,
        ST_GeomFromtext('POINT(14.659108 46.406241)',4326),46.406241,
        14.659108,'184/10606');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10607,'Sostanj',1,184,
        ST_GeomFromtext('POINT(15.008333 46.413056)',4326),46.413056,
        15.008333,'184/10607');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10608,'Sredisce ob Dravi',1,184,
        ST_GeomFromtext('POINT(16.270493 46.39594)',4326),46.39594,
        16.270493,'184/10608');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10609,'Starse',1,184,
        ST_GeomFromtext('POINT(15.755199 46.455303)',4326),46.455303,
        15.755199,'184/10609');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10610,'Store',1,184,
        ST_GeomFromtext('POINT(15.327222 46.201111)',4326),46.201111,
        15.327222,'184/10610');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10611,'Straza',1,184,
        ST_GeomFromtext('POINT(15.083769 45.792882)',4326),45.792882,
        15.083769,'184/10611');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10612,'Sveta Ana',1,184,
        ST_GeomFromtext('POINT(15.839033 46.647522)',4326),46.647522,
        15.839033,'184/10612');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10613,'Sveta Trojica v Slovenskih Goricah',1,184,
        ST_GeomFromtext('POINT(15.876503 46.575449)',4326),46.575449,
        15.876503,'184/10613');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10614,'Sveti Andraz v Slovenskih Goricah',1,184,
        ST_GeomFromtext('POINT(15.9625 46.513056)',4326),46.513056,
        15.9625,'184/10614');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10615,'Sveti Jurij',1,184,
        ST_GeomFromtext('POINT(16.026667 46.5675)',4326),46.5675,
        16.026667,'184/10615');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10616,'Sveti Jurij v Slovenskih Goricah',1,184,
        ST_GeomFromtext('POINT(15.791401 46.613158)',4326),46.613158,
        15.791401,'184/10616');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10617,'Sveti Tomaz',1,184,
        ST_GeomFromtext('POINT(16.079783 46.483216)',4326),46.483216,
        16.079783,'184/10617');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10618,'Tabor',1,184,
        ST_GeomFromtext('POINT(15.014343 46.222349)',4326),46.222349,
        15.014343,'184/10618');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10619,'Tisina',1,184,
        ST_GeomFromtext('POINT(16.080932 46.660442)',4326),46.660442,
        16.080932,'184/10619');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10620,'Tolmin',1,184,
        ST_GeomFromtext('POINT(13.802222 46.176389)',4326),46.176389,
        13.802222,'184/10620');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10621,'Trbovlje',1,184,
        ST_GeomFromtext('POINT(15.042222 46.141667)',4326),46.141667,
        15.042222,'184/10621');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10622,'Trebnje',1,184,
        ST_GeomFromtext('POINT(15.033611 45.916667)',4326),45.916667,
        15.033611,'184/10622');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10623,'Trnovska Vas',1,184,
        ST_GeomFromtext('POINT(15.904444 46.517778)',4326),46.517778,
        15.904444,'184/10623');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10624,'Trzic',1,184,
        ST_GeomFromtext('POINT(14.323611 46.384167)',4326),46.384167,
        14.323611,'184/10624');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10625,'Trzin',1,184,
        ST_GeomFromtext('POINT(14.552565 46.125272)',4326),46.125272,
        14.552565,'184/10625');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10626,'Turnisce',1,184,
        ST_GeomFromtext('POINT(16.318056 46.621944)',4326),46.621944,
        16.318056,'184/10626');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10627,'Velenje',1,184,
        ST_GeomFromtext('POINT(15.133333 46.366667)',4326),46.366667,
        15.133333,'184/10627');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10628,'Velika Polana',1,184,
        ST_GeomFromtext('POINT(16.356667 46.578611)',4326),46.578611,
        16.356667,'184/10628');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10629,'Velike Lasce',1,184,
        ST_GeomFromtext('POINT(14.585833 45.839167)',4326),45.839167,
        14.585833,'184/10629');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10630,'Verzej',1,184,
        ST_GeomFromtext('POINT(16.171209 46.581839)',4326),46.581839,
        16.171209,'184/10630');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10631,'Videm',1,184,
        ST_GeomFromtext('POINT(15.927222 46.350278)',4326),46.350278,
        15.927222,'184/10631');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10632,'Vipava',1,184,
        ST_GeomFromtext('POINT(13.984444 45.823611)',4326),45.823611,
        13.984444,'184/10632');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10633,'Vitanje',1,184,
        ST_GeomFromtext('POINT(15.294722 46.403056)',4326),46.403056,
        15.294722,'184/10633');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10634,'Vodice',1,184,
        ST_GeomFromtext('POINT(14.4925 46.173611)',4326),46.173611,
        14.4925,'184/10634');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10635,'Vojnik',1,184,
        ST_GeomFromtext('POINT(15.312585 46.317127)',4326),46.317127,
        15.312585,'184/10635');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10636,'Vransko',1,184,
        ST_GeomFromtext('POINT(14.952249 46.245659)',4326),46.245659,
        14.952249,'184/10636');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10637,'Vrhnika',1,184,
        ST_GeomFromtext('POINT(14.3 45.966667)',4326),45.966667,
        14.3,'184/10637');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10638,'Vuzenica',1,184,
        ST_GeomFromtext('POINT(15.152222 46.568889)',4326),46.568889,
        15.152222,'184/10638');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10639,'Zagorje ob Savi',1,184,
        ST_GeomFromtext('POINT(14.936944 46.142778)',4326),46.142778,
        14.936944,'184/10639');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10640,'Zalec',1,184,
        ST_GeomFromtext('POINT(15.172702 46.255076)',4326),46.255076,
        15.172702,'184/10640');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10641,'Zavrc',1,184,
        ST_GeomFromtext('POINT(16.045278 46.359167)',4326),46.359167,
        16.045278,'184/10641');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10642,'Zelezniki',1,184,
        ST_GeomFromtext('POINT(14.105833 46.2125)',4326),46.2125,
        14.105833,'184/10642');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10643,'Zetale',1,184,
        ST_GeomFromtext('POINT(15.805799 46.282237)',4326),46.282237,
        15.805799,'184/10643');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10644,'Ziri',1,184,
        ST_GeomFromtext('POINT(14.115556 46.051667)',4326),46.051667,
        14.115556,'184/10644');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10645,'Zirovnica',1,184,
        ST_GeomFromtext('POINT(14.179722 46.399167)',4326),46.399167,
        14.179722,'184/10645');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10646,'Zrece',1,184,
        ST_GeomFromtext('POINT(15.38 46.393889)',4326),46.393889,
        15.38,'184/10646');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10647,'Zuzemberk',1,184,
        ST_GeomFromtext('POINT(14.949722 45.804722)',4326),45.804722,
        14.949722,'184/10647');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10648,'Honiara',1,20,
        ST_GeomFromtext('POINT(159.948323 -9.430384)',4326),-9.430384,
        159.948323,'20/10648');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10847,'Central Equatoria',1,247,
        ST_GeomFromtext('POINT(31.0 4.75)',4326),4.75,
        31.0,'247/10847');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10848,'Eastern Equatoria',1,247,
        ST_GeomFromtext('POINT(33.8 4.9)',4326),4.9,
        33.8,'247/10848');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10849,'Jonglei',1,247,
        ST_GeomFromtext('POINT(32.4 7.4)',4326),7.4,
        32.4,'247/10849');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10850,'Lakes',1,247,
        ST_GeomFromtext('POINT(30.0 6.75)',4326),6.75,
        30.0,'247/10850');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10851,'Northern Bahr El Ghazal',1,247,
        ST_GeomFromtext('POINT(27.0 8.85)',4326),8.85,
        27.0,'247/10851');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10852,'Unity',1,247,
        ST_GeomFromtext('POINT(29.85 8.65)',4326),8.65,
        29.85,'247/10852');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10853,'Upper Nile',1,247,
        ST_GeomFromtext('POINT(32.7 10.0)',4326),10.0,
        32.7,'247/10853');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10854,'Warrap',1,247,
        ST_GeomFromtext('POINT(28.85 8.0)',4326),8.0,
        28.85,'247/10854');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10855,'Western Bahr El Ghazal',1,247,
        ST_GeomFromtext('POINT(26.0 8.15)',4326),8.15,
        26.0,'247/10855');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10856,'Western Equatoria',1,247,
        ST_GeomFromtext('POINT(28.4 5.4)',4326),5.4,
        28.4,'247/10856');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10649,'Ceuta',1,188,
        ST_GeomFromtext('POINT(-5.316195 35.888287)',4326),35.888287,
        -5.316195,'188/10649');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10650,'Melilla',1,188,
        ST_GeomFromtext('POINT(-2.938794 35.292339)',4326),35.292339,
        -2.938794,'188/10650');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10651,'White Nile',1,190,
        ST_GeomFromtext('POINT(32.4 13.5)',4326),13.5,
        32.4,'190/10651');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10652,'Aerodrom (Skopje)',1,112,
        ST_GeomFromtext('POINT(21.45944 41.98806)',4326),41.98806,
        21.45944,'112/10652');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10653,'Aracinovo',1,112,
        ST_GeomFromtext('POINT(21.583333 42.05)',4326),42.05,
        21.583333,'112/10653');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10654,'Berovo',1,112,
        ST_GeomFromtext('POINT(22.816667 41.65)',4326),41.65,
        22.816667,'112/10654');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10655,'Bitola',1,112,
        ST_GeomFromtext('POINT(21.316667 41.016667)',4326),41.016667,
        21.316667,'112/10655');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10656,'Bogdanci',1,112,
        ST_GeomFromtext('POINT(22.6 41.2)',4326),41.2,
        22.6,'112/10656');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10657,'Bogovinje',1,112,
        ST_GeomFromtext('POINT(20.88222 41.95028)',4326),41.95028,
        20.88222,'112/10657');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10658,'Bosilovo',1,112,
        ST_GeomFromtext('POINT(22.783333 41.466667)',4326),41.466667,
        22.783333,'112/10658');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10659,'Brvenica',1,112,
        ST_GeomFromtext('POINT(21.033333 41.883333)',4326),41.883333,
        21.033333,'112/10659');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10660,'Butel (Skopje)',1,112,
        ST_GeomFromtext('POINT(21.46889 42.08194)',4326),42.08194,
        21.46889,'112/10660');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10661,'Cair (Skopje)',1,112,
        ST_GeomFromtext('POINT(21.44389 42.07917)',4326),42.07917,
        21.44389,'112/10661');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10662,'Caska',1,112,
        ST_GeomFromtext('POINT(21.59028 41.59833)',4326),41.59833,
        21.59028,'112/10662');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10663,'Centar (Skopje)',1,112,
        ST_GeomFromtext('POINT(21.42889 42.005)',4326),42.005,
        21.42889,'112/10663');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10664,'Centar Zupa',1,112,
        ST_GeomFromtext('POINT(20.583333 41.466667)',4326),41.466667,
        20.583333,'112/10664');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10665,'Cesinovo',1,112,
        ST_GeomFromtext('POINT(22.266667 41.9)',4326),41.9,
        22.266667,'112/10665');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10666,'Cucer Sandevo',1,112,
        ST_GeomFromtext('POINT(21.416667 42.166667)',4326),42.166667,
        21.416667,'112/10666');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10667,'Debar',1,112,
        ST_GeomFromtext('POINT(20.58444 41.5325)',4326),41.5325,
        20.58444,'112/10667');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10668,'Debarca',1,112,
        ST_GeomFromtext('POINT(20.822222 41.334167)',4326),41.334167,
        20.822222,'112/10668');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10669,'Delcevo',1,112,
        ST_GeomFromtext('POINT(22.766667 41.933333)',4326),41.933333,
        22.766667,'112/10669');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10670,'Demir Hisar',1,112,
        ST_GeomFromtext('POINT(21.14389 41.28083)',4326),41.28083,
        21.14389,'112/10670');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10671,'Demir Kapija',1,112,
        ST_GeomFromtext('POINT(22.25 41.383333)',4326),41.383333,
        22.25,'112/10671');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10672,'Dojran',1,112,
        ST_GeomFromtext('POINT(22.68917 41.2425)',4326),41.2425,
        22.68917,'112/10672');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10673,'Dolneni',1,112,
        ST_GeomFromtext('POINT(21.433333 41.483333)',4326),41.483333,
        21.433333,'112/10673');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10674,'Dorce Petrov (Gjorce Petrov) (Skopje)',1,112,
        ST_GeomFromtext('POINT(21.333333 42.05)',4326),42.05,
        21.333333,'112/10674');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10675,'Drugovo',1,112,
        ST_GeomFromtext('POINT(20.916667 41.466667)',4326),41.466667,
        20.916667,'112/10675');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10676,'Gazi Baba (Skopje)',1,112,
        ST_GeomFromtext('POINT(21.516667 42.05)',4326),42.05,
        21.516667,'112/10676');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10677,'Gevgelija',1,112,
        ST_GeomFromtext('POINT(22.4 41.2)',4326),41.2,
        22.4,'112/10677');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10678,'Gostivar',1,112,
        ST_GeomFromtext('POINT(20.83222 41.79306)',4326),41.79306,
        20.83222,'112/10678');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10679,'Gradsko',1,112,
        ST_GeomFromtext('POINT(21.916667 41.6)',4326),41.6,
        21.916667,'112/10679');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10680,'Ilinden',1,112,
        ST_GeomFromtext('POINT(21.633333 42.0)',4326),42.0,
        21.633333,'112/10680');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10681,'Jegunovce',1,112,
        ST_GeomFromtext('POINT(21.14528 42.11306)',4326),42.11306,
        21.14528,'112/10681');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10682,'Karbinci',1,112,
        ST_GeomFromtext('POINT(22.283333 41.8)',4326),41.8,
        22.283333,'112/10682');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10683,'Karpos (Skopje)',1,112,
        ST_GeomFromtext('POINT(21.383333 42.0)',4326),42.0,
        21.383333,'112/10683');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10684,'Kavadarci',1,112,
        ST_GeomFromtext('POINT(22.00139 41.285)',4326),41.285,
        22.00139,'112/10684');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10685,'Kicevo',1,112,
        ST_GeomFromtext('POINT(20.95 41.516667)',4326),41.516667,
        20.95,'112/10685');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10686,'Kisela Voda (Skopje)',1,112,
        ST_GeomFromtext('POINT(21.516667 41.95)',4326),41.95,
        21.516667,'112/10686');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10687,'Kocani',1,112,
        ST_GeomFromtext('POINT(22.4 41.983333)',4326),41.983333,
        22.4,'112/10687');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10688,'Konce',1,112,
        ST_GeomFromtext('POINT(22.4 41.533333)',4326),41.533333,
        22.4,'112/10688');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10689,'Kratovo',1,112,
        ST_GeomFromtext('POINT(22.166667 42.083333)',4326),42.083333,
        22.166667,'112/10689');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10690,'Kriva Palanka',1,112,
        ST_GeomFromtext('POINT(22.333333 42.25)',4326),42.25,
        22.333333,'112/10690');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10691,'Krivogastani',1,112,
        ST_GeomFromtext('POINT(21.366667 41.333333)',4326),41.333333,
        21.366667,'112/10691');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10692,'Krusevo',1,112,
        ST_GeomFromtext('POINT(21.266667 41.366667)',4326),41.366667,
        21.266667,'112/10692');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10693,'Kumanovo',1,112,
        ST_GeomFromtext('POINT(21.77278 42.08944)',4326),42.08944,
        21.77278,'112/10693');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10694,'Lipkovo',1,112,
        ST_GeomFromtext('POINT(21.6 42.166667)',4326),42.166667,
        21.6,'112/10694');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10695,'Lozovo',1,112,
        ST_GeomFromtext('POINT(21.933333 41.75)',4326),41.75,
        21.933333,'112/10695');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10696,'Makedonska Kamenica',1,112,
        ST_GeomFromtext('POINT(22.583333 42.05)',4326),42.05,
        22.583333,'112/10696');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10697,'Makedonski Brod',1,112,
        ST_GeomFromtext('POINT(21.233333 41.65556)',4326),41.65556,
        21.233333,'112/10697');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10698,'Mavrovo i Rostusa',1,112,
        ST_GeomFromtext('POINT(20.68389 41.65778)',4326),41.65778,
        20.68389,'112/10698');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10699,'Mogila',1,112,
        ST_GeomFromtext('POINT(21.43556 41.15806)',4326),41.15806,
        21.43556,'112/10699');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10700,'Negotino',1,112,
        ST_GeomFromtext('POINT(22.15 41.516667)',4326),41.516667,
        22.15,'112/10700');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10701,'Novaci',1,112,
        ST_GeomFromtext('POINT(21.6675 41.01944)',4326),41.01944,
        21.6675,'112/10701');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10702,'Novo Selo',1,112,
        ST_GeomFromtext('POINT(22.9 41.416667)',4326),41.416667,
        22.9,'112/10702');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10703,'Ohrid',1,112,
        ST_GeomFromtext('POINT(20.87028 41.13083)',4326),41.13083,
        20.87028,'112/10703');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10704,'Oslomej',1,112,
        ST_GeomFromtext('POINT(21.05 41.6)',4326),41.6,
        21.05,'112/10704');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10705,'Pehcevo',1,112,
        ST_GeomFromtext('POINT(22.916667 41.783333)',4326),41.783333,
        22.916667,'112/10705');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10706,'Petrovec',1,112,
        ST_GeomFromtext('POINT(21.716667 41.916667)',4326),41.916667,
        21.716667,'112/10706');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10707,'Plasnica',1,112,
        ST_GeomFromtext('POINT(21.116667 41.45)',4326),41.45,
        21.116667,'112/10707');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10708,'Prilep',1,112,
        ST_GeomFromtext('POINT(21.67583 41.28778)',4326),41.28778,
        21.67583,'112/10708');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10709,'Probistip',1,112,
        ST_GeomFromtext('POINT(22.15 41.966667)',4326),41.966667,
        22.15,'112/10709');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10710,'Radovis',1,112,
        ST_GeomFromtext('POINT(22.5 41.65)',4326),41.65,
        22.5,'112/10710');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10711,'Rankovce',1,112,
        ST_GeomFromtext('POINT(22.15 42.216667)',4326),42.216667,
        22.15,'112/10711');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10712,'Resen',1,112,
        ST_GeomFromtext('POINT(21.016667 41.033333)',4326),41.033333,
        21.016667,'112/10712');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10713,'Rosoman',1,112,
        ST_GeomFromtext('POINT(21.916667 41.5)',4326),41.5,
        21.916667,'112/10713');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10714,'Saraj (Skopje)',1,112,
        ST_GeomFromtext('POINT(21.266667 41.983333)',4326),41.983333,
        21.266667,'112/10714');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10715,'Sopiste',1,112,
        ST_GeomFromtext('POINT(21.316667 41.9)',4326),41.9,
        21.316667,'112/10715');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10716,'Staro Nagoricane',1,112,
        ST_GeomFromtext('POINT(21.933333 42.233333)',4326),42.233333,
        21.933333,'112/10716');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10717,'Stip',1,112,
        ST_GeomFromtext('POINT(22.2 41.7)',4326),41.7,
        22.2,'112/10717');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10718,'Struga',1,112,
        ST_GeomFromtext('POINT(20.63361 41.28139)',4326),41.28139,
        20.63361,'112/10718');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10719,'Strumica',1,112,
        ST_GeomFromtext('POINT(22.64639 41.41111)',4326),41.41111,
        22.64639,'112/10719');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10720,'Studenicani',1,112,
        ST_GeomFromtext('POINT(21.433333 41.833333)',4326),41.833333,
        21.433333,'112/10720');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10721,'Suto Orizari (Skopje)',1,112,
        ST_GeomFromtext('POINT(21.416667 42.05)',4326),42.05,
        21.416667,'112/10721');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10722,'Sveti Nikole',1,112,
        ST_GeomFromtext('POINT(21.983333 41.9)',4326),41.9,
        21.983333,'112/10722');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10723,'Tearce',1,112,
        ST_GeomFromtext('POINT(21.05 42.1)',4326),42.1,
        21.05,'112/10723');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10724,'Tetovo',1,112,
        ST_GeomFromtext('POINT(20.9025 42.04444)',4326),42.04444,
        20.9025,'112/10724');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10725,'Valandovo',1,112,
        ST_GeomFromtext('POINT(22.53222 41.33444)',4326),41.33444,
        22.53222,'112/10725');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10726,'Vasilevo',1,112,
        ST_GeomFromtext('POINT(22.666667 41.533333)',4326),41.533333,
        22.666667,'112/10726');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10727,'Veles',1,112,
        ST_GeomFromtext('POINT(21.76278 41.77583)',4326),41.77583,
        21.76278,'112/10727');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10728,'Vevcani',1,112,
        ST_GeomFromtext('POINT(20.583333 41.233333)',4326),41.233333,
        20.583333,'112/10728');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10729,'Vinica',1,112,
        ST_GeomFromtext('POINT(22.58417 41.85917)',4326),41.85917,
        22.58417,'112/10729');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10730,'Vranestica',1,112,
        ST_GeomFromtext('POINT(21.05 41.5)',4326),41.5,
        21.05,'112/10730');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10731,'Vrapciste',1,112,
        ST_GeomFromtext('POINT(20.85 41.85)',4326),41.85,
        20.85,'112/10731');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10732,'Zajas',1,112,
        ST_GeomFromtext('POINT(20.9 41.6)',4326),41.6,
        20.9,'112/10732');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10733,'Zelenikovo',1,112,
        ST_GeomFromtext('POINT(21.583333 41.833333)',4326),41.833333,
        21.583333,'112/10733');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10734,'Zelino',1,112,
        ST_GeomFromtext('POINT(21.133333 41.933333)',4326),41.933333,
        21.133333,'112/10734');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10735,'Zrnovci',1,112,
        ST_GeomFromtext('POINT(22.45 41.833333)',4326),41.833333,
        22.45,'112/10735');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10736,'Chaguanas Borough',1,194,
        ST_GeomFromtext('POINT(-61.41207 10.51648)',4326),10.51648,
        -61.41207,'194/10736');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10737,'Arima Borough',1,194,
        ST_GeomFromtext('POINT(-61.2797 10.631806)',4326),10.631806,
        -61.2797,'194/10737');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10738,'Caroni',1,194,
        ST_GeomFromtext('POINT(-61.372753 10.510014)',4326),10.510014,
        -61.372753,'194/10738');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10739,'Diego Martin',1,194,
        ST_GeomFromtext('POINT(-61.58369 10.713726)',4326),10.713726,
        -61.58369,'194/10739');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10740,'Nariva/Mayaro',1,194,
        ST_GeomFromtext('POINT(-61.013268 10.28928)',4326),10.28928,
        -61.013268,'194/10740');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10741,'Point Fortin Borough',1,194,
        ST_GeomFromtext('POINT(-61.683029 10.161273)',4326),10.161273,
        -61.683029,'194/10741');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10742,'Port of Spain',1,194,
        ST_GeomFromtext('POINT(-61.478912 10.659567)',4326),10.659567,
        -61.478912,'194/10742');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10743,'Rest of St. George',1,194,
        ST_GeomFromtext('POINT(-61.373066 10.672139)',4326),10.672139,
        -61.373066,'194/10743');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10744,'San Fernando',1,194,
        ST_GeomFromtext('POINT(-61.458598 10.282893)',4326),10.282893,
        -61.458598,'194/10744');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10745,'St. Andrew/St. David',1,194,
        ST_GeomFromtext('POINT(-61.093352 10.645048)',4326),10.645048,
        -61.093352,'194/10745');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10746,'St. Anns',1,194,
        ST_GeomFromtext('POINT(-61.515328 10.674549)',4326),10.674549,
        -61.515328,'194/10746');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10747,'St. Patrick',1,194,
        ST_GeomFromtext('POINT(-61.560324 10.124563)',4326),10.124563,
        -61.560324,'194/10747');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10748,'Tacarigua',1,194,
        ST_GeomFromtext('POINT(-61.364996 10.644123)',4326),10.644123,
        -61.364996,'194/10748');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10749,'Tobago',1,194,
        ST_GeomFromtext('POINT(-60.698199 11.231771)',4326),11.231771,
        -60.698199,'194/10749');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10750,'Victoria',1,194,
        ST_GeomFromtext('POINT(-61.279404 10.179403)',4326),10.179403,
        -61.279404,'194/10750');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10751,'Canakkale',1,202,
        ST_GeomFromtext('POINT(26.833333 40.083333)',4326),40.083333,
        26.833333,'202/10751');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10752,'Cankiri',1,202,
        ST_GeomFromtext('POINT(33.416667 40.666667)',4326),40.666667,
        33.416667,'202/10752');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10753,'Corum',1,202,
        ST_GeomFromtext('POINT(34.738647 40.493586)',4326),40.493586,
        34.738647,'202/10753');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10754,'Adana',1,202,
        ST_GeomFromtext('POINT(35.416667 37.25)',4326),37.25,
        35.416667,'202/10754');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10755,'Adiyaman',1,202,
        ST_GeomFromtext('POINT(38.25 37.75)',4326),37.75,
        38.25,'202/10755');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10756,'Afyonkarahisar',1,202,
        ST_GeomFromtext('POINT(30.666667 38.75)',4326),38.75,
        30.666667,'202/10756');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10757,'Agri',1,202,
        ST_GeomFromtext('POINT(43.166667 39.666667)',4326),39.666667,
        43.166667,'202/10757');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10758,'Aksaray',1,202,
        ST_GeomFromtext('POINT(34.014198 38.365035)',4326),38.365035,
        34.014198,'202/10758');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10759,'Amasya',1,202,
        ST_GeomFromtext('POINT(35.886701 40.726192)',4326),40.726192,
        35.886701,'202/10759');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10760,'Ankara',1,202,
        ST_GeomFromtext('POINT(32.50094 39.750326)',4326),39.750326,
        32.50094,'202/10760');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10761,'Antalya',1,202,
        ST_GeomFromtext('POINT(31.0 37.0)',4326),37.0,
        31.0,'202/10761');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10762,'Artvin',1,202,
        ST_GeomFromtext('POINT(41.833333 41.166667)',4326),41.166667,
        41.833333,'202/10762');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10763,'Aydin',1,202,
        ST_GeomFromtext('POINT(28.0 37.75)',4326),37.75,
        28.0,'202/10763');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10764,'Balikesir',1,202,
        ST_GeomFromtext('POINT(28.0 39.75)',4326),39.75,
        28.0,'202/10764');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10765,'Bartin',1,202,
        ST_GeomFromtext('POINT(32.5 41.583333)',4326),41.583333,
        32.5,'202/10765');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10766,'Batman',1,202,
        ST_GeomFromtext('POINT(41.333333 38.0)',4326),38.0,
        41.333333,'202/10766');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10767,'Bayburt',1,202,
        ST_GeomFromtext('POINT(40.25 40.25)',4326),40.25,
        40.25,'202/10767');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10768,'Bilecik',1,202,
        ST_GeomFromtext('POINT(30.166667 40.0)',4326),40.0,
        30.166667,'202/10768');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10769,'Bingol',1,202,
        ST_GeomFromtext('POINT(40.833333 39.083333)',4326),39.083333,
        40.833333,'202/10769');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10770,'Bitlis',1,202,
        ST_GeomFromtext('POINT(42.391341 38.342005)',4326),38.342005,
        42.391341,'202/10770');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10771,'Bolu',1,202,
        ST_GeomFromtext('POINT(31.583333 40.666667)',4326),40.666667,
        31.583333,'202/10771');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10772,'Burdur',1,202,
        ST_GeomFromtext('POINT(30.0 37.5)',4326),37.5,
        30.0,'202/10772');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10773,'Bursa',1,202,
        ST_GeomFromtext('POINT(29.083333 40.166667)',4326),40.166667,
        29.083333,'202/10773');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10774,'Denizli',1,202,
        ST_GeomFromtext('POINT(29.25 37.7)',4326),37.7,
        29.25,'202/10774');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10775,'Diyarbakir',1,202,
        ST_GeomFromtext('POINT(40.5 38.0)',4326),38.0,
        40.5,'202/10775');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10776,'Duzce',1,202,
        ST_GeomFromtext('POINT(31.166667 40.833333)',4326),40.833333,
        31.166667,'202/10776');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10777,'Edirne',1,202,
        ST_GeomFromtext('POINT(26.666667 41.25)',4326),41.25,
        26.666667,'202/10777');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10778,'Elazig',1,202,
        ST_GeomFromtext('POINT(39.496515 38.529872)',4326),38.529872,
        39.496515,'202/10778');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10779,'Erzincan',1,202,
        ST_GeomFromtext('POINT(39.573323 39.798551)',4326),39.798551,
        39.573323,'202/10779');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10780,'Erzurum',1,202,
        ST_GeomFromtext('POINT(41.532766 39.98)',4326),39.98,
        41.532766,'202/10780');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10781,'Eskisehir',1,202,
        ST_GeomFromtext('POINT(31.166667 39.666667)',4326),39.666667,
        31.166667,'202/10781');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10782,'Gumushane',1,202,
        ST_GeomFromtext('POINT(39.583333 40.25)',4326),40.25,
        39.583333,'202/10782');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10783,'Gaziantep',1,202,
        ST_GeomFromtext('POINT(37.333333 37.083333)',4326),37.083333,
        37.333333,'202/10783');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10784,'Giresun',1,202,
        ST_GeomFromtext('POINT(38.5 40.5)',4326),40.5,
        38.5,'202/10784');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10785,'Hakkari',1,202,
        ST_GeomFromtext('POINT(44.166667 37.583333)',4326),37.583333,
        44.166667,'202/10785');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10786,'Hatay',1,202,
        ST_GeomFromtext('POINT(36.25 36.5)',4326),36.5,
        36.25,'202/10786');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10787,'Igdir',1,202,
        ST_GeomFromtext('POINT(43.863557 39.928256)',4326),39.928256,
        43.863557,'202/10787');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10788,'Isparta',1,202,
        ST_GeomFromtext('POINT(31.0 38.0)',4326),38.0,
        31.0,'202/10788');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10789,'Istanbul',1,202,
        ST_GeomFromtext('POINT(28.75 41.166667)',4326),41.166667,
        28.75,'202/10789');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10790,'Izmir',1,202,
        ST_GeomFromtext('POINT(27.5 38.25)',4326),38.25,
        27.5,'202/10790');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10791,'Kahramanmaras',1,202,
        ST_GeomFromtext('POINT(37.0 38.0)',4326),38.0,
        37.0,'202/10791');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10792,'Karabuk',1,202,
        ST_GeomFromtext('POINT(32.5 41.25)',4326),41.25,
        32.5,'202/10792');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10793,'Karaman',1,202,
        ST_GeomFromtext('POINT(33.25 37.083333)',4326),37.083333,
        33.25,'202/10793');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10794,'Kars',1,202,
        ST_GeomFromtext('POINT(43.083333 40.416667)',4326),40.416667,
        43.083333,'202/10794');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10795,'Kastamonu',1,202,
        ST_GeomFromtext('POINT(33.666667 41.5)',4326),41.5,
        33.666667,'202/10795');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10796,'Kutahya',1,202,
        ST_GeomFromtext('POINT(29.5 39.25)',4326),39.25,
        29.5,'202/10796');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10797,'Kayseri',1,202,
        ST_GeomFromtext('POINT(35.916667 38.75)',4326),38.75,
        35.916667,'202/10797');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10798,'Kirklareli',1,202,
        ST_GeomFromtext('POINT(27.5 41.666667)',4326),41.666667,
        27.5,'202/10798');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10799,'Kirsehir',1,202,
        ST_GeomFromtext('POINT(34.166667 39.333333)',4326),39.333333,
        34.166667,'202/10799');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10800,'Kocaeli',1,202,
        ST_GeomFromtext('POINT(29.916667 40.916667)',4326),40.916667,
        29.916667,'202/10800');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10801,'Konya',1,202,
        ST_GeomFromtext('POINT(32.5 38.166667)',4326),38.166667,
        32.5,'202/10801');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10802,'Malatya',1,202,
        ST_GeomFromtext('POINT(38.0 38.5)',4326),38.5,
        38.0,'202/10802');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10803,'Manisa',1,202,
        ST_GeomFromtext('POINT(28.166667 38.833333)',4326),38.833333,
        28.166667,'202/10803');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10804,'Mardin',1,202,
        ST_GeomFromtext('POINT(40.780992 37.401401)',4326),37.401401,
        40.780992,'202/10804');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10805,'Mersin',1,202,
        ST_GeomFromtext('POINT(34.0 36.75)',4326),36.75,
        34.0,'202/10805');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10806,'Mugla',1,202,
        ST_GeomFromtext('POINT(28.5 37.166667)',4326),37.166667,
        28.5,'202/10806');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10807,'Mus',1,202,
        ST_GeomFromtext('POINT(41.683007 38.977103)',4326),38.977103,
        41.683007,'202/10807');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10808,'Nevsehir',1,202,
        ST_GeomFromtext('POINT(34.666667 38.916667)',4326),38.916667,
        34.666667,'202/10808');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10809,'Nigde',1,202,
        ST_GeomFromtext('POINT(34.75 37.833333)',4326),37.833333,
        34.75,'202/10809');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10810,'Ordu',1,202,
        ST_GeomFromtext('POINT(37.5 40.833333)',4326),40.833333,
        37.5,'202/10810');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10811,'Osmaniye',1,202,
        ST_GeomFromtext('POINT(36.25 37.25)',4326),37.25,
        36.25,'202/10811');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10812,'Rize',1,202,
        ST_GeomFromtext('POINT(41.0 41.0)',4326),41.0,
        41.0,'202/10812');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10813,'Sakarya',1,202,
        ST_GeomFromtext('POINT(30.583333 40.75)',4326),40.75,
        30.583333,'202/10813');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10814,'Samsun',1,202,
        ST_GeomFromtext('POINT(36.333333 41.25)',4326),41.25,
        36.333333,'202/10814');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10815,'Sanliurfa',1,202,
        ST_GeomFromtext('POINT(39.0 37.25)',4326),37.25,
        39.0,'202/10815');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10816,'Siirt',1,202,
        ST_GeomFromtext('POINT(42.166667 37.833333)',4326),37.833333,
        42.166667,'202/10816');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10817,'Sinop',1,202,
        ST_GeomFromtext('POINT(35.0 41.666667)',4326),41.666667,
        35.0,'202/10817');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10818,'Sirnak',1,202,
        ST_GeomFromtext('POINT(42.562251 37.563283)',4326),37.563283,
        42.562251,'202/10818');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10819,'Sivas',1,202,
        ST_GeomFromtext('POINT(37.408114 39.53793)',4326),39.53793,
        37.408114,'202/10819');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10820,'Tekirdag',1,202,
        ST_GeomFromtext('POINT(27.5 41.0)',4326),41.0,
        27.5,'202/10820');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10821,'Tokat',1,202,
        ST_GeomFromtext('POINT(36.583333 40.416667)',4326),40.416667,
        36.583333,'202/10821');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10822,'Trabzon',1,202,
        ST_GeomFromtext('POINT(39.81255 40.869457)',4326),40.869457,
        39.81255,'202/10822');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10823,'Tunceli',1,202,
        ST_GeomFromtext('POINT(39.5 39.083333)',4326),39.083333,
        39.5,'202/10823');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10824,'Usak',1,202,
        ST_GeomFromtext('POINT(29.416667 38.5)',4326),38.5,
        29.416667,'202/10824');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10825,'Van',1,202,
        ST_GeomFromtext('POINT(43.717793 38.407357)',4326),38.407357,
        43.717793,'202/10825');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10826,'Yalova',1,202,
        ST_GeomFromtext('POINT(29.166667 40.583333)',4326),40.583333,
        29.166667,'202/10826');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10827,'Yozgat',1,202,
        ST_GeomFromtext('POINT(35.333333 39.583333)',4326),39.583333,
        35.333333,'202/10827');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10828,'Zonguldak',1,202,
        ST_GeomFromtext('POINT(31.833333 41.25)',4326),41.25,
        31.833333,'202/10828');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10829,'Isingiro',1,206,
        ST_GeomFromtext('POINT(30.871754 -0.833538)',4326),-0.833538,
        30.871754,'206/10829');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10830,'Anguilla',1,207,
        ST_GeomFromtext('POINT(-63.070208 18.204954)',4326),18.204954,
        -63.070208,'207/10830');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10831,'British Virgin Islands',1,207,
        ST_GeomFromtext('POINT(-64.639964 18.420694)',4326),18.420694,
        -64.639964,'207/10831');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10832,'Cayman Islands',1,207,
        ST_GeomFromtext('POINT(-80.557691 19.488793)',4326),19.488793,
        -80.557691,'207/10832');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10833,'Falkland Islands (Islas Malvinas)',1,207,
        ST_GeomFromtext('POINT(-59.562794 -51.99335)',4326),-51.99335,
        -59.562794,'207/10833');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10834,'Gibraltar',1,207,
        ST_GeomFromtext('POINT(-5.345374 36.137741)',4326),36.137741,
        -5.345374,'207/10834');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10835,'Guernsey',1,207,
        ST_GeomFromtext('POINT(-2.602071 49.44447)',4326),49.44447,
        -2.602071,'207/10835');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10836,'Isle of Man',1,207,
        ST_GeomFromtext('POINT(-4.548056 54.236107)',4326),54.236107,
        -4.548056,'207/10836');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10837,'Jersey',1,207,
        ST_GeomFromtext('POINT(-2.13125 49.214439)',4326),49.214439,
        -2.13125,'207/10837');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10838,'Montserrat',1,207,
        ST_GeomFromtext('POINT(-62.186962 16.742578)',4326),16.742578,
        -62.186962,'207/10838');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10839,'Pitcairn Islands',1,207,
        ST_GeomFromtext('POINT(-127.43929 -24.703606)',4326),-24.703606,
        -127.43929,'207/10839');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10840,'Saint Helena, Ascension, and Tristan da Cunha',1,207,
        ST_GeomFromtext('POINT(-5.733488 -15.988524)',4326),-15.988524,
        -5.733488,'207/10840');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10841,'Turks and Caicos Islands',1,207,
        ST_GeomFromtext('POINT(-71.768174 21.779152)',4326),21.779152,
        -71.768174,'207/10841');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10842,'American Samoa',1,209,
        ST_GeomFromtext('POINT(-170.132217 -14.270972)',4326),-14.270972,
        -170.132217,'209/10842');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10843,'Guam',1,209,
        ST_GeomFromtext('POINT(144.793778 13.444304)',4326),13.444304,
        144.793778,'209/10843');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10844,'Puerto Rico',1,209,
        ST_GeomFromtext('POINT(-66.1 18.45)',4326),18.45,
        -66.1,'209/10844');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10845,'Vargas',1,214,
        ST_GeomFromtext('POINT(-66.9 10.566667)',4326),10.566667,
        -66.9,'214/10845');
INSERT INTO regions(id,name,level,country_id,the_geom,center_lat,center_lon,path) VALUES
        (10846,'An Giang',1,216,
        ST_GeomFromtext('POINT(105.166667 10.5)',4326),10.5,
        105.166667,'216/10846');
UPDATE regions SET name = 'Paktiya' WHERE id = 3554;
UPDATE regions SET name = 'Sar-e Pul' WHERE id = 3556;
UPDATE regions SET name = 'Diber' WHERE id = 68;
UPDATE regions SET name = 'Durres' WHERE id = 69;
UPDATE regions SET name = 'Gjirokaster' WHERE id = 72;
UPDATE regions SET name = 'Korce' WHERE id = 73;
UPDATE regions SET name = 'Kikes' WHERE id = 74;
UPDATE regions SET name = 'Lezhe' WHERE id = 75;
UPDATE regions SET name = 'Shkoder' WHERE id = 76;
UPDATE regions SET name = 'Tirane' WHERE id = 77;
UPDATE regions SET name = 'Vlore' WHERE id = 78;
UPDATE regions SET name = 'Ain Defla' WHERE id = 868;
UPDATE regions SET name = 'Ain Temouchent' WHERE id = 867;
UPDATE regions SET name = 'Bechar' WHERE id = 863;
UPDATE regions SET name = 'Bejaia' WHERE id = 862;
UPDATE regions SET name = 'Bordj Bou Arreridj' WHERE id = 854;
UPDATE regions SET name = 'Boumerdes' WHERE id = 852;
UPDATE regions SET name = 'Ghardaia' WHERE id = 859;
UPDATE regions SET name = 'Medea' WHERE id = 874;
UPDATE regions SET name = 'Naama' WHERE id = 845;
UPDATE regions SET name = 'Setif' WHERE id = 836;
UPDATE regions SET name = 'Saida' WHERE id = 837;
UPDATE regions SET name = 'Sidi Bel Abbes' WHERE id = 835;
UPDATE regions SET name = 'Tebessa' WHERE id = 844;
UPDATE regions SET name = 'Sant Julia de Loria' WHERE id = 82;
UPDATE regions SET name = 'Bie' WHERE id = 35;
UPDATE regions SET name = 'Huila' WHERE id = 42;
UPDATE regions SET name = 'Uige' WHERE id = 49;
UPDATE regions SET name = 'Cordoba' WHERE id = 105;
UPDATE regions SET name = 'Buenos Aires Capital Federal' WHERE id = 111;
UPDATE regions SET name = 'Entre Rios' WHERE id = 103;
UPDATE regions SET name = 'Neuquen' WHERE id = 102;
UPDATE regions SET name = 'Rio Negro' WHERE id = 106;
UPDATE regions SET name = 'Tucuman' WHERE id = 122;
UPDATE regions SET name = 'Aragatsotn' WHERE id = 123;
UPDATE regions SET name = 'Carinthia' WHERE id = 166;
UPDATE regions SET name = 'Lower Austria' WHERE id = 167;
UPDATE regions SET name = 'Upper Austria' WHERE id = 169;
UPDATE regions SET name = 'Styria' WHERE id = 162;
UPDATE regions SET name = 'Tyrol' WHERE id = 163;
UPDATE regions SET name = 'Vienna' WHERE id = 168;
UPDATE regions SET name = 'Agcabadi' WHERE id = 3569;
UPDATE regions SET name = 'Ali Bayramli Sahari' WHERE id = 3568;
UPDATE regions SET name = 'Baki Sahari' WHERE id = 214;
UPDATE regions SET name = 'Balakan' WHERE id = 3572;
UPDATE regions SET name = 'Barda' WHERE id = 3570;
UPDATE regions SET name = 'Cabrayil' WHERE id = 210;
UPDATE regions SET name = 'Davaci' WHERE id = 3577;
UPDATE regions SET name = 'Fuzuli' WHERE id = 191;
UPDATE regions SET name = 'Ganca Sahari' WHERE id = 3580;
UPDATE regions SET name = 'Kurdamir' WHERE id = 3582;
UPDATE regions SET name = 'Mingacevir Sahari' WHERE id = 3584;
UPDATE regions SET name = 'Naxcivan Muxtar' WHERE id = 180;
UPDATE regions SET name = 'Neftcala' WHERE id = 234;
UPDATE regions SET name = 'Sumqayit Sahari' WHERE id = 171;
UPDATE regions SET name = 'Xacmaz' WHERE id = 177;
UPDATE regions SET name = 'Acklins Islands' WHERE id = 394;
UPDATE regions SET name = 'Bimini' WHERE id = 374;
UPDATE regions SET name = 'Crooked Island and Long Cay' WHERE id = 392;
UPDATE regions SET name = 'Brest' WHERE id = 401;
UPDATE regions SET name = 'Gomel' WHERE id = 399;
UPDATE regions SET name = 'Grodno' WHERE id = 403;
UPDATE regions SET name = 'Mogilev' WHERE id = 398;
UPDATE regions SET name = 'Brussels-Capital Region' WHERE id = 264;
UPDATE regions SET name = 'Flanders' WHERE id = 265;
UPDATE regions SET name = 'Wallonia' WHERE id = 260;
UPDATE regions SET name = 'Oueme' WHERE id = 278;
UPDATE regions SET name = 'Tsirang' WHERE id = 489;
UPDATE regions SET name = 'Dagana' WHERE id = 488;
UPDATE regions SET name = 'Sarpang' WHERE id = 486;
UPDATE regions SET name = 'Haa' WHERE id = 485;
UPDATE regions SET name = 'Lhuentse' WHERE id = 484;
UPDATE regions SET name = 'Monggar' WHERE id = 483;
UPDATE regions SET name = 'Pemagatshel' WHERE id = 481;
UPDATE regions SET name = 'Samdrupjongkhar' WHERE id = 472;
UPDATE regions SET name = 'Zhemgang' WHERE id = 473;
UPDATE regions SET name = 'Trashiyangtse' WHERE id = 474;
UPDATE regions SET name = 'Trashigang' WHERE id = 475;
UPDATE regions SET name = 'Trongsa' WHERE id = 477;
UPDATE regions SET name = 'Wangdue' WHERE id = 478;
UPDATE regions SET name = 'Potosi' WHERE id = 427;
UPDATE regions SET name = 'Bosniak/Croat Federation of Bosnia and Herzegovina' WHERE id = 397;
UPDATE regions SET name = 'Bosnian Serb-led Republika Srpska' WHERE id = 396;
UPDATE regions SET name = 'North East' WHERE id = 496;
UPDATE regions SET name = 'North West' WHERE id = 495;
UPDATE regions SET name = 'South East' WHERE id = 493;
UPDATE regions SET name = 'South' WHERE id = 494;
UPDATE regions SET name = 'Amapa' WHERE id = 432;
UPDATE regions SET name = 'Ceara' WHERE id = 435;
UPDATE regions SET name = 'Espirito Santo' WHERE id = 437;
UPDATE regions SET name = 'Goias' WHERE id = 438;
UPDATE regions SET name = 'Maranhao' WHERE id = 439;
UPDATE regions SET name = 'Mato Grosso' WHERE id = 440;
UPDATE regions SET name = 'Paraiba' WHERE id = 444;
UPDATE regions SET name = 'Parana' WHERE id = 445;
UPDATE regions SET name = 'Pernambuco' WHERE id = 446;
UPDATE regions SET name = 'Rio de Janeiro' WHERE id = 448;
UPDATE regions SET name = 'Roraima' WHERE id = 452;
UPDATE regions SET name = 'Sao Paulo' WHERE id = 453;
UPDATE regions SET name = 'Brunei-Muara' WHERE id = 470;
UPDATE regions SET name = 'Sofia City' WHERE id = 336;
UPDATE regions SET name = 'Khaskovo' WHERE id = 337;
UPDATE regions SET name = 'Kurdzhali' WHERE id = 338;
UPDATE regions SET name = 'Ayeyawaddy' WHERE id = 1855;
UPDATE regions SET name = 'Kayar' WHERE id = 1865;
UPDATE regions SET name = 'Koh Kong' WHERE id = 3657;
UPDATE regions SET name = 'Otdar Meanchey' WHERE id = 3661;
UPDATE regions SET name = 'Preah Sihanouk' WHERE id = 3663;
UPDATE regions SET name = 'Ratanak Kiri' WHERE id = 3667;
UPDATE regions SET name = 'Far North' WHERE id = 626;
UPDATE regions SET name = 'North' WHERE id = 628;
UPDATE regions SET name = 'North-West' WHERE id = 629;
UPDATE regions SET name = 'West' WHERE id = 630;
UPDATE regions SET name = 'South' WHERE id = 631;
UPDATE regions SET name = 'South West' WHERE id = 632;
UPDATE regions SET name = 'Quebec' WHERE id = 524;
UPDATE regions SET name = 'Yukon Territory' WHERE id = 522;
UPDATE regions SET name = 'Paul' WHERE id = 702;
UPDATE regions SET name = 'Sao Domingos' WHERE id = 690;
UPDATE regions SET name = 'Sao Filipe' WHERE id = 687;
UPDATE regions SET name = 'Sao Miguel' WHERE id = 692;
UPDATE regions SET name = 'Sao Nicolau' WHERE id = 693;
UPDATE regions SET name = 'Sao Vicente' WHERE id = 688;
UPDATE regions SET name = 'Kemo' WHERE id = 517;
UPDATE regions SET name = 'Mambere-Kadei' WHERE id = 512;
UPDATE regions SET name = 'Nana-Grebizi' WHERE id = 515;
UPDATE regions SET name = 'Nana-Mambere' WHERE id = 516;
UPDATE regions SET name = 'Ombella-Mpoko' WHERE id = 518;
UPDATE regions SET name = 'Ouham-Pende' WHERE id = 510;
UPDATE regions SET name = 'Sangha-Mbaere' WHERE id = 509;
UPDATE regions SET name = 'Guera' WHERE id = 2801;
UPDATE regions SET name = 'Ouaddai' WHERE id = 2811;
UPDATE regions SET name = 'Aisen del General Carlos Ibanez del Campo' WHERE id = 559;
UPDATE regions SET name = 'Araucania' WHERE id = 561;
UPDATE regions SET name = 'Biobio' WHERE id = 3604;
UPDATE regions SET name = 'Magallanes y de la Antartica Chilena' WHERE id = 3606;
UPDATE regions SET name = 'Region Metropolitana de Santiago' WHERE id = 569;
UPDATE regions SET name = 'Tarapaca' WHERE id = 570;
UPDATE regions SET name = 'Valparaiso' WHERE id = 571;
UPDATE regions SET name = 'Inner Mongolia' WHERE id = 590;
UPDATE regions SET name = 'Xinjiang Uygur' WHERE id = 600;
UPDATE regions SET name = 'Tibet' WHERE id = 3611;
UPDATE regions SET name = 'Atlantico' WHERE id = 655;
UPDATE regions SET name = 'Bolivar' WHERE id = 656;
UPDATE regions SET name = 'Boyaca' WHERE id = 657;
UPDATE regions SET name = 'Cordoba' WHERE id = 664;
UPDATE regions SET name = 'Caqueta' WHERE id = 659;
UPDATE regions SET name = 'Choco' WHERE id = 663;
UPDATE regions SET name = 'Guainia' WHERE id = 666;
UPDATE regions SET name = 'Narino' WHERE id = 672;
UPDATE regions SET name = 'Quindio' WHERE id = 675;
UPDATE regions SET name = 'San Andres y Providencia' WHERE id = 677;
UPDATE regions SET name = 'Vaupes' WHERE id = 682;
UPDATE regions SET name = 'Lekoumou' WHERE id = 642;
UPDATE regions SET name = 'Limon' WHERE id = 705;
UPDATE regions SET name = 'San Jose' WHERE id = 704;
UPDATE regions SET name = 'Agneby' WHERE id = 622;
UPDATE regions SET name = 'Denguele' WHERE id = 619;
UPDATE regions SET name = 'Marahoue' WHERE id = 604;
UPDATE regions SET name = 'Moyen-Comoe' WHERE id = 610;
UPDATE regions SET name = 'N''zi-Comoe' WHERE id = 611;
UPDATE regions SET name = 'Sud-Comoe' WHERE id = 614;
UPDATE regions SET name = 'Vallee du Bandama' WHERE id = 615;
UPDATE regions SET name = 'Sibenik-Knin' WHERE id = 1204;
UPDATE regions SET name = 'Bjelovar-Bilogora' WHERE id = 1222;
UPDATE regions SET name = 'Slavonski Brod-Posavina' WHERE id = 1209;
UPDATE regions SET name = 'Dubrovnik-Neretva' WHERE id = 1210;
UPDATE regions SET name = 'Zagreb City' WHERE id = 1208;
UPDATE regions SET name = 'Istria' WHERE id = 1223;
UPDATE regions SET name = 'Karlovac' WHERE id = 1211;
UPDATE regions SET name = 'Koprivnica-Krizevci' WHERE id = 1213;
UPDATE regions SET name = 'Krapina-Zagorje' WHERE id = 1214;
UPDATE regions SET name = 'Lika-Senj' WHERE id = 1215;
UPDATE regions SET name = 'Medimurje' WHERE id = 1212;
UPDATE regions SET name = 'Osijek-Baranja' WHERE id = 1216;
UPDATE regions SET name = 'Pozega-Slavonia' WHERE id = 3644;
UPDATE regions SET name = 'Primorje-Gorski kotar' WHERE id = 1203;
UPDATE regions SET name = 'Sisak-Moslavina' WHERE id = 1206;
UPDATE regions SET name = 'Split-Dalmatia' WHERE id = 1207;
UPDATE regions SET name = 'Varazdin' WHERE id = 1205;
UPDATE regions SET name = 'Virovitica-Podravina' WHERE id = 1218;
UPDATE regions SET name = 'Vukovar-Sirmium' WHERE id = 1219;
UPDATE regions SET name = 'Zadar' WHERE id = 1220;
UPDATE regions SET name = 'Zagreb' WHERE id = 1221;
UPDATE regions SET name = 'Camaguey' WHERE id = 724;
UPDATE regions SET name = 'Ciego de Avila' WHERE id = 725;
UPDATE regions SET name = 'Guantanamo' WHERE id = 723;
UPDATE regions SET name = 'Holguin' WHERE id = 722;
UPDATE regions SET name = 'Pinar del Rio' WHERE id = 717;
UPDATE regions SET name = 'Sancti Spiritus' WHERE id = 716;
UPDATE regions SET name = 'Ustecky' WHERE id = 752;
UPDATE regions SET name = 'South Bohemia' WHERE id = 749;
UPDATE regions SET name = 'South Moravia' WHERE id = 740;
UPDATE regions SET name = 'Karlovarsky' WHERE id = 741;
UPDATE regions SET name = 'Kralovehradecky' WHERE id = 743;
UPDATE regions SET name = 'Vysocina' WHERE id = 742;
UPDATE regions SET name = 'Liberecky' WHERE id = 744;
UPDATE regions SET name = 'Moravia-Silesia' WHERE id = 745;
UPDATE regions SET name = 'Olomoucky' WHERE id = 746;
UPDATE regions SET name = 'Pardubicky' WHERE id = 747;
UPDATE regions SET name = 'Pilsen' WHERE id = 748;
UPDATE regions SET name = 'Central Bohemia' WHERE id = 739;
UPDATE regions SET name = 'Zlinsky' WHERE id = 751;
UPDATE regions SET name = 'Kasai-Occidental' WHERE id = 636;
UPDATE regions SET name = 'Kasai-Oriental' WHERE id = 637;
UPDATE regions SET name = 'Dajabon' WHERE id = 801;
UPDATE regions SET name = 'Maria Trinidad Sanchez' WHERE id = 812;
UPDATE regions SET name = 'Monsenor Nouel' WHERE id = 813;
UPDATE regions SET name = 'Sanchez Ramirez' WHERE id = 825;
UPDATE regions SET name = 'Samana' WHERE id = 820;
UPDATE regions SET name = 'San Cristobal' WHERE id = 821;
UPDATE regions SET name = 'San Jose de Ocoa' WHERE id = 822;
UPDATE regions SET name = 'San Pedro de Macoris' WHERE id = 824;
UPDATE regions SET name = 'Santiago Rodriguez' WHERE id = 827;
UPDATE regions SET name = 'Santo Domingo' WHERE id = 3632;
UPDATE regions SET name = 'Daqahliya' WHERE id = 924;
UPDATE regions SET name = 'Red Sea' WHERE id = 899;
UPDATE regions SET name = 'El Beheira' WHERE id = 900;
UPDATE regions SET name = 'Fayyoum' WHERE id = 904;
UPDATE regions SET name = 'Gharbiya' WHERE id = 905;
UPDATE regions SET name = 'Alexandria' WHERE id = 906;
UPDATE regions SET name = 'Ismailia' WHERE id = 907;
UPDATE regions SET name = 'Giza' WHERE id = 908;
UPDATE regions SET name = 'Monofiya' WHERE id = 909;
UPDATE regions SET name = 'Minya' WHERE id = 910;
UPDATE regions SET name = 'Cairo' WHERE id = 911;
UPDATE regions SET name = 'Qalioubiya' WHERE id = 913;
UPDATE regions SET name = 'New Valley' WHERE id = 912;
UPDATE regions SET name = 'Suez' WHERE id = 914;
UPDATE regions SET name = 'Sharqiya' WHERE id = 915;
UPDATE regions SET name = 'Asuit' WHERE id = 917;
UPDATE regions SET name = 'Bani Suef' WHERE id = 918;
UPDATE regions SET name = 'Port Said' WHERE id = 919;
UPDATE regions SET name = 'Damietta' WHERE id = 920;
UPDATE regions SET name = 'South Sinai' WHERE id = 921;
UPDATE regions SET name = 'Kafr el Sheikh' WHERE id = 922;
UPDATE regions SET name = 'Matroh' WHERE id = 901;
UPDATE regions SET name = 'Qena' WHERE id = 902;
UPDATE regions SET name = 'North Sinai' WHERE id = 903;
UPDATE regions SET name = 'Sohag' WHERE id = 923;
UPDATE regions SET name = 'Ahuachapan' WHERE id = 2659;
UPDATE regions SET name = 'Cabanas' WHERE id = 2660;
UPDATE regions SET name = 'Cuscatlan' WHERE id = 2662;
UPDATE regions SET name = 'La Union' WHERE id = 2665;
UPDATE regions SET name = 'Morazan' WHERE id = 2666;
UPDATE regions SET name = 'Usulutan' WHERE id = 2672;
UPDATE regions SET name = 'Annobon' WHERE id = 1087;
UPDATE regions SET name = 'Kie-Ntem' WHERE id = 1083;
UPDATE regions SET name = 'Wele-Nzas' WHERE id = 1086;
UPDATE regions SET name = 'South' WHERE id = 929;
UPDATE regions SET name = 'Southern Red Sea' WHERE id = 928;
UPDATE regions SET name = 'Central' WHERE id = 930;
UPDATE regions SET name = 'Northern Red Sea' WHERE id = 927;
UPDATE regions SET name = 'Harjumaa' WHERE id = 964;
UPDATE regions SET name = 'Hiiumaa' WHERE id = 965;
UPDATE regions SET name = 'Ida-Virumaa' WHERE id = 966;
UPDATE regions SET name = 'Jarvamaa' WHERE id = 960;
UPDATE regions SET name = 'Jogevamaa' WHERE id = 967;
UPDATE regions SET name = 'Laanemaa' WHERE id = 961;
UPDATE regions SET name = 'Laane-Virumaa' WHERE id = 962;
UPDATE regions SET name = 'Parnumaa' WHERE id = 954;
UPDATE regions SET name = 'Polvamaa' WHERE id = 963;
UPDATE regions SET name = 'Raplamaa' WHERE id = 953;
UPDATE regions SET name = 'Saaremaa' WHERE id = 959;
UPDATE regions SET name = 'Tartumaa' WHERE id = 958;
UPDATE regions SET name = 'Vorumaa' WHERE id = 955;
UPDATE regions SET name = 'Valgamaa' WHERE id = 957;
UPDATE regions SET name = 'Viljandimaa' WHERE id = 956;
UPDATE regions SET name = 'Binshangul Gumuz' WHERE id = 3634;
UPDATE regions SET name = 'Ile-de-France' WHERE id = 992;
UPDATE regions SET name = 'Lower Normandy' WHERE id = 993;
UPDATE regions SET name = 'Burgundy' WHERE id = 990;
UPDATE regions SET name = 'Brittany' WHERE id = 1010;
UPDATE regions SET name = 'Corsica' WHERE id = 998;
UPDATE regions SET name = 'Franche-Comte' WHERE id = 997;
UPDATE regions SET name = 'Upper Normandy' WHERE id = 996;
UPDATE regions SET name = 'Midi-Pyrenees' WHERE id = 1006;
UPDATE regions SET name = 'Provence-Alpes-Cote d''Azur' WHERE id = 1001;
UPDATE regions SET name = 'Rhone-Alpes' WHERE id = 1000;
UPDATE regions SET name = 'Haut-Ogooue' WHERE id = 1028;
UPDATE regions SET name = 'Moyen-Ogooue' WHERE id = 1027;
UPDATE regions SET name = 'Ngounie' WHERE id = 1021;
UPDATE regions SET name = 'Ogooue-Ivindo' WHERE id = 1022;
UPDATE regions SET name = 'Ogooue-Lolo' WHERE id = 1023;
UPDATE regions SET name = 'Ogooue-Maritime' WHERE id = 1025;
UPDATE regions SET name = 'Autonomous Republic of Abkhazia' WHERE id = 1045;
UPDATE regions SET name = 'Autonomous Republic of Adjara' WHERE id = 1044;
UPDATE regions SET name = 'Racha-Lechkhumi' WHERE id = 1038;
UPDATE regions SET name = 'Baden-Wurttemberg' WHERE id = 765;
UPDATE regions SET name = 'Bavaria' WHERE id = 766;
UPDATE regions SET name = 'Hesse' WHERE id = 767;
UPDATE regions SET name = 'Mecklenburg-Western Pomerania' WHERE id = 760;
UPDATE regions SET name = 'Lower Saxony' WHERE id = 759;
UPDATE regions SET name = 'North Rhine-Westphalia' WHERE id = 758;
UPDATE regions SET name = 'Rhineland-Palatinate' WHERE id = 757;
UPDATE regions SET name = 'Saxony' WHERE id = 755;
UPDATE regions SET name = 'Thuringia' WHERE id = 768;
UPDATE regions SET name = 'Brong-Ahafo' WHERE id = 1047;
UPDATE regions SET name = 'Peten' WHERE id = 1125;
UPDATE regions SET name = 'Quiche' WHERE id = 1127;
UPDATE regions SET name = 'Sacatepequez' WHERE id = 1129;
UPDATE regions SET name = 'Solola' WHERE id = 1132;
UPDATE regions SET name = 'Suchitepequez' WHERE id = 1133;
UPDATE regions SET name = 'Totonicapan' WHERE id = 1134;
UPDATE regions SET name = 'Bafata' WHERE id = 1074;
UPDATE regions SET name = 'Gabu' WHERE id = 1079;
UPDATE regions SET name = 'Artibonite' WHERE id = 1226;
UPDATE regions SET name = 'Abricots' WHERE id = 3409;
UPDATE regions SET name = 'Acul du Nord' WHERE id = 3410;
UPDATE regions SET name = 'Anglais' WHERE id = 3484;
UPDATE regions SET name = 'Anse d''Hainault' WHERE id = 3411;
UPDATE regions SET name = 'Anse Rouge' WHERE id = 3412;
UPDATE regions SET name = 'Anse A Foleur' WHERE id = 3413;
UPDATE regions SET name = 'Anse A Galet' WHERE id = 3414;
UPDATE regions SET name = 'Anse A Pitre' WHERE id = 3415;
UPDATE regions SET name = 'Anse A Veau' WHERE id = 3416;
UPDATE regions SET name = 'Aquin' WHERE id = 3417;
UPDATE regions SET name = 'Arcahaie' WHERE id = 3418;
UPDATE regions SET name = 'Arnaud' WHERE id = 3546;
UPDATE regions SET name = 'Arniquet' WHERE id = 3419;
UPDATE regions SET name = 'Asile' WHERE id = 3482;
UPDATE regions SET name = 'Bahon' WHERE id = 3420;
UPDATE regions SET name = 'Baie de Henne' WHERE id = 3421;
UPDATE regions SET name = 'Bainet' WHERE id = 3422;
UPDATE regions SET name = 'Baraderes' WHERE id = 3423;
UPDATE regions SET name = 'Bas Limbe' WHERE id = 3424;
UPDATE regions SET name = 'Bassin Bleu' WHERE id = 3425;
UPDATE regions SET name = 'Beaumont' WHERE id = 3426;
UPDATE regions SET name = 'Belladere' WHERE id = 3427;
UPDATE regions SET name = 'Belle Anse' WHERE id = 3428;
UPDATE regions SET name = 'Bombardopolis' WHERE id = 3429;
UPDATE regions SET name = 'Bonbon' WHERE id = 3430;
UPDATE regions SET name = 'Borgne' WHERE id = 3431;
UPDATE regions SET name = 'Boucan Carre' WHERE id = 3432;
UPDATE regions SET name = 'Coteaux' WHERE id = 3450;
UPDATE regions SET name = 'Cotes de Fer' WHERE id = 3451;
UPDATE regions SET name = 'Cabaret' WHERE id = 3433;
UPDATE regions SET name = 'Camp Perrin' WHERE id = 3434;
UPDATE regions SET name = 'Cap Haitien' WHERE id = 3435;
UPDATE regions SET name = 'Capotille' WHERE id = 3436;
UPDATE regions SET name = 'Caracol' WHERE id = 3437;
UPDATE regions SET name = 'Carice' WHERE id = 3438;
UPDATE regions SET name = 'Carrefour' WHERE id = 3439;
UPDATE regions SET name = 'Cavaillon' WHERE id = 3440;
UPDATE regions SET name = 'Cayes' WHERE id = 3485;
UPDATE regions SET name = 'Cayes Jacmel' WHERE id = 3441;
UPDATE regions SET name = 'Cerca La Source' WHERE id = 3442;
UPDATE regions SET name = 'Cerca Carvajal' WHERE id = 3443;
UPDATE regions SET name = 'Chambellan' WHERE id = 3444;
UPDATE regions SET name = 'Chamsolme' WHERE id = 3545;
UPDATE regions SET name = 'Chantal' WHERE id = 3445;
UPDATE regions SET name = 'Chardonnieres' WHERE id = 3446;
UPDATE regions SET name = 'Cite Soleil' WHERE id = 3447;
UPDATE regions SET name = 'Corail' WHERE id = 3448;
UPDATE regions SET name = 'Cornillon' WHERE id = 3449;
UPDATE regions SET name = 'Croix-Des-Bouquets' WHERE id = 3452;
UPDATE regions SET name = 'Dame Marie' WHERE id = 3453;
UPDATE regions SET name = 'Delmas' WHERE id = 3454;
UPDATE regions SET name = 'Desdunes' WHERE id = 3455;
UPDATE regions SET name = 'Dessalines' WHERE id = 3456;
UPDATE regions SET name = 'Dondon' WHERE id = 3457;
UPDATE regions SET name = 'Ennery' WHERE id = 3458;
UPDATE regions SET name = 'Estere' WHERE id = 3459;
UPDATE regions SET name = 'Ferrier' WHERE id = 3547;
UPDATE regions SET name = 'Fonds Des Negres' WHERE id = 3460;
UPDATE regions SET name = 'Fonds Verrettes' WHERE id = 3461;
UPDATE regions SET name = 'Fort Liberte' WHERE id = 3462;
UPDATE regions SET name = 'Ganthier' WHERE id = 3463;
UPDATE regions SET name = 'Gonaives' WHERE id = 3464;
UPDATE regions SET name = 'Grande Riviere Du Nord' WHERE id = 3466;
UPDATE regions SET name = 'Grand Boucan' WHERE id = 3548;
UPDATE regions SET name = 'Grande Saline' WHERE id = 3465;
UPDATE regions SET name = 'Grand-Goave' WHERE id = 3467;
UPDATE regions SET name = 'Grand Gosier' WHERE id = 3468;
UPDATE regions SET name = 'Gressier' WHERE id = 3469;
UPDATE regions SET name = 'Gros Morne' WHERE id = 3470;
UPDATE regions SET name = 'Hinche' WHERE id = 3471;
UPDATE regions SET name = 'Ile A Vache' WHERE id = 3472;
UPDATE regions SET name = 'Irois' WHERE id = 3486;
UPDATE regions SET name = 'Jeremie' WHERE id = 3475;
UPDATE regions SET name = 'Jacmel' WHERE id = 3473;
UPDATE regions SET name = 'Jean Rabel' WHERE id = 3474;
UPDATE regions SET name = 'Kenscoff' WHERE id = 3476;
UPDATE regions SET name = 'La Chapelle' WHERE id = 3477;
UPDATE regions SET name = 'La Tortue' WHERE id = 3478;
UPDATE regions SET name = 'La Vallee' WHERE id = 3479;
UPDATE regions SET name = 'La Victoire' WHERE id = 3480;
UPDATE regions SET name = 'Leogane' WHERE id = 3483;
UPDATE regions SET name = 'Lascahobas' WHERE id = 3481;
UPDATE regions SET name = 'Limbe' WHERE id = 3487;
UPDATE regions SET name = 'Limonade' WHERE id = 3488;
UPDATE regions SET name = 'Mole Saint Nicolas' WHERE id = 3496;
UPDATE regions SET name = 'Maissade' WHERE id = 3489;
UPDATE regions SET name = 'Maniche' WHERE id = 3490;
UPDATE regions SET name = 'Marigot' WHERE id = 3491;
UPDATE regions SET name = 'Marmelade' WHERE id = 3492;
UPDATE regions SET name = 'Milot' WHERE id = 3493;
UPDATE regions SET name = 'Miragoane' WHERE id = 3494;
UPDATE regions SET name = 'Mirebalais' WHERE id = 3495;
UPDATE regions SET name = 'Mombin Crochu' WHERE id = 3497;
UPDATE regions SET name = 'Mont Organise' WHERE id = 3498;
UPDATE regions SET name = 'Moron' WHERE id = 3499;
UPDATE regions SET name = 'Ouanaminthe' WHERE id = 3500;
UPDATE regions SET name = 'Petion-Ville' WHERE id = 3503;
UPDATE regions SET name = 'Paillant' WHERE id = 3549;
UPDATE regions SET name = 'Perches' WHERE id = 3501;
UPDATE regions SET name = 'Pestel' WHERE id = 3502;
UPDATE regions SET name = 'Petit Trou De Nippes' WHERE id = 3504;
UPDATE regions SET name = 'Petite Riviere de l''Artibonite' WHERE id = 3505;
UPDATE regions SET name = 'Petite Riviere de Nippes' WHERE id = 3506;
UPDATE regions SET name = 'Petit Goave' WHERE id = 3507;
UPDATE regions SET name = 'Pignon' WHERE id = 3508;
UPDATE regions SET name = 'Pilate' WHERE id = 3509;
UPDATE regions SET name = 'Plaine du Nord' WHERE id = 3510;
UPDATE regions SET name = 'Plaisance' WHERE id = 3511;
UPDATE regions SET name = 'Plaisance du Sud' WHERE id = 3878;
UPDATE regions SET name = 'Pointe A Raquette' WHERE id = 3512;
UPDATE regions SET name = 'Port-a-Piment' WHERE id = 3513;
UPDATE regions SET name = 'Port-au-Prince' WHERE id = 3514;
UPDATE regions SET name = 'Port De Paix' WHERE id = 3515;
UPDATE regions SET name = 'Port Margot' WHERE id = 3516;
UPDATE regions SET name = 'Port-Salut' WHERE id = 3517;
UPDATE regions SET name = 'Quartier Morin' WHERE id = 3518;
UPDATE regions SET name = 'Ranquitte' WHERE id = 3519;
UPDATE regions SET name = 'Roche-A-Bateau' WHERE id = 3520;
UPDATE regions SET name = 'Roseaux' WHERE id = 3521;
UPDATE regions SET name = 'Saint-Michel de l''Attal' WHERE id = 3522;
UPDATE regions SET name = 'Sainte Suzanne' WHERE id = 3523;
UPDATE regions SET name = 'St. Jean du Sud' WHERE id = 3524;
UPDATE regions SET name = 'Saint Louis du Nord' WHERE id = 3525;
UPDATE regions SET name = 'St. Louis du Sud' WHERE id = 3526;
UPDATE regions SET name = 'Saint-Marc' WHERE id = 3527;
UPDATE regions SET name = 'St. Raphael' WHERE id = 3528;
UPDATE regions SET name = 'Saut d''Eau' WHERE id = 3529;
UPDATE regions SET name = 'Savanette' WHERE id = 3530;
UPDATE regions SET name = 'Tabarre' WHERE id = 3531;
UPDATE regions SET name = 'Terre Neuve' WHERE id = 3532;
UPDATE regions SET name = 'Terrier Rouge' WHERE id = 3533;
UPDATE regions SET name = 'Thiotte' WHERE id = 3534;
UPDATE regions SET name = 'Thomassique' WHERE id = 3535;
UPDATE regions SET name = 'Thomazeau' WHERE id = 3536;
UPDATE regions SET name = 'Thomonde' WHERE id = 3537;
UPDATE regions SET name = 'Tiburon' WHERE id = 3538;
UPDATE regions SET name = 'Torbeck' WHERE id = 3539;
UPDATE regions SET name = 'Trou du Nord' WHERE id = 3540;
UPDATE regions SET name = 'Valliere' WHERE id = 3541;
UPDATE regions SET name = 'Verrettes' WHERE id = 3542;
UPDATE regions SET name = 'Atlantida' WHERE id = 1185;
UPDATE regions SET name = 'Colon' WHERE id = 1187;
UPDATE regions SET name = 'Copan' WHERE id = 1189;
UPDATE regions SET name = 'El Paraiso' WHERE id = 1191;
UPDATE regions SET name = 'Francisco Morazan' WHERE id = 1192;
UPDATE regions SET name = 'Intibuca' WHERE id = 1194;
UPDATE regions SET name = 'Islas de la Bahia' WHERE id = 1195;
UPDATE regions SET name = 'Santa Barbara' WHERE id = 1200;
UPDATE regions SET name = 'Bacs-kiskun' WHERE id = 1236;
UPDATE regions SET name = 'Bekes' WHERE id = 1238;
UPDATE regions SET name = 'Borsod-abauj-zemplen' WHERE id = 1239;
UPDATE regions SET name = 'Csongrad' WHERE id = 1240;
UPDATE regions SET name = 'Fejer' WHERE id = 1241;
UPDATE regions SET name = 'Hajdu-bihar' WHERE id = 1243;
UPDATE regions SET name = 'Jasz-nagykun-szolnok' WHERE id = 1245;
UPDATE regions SET name = 'Komarom-esztergom' WHERE id = 1246;
UPDATE regions SET name = 'Nograd' WHERE id = 1247;
UPDATE regions SET name = 'Szabolcs-szatmar-bereg' WHERE id = 1250;
UPDATE regions SET name = 'Veszprem' WHERE id = 1234;
UPDATE regions SET name = 'East' WHERE id = 1400;
UPDATE regions SET name = 'Capital region' WHERE id = 1402;
UPDATE regions SET name = 'Northeast' WHERE id = 1397;
UPDATE regions SET name = 'Northwest' WHERE id = 1396;
UPDATE regions SET name = 'South' WHERE id = 1403;
UPDATE regions SET name = 'Southwest' WHERE id = 1398;
UPDATE regions SET name = 'Westfjords' WHERE id = 1399;
UPDATE regions SET name = 'West' WHERE id = 1401;
UPDATE regions SET name = 'Bangka Belitung Islands' WHERE id = 1279;
UPDATE regions SET the_geom = ST_GeomFromtext('POINT(106.116667 -2.133333)',4326),
            center_lat=-2.133333,
            center_lon=106.116667
             WHERE id = 1279;
UPDATE regions SET name = 'West Papua' WHERE id = 1283;
UPDATE regions SET name = 'West Java' WHERE id = 1286;
UPDATE regions SET name = 'Central Java' WHERE id = 1254;
UPDATE regions SET name = 'East Java' WHERE id = 1272;
UPDATE regions SET name = 'West Kalimantan' WHERE id = 1271;
UPDATE regions SET name = 'South Kalimantan' WHERE id = 1276;
UPDATE regions SET name = 'Central Kalimantan' WHERE id = 1274;
UPDATE regions SET name = 'East Kalimantan' WHERE id = 1273;
UPDATE regions SET name = 'Riau Islands' WHERE id = 1269;
UPDATE regions SET name = 'North Maluku' WHERE id = 1261;
UPDATE regions SET name = 'West Nusa Tenggara' WHERE id = 1260;
UPDATE regions SET name = 'East Nusa Tenggara' WHERE id = 1264;
UPDATE regions SET the_geom = ST_GeomFromtext('POINT(123.583333 -10.183333)',4326),
            center_lat=-10.183333,
            center_lon=123.583333
             WHERE id = 1264;
UPDATE regions SET name = 'West Sulawesi' WHERE id = 1270;
UPDATE regions SET name = 'South Sulawesi' WHERE id = 1275;
UPDATE regions SET name = 'Central Sulawesi' WHERE id = 1263;
UPDATE regions SET the_geom = ST_GeomFromtext('POINT(121.0 -1.0)',4326),
            center_lat=-1.0,
            center_lon=121.0
             WHERE id = 1263;
UPDATE regions SET name = 'Southeast Sulawesi' WHERE id = 1262;
UPDATE regions SET name = 'North Sulawesi' WHERE id = 1259;
UPDATE regions SET the_geom = ST_GeomFromtext('POINT(124.833333 1.25)',4326),
            center_lat=1.25,
            center_lon=124.833333
             WHERE id = 1259;
UPDATE regions SET name = 'West Sumatra' WHERE id = 1258;
UPDATE regions SET name = 'South Sumatra' WHERE id = 1257;
UPDATE regions SET name = 'North Sumatra' WHERE id = 1256;
UPDATE regions SET name = 'Al Anbar' WHERE id = 1379;
UPDATE regions SET name = 'Al Basrah' WHERE id = 1380;
UPDATE regions SET name = 'Al Muthanna' WHERE id = 1381;
UPDATE regions SET name = 'Al Qadisiyah' WHERE id = 1382;
UPDATE regions SET name = 'An Najaf' WHERE id = 1383;
UPDATE regions SET name = 'As Sulaymaniyah' WHERE id = 1386;
UPDATE regions SET name = 'Kirkuk' WHERE id = 1384;
UPDATE regions SET name = 'Dhi Qar' WHERE id = 1391;
UPDATE regions SET name = 'Dahuk' WHERE id = 1392;
UPDATE regions SET name = 'Salah ad Din' WHERE id = 1378;
UPDATE regions SET name = 'Southern' WHERE id = 1410;
UPDATE regions SET name = 'Central' WHERE id = 1406;
UPDATE regions SET name = 'Northern' WHERE id = 1407;
UPDATE regions SET name = 'Sicilia' WHERE id = 1413;
UPDATE regions SET name = '''Amman' WHERE id = 1455;
UPDATE regions SET name = 'Al ''Aqabah' WHERE id = 1454;
UPDATE regions SET name = 'Al Balqa''' WHERE id = 1446;
UPDATE regions SET name = 'Al Karak' WHERE id = 1451;
UPDATE regions SET name = 'Al Mafraq' WHERE id = 1448;
UPDATE regions SET name = 'At Tafilah' WHERE id = 1447;
UPDATE regions SET name = 'Az Zarqa''' WHERE id = 1445;
UPDATE regions SET name = 'Aqtobe' WHERE id = 1514;
UPDATE regions SET name = 'Nairobi Area' WHERE id = 1528;
UPDATE regions SET name = 'Chagang' WHERE id = 2406;
UPDATE regions SET name = 'North Hamgyong' WHERE id = 2408;
UPDATE regions SET name = 'South Hamgyong' WHERE id = 2409;
UPDATE regions SET name = 'North Hwanghae' WHERE id = 2410;
UPDATE regions SET name = 'South Hwanghae' WHERE id = 2411;
UPDATE regions SET name = 'Kangwon' WHERE id = 2413;
UPDATE regions SET name = 'North P''yongan' WHERE id = 2404;
UPDATE regions SET name = 'South P''yongan' WHERE id = 2403;
UPDATE regions SET name = 'Pyongyang' WHERE id = 2414;
UPDATE regions SET name = 'Chungbuk' WHERE id = 1587;
UPDATE regions SET name = 'Chungnam' WHERE id = 1586;
UPDATE regions SET name = 'Gangwon' WHERE id = 1592;
UPDATE regions SET name = 'Gyeonggi' WHERE id = 1593;
UPDATE regions SET name = 'Gyeongbuk' WHERE id = 1579;
UPDATE regions SET name = 'Gyeongnam' WHERE id = 1580;
UPDATE regions SET name = 'Jeonbuk' WHERE id = 1589;
UPDATE regions SET name = 'Jeonnam' WHERE id = 1585;
UPDATE regions SET name = 'Al Jahra''' WHERE id = 1596;
UPDATE regions SET name = 'Al ''Asimah' WHERE id = 1594;
UPDATE regions SET name = 'Ysyk-Kol' WHERE id = 1534;
UPDATE regions SET name = 'Attapu' WHERE id = 1606;
UPDATE regions SET name = 'Louangnamtha' WHERE id = 1611;
UPDATE regions SET name = 'Oudomxai' WHERE id = 1610;
UPDATE regions SET name = 'Phongsali' WHERE id = 1609;
UPDATE regions SET name = 'Savannakhet' WHERE id = 1607;
UPDATE regions SET name = 'Viangchan' WHERE id = 3673;
UPDATE regions SET name = 'Beirut' WHERE id = 1620;
UPDATE regions SET name = 'Beqaa' WHERE id = 1619;
UPDATE regions SET name = 'Liban-Nord' WHERE id = 3677;
UPDATE regions SET name = 'Liban-Sud' WHERE id = 3678;
UPDATE regions SET name = 'Mont-Liban' WHERE id = 3679;
UPDATE regions SET name = 'Nabatiye' WHERE id = 3680;
UPDATE regions SET name = 'Al Jafarah' WHERE id = 1660;
UPDATE regions SET name = 'Al Wahat' WHERE id = 1644;
UPDATE regions SET name = 'Wadi ash Shati' WHERE id = 1641;
UPDATE regions SET name = 'Banghazi' WHERE id = 1650;
UPDATE regions SET name = 'Sabha' WHERE id = 1663;
UPDATE regions SET name = 'Vaduz' WHERE id = 1690;
UPDATE regions SET name = 'Siauliu' WHERE id = 1731;
UPDATE regions SET name = 'Telsiu' WHERE id = 3695;
UPDATE regions SET name = 'Central Region' WHERE id = 3709;
UPDATE regions SET name = 'Northern Region' WHERE id = 3710;
UPDATE regions SET name = 'Southern Region' WHERE id = 3711;
UPDATE regions SET name = 'Segou' WHERE id = 1850;
UPDATE regions SET name = 'Tombouctou' WHERE id = 1852;
UPDATE regions SET name = 'Riviere du Rempart' WHERE id = 1951;
UPDATE regions SET name = 'Rodrigues' WHERE id = 1945;
UPDATE regions SET name = 'Coahuila de Zaragoza' WHERE id = 1820;
UPDATE regions SET name = 'Mexico' WHERE id = 1828;
UPDATE regions SET name = 'Michoacan de Ocampo' WHERE id = 1829;
UPDATE regions SET name = 'Nuevo Leon' WHERE id = 1811;
UPDATE regions SET name = 'Queretaro de Arteaga' WHERE id = 1808;
UPDATE regions SET name = 'San Luis Potosi' WHERE id = 1806;
UPDATE regions SET name = 'Veracruz-Llave' WHERE id = 1832;
UPDATE regions SET name = 'Yucatan' WHERE id = 1831;
UPDATE regions SET name = 'Omnogovi' WHERE id = 1905;
UPDATE regions SET name = 'Ovorhangay' WHERE id = 1906;
UPDATE regions SET name = 'Bayan-Olgiy' WHERE id = 1894;
UPDATE regions SET name = 'Govisumber' WHERE id = 1901;
UPDATE regions SET name = 'Hovsgol' WHERE id = 1904;
UPDATE regions SET name = 'Suhbaatar' WHERE id = 1908;
UPDATE regions SET name = 'Tov' WHERE id = 1909;
UPDATE regions SET name = 'Savnik' WHERE id = 3702;
UPDATE regions SET name = 'Zabljak' WHERE id = 1869;
UPDATE regions SET name = 'Kolasin' WHERE id = 3698;
UPDATE regions SET name = 'Niksic' WHERE id = 1878;
UPDATE regions SET name = 'Pluzine' WHERE id = 3700;
UPDATE regions SET name = 'Rozaje' WHERE id = 3701;
UPDATE regions SET name = 'Fes-Boulemane' WHERE id = 1753;
UPDATE regions SET name = 'Gharb-Chrarda-Beni Hssen' WHERE id = 1746;
UPDATE regions SET name = 'Guelmim-Es Smara' WHERE id = 1755;
UPDATE regions SET name = 'Laayoune-Boujdour-Sakia El Hamra' WHERE id = 1756;
UPDATE regions SET name = 'Meknes-Tafilalet' WHERE id = 1749;
UPDATE regions SET name = 'Rabat-Sale-Zemmour-Zaer' WHERE id = 1757;
UPDATE regions SET name = 'Souss-Massa-Draa' WHERE id = 1758;
UPDATE regions SET name = 'Tanger-Tetouan' WHERE id = 1751;
UPDATE regions SET name = 'Okavango' WHERE id = 1992;
UPDATE regions SET name = 'Eastern' WHERE id = 2107;
UPDATE regions SET name = 'Esteli' WHERE id = 2060;
UPDATE regions SET name = 'Leon' WHERE id = 2063;
UPDATE regions SET name = 'Rio San Juan' WHERE id = 2070;
UPDATE regions SET name = 'Tillaberi' WHERE id = 3712;
UPDATE regions SET name = 'More og Romsdal' WHERE id = 2104;
UPDATE regions SET name = 'Nord-Trondelag' WHERE id = 2088;
UPDATE regions SET name = 'Sor-Trondelag' WHERE id = 2090;
UPDATE regions SET name = 'Al Batinah' WHERE id = 2144;
UPDATE regions SET name = 'Az Zahirah' WHERE id = 2142;
UPDATE regions SET name = 'Balochistan' WHERE id = 2154;
UPDATE regions SET name = 'Khyber Pakhtunkhwa (formerly North-West Frontier Province)' WHERE id = 2152;
UPDATE regions SET name = 'Sindh' WHERE id = 2149;
UPDATE regions SET name = 'Bocas del Toro' WHERE id = 2157;
UPDATE regions SET name = 'Chiriqui' WHERE id = 2168;
UPDATE regions SET name = 'Cocle' WHERE id = 2167;
UPDATE regions SET name = 'Colon' WHERE id = 2166;
UPDATE regions SET name = 'Darien' WHERE id = 2165;
UPDATE regions SET name = 'Embera-Wounaan' WHERE id = 2164;
UPDATE regions SET name = 'Ngobe-Bugle' WHERE id = 2160;
UPDATE regions SET name = 'Panama' WHERE id = 2159;
UPDATE regions SET name = 'Bougainville' WHERE id = 2301;
UPDATE regions SET name = 'Alto Parana' WHERE id = 2439;
UPDATE regions SET name = 'Asuncion' WHERE id = 2454;
UPDATE regions SET name = 'Boqueron' WHERE id = 2437;
UPDATE regions SET name = 'Caaguazu' WHERE id = 2453;
UPDATE regions SET name = 'Caazapa' WHERE id = 2452;
UPDATE regions SET name = 'Canindeyu' WHERE id = 2451;
UPDATE regions SET name = 'Concepcion' WHERE id = 2449;
UPDATE regions SET name = 'Guaira' WHERE id = 2447;
UPDATE regions SET name = 'Itapua' WHERE id = 2446;
UPDATE regions SET name = 'Neembucu' WHERE id = 3721;
UPDATE regions SET name = 'Paraguari' WHERE id = 2443;
UPDATE regions SET name = 'Apurimac' WHERE id = 2191;
UPDATE regions SET name = 'Huanuco' WHERE id = 2184;
UPDATE regions SET name = 'Junin' WHERE id = 2182;
UPDATE regions SET name = 'San Martin' WHERE id = 2175;
UPDATE regions SET name = 'Kuyavia-Pomerania' WHERE id = 2309;
UPDATE regions SET name = 'Lodzkie' WHERE id = 2323;
UPDATE regions SET name = 'Lower Silesia' WHERE id = 2322;
UPDATE regions SET name = 'Masovia' WHERE id = 2319;
UPDATE regions SET name = 'Opolskie' WHERE id = 2318;
UPDATE regions SET name = 'Podlaskie' WHERE id = 2316;
UPDATE regions SET name = 'Pomerania' WHERE id = 2315;
UPDATE regions SET name = 'Silesia' WHERE id = 2314;
UPDATE regions SET name = 'Subcarpathia' WHERE id = 2313;
UPDATE regions SET name = 'Warmia-Masuria' WHERE id = 2311;
UPDATE regions SET name = 'West Pomerania' WHERE id = 2310;
UPDATE regions SET name = 'Evora' WHERE id = 2429;
UPDATE regions SET name = 'Braganca' WHERE id = 2421;
UPDATE regions SET name = 'Lisbon' WHERE id = 2434;
UPDATE regions SET name = 'Santarem' WHERE id = 2417;
UPDATE regions SET name = 'Setubal' WHERE id = 2428;
UPDATE regions SET name = 'Hincesti' WHERE id = 1795;
UPDATE regions SET name = 'Riscani' WHERE id = 1776;
UPDATE regions SET name = 'Singerei' WHERE id = 1777;
UPDATE regions SET name = 'Stefan-Voda' WHERE id = 1780;
UPDATE regions SET name = 'Dimbovita' WHERE id = 3730;
UPDATE regions SET name = 'Vilcea' WHERE id = 3738;
UPDATE regions SET name = 'Republic of Adygea (Adygea)' WHERE id = 2536;
UPDATE regions SET name = 'Altai Republic' WHERE id = 2538;
UPDATE regions SET name = 'Amur Region' WHERE id = 2528;
UPDATE regions SET name = 'Arkhangelsk Region' WHERE id = 2529;
UPDATE regions SET name = 'Astrakhan region' WHERE id = 2530;
UPDATE regions SET name = 'Republic of Bashkortostan' WHERE id = 2531;
UPDATE regions SET name = 'Belgorod Region' WHERE id = 2532;
UPDATE regions SET name = 'Bryansk Region' WHERE id = 2533;
UPDATE regions SET name = 'The Republic of Buryatia' WHERE id = 2534;
UPDATE regions SET name = 'Chechen Republic' WHERE id = 2539;
UPDATE regions SET name = 'Chelyabinsk Region' WHERE id = 2540;
UPDATE regions SET name = 'Chukotka Autonomous District' WHERE id = 2542;
UPDATE regions SET name = 'Chuvash Republic - Chuvashia' WHERE id = 2544;
UPDATE regions SET name = 'Saint Petersburg' WHERE id = 2545;
UPDATE regions SET name = 'Dagestan Republic' WHERE id = 2546;
UPDATE regions SET name = 'Republic of Ingushetia' WHERE id = 2549;
UPDATE regions SET name = 'Irkutsk Region' WHERE id = 2550;
UPDATE regions SET name = 'Ivanovo region' WHERE id = 2551;
UPDATE regions SET name = 'Kabardino-Balkar Republic' WHERE id = 2552;
UPDATE regions SET name = 'Kaliningrad region' WHERE id = 2535;
UPDATE regions SET name = 'Republic of Kalmykia' WHERE id = 2553;
UPDATE regions SET name = 'Kaluga region' WHERE id = 2555;
UPDATE regions SET name = 'Kamchatka' WHERE id = 2556;
UPDATE regions SET name = 'Karachay-Cherkessia' WHERE id = 2524;
UPDATE regions SET name = 'Republic of Karelia' WHERE id = 2523;
UPDATE regions SET name = 'Kemerovo Region' WHERE id = 2522;
UPDATE regions SET name = 'Khabarovsk Territory' WHERE id = 2521;
UPDATE regions SET name = 'The Republic of Khakassia' WHERE id = 2520;
UPDATE regions SET name = 'Khanty-Mansiysk Autonomous Okrug - Ugra' WHERE id = 2519;
UPDATE regions SET name = 'Kirov region' WHERE id = 2557;
UPDATE regions SET name = 'Komi Republic' WHERE id = 2558;
UPDATE regions SET name = 'Kostroma region' WHERE id = 2561;
UPDATE regions SET name = 'Krasnodar Territory' WHERE id = 2562;
UPDATE regions SET name = 'Krasnoyarsk Territory' WHERE id = 2563;
UPDATE regions SET name = 'Kurgan region' WHERE id = 2564;
UPDATE regions SET name = 'Kursk Region' WHERE id = 2565;
UPDATE regions SET name = 'Leningrad Region' WHERE id = 2566;
UPDATE regions SET name = 'Lipetsk region' WHERE id = 2567;
UPDATE regions SET name = 'The Republic of Mari El' WHERE id = 2569;
UPDATE regions SET name = 'Republic of Mordovia' WHERE id = 2570;
UPDATE regions SET name = 'Moscow' WHERE id = 2571;
UPDATE regions SET name = 'Murmansk region' WHERE id = 2572;
UPDATE regions SET name = 'Nenets Autonomous District' WHERE id = 2573;
UPDATE regions SET name = 'Nizhny Novgorod region' WHERE id = 2574;
UPDATE regions SET name = 'Republic of North Ossetia - Alania' WHERE id = 2575;
UPDATE regions SET name = 'Novgorod Region' WHERE id = 2577;
UPDATE regions SET name = 'Novosibirsk Region' WHERE id = 2578;
UPDATE regions SET name = 'Omsk Region' WHERE id = 2579;
UPDATE regions SET name = 'Orel' WHERE id = 2580;
UPDATE regions SET name = 'Orenburg region' WHERE id = 2581;
UPDATE regions SET name = 'Penza Region' WHERE id = 2587;
UPDATE regions SET name = 'Perm' WHERE id = 2598;
UPDATE regions SET name = 'Primorsky Krai' WHERE id = 2512;
UPDATE regions SET name = 'Pskov Region' WHERE id = 2513;
UPDATE regions SET name = 'Rostov Region' WHERE id = 2514;
UPDATE regions SET name = 'Ryazan Region' WHERE id = 2515;
UPDATE regions SET name = 'The Republic of Sakha (Yakutia)' WHERE id = 2516;
UPDATE regions SET name = 'Sakhalin Region' WHERE id = 2517;
UPDATE regions SET name = 'Samara Region' WHERE id = 2511;
UPDATE regions SET name = 'Saratov Region' WHERE id = 2597;
UPDATE regions SET name = 'Smolensk region' WHERE id = 2596;
UPDATE regions SET name = 'Stavropol Territory' WHERE id = 2595;
UPDATE regions SET name = 'Sverdlovsk Region' WHERE id = 2594;
UPDATE regions SET name = 'Tambov region' WHERE id = 2593;
UPDATE regions SET name = 'The Republic of Tatarstan (Tatarstan)' WHERE id = 2592;
UPDATE regions SET name = 'Tomsk Region' WHERE id = 2586;
UPDATE regions SET name = 'Tula Region' WHERE id = 2582;
UPDATE regions SET name = 'The Republic of Tuva' WHERE id = 2583;
UPDATE regions SET name = 'Tver region' WHERE id = 2584;
UPDATE regions SET name = 'Tyumen Region' WHERE id = 2585;
UPDATE regions SET name = 'Udmurt Republic' WHERE id = 2576;
UPDATE regions SET name = 'Ulyanovsk region' WHERE id = 2554;
UPDATE regions SET name = 'Vladimir Region' WHERE id = 2527;
UPDATE regions SET name = 'Volgograd Region' WHERE id = 2526;
UPDATE regions SET name = 'Vologda Region' WHERE id = 2588;
UPDATE regions SET name = 'Voronezh Region' WHERE id = 2589;
UPDATE regions SET name = 'Yamalo-Nenets Autonomous District' WHERE id = 2590;
UPDATE regions SET name = 'Yaroslavl Region' WHERE id = 2525;
UPDATE regions SET name = 'Jewish Autonomous Region' WHERE id = 2518;
UPDATE regions SET name = 'Anse La Raye' WHERE id = 1679;
UPDATE regions SET name = 'Soufriere' WHERE id = 1674;
UPDATE regions SET name = 'Principe' WHERE id = 2728;
UPDATE regions SET name = 'Sao Tome' WHERE id = 2727;
UPDATE regions SET name = '''Asir' WHERE id = 2619;
UPDATE regions SET name = 'Northern Border' WHERE id = 2618;
UPDATE regions SET name = 'Medina' WHERE id = 2616;
UPDATE regions SET name = 'Al Qasim' WHERE id = 2615;
UPDATE regions SET name = 'Riyadh' WHERE id = 2614;
UPDATE regions SET name = 'Eastern' WHERE id = 2613;
UPDATE regions SET name = 'Mecca' WHERE id = 2611;
UPDATE regions SET name = 'Kedougou' WHERE id = 3763;
UPDATE regions SET name = 'Sedhiou' WHERE id = 3764;
UPDATE regions SET name = 'Zilinsky' WHERE id = 2740;
UPDATE regions SET name = 'Banskobystricky' WHERE id = 2746;
UPDATE regions SET name = 'Bratislavsky' WHERE id = 2745;
UPDATE regions SET name = 'Kosicky' WHERE id = 2744;
UPDATE regions SET name = 'Presovsky' WHERE id = 2739;
UPDATE regions SET name = 'Trnavsky' WHERE id = 2741;
UPDATE regions SET name = 'Middle Jubba' WHERE id = 2690;
UPDATE regions SET name = 'Lower Jubba' WHERE id = 2691;
UPDATE regions SET name = 'Middle Shabeelle' WHERE id = 2695;
UPDATE regions SET name = 'Lower Shabeelle' WHERE id = 2696;
UPDATE regions SET name = 'Andalucia' WHERE id = 942;
UPDATE regions SET name = 'Aragon' WHERE id = 943;
UPDATE regions SET name = 'Castilla y Leon' WHERE id = 940;
UPDATE regions SET name = 'Catalonia' WHERE id = 938;
UPDATE regions SET name = 'Madrid' WHERE id = 945;
UPDATE regions SET name = 'Navarra' WHERE id = 946;
UPDATE regions SET name = 'Valencian Community' WHERE id = 947;
UPDATE regions SET name = 'Balearic Islands' WHERE id = 937;
UPDATE regions SET name = 'Canary Islands' WHERE id = 936;
UPDATE regions SET the_geom = ST_GeomFromtext('POINT(-15.622 27.978)',4326),
            center_lat=27.978,
            center_lon=-15.622
             WHERE id = 936;
UPDATE regions SET name = 'Basque Country' WHERE id = 952;
UPDATE regions SET name = 'Asturias' WHERE id = 951;
UPDATE regions SET name = 'Murcia' WHERE id = 950;
UPDATE regions SET name = 'Central' WHERE id = 3685;
UPDATE regions SET name = 'Eastern' WHERE id = 3686;
UPDATE regions SET name = 'North Central' WHERE id = 3687;
UPDATE regions SET name = 'North Western' WHERE id = 3688;
UPDATE regions SET name = 'Northern' WHERE id = 3689;
UPDATE regions SET name = 'Sabaragamuwa' WHERE id = 3690;
UPDATE regions SET name = 'Southern' WHERE id = 3691;
UPDATE regions SET name = 'Uva' WHERE id = 3692;
UPDATE regions SET name = 'Western' WHERE id = 3693;
UPDATE regions SET name = 'Sinnar' WHERE id = 3754;
UPDATE regions SET name = 'Warrap' WHERE id = 3758;
UPDATE regions SET name = 'Ostergotland' WHERE id = 2774;
UPDATE regions SET name = 'Gavleborg' WHERE id = 2772;
UPDATE regions SET name = 'Jamtland' WHERE id = 2770;
UPDATE regions SET name = 'Jonkoping' WHERE id = 2769;
UPDATE regions SET name = 'Sodermanland' WHERE id = 2768;
UPDATE regions SET name = 'Skane' WHERE id = 2760;
UPDATE regions SET name = 'Varmland' WHERE id = 2765;
UPDATE regions SET name = 'Vasterbotten' WHERE id = 2764;
UPDATE regions SET name = 'Vasternorrland' WHERE id = 2763;
UPDATE regions SET name = 'Vastmanland' WHERE id = 2762;
UPDATE regions SET name = 'Vastra Gotaland' WHERE id = 2761;
UPDATE regions SET name = 'Appenzell Ausser-Rhoden' WHERE id = 541;
UPDATE regions SET name = 'Appenzell Inner-Rhoden' WHERE id = 546;
UPDATE regions SET name = 'Geneve' WHERE id = 542;
UPDATE regions SET name = 'Graubunden' WHERE id = 537;
UPDATE regions SET name = 'Luzern' WHERE id = 532;
UPDATE regions SET name = 'Neuchatel' WHERE id = 534;
UPDATE regions SET name = 'Zurich' WHERE id = 547;
UPDATE regions SET name = 'Halab' WHERE id = 2784;
UPDATE regions SET name = 'Al Hasakah' WHERE id = 2790;
UPDATE regions SET name = 'Hims' WHERE id = 2789;
UPDATE regions SET name = 'Latakia' WHERE id = 2796;
UPDATE regions SET name = 'Al Qunaytirah' WHERE id = 2792;
UPDATE regions SET name = 'Gorno-Badakhshan Autonomous Oblast' WHERE id = 2900;
UPDATE regions SET name = 'Khatlon oblast' WHERE id = 2901;
UPDATE regions SET name = 'Sogd oblast' WHERE id = 2902;
UPDATE regions SET name = 'Region of Republican Subordination' WHERE id = 2899;
UPDATE regions SET name = 'Oecussi' WHERE id = 2920;
UPDATE regions SET name = 'Cova-Lima' WHERE id = 2921;
UPDATE regions SET name = 'Eua' WHERE id = 2925;
UPDATE regions SET name = 'Beja' WHERE id = 2945;
UPDATE regions SET name = 'Ben Arous' WHERE id = 2944;
UPDATE regions SET name = 'Gabes' WHERE id = 2962;
UPDATE regions SET name = 'Kasserine' WHERE id = 2964;
UPDATE regions SET name = 'Kef' WHERE id = 2960;
UPDATE regions SET name = 'Medenine' WHERE id = 2949;
UPDATE regions SET name = 'Manouba' WHERE id = 2948;
UPDATE regions SET name = 'Crimea or Avtonomna Respublika Krym' WHERE id = 3141;
UPDATE regions SET name = 'Kyiv' WHERE id = 3140;
UPDATE regions SET name = 'Kyiv City' WHERE id = 3161;
UPDATE regions SET name = 'Odesa' WHERE id = 3156;
UPDATE regions SET name = 'Zakarpattya' WHERE id = 3150;
UPDATE regions SET name = 'Volyn''' WHERE id = 3148;
UPDATE regions SET name = '''Ajman' WHERE id = 97;
UPDATE regions SET name = 'Dubai' WHERE id = 98;
UPDATE regions SET name = 'Al Fujayrah' WHERE id = 92;
UPDATE regions SET name = 'Ra''s al Khaymah' WHERE id = 94;
UPDATE regions SET name = 'Quwain' WHERE id = 95;
UPDATE regions SET name = 'Paysandu' WHERE id = 3189;
UPDATE regions SET name = 'Rio Negro' WHERE id = 3172;
UPDATE regions SET name = 'San Jose' WHERE id = 3173;
UPDATE regions SET name = 'Tacuarembo' WHERE id = 3175;
UPDATE regions SET name = 'Bukhara' WHERE id = 3251;
UPDATE regions SET name = 'Fergana' WHERE id = 3249;
UPDATE regions SET name = 'Navoiy' WHERE id = 3247;
UPDATE regions SET name = 'Sirdarya' WHERE id = 3245;
UPDATE regions SET name = 'Anzoategui' WHERE id = 3277;
UPDATE regions SET name = 'Bolivar' WHERE id = 3280;
UPDATE regions SET name = 'Federal Dependencies' WHERE id = 3265;
UPDATE regions SET the_geom = ST_GeomFromtext('POINT(-65.33 10.941)',4326),
            center_lat=10.941,
            center_lon=-65.33
             WHERE id = 3265;
UPDATE regions SET name = 'Capital District' WHERE id = 3266;
UPDATE regions SET name = 'Falcon' WHERE id = 3267;
UPDATE regions SET name = 'Guarico' WHERE id = 3268;
UPDATE regions SET name = 'Merida' WHERE id = 3282;
UPDATE regions SET name = 'Tachira' WHERE id = 3272;
UPDATE regions SET name = 'Ho Chi Minh City' WHERE id = 3841;
UPDATE regions SET name = 'Aden' WHERE id = 3329;
UPDATE regions SET name = 'Al-Baidha' WHERE id = 3325;
UPDATE regions SET name = 'Al-Dhalae' WHERE id = 3326;
UPDATE regions SET name = 'Al-Hodeidah' WHERE id = 3327;
UPDATE regions SET name = 'Al-Jawf' WHERE id = 3337;
UPDATE regions SET name = 'Al-Mhrah' WHERE id = 3336;
UPDATE regions SET name = 'Al-Mhweit' WHERE id = 3328;
UPDATE regions SET name = 'Sana''a City' WHERE id = 3323;
UPDATE regions SET name = 'Hadramout' WHERE id = 3320;
UPDATE regions SET name = 'Lahj' WHERE id = 3318;
UPDATE regions SET name = 'Mareb' WHERE id = 3335;
UPDATE regions SET name = 'Reimah' WHERE id = 3334;
UPDATE regions SET name = 'Sadah' WHERE id = 3333;
UPDATE regions SET name = 'Sana''a' WHERE id = 3332;
UPDATE regions SET name = 'Taiz' WHERE id = 3330;
DELETE FROM regions WHERE id=51;
DELETE FROM regions WHERE id=52;
DELETE FROM regions WHERE id=54;
DELETE FROM regions WHERE id=53;
DELETE FROM regions WHERE id=55;
DELETE FROM regions WHERE id=56;
DELETE FROM regions WHERE id=57;
DELETE FROM regions WHERE id=58;
DELETE FROM regions WHERE id=59;
DELETE FROM regions WHERE id=60;
DELETE FROM regions WHERE id=61;
DELETE FROM regions WHERE id=62;
DELETE FROM regions WHERE id=63;
DELETE FROM regions WHERE id=64;
DELETE FROM regions WHERE id=65;
DELETE FROM regions WHERE id=66;
UPDATE projects_regions SET region_id=3551 WHERE region_id=10;
DELETE FROM regions WHERE id=10;
DELETE FROM regions WHERE id=11;
DELETE FROM regions WHERE id=12;
DELETE FROM regions WHERE id=25;
DELETE FROM regions WHERE id=28;
UPDATE projects_regions SET region_id=73 WHERE region_id=3560;
DELETE FROM regions WHERE id=3560;
DELETE FROM regions WHERE id=137;
DELETE FROM regions WHERE id=136;
DELETE FROM regions WHERE id=135;
DELETE FROM regions WHERE id=138;
UPDATE projects_regions SET region_id=82 WHERE region_id=3561;
DELETE FROM regions WHERE id=3561;
DELETE FROM regions WHERE id=3557;
DELETE FROM regions WHERE id=3558;
DELETE FROM regions WHERE id=3559;
DELETE FROM regions WHERE id=126;
UPDATE projects_regions SET region_id=127 WHERE region_id=3562;
DELETE FROM regions WHERE id=3562;
UPDATE projects_regions SET region_id=128 WHERE region_id=3563;
DELETE FROM regions WHERE id=3563;
DELETE FROM regions WHERE id=129;
UPDATE projects_regions SET region_id=130 WHERE region_id=3564;
DELETE FROM regions WHERE id=3564;
UPDATE projects_regions SET region_id=132 WHERE region_id=3565;
DELETE FROM regions WHERE id=3565;
UPDATE projects_regions SET region_id=134 WHERE region_id=3566;
DELETE FROM regions WHERE id=3566;
DELETE FROM regions WHERE id=154;
DELETE FROM regions WHERE id=159;
DELETE FROM regions WHERE id=192;
UPDATE projects_regions SET region_id=3569 WHERE region_id=213;
DELETE FROM regions WHERE id=213;
DELETE FROM regions WHERE id=211;
DELETE FROM regions WHERE id=216;
DELETE FROM regions WHERE id=3571;
DELETE FROM regions WHERE id=212;
DELETE FROM regions WHERE id=205;
DELETE FROM regions WHERE id=201;
DELETE FROM regions WHERE id=199;
DELETE FROM regions WHERE id=3575;
DELETE FROM regions WHERE id=195;
DELETE FROM regions WHERE id=193;
DELETE FROM regions WHERE id=194;
DELETE FROM regions WHERE id=183;
DELETE FROM regions WHERE id=182;
DELETE FROM regions WHERE id=186;
DELETE FROM regions WHERE id=229;
DELETE FROM regions WHERE id=228;
DELETE FROM regions WHERE id=224;
DELETE FROM regions WHERE id=181;
DELETE FROM regions WHERE id=203;
DELETE FROM regions WHERE id=237;
DELETE FROM regions WHERE id=200;
DELETE FROM regions WHERE id=196;
DELETE FROM regions WHERE id=190;
DELETE FROM regions WHERE id=187;
DELETE FROM regions WHERE id=3586;
DELETE FROM regions WHERE id=217;
DELETE FROM regions WHERE id=3589;
DELETE FROM regions WHERE id=238;
DELETE FROM regions WHERE id=185;
DELETE FROM regions WHERE id=172;
DELETE FROM regions WHERE id=222;
DELETE FROM regions WHERE id=225;
DELETE FROM regions WHERE id=365;
DELETE FROM regions WHERE id=263;
DELETE FROM regions WHERE id=266;
DELETE FROM regions WHERE id=262;
DELETE FROM regions WHERE id=268;
DELETE FROM regions WHERE id=258;
DELETE FROM regions WHERE id=267;
DELETE FROM regions WHERE id=259;
DELETE FROM regions WHERE id=261;
DELETE FROM regions WHERE id=413;
DELETE FROM regions WHERE id=420;
DELETE FROM regions WHERE id=3599;
DELETE FROM regions WHERE id=411;
DELETE FROM regions WHERE id=417;
DELETE FROM regions WHERE id=416;
DELETE FROM regions WHERE id=410;
DELETE FROM regions WHERE id=412;
DELETE FROM regions WHERE id=419;
DELETE FROM regions WHERE id=418;
DELETE FROM regions WHERE id=414;
DELETE FROM regions WHERE id=415;
DELETE FROM regions WHERE id=423;
UPDATE projects_regions SET region_id=425 WHERE region_id=3601;
DELETE FROM regions WHERE id=3601;
DELETE FROM regions WHERE id=3602;
UPDATE projects_regions SET region_id=10013 WHERE region_id=281;
DELETE FROM regions WHERE id=281;
UPDATE projects_regions SET region_id=10017 WHERE region_id=282;
DELETE FROM regions WHERE id=282;
UPDATE projects_regions SET region_id=10013 WHERE region_id=283;
DELETE FROM regions WHERE id=283;
DELETE FROM regions WHERE id=284;
DELETE FROM regions WHERE id=285;
UPDATE projects_regions SET region_id=10016 WHERE region_id=286;
DELETE FROM regions WHERE id=286;
UPDATE projects_regions SET region_id=10018 WHERE region_id=287;
DELETE FROM regions WHERE id=287;
UPDATE projects_regions SET region_id=10014 WHERE region_id=3595;
DELETE FROM regions WHERE id=3595;
DELETE FROM regions WHERE id=288;
UPDATE projects_regions SET region_id=10020 WHERE region_id=289;
DELETE FROM regions WHERE id=289;
UPDATE projects_regions SET region_id=10020 WHERE region_id=290;
DELETE FROM regions WHERE id=290;
UPDATE projects_regions SET region_id=10021 WHERE region_id=291;
DELETE FROM regions WHERE id=291;
DELETE FROM regions WHERE id=292;
DELETE FROM regions WHERE id=294;
DELETE FROM regions WHERE id=293;
DELETE FROM regions WHERE id=295;
UPDATE projects_regions SET region_id=10020 WHERE region_id=296;
DELETE FROM regions WHERE id=296;
DELETE FROM regions WHERE id=297;
UPDATE projects_regions SET region_id=10013 WHERE region_id=298;
DELETE FROM regions WHERE id=298;
DELETE FROM regions WHERE id=299;
UPDATE projects_regions SET region_id=10016 WHERE region_id=300;
DELETE FROM regions WHERE id=300;
DELETE FROM regions WHERE id=301;
UPDATE projects_regions SET region_id=10014 WHERE region_id=302;
DELETE FROM regions WHERE id=302;
UPDATE projects_regions SET region_id=10022 WHERE region_id=303;
DELETE FROM regions WHERE id=303;
DELETE FROM regions WHERE id=304;
DELETE FROM regions WHERE id=3596;
UPDATE projects_regions SET region_id=10019 WHERE region_id=305;
DELETE FROM regions WHERE id=305;
UPDATE projects_regions SET region_id=10017 WHERE region_id=306;
DELETE FROM regions WHERE id=306;
DELETE FROM regions WHERE id=307;
DELETE FROM regions WHERE id=3597;
UPDATE projects_regions SET region_id=10023 WHERE region_id=308;
DELETE FROM regions WHERE id=308;
DELETE FROM regions WHERE id=309;
UPDATE projects_regions SET region_id=10022 WHERE region_id=310;
DELETE FROM regions WHERE id=310;
DELETE FROM regions WHERE id=311;
UPDATE projects_regions SET region_id=10024 WHERE region_id=314;
DELETE FROM regions WHERE id=314;
DELETE FROM regions WHERE id=312;
UPDATE projects_regions SET region_id=10017 WHERE region_id=313;
DELETE FROM regions WHERE id=313;
DELETE FROM regions WHERE id=315;
UPDATE projects_regions SET region_id=10024 WHERE region_id=316;
DELETE FROM regions WHERE id=316;
UPDATE projects_regions SET region_id=10021 WHERE region_id=317;
DELETE FROM regions WHERE id=317;
DELETE FROM regions WHERE id=318;
DELETE FROM regions WHERE id=319;
DELETE FROM regions WHERE id=320;
UPDATE projects_regions SET region_id=10022 WHERE region_id=321;
DELETE FROM regions WHERE id=321;
UPDATE projects_regions SET region_id=10018 WHERE region_id=322;
DELETE FROM regions WHERE id=322;
UPDATE projects_regions SET region_id=10022 WHERE region_id=323;
DELETE FROM regions WHERE id=323;
DELETE FROM regions WHERE id=324;
DELETE FROM regions WHERE id=1540;
DELETE FROM regions WHERE id=1541;
DELETE FROM regions WHERE id=1546;
DELETE FROM regions WHERE id=1542;
DELETE FROM regions WHERE id=1543;
DELETE FROM regions WHERE id=1544;
DELETE FROM regions WHERE id=1545;
DELETE FROM regions WHERE id=1547;
DELETE FROM regions WHERE id=1548;
DELETE FROM regions WHERE id=3658;
DELETE FROM regions WHERE id=1550;
DELETE FROM regions WHERE id=1551;
DELETE FROM regions WHERE id=1552;
DELETE FROM regions WHERE id=1553;
DELETE FROM regions WHERE id=1554;
DELETE FROM regions WHERE id=1556;
DELETE FROM regions WHERE id=1557;
DELETE FROM regions WHERE id=1558;
DELETE FROM regions WHERE id=1559;
DELETE FROM regions WHERE id=1560;
DELETE FROM regions WHERE id=1561;
DELETE FROM regions WHERE id=1563;
DELETE FROM regions WHERE id=730;
DELETE FROM regions WHERE id=729;
DELETE FROM regions WHERE id=728;
DELETE FROM regions WHERE id=727;
DELETE FROM regions WHERE id=726;
DELETE FROM regions WHERE id=732;
DELETE FROM regions WHERE id=731;
DELETE FROM regions WHERE id=2799;
DELETE FROM regions WHERE id=2813;
DELETE FROM regions WHERE id=563;
DELETE FROM regions WHERE id=567;
UPDATE projects_regions SET region_id=569 WHERE region_id=3607;
DELETE FROM regions WHERE id=3607;
DELETE FROM regions WHERE id=591;
DELETE FROM regions WHERE id=3610;
DELETE FROM regions WHERE id=601;
DELETE FROM regions WHERE id=654;
DELETE FROM regions WHERE id=3621;
DELETE FROM regions WHERE id=684;
DELETE FROM regions WHERE id=686;
DELETE FROM regions WHERE id=685;
DELETE FROM regions WHERE id=3645;
DELETE FROM regions WHERE id=1217;
DELETE FROM regions WHERE id=714;
DELETE FROM regions WHERE id=635;
DELETE FROM regions WHERE id=3613;
DELETE FROM regions WHERE id=3614;
DELETE FROM regions WHERE id=639;
DELETE FROM regions WHERE id=640;
DELETE FROM regions WHERE id=794;
DELETE FROM regions WHERE id=793;
DELETE FROM regions WHERE id=792;
DELETE FROM regions WHERE id=791;
DELETE FROM regions WHERE id=790;
DELETE FROM regions WHERE id=789;
DELETE FROM regions WHERE id=788;
DELETE FROM regions WHERE id=787;
DELETE FROM regions WHERE id=786;
DELETE FROM regions WHERE id=785;
DELETE FROM regions WHERE id=795;
DELETE FROM regions WHERE id=784;
DELETE FROM regions WHERE id=796;
DELETE FROM regions WHERE id=797;
UPDATE projects_regions SET region_id=799 WHERE region_id=3622;
DELETE FROM regions WHERE id=3622;
DELETE FROM regions WHERE id=804;
DELETE FROM regions WHERE id=808;
DELETE FROM regions WHERE id=809;
DELETE FROM regions WHERE id=3626;
DELETE FROM regions WHERE id=880;
DELETE FROM regions WHERE id=886;
DELETE FROM regions WHERE id=3629;
DELETE FROM regions WHERE id=3633;
DELETE FROM regions WHERE id=971;
UPDATE projects_regions SET region_id=973 WHERE region_id=3635;
DELETE FROM regions WHERE id=3635;
UPDATE projects_regions SET region_id=974 WHERE region_id=3636;
DELETE FROM regions WHERE id=3636;
UPDATE projects_regions SET region_id=3637 WHERE region_id=977;
DELETE FROM regions WHERE id=977;
DELETE FROM regions WHERE id=1015;
DELETE FROM regions WHERE id=1013;
DELETE FROM regions WHERE id=1012;
DELETE FROM regions WHERE id=1011;
DELETE FROM regions WHERE id=1014;
DELETE FROM regions WHERE id=1016;
DELETE FROM regions WHERE id=986;
DELETE FROM regions WHERE id=979;
DELETE FROM regions WHERE id=983;
DELETE FROM regions WHERE id=980;
DELETE FROM regions WHERE id=981;
DELETE FROM regions WHERE id=982;
DELETE FROM regions WHERE id=1137;
DELETE FROM regions WHERE id=1136;
DELETE FROM regions WHERE id=142;
DELETE FROM regions WHERE id=139;
DELETE FROM regions WHERE id=140;
DELETE FROM regions WHERE id=141;
DELETE FROM regions WHERE id=1070;
DELETE FROM regions WHERE id=3638;
DELETE FROM regions WHERE id=1056;
DELETE FROM regions WHERE id=1100;
DELETE FROM regions WHERE id=1101;
DELETE FROM regions WHERE id=1102;
DELETE FROM regions WHERE id=1103;
DELETE FROM regions WHERE id=1090;
DELETE FROM regions WHERE id=1091;
DELETE FROM regions WHERE id=1092;
DELETE FROM regions WHERE id=1093;
DELETE FROM regions WHERE id=1094;
DELETE FROM regions WHERE id=1095;
DELETE FROM regions WHERE id=1096;
DELETE FROM regions WHERE id=1097;
DELETE FROM regions WHERE id=1098;
DELETE FROM regions WHERE id=1099;
DELETE FROM regions WHERE id=1066;
DELETE FROM regions WHERE id=1065;
DELETE FROM regions WHERE id=3639;
DELETE FROM regions WHERE id=1067;
DELETE FROM regions WHERE id=1139;
DELETE FROM regions WHERE id=1140;
DELETE FROM regions WHERE id=1141;
DELETE FROM regions WHERE id=1142;
DELETE FROM regions WHERE id=1143;
DELETE FROM regions WHERE id=1144;
DELETE FROM regions WHERE id=1145;
DELETE FROM regions WHERE id=1146;
DELETE FROM regions WHERE id=1147;
DELETE FROM regions WHERE id=1149;
DELETE FROM regions WHERE id=1150;
DELETE FROM regions WHERE id=1151;
DELETE FROM regions WHERE id=1138;
DELETE FROM regions WHERE id=1152;
DELETE FROM regions WHERE id=1153;
DELETE FROM regions WHERE id=1154;
DELETE FROM regions WHERE id=1155;
DELETE FROM regions WHERE id=1156;
DELETE FROM regions WHERE id=1148;
UPDATE projects_regions SET region_id=1127 WHERE region_id=3641;
DELETE FROM regions WHERE id=3641;
DELETE FROM regions WHERE id=1126;
DELETE FROM regions WHERE id=1063;
UPDATE projects_regions SET region_id=10140 WHERE region_id=1057;
DELETE FROM regions WHERE id=1057;
DELETE FROM regions WHERE id=1060;
DELETE FROM regions WHERE id=1064;
DELETE FROM regions WHERE id=1059;
DELETE FROM regions WHERE id=1058;
DELETE FROM regions WHERE id=1061;
DELETE FROM regions WHERE id=1062;
DELETE FROM regions WHERE id=3543;
DELETE FROM regions WHERE id=3544;
DELETE FROM regions WHERE id=1190;
DELETE FROM regions WHERE id=1181;
DELETE FROM regions WHERE id=1182;
DELETE FROM regions WHERE id=1174;
DELETE FROM regions WHERE id=1173;
DELETE FROM regions WHERE id=1175;
DELETE FROM regions WHERE id=1176;
DELETE FROM regions WHERE id=1183;
DELETE FROM regions WHERE id=1172;
DELETE FROM regions WHERE id=1170;
DELETE FROM regions WHERE id=1179;
DELETE FROM regions WHERE id=1184;
DELETE FROM regions WHERE id=1167;
DELETE FROM regions WHERE id=1168;
DELETE FROM regions WHERE id=1169;
DELETE FROM regions WHERE id=1180;
DELETE FROM regions WHERE id=1177;
DELETE FROM regions WHERE id=1178;
DELETE FROM regions WHERE id=1171;
DELETE FROM regions WHERE id=1287;
DELETE FROM regions WHERE id=1301;
DELETE FROM regions WHERE id=1320;
DELETE FROM regions WHERE id=1353;
DELETE FROM regions WHERE id=1354;
DELETE FROM regions WHERE id=1358;
DELETE FROM regions WHERE id=1359;
DELETE FROM regions WHERE id=1360;
DELETE FROM regions WHERE id=1361;
DELETE FROM regions WHERE id=1362;
DELETE FROM regions WHERE id=1363;
DELETE FROM regions WHERE id=1364;
DELETE FROM regions WHERE id=1365;
DELETE FROM regions WHERE id=1366;
DELETE FROM regions WHERE id=1367;
DELETE FROM regions WHERE id=1368;
DELETE FROM regions WHERE id=1369;
DELETE FROM regions WHERE id=1370;
DELETE FROM regions WHERE id=1371;
DELETE FROM regions WHERE id=1372;
DELETE FROM regions WHERE id=1373;
DELETE FROM regions WHERE id=1352;
DELETE FROM regions WHERE id=1350;
DELETE FROM regions WHERE id=1351;
DELETE FROM regions WHERE id=1349;
DELETE FROM regions WHERE id=1355;
DELETE FROM regions WHERE id=1356;
DELETE FROM regions WHERE id=1357;
DELETE FROM regions WHERE id=1348;
DELETE FROM regions WHERE id=1377;
DELETE FROM regions WHERE id=1375;
DELETE FROM regions WHERE id=1374;
DELETE FROM regions WHERE id=1376;
DELETE FROM regions WHERE id=1343;
DELETE FROM regions WHERE id=1335;
DELETE FROM regions WHERE id=1334;
DELETE FROM regions WHERE id=1327;
DELETE FROM regions WHERE id=1342;
DELETE FROM regions WHERE id=1338;
DELETE FROM regions WHERE id=1337;
DELETE FROM regions WHERE id=1336;
DELETE FROM regions WHERE id=1341;
DELETE FROM regions WHERE id=1347;
DELETE FROM regions WHERE id=1323;
DELETE FROM regions WHERE id=1324;
DELETE FROM regions WHERE id=1326;
DELETE FROM regions WHERE id=1328;
DELETE FROM regions WHERE id=1329;
DELETE FROM regions WHERE id=1340;
DELETE FROM regions WHERE id=1346;
DELETE FROM regions WHERE id=1322;
DELETE FROM regions WHERE id=1325;
DELETE FROM regions WHERE id=1344;
DELETE FROM regions WHERE id=1345;
DELETE FROM regions WHERE id=1330;
DELETE FROM regions WHERE id=1331;
DELETE FROM regions WHERE id=1332;
DELETE FROM regions WHERE id=1333;
DELETE FROM regions WHERE id=1339;
DELETE FROM regions WHERE id=1404;
DELETE FROM regions WHERE id=1529;
DELETE FROM regions WHERE id=2412;
DELETE FROM regions WHERE id=2407;
DELETE FROM regions WHERE id=2415;
DELETE FROM regions WHERE id=2405;
DELETE FROM regions WHERE id=2416;
DELETE FROM regions WHERE id=3671;
DELETE FROM regions WHERE id=1608;
DELETE FROM regions WHERE id=1613;
DELETE FROM regions WHERE id=1615;
DELETE FROM regions WHERE id=1599;
DELETE FROM regions WHERE id=1743;
DELETE FROM regions WHERE id=1742;
DELETE FROM regions WHERE id=1740;
DELETE FROM regions WHERE id=1739;
DELETE FROM regions WHERE id=1741;
DELETE FROM regions WHERE id=3675;
DELETE FROM regions WHERE id=1621;
DELETE FROM regions WHERE id=3676;
DELETE FROM regions WHERE id=1622;
DELETE FROM regions WHERE id=1617;
DELETE FROM regions WHERE id=1618;
DELETE FROM regions WHERE id=1625;
DELETE FROM regions WHERE id=1627;
DELETE FROM regions WHERE id=1628;
DELETE FROM regions WHERE id=1629;
DELETE FROM regions WHERE id=1666;
DELETE FROM regions WHERE id=1669;
DELETE FROM regions WHERE id=1651;
DELETE FROM regions WHERE id=1645;
DELETE FROM regions WHERE id=1656;
DELETE FROM regions WHERE id=1655;
DELETE FROM regions WHERE id=1648;
DELETE FROM regions WHERE id=1661;
DELETE FROM regions WHERE id=1658;
DELETE FROM regions WHERE id=1646;
DELETE FROM regions WHERE id=1662;
DELETE FROM regions WHERE id=3694;
DELETE FROM regions WHERE id=1733;
DELETE FROM regions WHERE id=1744;
DELETE FROM regions WHERE id=1803;
DELETE FROM regions WHERE id=1953;
DELETE FROM regions WHERE id=1954;
DELETE FROM regions WHERE id=1955;
DELETE FROM regions WHERE id=1956;
DELETE FROM regions WHERE id=1957;
DELETE FROM regions WHERE id=1958;
DELETE FROM regions WHERE id=1959;
DELETE FROM regions WHERE id=1960;
DELETE FROM regions WHERE id=1961;
DELETE FROM regions WHERE id=1962;
DELETE FROM regions WHERE id=1963;
DELETE FROM regions WHERE id=1964;
DELETE FROM regions WHERE id=1965;
UPDATE projects_regions SET region_id=3711 WHERE region_id=1966;
DELETE FROM regions WHERE id=1966;
DELETE FROM regions WHERE id=1967;
DELETE FROM regions WHERE id=1968;
DELETE FROM regions WHERE id=1969;
DELETE FROM regions WHERE id=1970;
DELETE FROM regions WHERE id=1971;
DELETE FROM regions WHERE id=1972;
DELETE FROM regions WHERE id=1973;
DELETE FROM regions WHERE id=1974;
DELETE FROM regions WHERE id=1975;
DELETE FROM regions WHERE id=1976;
DELETE FROM regions WHERE id=1977;
DELETE FROM regions WHERE id=1978;
UPDATE projects_regions SET region_id=1844 WHERE region_id=3697;
DELETE FROM regions WHERE id=3697;
DELETE FROM regions WHERE id=1938;
DELETE FROM regions WHERE id=1937;
DELETE FROM regions WHERE id=1939;
DELETE FROM regions WHERE id=1940;
DELETE FROM regions WHERE id=3707;
DELETE FROM regions WHERE id=1931;
DELETE FROM regions WHERE id=1949;
DELETE FROM regions WHERE id=1944;
DELETE FROM regions WHERE id=3703;
DELETE FROM regions WHERE id=1872;
DELETE FROM regions WHERE id=1880;
DELETE FROM regions WHERE id=3699;
DELETE FROM regions WHERE id=1875;
DELETE FROM regions WHERE id=1874;
DELETE FROM regions WHERE id=1920;
UPDATE projects_regions SET region_id=1923 WHERE region_id=3706;
DELETE FROM regions WHERE id=3706;
UPDATE projects_regions SET region_id=2108 WHERE region_id=3714;
DELETE FROM regions WHERE id=3714;
UPDATE projects_regions SET region_id=2109 WHERE region_id=3715;
DELETE FROM regions WHERE id=3715;
DELETE FROM regions WHERE id=2084;
DELETE FROM regions WHERE id=2077;
DELETE FROM regions WHERE id=87;
DELETE FROM regions WHERE id=88;
DELETE FROM regions WHERE id=89;
DELETE FROM regions WHERE id=86;
DELETE FROM regions WHERE id=90;
DELETE FROM regions WHERE id=2007;
DELETE FROM regions WHERE id=2006;
DELETE FROM regions WHERE id=2005;
DELETE FROM regions WHERE id=2068;
DELETE FROM regions WHERE id=2014;
DELETE FROM regions WHERE id=2051;
DELETE FROM regions WHERE id=1910;
DELETE FROM regions WHERE id=1912;
DELETE FROM regions WHERE id=1911;
DELETE FROM regions WHERE id=1913;
DELETE FROM regions WHERE id=2091;
DELETE FROM regions WHERE id=2150;
DELETE FROM regions WHERE id=2151;
DELETE FROM regions WHERE id=2153;
DELETE FROM regions WHERE id=3718;
DELETE FROM regions WHERE id=2194;
DELETE FROM regions WHERE id=2195;
DELETE FROM regions WHERE id=2196;
DELETE FROM regions WHERE id=2197;
DELETE FROM regions WHERE id=2198;
UPDATE projects_regions SET region_id=10387 WHERE region_id=2199;
DELETE FROM regions WHERE id=2199;
DELETE FROM regions WHERE id=2200;
DELETE FROM regions WHERE id=2201;
DELETE FROM regions WHERE id=2202;
DELETE FROM regions WHERE id=2203;
DELETE FROM regions WHERE id=2204;
DELETE FROM regions WHERE id=2205;
DELETE FROM regions WHERE id=2206;
DELETE FROM regions WHERE id=2207;
DELETE FROM regions WHERE id=2208;
UPDATE projects_regions SET region_id=10390 WHERE region_id=2209;
DELETE FROM regions WHERE id=2209;
DELETE FROM regions WHERE id=2210;
UPDATE projects_regions SET region_id=10381 WHERE region_id=2211;
DELETE FROM regions WHERE id=2211;
DELETE FROM regions WHERE id=2212;
DELETE FROM regions WHERE id=2213;
DELETE FROM regions WHERE id=2214;
DELETE FROM regions WHERE id=2215;
DELETE FROM regions WHERE id=2216;
DELETE FROM regions WHERE id=2217;
UPDATE projects_regions SET region_id=10388 WHERE region_id=2218;
DELETE FROM regions WHERE id=2218;
DELETE FROM regions WHERE id=2219;
DELETE FROM regions WHERE id=2220;
DELETE FROM regions WHERE id=2221;
DELETE FROM regions WHERE id=2222;
DELETE FROM regions WHERE id=2223;
DELETE FROM regions WHERE id=2224;
DELETE FROM regions WHERE id=2225;
DELETE FROM regions WHERE id=2226;
DELETE FROM regions WHERE id=2227;
DELETE FROM regions WHERE id=2228;
DELETE FROM regions WHERE id=2229;
UPDATE projects_regions SET region_id=10381 WHERE region_id=2230;
DELETE FROM regions WHERE id=2230;
DELETE FROM regions WHERE id=2231;
DELETE FROM regions WHERE id=2232;
DELETE FROM regions WHERE id=2233;
DELETE FROM regions WHERE id=2234;
DELETE FROM regions WHERE id=2235;
UPDATE projects_regions SET region_id=10389 WHERE region_id=2236;
DELETE FROM regions WHERE id=2236;
UPDATE projects_regions SET region_id=10377 WHERE region_id=2237;
DELETE FROM regions WHERE id=2237;
DELETE FROM regions WHERE id=2238;
DELETE FROM regions WHERE id=2239;
UPDATE projects_regions SET region_id=10379 WHERE region_id=2240;
DELETE FROM regions WHERE id=2240;
DELETE FROM regions WHERE id=3719;
DELETE FROM regions WHERE id=3720;
UPDATE projects_regions SET region_id=10390 WHERE region_id=2241;
DELETE FROM regions WHERE id=2241;
UPDATE projects_regions SET region_id=10390 WHERE region_id=2242;
DELETE FROM regions WHERE id=2242;
DELETE FROM regions WHERE id=2243;
DELETE FROM regions WHERE id=2244;
UPDATE projects_regions SET region_id=10388 WHERE region_id=2245;
DELETE FROM regions WHERE id=2245;
UPDATE projects_regions SET region_id=10392 WHERE region_id=2246;
DELETE FROM regions WHERE id=2246;
DELETE FROM regions WHERE id=2247;
UPDATE projects_regions SET region_id=10382 WHERE region_id=2248;
DELETE FROM regions WHERE id=2248;
UPDATE projects_regions SET region_id=10381 WHERE region_id=2249;
DELETE FROM regions WHERE id=2249;
DELETE FROM regions WHERE id=2250;
DELETE FROM regions WHERE id=2251;
UPDATE projects_regions SET region_id=10384 WHERE region_id=2252;
DELETE FROM regions WHERE id=2252;
UPDATE projects_regions SET region_id=10382 WHERE region_id=2253;
DELETE FROM regions WHERE id=2253;
DELETE FROM regions WHERE id=2254;
UPDATE projects_regions SET region_id=10383 WHERE region_id=2255;
DELETE FROM regions WHERE id=2255;
DELETE FROM regions WHERE id=2256;
DELETE FROM regions WHERE id=2257;
DELETE FROM regions WHERE id=2258;
DELETE FROM regions WHERE id=2259;
DELETE FROM regions WHERE id=2260;
DELETE FROM regions WHERE id=2261;
DELETE FROM regions WHERE id=2262;
DELETE FROM regions WHERE id=2263;
UPDATE projects_regions SET region_id=10392 WHERE region_id=2264;
DELETE FROM regions WHERE id=2264;
UPDATE projects_regions SET region_id=10389 WHERE region_id=2265;
DELETE FROM regions WHERE id=2265;
DELETE FROM regions WHERE id=2266;
DELETE FROM regions WHERE id=2267;
DELETE FROM regions WHERE id=2268;
DELETE FROM regions WHERE id=2269;
DELETE FROM regions WHERE id=2270;
DELETE FROM regions WHERE id=2271;
UPDATE projects_regions SET region_id=10382 WHERE region_id=2272;
DELETE FROM regions WHERE id=2272;
DELETE FROM regions WHERE id=2273;
DELETE FROM regions WHERE id=2274;
DELETE FROM regions WHERE id=2275;
DELETE FROM regions WHERE id=2354;
DELETE FROM regions WHERE id=2336;
DELETE FROM regions WHERE id=2351;
DELETE FROM regions WHERE id=2356;
DELETE FROM regions WHERE id=2357;
DELETE FROM regions WHERE id=2358;
DELETE FROM regions WHERE id=2359;
DELETE FROM regions WHERE id=2360;
DELETE FROM regions WHERE id=2344;
DELETE FROM regions WHERE id=2353;
DELETE FROM regions WHERE id=2334;
DELETE FROM regions WHERE id=2335;
DELETE FROM regions WHERE id=2337;
DELETE FROM regions WHERE id=2338;
DELETE FROM regions WHERE id=2341;
DELETE FROM regions WHERE id=2348;
DELETE FROM regions WHERE id=2355;
DELETE FROM regions WHERE id=2352;
DELETE FROM regions WHERE id=2349;
DELETE FROM regions WHERE id=2361;
DELETE FROM regions WHERE id=2362;
DELETE FROM regions WHERE id=2363;
DELETE FROM regions WHERE id=2364;
DELETE FROM regions WHERE id=2347;
DELETE FROM regions WHERE id=2346;
DELETE FROM regions WHERE id=2365;
DELETE FROM regions WHERE id=2366;
DELETE FROM regions WHERE id=2367;
DELETE FROM regions WHERE id=2369;
DELETE FROM regions WHERE id=2371;
DELETE FROM regions WHERE id=2372;
DELETE FROM regions WHERE id=2373;
DELETE FROM regions WHERE id=2345;
DELETE FROM regions WHERE id=2339;
DELETE FROM regions WHERE id=2340;
DELETE FROM regions WHERE id=2374;
DELETE FROM regions WHERE id=2368;
DELETE FROM regions WHERE id=2370;
DELETE FROM regions WHERE id=2377;
DELETE FROM regions WHERE id=2378;
DELETE FROM regions WHERE id=2380;
DELETE FROM regions WHERE id=2375;
DELETE FROM regions WHERE id=2376;
DELETE FROM regions WHERE id=2379;
DELETE FROM regions WHERE id=2381;
DELETE FROM regions WHERE id=2383;
DELETE FROM regions WHERE id=2384;
DELETE FROM regions WHERE id=2382;
DELETE FROM regions WHERE id=2385;
DELETE FROM regions WHERE id=2389;
DELETE FROM regions WHERE id=2387;
DELETE FROM regions WHERE id=2390;
DELETE FROM regions WHERE id=2391;
DELETE FROM regions WHERE id=2386;
DELETE FROM regions WHERE id=2388;
DELETE FROM regions WHERE id=2392;
DELETE FROM regions WHERE id=2393;
DELETE FROM regions WHERE id=2394;
DELETE FROM regions WHERE id=2396;
DELETE FROM regions WHERE id=2395;
DELETE FROM regions WHERE id=2400;
DELETE FROM regions WHERE id=2397;
DELETE FROM regions WHERE id=2401;
DELETE FROM regions WHERE id=2402;
DELETE FROM regions WHERE id=2398;
DELETE FROM regions WHERE id=2324;
DELETE FROM regions WHERE id=2325;
DELETE FROM regions WHERE id=2350;
DELETE FROM regions WHERE id=2326;
DELETE FROM regions WHERE id=2327;
DELETE FROM regions WHERE id=2328;
DELETE FROM regions WHERE id=2329;
DELETE FROM regions WHERE id=2330;
DELETE FROM regions WHERE id=2399;
DELETE FROM regions WHERE id=2331;
DELETE FROM regions WHERE id=2332;
DELETE FROM regions WHERE id=2333;
DELETE FROM regions WHERE id=2343;
DELETE FROM regions WHERE id=2342;
DELETE FROM regions WHERE id=2461;
DELETE FROM regions WHERE id=2463;
DELETE FROM regions WHERE id=2466;
DELETE FROM regions WHERE id=2468;
DELETE FROM regions WHERE id=2467;
DELETE FROM regions WHERE id=2469;
DELETE FROM regions WHERE id=3722;
DELETE FROM regions WHERE id=3723;
DELETE FROM regions WHERE id=3724;
DELETE FROM regions WHERE id=3725;
DELETE FROM regions WHERE id=3726;
DELETE FROM regions WHERE id=3727;
DELETE FROM regions WHERE id=3728;
DELETE FROM regions WHERE id=3729;
DELETE FROM regions WHERE id=2500;
DELETE FROM regions WHERE id=3731;
UPDATE projects_regions SET region_id=2477 WHERE region_id=3733;
DELETE FROM regions WHERE id=3733;
DELETE FROM regions WHERE id=3732;
DELETE FROM regions WHERE id=3735;
DELETE FROM regions WHERE id=3736;
DELETE FROM regions WHERE id=3737;
DELETE FROM regions WHERE id=2480;
DELETE FROM regions WHERE id=2537;
DELETE FROM regions WHERE id=2541;
DELETE FROM regions WHERE id=2547;
DELETE FROM regions WHERE id=2548;
DELETE FROM regions WHERE id=2559;
DELETE FROM regions WHERE id=2560;
DELETE FROM regions WHERE id=2568;
DELETE FROM regions WHERE id=2591;
DELETE FROM regions WHERE id=2543;
DELETE FROM regions WHERE id=2599;
DELETE FROM regions WHERE id=2600;
DELETE FROM regions WHERE id=2601;
UPDATE projects_regions SET region_id=10404 WHERE region_id=3739;
DELETE FROM regions WHERE id=3739;
DELETE FROM regions WHERE id=2602;
DELETE FROM regions WHERE id=2603;
DELETE FROM regions WHERE id=2604;
DELETE FROM regions WHERE id=2605;
DELETE FROM regions WHERE id=2606;
DELETE FROM regions WHERE id=2607;
UPDATE projects_regions SET region_id=10406 WHERE region_id=3740;
DELETE FROM regions WHERE id=3740;
UPDATE projects_regions SET region_id=10407 WHERE region_id=3741;
DELETE FROM regions WHERE id=3741;
DELETE FROM regions WHERE id=2608;
UPDATE projects_regions SET region_id=10405 WHERE region_id=3742;
DELETE FROM regions WHERE id=3742;
DELETE FROM regions WHERE id=2644;
DELETE FROM regions WHERE id=2642;
DELETE FROM regions WHERE id=2643;
DELETE FROM regions WHERE id=2701;
DELETE FROM regions WHERE id=2700;
DELETE FROM regions WHERE id=2640;
DELETE FROM regions WHERE id=3771;
DELETE FROM regions WHERE id=2724;
DELETE FROM regions WHERE id=2714;
DELETE FROM regions WHERE id=2715;
DELETE FROM regions WHERE id=2716;
DELETE FROM regions WHERE id=2703;
DELETE FROM regions WHERE id=3767;
DELETE FROM regions WHERE id=3768;
DELETE FROM regions WHERE id=2704;
DELETE FROM regions WHERE id=2717;
DELETE FROM regions WHERE id=2705;
DELETE FROM regions WHERE id=2706;
DELETE FROM regions WHERE id=2702;
DELETE FROM regions WHERE id=3769;
DELETE FROM regions WHERE id=2707;
DELETE FROM regions WHERE id=2708;
DELETE FROM regions WHERE id=2709;
UPDATE projects_regions SET region_id=10426 WHERE region_id=2718;
DELETE FROM regions WHERE id=2718;
DELETE FROM regions WHERE id=2719;
DELETE FROM regions WHERE id=3770;
DELETE FROM regions WHERE id=2711;
DELETE FROM regions WHERE id=2710;
DELETE FROM regions WHERE id=2720;
DELETE FROM regions WHERE id=2721;
DELETE FROM regions WHERE id=2722;
DELETE FROM regions WHERE id=2723;
DELETE FROM regions WHERE id=2712;
DELETE FROM regions WHERE id=2713;
DELETE FROM regions WHERE id=2725;
DELETE FROM regions WHERE id=2726;
DELETE FROM regions WHERE id=3772;
DELETE FROM regions WHERE id=2747;
DELETE FROM regions WHERE id=3773;
DELETE FROM regions WHERE id=2748;
DELETE FROM regions WHERE id=2749;
DELETE FROM regions WHERE id=2750;
DELETE FROM regions WHERE id=2751;
DELETE FROM regions WHERE id=2752;
DELETE FROM regions WHERE id=2753;
DELETE FROM regions WHERE id=2756;
DELETE FROM regions WHERE id=2757;
DELETE FROM regions WHERE id=2758;
DELETE FROM regions WHERE id=2754;
DELETE FROM regions WHERE id=2755;
UPDATE projects_regions SET region_id=3338 WHERE region_id=3877;
DELETE FROM regions WHERE id=3877;
DELETE FROM regions WHERE id=3345;
DELETE FROM regions WHERE id=3342;
DELETE FROM regions WHERE id=1695;
DELETE FROM regions WHERE id=1696;
DELETE FROM regions WHERE id=1699;
DELETE FROM regions WHERE id=1700;
DELETE FROM regions WHERE id=1701;
DELETE FROM regions WHERE id=1691;
DELETE FROM regions WHERE id=1702;
DELETE FROM regions WHERE id=1698;
DELETE FROM regions WHERE id=1709;
DELETE FROM regions WHERE id=1697;
DELETE FROM regions WHERE id=1692;
DELETE FROM regions WHERE id=1711;
DELETE FROM regions WHERE id=1712;
DELETE FROM regions WHERE id=1713;
DELETE FROM regions WHERE id=1714;
DELETE FROM regions WHERE id=1715;
DELETE FROM regions WHERE id=1694;
DELETE FROM regions WHERE id=1693;
DELETE FROM regions WHERE id=1710;
DELETE FROM regions WHERE id=1708;
DELETE FROM regions WHERE id=1707;
DELETE FROM regions WHERE id=1706;
DELETE FROM regions WHERE id=1705;
DELETE FROM regions WHERE id=1704;
DELETE FROM regions WHERE id=1703;
DELETE FROM regions WHERE id=2622;
UPDATE projects_regions SET region_id=10847 WHERE region_id=3743;
DELETE FROM regions WHERE id=3743;
DELETE FROM regions WHERE id=2624;
UPDATE projects_regions SET region_id=10848 WHERE region_id=3744;
DELETE FROM regions WHERE id=3744;
DELETE FROM regions WHERE id=2625;
DELETE FROM regions WHERE id=3746;
DELETE FROM regions WHERE id=3747;
DELETE FROM regions WHERE id=2628;
UPDATE projects_regions SET region_id=10850 WHERE region_id=3748;
DELETE FROM regions WHERE id=3748;
UPDATE projects_regions SET region_id=10851 WHERE region_id=3749;
DELETE FROM regions WHERE id=3749;
UPDATE projects_regions SET region_id=10852 WHERE region_id=3757;
DELETE FROM regions WHERE id=3757;
UPDATE projects_regions SET region_id=10853 WHERE region_id=2630;
DELETE FROM regions WHERE id=2630;
UPDATE projects_regions SET region_id=10855 WHERE region_id=3759;
DELETE FROM regions WHERE id=3759;
UPDATE projects_regions SET region_id=10856 WHERE region_id=3761;
DELETE FROM regions WHERE id=3761;
DELETE FROM regions WHERE id=2646;
DELETE FROM regions WHERE id=2645;
DELETE FROM regions WHERE id=535;
DELETE FROM regions WHERE id=3049;
DELETE FROM regions WHERE id=3051;
DELETE FROM regions WHERE id=3048;
DELETE FROM regions WHERE id=3050;
DELETE FROM regions WHERE id=2823;
DELETE FROM regions WHERE id=2824;
DELETE FROM regions WHERE id=2853;
DELETE FROM regions WHERE id=2860;
DELETE FROM regions WHERE id=2880;
DELETE FROM regions WHERE id=2882;
DELETE FROM regions WHERE id=2885;
DELETE FROM regions WHERE id=1841;
DELETE FROM regions WHERE id=1843;
DELETE FROM regions WHERE id=1842;
DELETE FROM regions WHERE id=1839;
DELETE FROM regions WHERE id=1838;
DELETE FROM regions WHERE id=1840;
DELETE FROM regions WHERE id=1836;
DELETE FROM regions WHERE id=1837;
DELETE FROM regions WHERE id=2904;
DELETE FROM regions WHERE id=2903;
DELETE FROM regions WHERE id=2905;
DELETE FROM regions WHERE id=2934;
DELETE FROM regions WHERE id=2933;
DELETE FROM regions WHERE id=2932;
DELETE FROM regions WHERE id=2931;
DELETE FROM regions WHERE id=2939;
DELETE FROM regions WHERE id=2938;
DELETE FROM regions WHERE id=2937;
DELETE FROM regions WHERE id=2936;
DELETE FROM regions WHERE id=2930;
DELETE FROM regions WHERE id=2929;
DELETE FROM regions WHERE id=2942;
DELETE FROM regions WHERE id=2941;
DELETE FROM regions WHERE id=2940;
DELETE FROM regions WHERE id=2935;
DELETE FROM regions WHERE id=3016;
DELETE FROM regions WHERE id=3015;
DELETE FROM regions WHERE id=3014;
DELETE FROM regions WHERE id=2974;
DELETE FROM regions WHERE id=3027;
DELETE FROM regions WHERE id=3028;
DELETE FROM regions WHERE id=3029;
DELETE FROM regions WHERE id=3030;
DELETE FROM regions WHERE id=3032;
DELETE FROM regions WHERE id=3033;
DELETE FROM regions WHERE id=3034;
DELETE FROM regions WHERE id=3035;
DELETE FROM regions WHERE id=3036;
DELETE FROM regions WHERE id=3037;
DELETE FROM regions WHERE id=3026;
DELETE FROM regions WHERE id=3031;
DELETE FROM regions WHERE id=3038;
DELETE FROM regions WHERE id=3023;
DELETE FROM regions WHERE id=3024;
DELETE FROM regions WHERE id=3020;
DELETE FROM regions WHERE id=3018;
DELETE FROM regions WHERE id=3017;
DELETE FROM regions WHERE id=3013;
DELETE FROM regions WHERE id=3012;
DELETE FROM regions WHERE id=2973;
DELETE FROM regions WHERE id=2972;
DELETE FROM regions WHERE id=2971;
DELETE FROM regions WHERE id=2970;
DELETE FROM regions WHERE id=2969;
DELETE FROM regions WHERE id=3011;
DELETE FROM regions WHERE id=2968;
DELETE FROM regions WHERE id=2967;
DELETE FROM regions WHERE id=3007;
DELETE FROM regions WHERE id=3006;
DELETE FROM regions WHERE id=3005;
DELETE FROM regions WHERE id=3004;
DELETE FROM regions WHERE id=2975;
DELETE FROM regions WHERE id=2976;
DELETE FROM regions WHERE id=2981;
DELETE FROM regions WHERE id=3039;
DELETE FROM regions WHERE id=3021;
DELETE FROM regions WHERE id=3022;
DELETE FROM regions WHERE id=2977;
DELETE FROM regions WHERE id=3025;
DELETE FROM regions WHERE id=3019;
DELETE FROM regions WHERE id=2978;
DELETE FROM regions WHERE id=2979;
DELETE FROM regions WHERE id=2980;
DELETE FROM regions WHERE id=2982;
DELETE FROM regions WHERE id=2983;
DELETE FROM regions WHERE id=3010;
DELETE FROM regions WHERE id=3009;
DELETE FROM regions WHERE id=3008;
DELETE FROM regions WHERE id=2984;
DELETE FROM regions WHERE id=2985;
DELETE FROM regions WHERE id=2986;
DELETE FROM regions WHERE id=2987;
DELETE FROM regions WHERE id=2988;
DELETE FROM regions WHERE id=2989;
DELETE FROM regions WHERE id=2990;
DELETE FROM regions WHERE id=2991;
DELETE FROM regions WHERE id=2992;
DELETE FROM regions WHERE id=2993;
DELETE FROM regions WHERE id=2994;
DELETE FROM regions WHERE id=2995;
DELETE FROM regions WHERE id=2996;
DELETE FROM regions WHERE id=2997;
DELETE FROM regions WHERE id=2998;
DELETE FROM regions WHERE id=2999;
DELETE FROM regions WHERE id=3000;
DELETE FROM regions WHERE id=3001;
DELETE FROM regions WHERE id=3002;
DELETE FROM regions WHERE id=3003;
DELETE FROM regions WHERE id=0;
DELETE FROM regions WHERE id=0;
DELETE FROM regions WHERE id=3041;
DELETE FROM regions WHERE id=3040;
DELETE FROM regions WHERE id=3046;
DELETE FROM regions WHERE id=3045;
DELETE FROM regions WHERE id=3044;
DELETE FROM regions WHERE id=3043;
DELETE FROM regions WHERE id=3042;
DELETE FROM regions WHERE id=3047;
DELETE FROM regions WHERE id=3128;
DELETE FROM regions WHERE id=3127;
DELETE FROM regions WHERE id=93;
DELETE FROM regions WHERE id=3053;
DELETE FROM regions WHERE id=3057;
DELETE FROM regions WHERE id=3058;
DELETE FROM regions WHERE id=3061;
DELETE FROM regions WHERE id=3076;
DELETE FROM regions WHERE id=3077;
DELETE FROM regions WHERE id=3166;
DELETE FROM regions WHERE id=3165;
DELETE FROM regions WHERE id=3167;
DELETE FROM regions WHERE id=3168;
DELETE FROM regions WHERE id=3169;
DELETE FROM regions WHERE id=3170;
DELETE FROM regions WHERE id=3171;
DELETE FROM regions WHERE id=3164;
DELETE FROM regions WHERE id=3163;
DELETE FROM regions WHERE id=3287;
DELETE FROM regions WHERE id=3286;
DELETE FROM regions WHERE id=3288;
DELETE FROM regions WHERE id=3292;
DELETE FROM regions WHERE id=3290;
DELETE FROM regions WHERE id=3293;
DELETE FROM regions WHERE id=3289;
DELETE FROM regions WHERE id=3291;
DELETE FROM regions WHERE id=3294;
DELETE FROM regions WHERE id=3295;
DELETE FROM regions WHERE id=3296;
DELETE FROM regions WHERE id=3305;
DELETE FROM regions WHERE id=3304;
DELETE FROM regions WHERE id=3303;
DELETE FROM regions WHERE id=931;
DELETE FROM regions WHERE id=934;
DELETE FROM regions WHERE id=933;
DELETE FROM regions WHERE id=932;
