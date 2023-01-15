/*
 Navicat MySQL Data Transfer

 Source Server         : library
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : library

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 16/01/2023 04:33:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `ISBN` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `location` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `state` int NOT NULL,
  `operator` int NOT NULL,
  PRIMARY KEY (`book_id`) USING BTREE,
  UNIQUE INDEX `BID_UNIQUE`(`book_id` ASC) USING BTREE,
  INDEX `op2_idx`(`operator` ASC) USING BTREE,
  INDEX `bo_idx`(`ISBN` ASC) USING BTREE,
  CONSTRAINT `bo` FOREIGN KEY (`ISBN`) REFERENCES `booklist` (`ISBN`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `op2` FOREIGN KEY (`operator`) REFERENCES `manager` (`manager_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 176 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '0000000000001', '流通室', 0, 1);
INSERT INTO `book` VALUES (2, '0000000000001', '流通室', 0, 1);
INSERT INTO `book` VALUES (3, '0000000000001', '流通室', 0, 1);

-- ----------------------------
-- Table structure for booklist
-- ----------------------------
DROP TABLE IF EXISTS `booklist`;
CREATE TABLE `booklist`  (
  `ISBN` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `bname` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `publisher` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `writer` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `ptime` date NULL DEFAULT NULL,
  `number` int NOT NULL DEFAULT 0,
  `operator` int NOT NULL,
  `is_popular` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`ISBN`) USING BTREE,
  UNIQUE INDEX `ISBN_UNIQUE`(`ISBN` ASC) USING BTREE,
  INDEX `op_idx`(`operator` ASC) USING BTREE,
  CONSTRAINT `op` FOREIGN KEY (`operator`) REFERENCES `manager` (`manager_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booklist
-- ----------------------------
INSERT INTO `booklist` VALUES ('0000000000001', '资本论', '人民出版社', '[德]卡尔·马克思', '1886-05-20', 3, 1, 0);

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow`  (
  `borrow_id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `user_id` int NOT NULL,
  `btime` datetime NOT NULL,
  `deadline` datetime NOT NULL,
  `rtime` datetime NULL DEFAULT NULL,
  `operator` int NULL DEFAULT NULL,
  PRIMARY KEY (`borrow_id`) USING BTREE,
  UNIQUE INDEX `BWID_UNIQUE`(`borrow_id` ASC) USING BTREE,
  INDEX `boo_idx`(`book_id` ASC) USING BTREE,
  INDEX `re_idx`(`user_id` ASC) USING BTREE,
  INDEX `op3_idx`(`operator` ASC) USING BTREE,
  CONSTRAINT `boo` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `op3` FOREIGN KEY (`operator`) REFERENCES `manager` (`manager_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `re` FOREIGN KEY (`user_id`) REFERENCES `reader` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES (1, 1, 1, '2019-05-14 00:00:00', '2020-05-14 00:00:00', '2022-05-14 00:00:00', 1);

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `manager_id` int NOT NULL AUTO_INCREMENT,
  `pass_wd` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mname` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`manager_id`) USING BTREE,
  UNIQUE INDEX `MID_UNIQUE`(`manager_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (1, '123456', 'admin_ips');

-- ----------------------------
-- Table structure for reader
-- ----------------------------
DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `pass_wd` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `rname` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `RID_UNIQUE`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reader
-- ----------------------------
INSERT INTO `reader` VALUES (1, 'user_ips', '123456', 'ユーザー', '08000138000', '08000138000@gmail.com');

-- ----------------------------
-- Table structure for reservation
-- ----------------------------
DROP TABLE IF EXISTS `reservation`;
CREATE TABLE `reservation`  (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `book_id` int NOT NULL,
  `deadline` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`reservation_id`) USING BTREE,
  UNIQUE INDEX `REID_UNIQUE`(`reservation_id` ASC) USING BTREE,
  UNIQUE INDEX `BID_UNIQUE`(`book_id` ASC) USING BTREE,
  INDEX `re2_idx`(`user_id` ASC) USING BTREE,
  INDEX `book_idx`(`book_id` ASC) USING BTREE,
  CONSTRAINT `book` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `re2` FOREIGN KEY (`user_id`) REFERENCES `reader` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 145 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reservation
-- ----------------------------
INSERT INTO `reservation` VALUES (1, 1, 1, '2020-05-15 00:00:00');

-- ----------------------------
-- Table structure for reservation_arrived
-- ----------------------------
DROP TABLE IF EXISTS `reservation_arrived`;
CREATE TABLE `reservation_arrived`  (
  `reservation_arrived_id` int NOT NULL AUTO_INCREMENT,
  `reservation_id` int NOT NULL,
  PRIMARY KEY (`reservation_arrived_id`) USING BTREE,
  INDEX `res_id_fk_idx`(`reservation_id` ASC) USING BTREE,
  CONSTRAINT `res_id_fk` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reservation_arrived
-- ----------------------------
INSERT INTO `reservation_arrived` VALUES (1, 1);

-- ----------------------------
-- View structure for arrive_reminder
-- ----------------------------
DROP VIEW IF EXISTS `arrive_reminder`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `arrive_reminder` AS select `reader`.`user_name` AS `user_name`,`booklist`.`bname` AS `bname`,`reader`.`email` AS `email` from ((((`reservation_arrived` join `reservation`) join `reader`) join `book`) join `booklist`) where ((`reservation_arrived`.`reservation_id` = `reservation`.`reservation_id`) and (`reservation`.`user_id` = `reader`.`user_id`) and (`reservation`.`book_id` = `book`.`book_id`) and (`book`.`ISBN` = `booklist`.`ISBN`));

-- ----------------------------
-- View structure for borrow_detail
-- ----------------------------
DROP VIEW IF EXISTS `borrow_detail`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `borrow_detail` AS select `borrow`.`borrow_id` AS `borrow_id`,`borrow`.`btime` AS `btime`,`borrow`.`rtime` AS `rtime`,`borrow`.`deadline` AS `deadline`,`borrow`.`book_id` AS `book_id`,`booklist`.`bname` AS `bname`,`borrow`.`user_id` AS `user_id`,`reader`.`user_name` AS `user_name` from (((`borrow` join `book`) join `booklist`) join `reader`) where ((`borrow`.`book_id` = `book`.`book_id`) and (`booklist`.`ISBN` = `book`.`ISBN`) and (`borrow`.`user_id` = `reader`.`user_id`));

-- ----------------------------
-- View structure for reservation_detail
-- ----------------------------
DROP VIEW IF EXISTS `reservation_detail`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `reservation_detail` AS select `reader`.`user_id` AS `user_id`,`reader`.`user_name` AS `user_name`,`reservation`.`reservation_id` AS `reservation_id`,`book`.`book_id` AS `book_id`,`booklist`.`bname` AS `bname`,`reservation`.`deadline` AS `deadline` from (((`booklist` join `book`) join `reader`) join `reservation`) where ((`reservation`.`user_id` = `reader`.`user_id`) and (`reservation`.`book_id` = `book`.`book_id`) and (`book`.`ISBN` = `booklist`.`ISBN`));

-- ----------------------------
-- View structure for return_reminder
-- ----------------------------
DROP VIEW IF EXISTS `return_reminder`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `return_reminder` AS select `reader`.`user_name` AS `user_name`,`borrow`.`btime` AS `btime`,`booklist`.`bname` AS `bname`,`reader`.`email` AS `email` from (((`borrow` join `reader`) join `book`) join `booklist`) where ((`reader`.`user_id` = `borrow`.`user_id`) and (`borrow`.`book_id` = `book`.`book_id`) and (`book`.`ISBN` = `booklist`.`ISBN`) and (`borrow`.`rtime` is null));

-- ----------------------------
-- View structure for sec_kill
-- ----------------------------
DROP VIEW IF EXISTS `sec_kill`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `sec_kill` AS select `booklist`.`ISBN` AS `ISBN`,`booklist`.`bname` AS `bname`,`booklist`.`publisher` AS `publisher`,`booklist`.`writer` AS `writer`,`booklist`.`ptime` AS `ptime`,(select count(0) from `book` where ((`book`.`ISBN` = `booklist`.`ISBN`) and (`book`.`state` = 0))) AS `number` from `booklist` where (`booklist`.`is_popular` = 1);

-- ----------------------------
-- Procedure structure for borrow_from_res
-- ----------------------------
DROP PROCEDURE IF EXISTS `borrow_from_res`;
delimiter ;;
CREATE PROCEDURE `borrow_from_res`(in res_id int, in op int)
BEGIN
	declare bid int;
    declare uid int;
    declare num int;
    declare t_error integer default 0;
    declare continue handler for sqlexception set t_error=1;
    start transaction;
    
    select count(*) into num from reservation where reservation_id=res_id;
    if num > 0 then
		select book_id, user_id into bid, uid from reservation where reservation_id=res_id;
		insert into borrow(book_id, user_id, btime, deadline, operator) values (bid, uid, now(), date_add(now(), interval 60 day), op); 
		DELETE from reservation where book_id=bid;
		UPDATE book SET state=2 where book_id=bid;
	end if;
    
    if t_error=1 then
		rollback;
	else
		commit;
	end if;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for do_sec_kill
-- ----------------------------
DROP PROCEDURE IF EXISTS `do_sec_kill`;
delimiter ;;
CREATE PROCEDURE `do_sec_kill`(IN bn varchar(30), IN uid int, OUT st int)
BEGIN
	declare num int;
    declare bid int;
    declare t_error integer default 0;
    declare continue handler for sqlexception set t_error=1;
    start transaction;
    
    select count(*) into num from book where ISBN=bn and state=0;
    select book_id into bid from book where ISBN=bn and state=0 order by book_id limit 0, 1;
	if num > 0 then
		insert into reservation(user_id, book_id, deadline) values(uid, bid, date_add(now(), interval 10 day));
		update book set state=1 where book_id=bid;
		set st = 1;
	else
		set st=0;
	end if;
    
    if t_error=1 then
		rollback;
        set st=-4;
	else
		commit;
	end if;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for make_reservation
-- ----------------------------
DROP PROCEDURE IF EXISTS `make_reservation`;
delimiter ;;
CREATE PROCEDURE `make_reservation`(IN bn varchar(30), IN uid int, OUT  st int)
BEGIN
	declare num int;
    declare ispop int;
    declare bid int;
	declare stat int;
    declare t_error integer default 0;
    declare continue handler for sqlexception set t_error=1;
    start transaction;
    
    select count(*) into num from book where ISBN=bn and (state=0 or (state=2 and book_id not in (select reservation.book_id from reservation))) order by state;
	select is_popular into ispop from booklist where booklist.ISBN=bn;
    if ispop > 0 then
		set st=-1;
	else
		if num > 0 then
			select state, book_id into stat, bid from book where ISBN=bn  and (state=0 or (state=2 and book_id not in (select reservation.book_id from reservation))) order by state limit 0, 1;
			if stat > 0 then
				insert into reservation(user_id, book_id) values(uid, bid);
				set st = 2;
			else
				insert into reservation(user_id, book_id, deadline) values(uid, bid, date_add(now(), interval 10 day));
				update book set state=1 where book_id=bid;
				set st = 1;
			end if;
		else
			set st=0;
		end if;
	end if;
    
    if t_error=1 then
		rollback;
        set st=-4;
	else
		commit;
	end if;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for new_book
-- ----------------------------
DROP PROCEDURE IF EXISTS `new_book`;
delimiter ;;
CREATE PROCEDURE `new_book`(IN ISBN varchar(30),IN bname varchar(45), IN publisher varchar(45), IN writer varchar(45), IN ptime date, IN num int, IN operator int,IN location varchar(45),IN state int)
BEGIN
	DECLARE i int;
	declare t_error integer default 0;
    declare continue handler for sqlexception set t_error=1;
    start transaction;
    
	insert into booklist(ISBN,bname, publisher, writer, ptime, number, operator)values (ISBN, bname, publisher, writer, ptime, num, operator);
	SET i=0;
	while i<num DO
		insert into book(ISBN,location,state,operator) values(ISBN,location,state,operator);
		SET i=i+1;
	end while;
    
    if t_error=1 then
		rollback;
	else
		commit;
	end if;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for return_book
-- ----------------------------
DROP PROCEDURE IF EXISTS `return_book`;
delimiter ;;
CREATE PROCEDURE `return_book`(in bor_id int)
BEGIN
	declare num int;
    declare bid int;
	declare n int;
    declare resid int;
    declare t_error integer default 0;
    declare continue handler for sqlexception set t_error=1;
    start transaction;
    
    select count(*) into n from borrow where borrow_id=bor_id and rtime is null;
    if n > 0 then
		select book_id into bid from borrow where borrow_id=bor_id;
		select count(*) into num from reservation where book_id=bid;
		if num > 0 then
			update borrow set rtime=now() where borrow_id=bor_id;
			update book set state=1 where book_id=bid;
            update reservation set deadline=now() where book_id=bid;
            select reservation_id into resid from reservation where book_id=bid;
            insert into reservation_arrived (reservation_id) values (resid);
		else
			update borrow set rtime=now() where borrow_id=bor_id;
			update book set state=0 where book_id=bid;
		end if;
	end if;
    
    if t_error=1 then
		rollback;
	else
		commit;
	end if;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table book
-- ----------------------------
DROP TRIGGER IF EXISTS `book_AFTER_DELETE`;
delimiter ;;
CREATE TRIGGER `book_AFTER_DELETE` AFTER DELETE ON `book` FOR EACH ROW BEGIN
	UPDATE booklist SET number=number-1 WHERE ISBN=old.ISBN;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
