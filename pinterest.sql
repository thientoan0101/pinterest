create database if not exists `pinterest`;

use `pinterest`;


/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `userId` int(11) NOT NULL auto_increment,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL, 
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Insert*/

insert into user (username, email, password) values 
('Toan', 'toan@vng.com', 'toan123'),
('Tan', 'tan@vng.com', 'tan123'),
('Truong', 'truong@vng.com', 'truong123'),
('Thanh', 'thanh@vng.com', 'thanh123'),
('Nhu', 'nhu@vng.com', 'nhu123');


/*Table structure for table `board` */

DROP TABLE IF EXISTS `board`;

CREATE TABLE `board` (
  `boardId` int(11) NOT NULL auto_increment,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `isActive` boolean NOT NULL,
  `isPublic` boolean NOT NULL,
  `userOwnerId` int(11) NOT NULL,
  PRIMARY KEY (`boardId`),
  CONSTRAINT `board_fk_owner` FOREIGN KEY (`userOwnerId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


insert into board (title, description, isActive, isPublic, userOwnerId) values
('tech', 'board for tech', true, true, 1),
('history', 'board for history', true, true, 2),
('vng', 'board for vng', true, true, 3);


/*Table structure for table `pin` */

DROP TABLE IF EXISTS `pin`;

CREATE TABLE `pin` (
  `pinId` int(11) NOT NULL auto_increment,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `imageUrl` varchar(2048) NOT NULL,
  `isActive` boolean NOT NULL,
  `userOwnerId` int(11) NOT NULL,
  `boardId` int(11) NOT NULL,
  PRIMARY KEY (`pinId`),
  CONSTRAINT `pin_fk_owner` FOREIGN KEY (`userOwnerId`) REFERENCES `user` (`userId`),
  CONSTRAINT `pin_fk_board` FOREIGN KEY (`boardId`) REFERENCES `board` (`boardId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


insert into pin (title, description, imageUrl, isActive, userOwnerId, boardId) values
('tech1', 'pin 1 for tech', 'url://pin1', true, 1, 1),
('history1', 'pin 1 for history', 'url://histo1', true, 2, 2),
('vng1', 'pin 1 for vng', 'url://histo1', true, 3, 3),
('vng2', 'pin 2 for vng', 'url://histo1', true, 3, 3);


/*Table structure for table `saved_pin` */

DROP TABLE IF EXISTS `saved_pin`;

CREATE TABLE `saved_pin` (
  `pinId` int(11) NOT NULL,
  `userSavedId` int(11) NOT NULL,
  `boardId` int(11) NOT NULL,
  PRIMARY KEY (`pinId`, `userSavedId`, `boardId`),
  CONSTRAINT `spin_fk_owner` FOREIGN KEY (`userSavedId`) REFERENCES `user` (`userId`),
  CONSTRAINT `spin_fk_board` FOREIGN KEY (`boardId`) REFERENCES `board` (`boardId`),
  CONSTRAINT `spin_fk_pin` FOREIGN KEY (`pinId`) REFERENCES `pin` (`pinId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*Table structure for table `board_contributor` */

DROP TABLE IF EXISTS `board_contributor`;

CREATE TABLE `board_contributor` (
  `boardId` int(11) NOT NULL,
  `contributorId` int(11) NOT NULL,
  PRIMARY KEY (`boardId`, `contributorId`),
  CONSTRAINT `contributor_fk_board` FOREIGN KEY (`boardId`) REFERENCES `board` (`boardId`),
  CONSTRAINT `contributor_fk_user` FOREIGN KEY (`contributorId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert into board_contributor (boardId, contributorId) values
(1,2),
(2,3),
(3,4);

/*Table structure for table `follow` */

DROP TABLE IF EXISTS `follow`;

CREATE TABLE `follow` (
  `followerId` int(11) NOT NULL,
  `followedId` int(11) NOT NULL,
  PRIMARY KEY (`followerId`, `followedId`),
  CONSTRAINT `follow_fk_follower` FOREIGN KEY (`followerId`) REFERENCES `user` (`userId`),
  CONSTRAINT `follow_fk_followed` FOREIGN KEY (`followedId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert into follow (followerId, followedId) values
(1,2),
(2,3),
(3,4);


/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `commentId` int(11) NOT NULL auto_increment,
  `userId` int(11) NOT NULL,
  `pinId` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `content` text NOT NULL,
  `parentCommentId` int(11),
  PRIMARY KEY (`commentId`),
  CONSTRAINT `comment_fk_userid` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`),
  CONSTRAINT `comment_fk_pinid` FOREIGN KEY (`pinId`) REFERENCES `pin` (`pinId`),
  CONSTRAINT `comment_fk_parent` FOREIGN KEY (`parentCommentId`) REFERENCES `comment` (`commentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert into comment (userId, pinId, time, content, parentCommentId) values
(1,2, '2022-06-22 23:32:00', 'content for comment 1', null),
(2,2, '2022-06-22 23:33:00', 'reply for comment 1', 1),
(3,1, '2022-06-22 23:34:00', 'content for comment 3', null);



DROP TABLE IF EXISTS `react`;

CREATE TABLE `react` (
  `commentId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`commentId`, `userId`),
  CONSTRAINT `react_fk_userid` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`),
  CONSTRAINT `react_fk_commentid` FOREIGN KEY (`commentId`) REFERENCES `comment` (`commentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert into react (commentId, userId, time, type) values
(1,2, '2022-06-22 23:33:00', 'love'),
(2,2, '2022-06-22 23:34:00', 'like'),
(3,1, '2022-06-22 23:35:00', 'like');
