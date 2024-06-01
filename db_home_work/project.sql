CREATE DATABASE databaseproject;
USE databaseproject;
-- Create dataset table
CREATE TABLE temp (
  CID INT(11) DEFAULT NULL,
  CNAME VARCHAR(255) DEFAULT NULL,
  CITY VARCHAR(255) DEFAULT NULL,
  OID INT(11) DEFAULT NULL,
  ODATE DATE DEFAULT NULL,
  ONUM INT(11) DEFAULT NULL,
  OTAMT DECIMAL(10,2) DEFAULT NULL,
  PID INT(11) DEFAULT NULL,
  PNAME VARCHAR(255) DEFAULT NULL,
  PUPRICE DECIMAL(10,2) DEFAULT NULL,
  PQTY INT(11) DEFAULT NULL,
  SUPID INT(11) DEFAULT NULL,
  CAMPNAME VARCHAR(255) DEFAULT NULL,
  CAMPCONTACT VARCHAR(255) DEFAULT NULL,
  CAMPPHONE VARCHAR(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Load data into dataset table
LOAD DATA INFILE 'C:/Users/Hp/Desktop/db_home_work/dataset.csv'
INTO TABLE temp
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '\"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(CID, CNAME, CITY, OID, @ODATE, ONUM, OTAMT, PID, PNAME, PUPRICE, PQTY, SUPID, CAMPNAME, CAMPCONTACT, CAMPPHONE)
SET ODATE = STR_TO_DATE(@ODATE, '%m/%d/%Y');

-- Create customer table
CREATE TABLE IF NOT EXISTS `customer` (
    cId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cName VARCHAR(255) NOT NULL,
    cCity VARCHAR(255) NOT NULL
);

-- Create supplier table
CREATE TABLE IF NOT EXISTS `supplier` (
    supId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    campName VARCHAR(255) NOT NULL,
    campContact VARCHAR(255) NOT NULL,
    campPhone VARCHAR(20) NOT NULL
);

-- Create product table
CREATE TABLE IF NOT EXISTS `product` (
    pId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pName VARCHAR(255) NOT NULL,
    pPrice DECIMAL(10, 2) NOT NULL, 
    supId INT NOT NULL,
    FOREIGN KEY (supId) REFERENCES supplier(supId)
);

-- Create order table
CREATE TABLE IF NOT EXISTS `order` (
    oId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cId INT NOT NULL,
    oDate DATE NOT NULL,
    oNum INT NOT NULL,
    oTamt DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cId) REFERENCES customer(cId)
);

-- Create order_item table
CREATE TABLE IF NOT EXISTS `orderItem` (
    oId INT NOT NULL,
    pId INT NOT NULL,
    pPrice DECIMAL(10, 2) NOT NULL,
    pQty INT NOT NULL,
    PRIMARY KEY (oId,pId),
    FOREIGN KEY (OID) REFERENCES `order`(oId),
    FOREIGN KEY (PID) REFERENCES `product`(pId)
);


-- Load data from dataset table into customer table
INSERT INTO customer (cId, cName, cCity)
SELECT CID, CNAME, CITY 
FROM temp
GROUP BY CID;

-- Load data from dataset table into supplier table
INSERT INTO supplier (supId, campName, campContact, campPhone) 
SELECT SUPID, CAMPNAME, CAMPCONTACT, CAMPPHONE
FROM temp
GROUP BY SUPID;

-- Load data from dataset table into product table
INSERT INTO product (pId, pName, pPrice, supId)
SELECT PID, PNAME, PUPRICE, SUPID
FROM temp
GROUP BY PID;

-- Load data from dataset table into order table
INSERT INTO `order` (oId, cId, oDate, oNum, oTamt)
SELECT OID, CID, ODATE, ONUM, OTAMT
FROM temp
GROUP BY OID;

-- Load data from dataset table into order_item table
INSERT INTO orderItem (oId, pId, pPrice, pQty)
SELECT OID, PID, PUPRICE, PQTY
FROM temp;
