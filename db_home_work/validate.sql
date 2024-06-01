USE databaseproject;

SELECT 
`customer`.cId,
`customer`.cName,
`customer`.cCity,
`order`.oId,
`order`.`oDate`,
`order`.`oNum`,
`order`.`oTamt`,
`orderitem`.`pId`,
`product`.`pName`,
`orderitem`.`pPrice`,
`orderitem`.`pQty`,
`supplier`.`supId`,
`supplier`.`campName`,
`supplier`.`campContact`,
`supplier`.`campPhone`
FROM 
`customer` , `order` , `orderitem` , `supplier`, `product`
WHERE 
`customer`.`cId` = `order`.`cId`
AND 
`order`.`oId` = `orderitem`.`oId`
AND 
`product`.`pId` = `orderitem`.`pId`
AND 
`supplier`.`supId` = `product`.`supId`
ORDER BY  `customer`.`cId`
INTO OUTFILE 'C:/Users/Hp/Desktop/db_home_work/validated_data.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';