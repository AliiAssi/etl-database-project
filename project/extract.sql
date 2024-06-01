-- use the database
USE db;
-- Select and export data
SELECT  c.CID AS customer_id,
        c.CNAME AS customer_name,
        c.CITY AS customer_city,
        o.OID AS order_id,
        o.ODATE AS order_date,
        o.ONUM AS order_number,
        o.OTAMT AS order_amount,
        o_i.PID AS product_id,
        p.PNAME AS product_name,
        o_i.PPRICE AS product_price,
        o_i.PQTY AS product_qty,
        s.SUPID AS supplier_id,
        s.CAMPNAME AS supplier_name,
        s.CAMPCONTACT AS supplier_contact,
        s.CAMPPHONE AS supplier_phone
FROM    `customer` c
JOIN    `order` o ON c.CID = o.CID
JOIN    `order_item` o_i ON o.OID = o_i.OID
JOIN    `product` p ON o_i.PID = p.PID
JOIN    `supplier` s ON p.SUPID = s.SUPID
ORDER BY c.CID ASC
INTO OUTFILE 'C:\\Users\\Hp\\Desktop\\chaza_jana\\data_extracted.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';




