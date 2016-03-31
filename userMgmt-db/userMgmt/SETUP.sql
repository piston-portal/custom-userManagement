/* DROP DATABASE IF EXISTS `userMgmt`; */
CREATE DATABASE IF NOT EXISTS `userMgmt`;
USE `userMgmt`;

/* users */
CREATE TABLE USER (
  ID 				VARCHAR(40) 	NOT NULL,
  UID 				VARCHAR(100) 	NOT NULL,
  PASSWORD			VARCHAR(100) 	NOT NULL,
  FIRST_NAME 		VARCHAR(100) 	NOT NULL,
  LAST_NAME 		VARCHAR(100),
  EMAIL	 			VARCHAR(100),
  PRIMARY KEY (ID),
  CONSTRAINT UNIQUE_EMAIL UNIQUE KEY (EMAIL)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- SET @portalAdminUserId := '3ca1a75a-d98b-42c7-8dd4-8176b25d317e';
INSERT INTO USER (ID, UID, PASSWORD, FIRST_NAME, LAST_NAME, EMAIL) 
VALUES
	('portalAdmin', 'portalAdmin', 'portalAdmin', 'Portal', 'Admin', 'pistonAdmin@koyad.in'),
	('piston', 'piston', 'piston', 'Piston', NULL, 'piston@koyad.in'),
	('tomcat', 'tomcat', 'tomcat', 'Tomcat', NULL, 'tomcat@koyad.in');
	
/* groups */	
CREATE TABLE GROUPS (
  ID 		VARCHAR(40) 	NOT NULL,
  NAME 		VARCHAR(100) 	NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- SET @portalAdminsGroupId := '1bc0dd7c-4a2b-429c-914e-51db75a73001';
INSERT INTO GROUPS (ID, NAME) 
VALUES ('portalAdmins', 'Portal Admins');

/* users and groups mappings */	
CREATE TABLE USER_GROUP (
  USER_ID 		VARCHAR(100) 	NOT NULL,
  GROUP_ID 		VARCHAR(100)	NOT NULL,
  PRIMARY KEY (USER_ID, GROUP_ID),
  CONSTRAINT FOREIGN_USER_ID FOREIGN KEY (USER_ID) REFERENCES USER (ID) ON DELETE CASCADE,
  CONSTRAINT FOREIGN_GROUP_ID FOREIGN KEY (GROUP_ID) REFERENCES GROUPS (ID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO USER_GROUP (USER_ID, GROUP_ID) 
VALUES
	('portalAdmin', 'portalAdmins');

/* roles */
CREATE TABLE ROLE (
  ID 		VARCHAR(40) 	NOT NULL,
  NAME 		VARCHAR(100) 	NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ROLE (ID, NAME) 
VALUES
	(UUID(), 'manager-gui'),
	(UUID(), 'manager-jmx');

/* user role mappings */
CREATE TABLE USER_ROLE (
  UID 			VARCHAR(100) 	NOT NULL,
  ROLE_NAME 	VARCHAR(100)	NOT NULL,
  PRIMARY KEY (UID, ROLE_NAME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO USER_ROLE (UID, ROLE_NAME) 
VALUES
	('tomcat', 'manager-gui'),
	('tomcat', 'manager-jmx');
