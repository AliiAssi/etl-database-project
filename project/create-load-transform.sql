CREATE DATABASE db;
USE db;
-- Create dataset table
CREATE TABLE dataset (
  cid INT(11) DEFAULT NULL,
  cname VARCHAR(255) DEFAULT NULL,
  City VARCHAR(255) DEFAULT NULL,
  oid INT(11) DEFAULT NULL,
  odate DATE DEFAULT NULL,
  onum INT(11) DEFAULT NULL,
  otamt DECIMAL(10,2) DEFAULT NULL,
  pid INT(11) DEFAULT NULL,
  pname VARCHAR(255) DEFAULT NULL,
  puprice DECIMAL(10,2) DEFAULT NULL,
  pqty INT(11) DEFAULT NULL,
  supid INT(11) DEFAULT NULL,
  campname VARCHAR(255) DEFAULT NULL,
  campctact VARCHAR(255) DEFAULT NULL,
  campphone VARCHAR(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Load data into dataset table
LOAD DATA INFILE 'C:/Users/Hp/Desktop/chaza_jana/dataset.csv'
INTO TABLE dataset
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '\"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(cid, cname, City, oid, @odate, onum, otamt, pid, pname, puprice, pqty, supid, campname, campctact, campphone)
SET odate = STR_TO_DATE(@odate, '%m/%d/%Y');

-- Create customer table
CREATE TABLE IF NOT EXISTS customer (
    CID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CNAME VARCHAR(255) NOT NULL,
    CITY VARCHAR(255) NOT NULL
);

-- Create supplier table
CREATE TABLE IF NOT EXISTS supplier (
    SUPID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CAMPNAME VARCHAR(255) NOT NULL,
    CAMPCONTACT VARCHAR(255) NOT NULL,
    CAMPPHONE VARCHAR(20) NOT NULL
);

-- Create product table
CREATE TABLE IF NOT EXISTS product (
    PID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    PNAME VARCHAR(255) NOT NULL,
    PPRICE DECIMAL(10, 2) NOT NULL, 
    SUPID INT NOT NULL,
    FOREIGN KEY (SUPID) REFERENCES supplier(SUPID)
);

-- Create order table
CREATE TABLE IF NOT EXISTS `order` (
    OID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CID INT NOT NULL,
    ODATE DATE NOT NULL,
    ONUM INT NOT NULL,
    OTAMT DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CID) REFERENCES customer(CID)
);

-- Create order_item table
CREATE TABLE IF NOT EXISTS order_item (
    OI_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    OID INT NOT NULL,
    PID INT NOT NULL,
    PPRICE DECIMAL(10, 2) NOT NULL,
    PQTY INT NOT NULL,
    FOREIGN KEY (OID) REFERENCES `order`(OID),
    FOREIGN KEY (PID) REFERENCES product(PID)
);

-- Load data from dataset table into customer table
INSERT INTO customer (CID, CNAME, CITY)
SELECT cid, cname, City 
FROM dataset
GROUP BY cid;

-- Load data from dataset table into supplier table
INSERT INTO supplier (SUPID, CAMPNAME, CAMPCONTACT, CAMPPHONE) 
SELECT supid, campname, campctact, campphone
FROM dataset
GROUP BY supid;

-- Load data from dataset table into product table
INSERT INTO product (PID, PNAME, PPRICE, SUPID)
SELECT pid, pname, puprice, supid
FROM dataset
GROUP BY pid;

-- Load data from dataset table into order table
INSERT INTO `order` (OID, CID, ODATE, ONUM, OTAMT)
SELECT oid, cid, odate, onum, otamt
FROM dataset
GROUP BY oid;

-- Load data from dataset table into order_item table
INSERT INTO order_item (OID, PID, PPRICE, PQTY)
SELECT oid, pid, puprice, pqty
FROM dataset;
