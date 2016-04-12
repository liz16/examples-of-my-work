purge recyclebin;


--
-- DROP THIRD LAYER TABLES
--
DROP TABLE BILL;
DROP TABLE SIM_CARD;
DROP TABLE PHONE_STOCK;


--
-- DROP SECOND LAYER TABLES
--
DROP TABLE PHONE_DESCRIPTION;
DROP TABLE MOBILE_ACCOUNT CASCADE CONSTRAINTS;
DROP SEQUENCE ACCSEQ;
DROP TABLE PHONE_STATUS CASCADE CONSTRAINTS;

 


--
-- DROP FIRST LAYER TABLES
--
DROP TABLE PHONECUSTOMER;
DROP SEQUENCE PCUSTSEQ;
DROP TABLE PHONESUPPLIER;
DROP SEQUENCE PSUPPSEQ;
DROP TABLE STORES;
DROP SEQUENCE STORESEQ;

DROP TABLE TYPEOFUSAGE;
--
-- CREATE FIRST LAYER OF TABLES 
--
CREATE TABLE PhoneCustomer /*TABLE 1. Created by ELIZABETH GOVAN*/
(
      Customer_Id          NUMBER(7)    PRIMARY KEY,
      Customer_Name        VARCHAR(20)  NOT NULL,
      Customer_Address     VARCHAR2(80),
      Customer_Email       VARCHAR(50)  UNIQUE,
      Contract_start_date  DATE DEFAULT SYSDATE,
      Bank_Sort_Code      NUMBER(6)    NOT NULL,
      Bank_Account_Number VARCHAR(20)  NOT NULL
);
CREATE SEQUENCE PCUSTSEQ START WITH 100;

CREATE TABLE PhoneSupplier (/*TABLE 2. Created by ELIZABETH GOVAN*/
      Supplier_Id        NUMBER(7)    PRIMARY KEY,
      Supplier_Name      VARCHAR2(25) not null,
      Supplier_Address   VARCHAR2(80) not null
);
CREATE SEQUENCE PSUPPSEQ START WITH 200;

/*Create table list of Stores. Table 3. created by Nataliya Kizyuk*/
CREATE TABLE STORES(
      STORE_ID           NUMBER(7)  PRIMARY KEY, 
      STORE_ADDRESS      VARCHAR(50) NOT NULL,
      STORE_PHONE_NUMBER VARCHAR(15) NOT NULL
      );
CREATE SEQUENCE STORESEQ START WITH 400;

/*Create table Type of usage. Table 4. created by Nataliya Kizyuk*/
CREATE TABLE TypeOFusage(
      Type_Of_Usage  VARCHAR(50) NOT NULL PRIMARY KEY,
      Ser_Provider   VARCHAR(20) NOT NULL,
      Call_Type      VARCHAR(20) NOT NULL,
      Cost_Per_Unit  NUMBER(5,2) NOT NULL,
      Size_Per_Unit  NUMBER(10)  NOT NULL,
      Type_Of_Unit   VARCHAR(20) NOT NULL
);
--
-- CREATE SECOND LAYER OF TABLES  that depends on the first layer
--
/*Create table Customer Bank Details. Table 5. created by Michael Kane
CREATE TABLE CUSTOMER_BANK_DETAILS(
      Customer_Id         NUMBER(7)    NOT NULL UNIQUE REFERENCES PHONECUSTOMER,
      Customer_Name       VARCHAR(20)  NOT NULL PRIMARY KEY,
      Bank_Sort_Code      NUMBER(6)    NOT NULL,
      Bank_Account_Number VARCHAR(20)  NOT NULL
);
*/
/*Create table phone Description. Table 6. created by Nataliya Kizyuk*/
CREATE TABLE Phone_Description(
      Phone_Name    VARCHAR(30) NOT NULL PRIMARY KEY,
      Phone_Brand   VARCHAR(20) NOT NULL,
      Manufacturer  VARCHAR(30) NOT NULL,
      Phone_Storage VARCHAR(30) NOT NULL,
      Phone_Cost    NUMBER(6,2) NOT NULL,
      Account_Price NUMBER(6,2) NOT NULL, 
      Supplier_Id   NUMBER(7)   NOT NULL REFERENCES PHONESUPPLIER 
);

CREATE TABLE Mobile_Account(/*TABLE 7. Created by Michael Kane*/
      Account_Number    NUMBER(8)   NOT NULL PRIMARY KEY,
      Account_Type      VARCHAR(30) NOT NULL,
      Contract_Type     VARCHAR(30) NOT NULL,
      Monthly_Charge    NUMBER(8)   NOT NULL,
      Existing_Customer CHAR(1)     NOT NULL CHECK(Existing_Customer = 'Y' or Existing_Customer = 'N'),
      Customer_Id       NUMBER(7)   NOT NULL REFERENCES PHONECUSTOMER
);
CREATE SEQUENCE ACCSEQ START WITH 80087007;

/*Create table phone Status. Table 8. created by Nataliya Kizyuk*/
CREATE TABLE PHONE_STATUS(
       Serial_Number   NUMBER(8)   NOT NULL PRIMARY KEY,
       Phone_Status    VARCHAR(20) NOT NULL CHECK(PHONE_STATUS IN('New','Upgraded','Replaced')),
       Account_Number  NUMBER(8)   NOT NULL,
       STORE_ID        NUMBER(7)   UNIQUE REFERENCES STORES
);
--
-- CREATE THIRD LAYER OF TABLES  that depends on the FIRST and SECOND layer
--
/*Create table Phone Stock. Table 9. created by Elizabeth Govan*/      
CREATE TABLE PHONE_STOCK(
      Stock_Code        VARCHAR(4)  NOT NULL,
      Phone_Storage     VARCHAR(30) NOT NULL,
      Phone_Name        VARCHAR(30) NOT NULL REFERENCES PHONE_DESCRIPTION,
      Price_Per_Unit    NUMBER(7,2) NOT NULL,
      Stock_Quantity    NUMBER(3)   NOT NULL,
      Reorder_Quantity  NUMBER(3),
      Store_Id          NUMBER(7)  REFERENCES STORES,
      Supplier_Id       NUMBER(7)  NOT NULL,
      PRIMARY KEY(PHONE_NAME, STORE_ID)
);

CREATE TABLE SIM_CARD /*Table 10. Created by Michael Kane*/
(
      Phone_Number   VARCHAR(15) NOT NULL ,
      Serial_Number  NUMBER(8)   NOT NULL REFERENCES PHONE_STATUS,
      Phone_Name     VARCHAR(30) NOT NULL ,
      Account_Number NUMBER(8)   NOT NULL REFERENCES Mobile_Account,
      PRIMARY KEY(PHONE_NAME, SERIAL_NUMBER)
);

/*Create table Bill that is referenced to table Type of usage. Table 11. Created by Nataliya Kizyuk*/
CREATE TABLE BILL(
      Account_Number       NUMBER (8)   REFERENCES Mobile_Account,
      Date_Time_Of_Usage   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
      Type_Of_Usage        VARCHAR (50) NOT NULL REFERENCES TypeOfUsage,
      Phone_No_Accessed    VARCHAR(25)  NOT NULL,
      Access_Provider      VARCHAR (20) NOT NULL,
      No_Of_Units_Used     NUMBER (5)   NOT NULL,
      Total_Cost           NUMBER(7,2)  NULL, /* Total_Cost = No_Of Units * Cost_per_unit. */
      Billing_Amount       NUMBER(7,2)  NULL,
      Start_Date           DATE DEFAULT SYSDATE,
      Renew_Date           DATE, 
      PRIMARY KEY(ACCOUNT_NUMBER,TYPE_OF_USAGE)
);
--
-- INSERT DATA INTO FIRST LAYER: PHONE_SUPPLIER, PHONE_CUSTOMER, LIST_OF_STORES, TYPEOFUSAGE.
--
/*1. Insert values into table PHONE CUSTOMER. Inserted by ELIZABETH GOVAN*/
INSERT INTO PHONECUSTOMER VALUES(PCUSTSEQ.NEXTVAL, 'Sarah White', '65 Auburn Avenue, Dublin 15',
                                         'sara.white@gmail.com', '05-JAN-2016', 129835,'3458 9876 1432 7638');
INSERT INTO PHONECUSTOMER VALUES(PCUSTSEQ.NEXTVAL, 'Connor Carr', '33 Laurel Lodge, Dublin 15',
                                         'connorCarr@gmail.com', '17-JAN-2016', 809129,'4583 8769 4321 6387');
INSERT INTO PHONECUSTOMER VALUES(PCUSTSEQ.NEXTVAL, 'John Black', '16 Park Drive, Dublin 15',
                                         'johnblack@gmail.com', '13-FEB-2014', 398350,'5834 7698 3214 3876');                                         
INSERT INTO PHONECUSTOMER VALUES(PCUSTSEQ.NEXTVAL, 'Joanna Cerise', '28 Deer Park, Dublin 15',
                                         'joanna.cerise.white@gmail.com', '09-MAY-2015', 149836,'8345 6987 2143 8763');
INSERT INTO PHONECUSTOMER VALUES(PCUSTSEQ.NEXTVAL, 'Nicole Doyle', '3 St.marks, Dublin 22',
                                         'NicoleDoyle@gmail.com', '05-JUN-2016', 629535,'2458 5876 9432 1638');
INSERT INTO PHONECUSTOMER VALUES(PCUSTSEQ.NEXTVAL, 'Franc Blank', '24 Kevin Street, Dublin 8',
                                         'francBlank@gmail.com', '19-SEP-2014', 227835,'3476 9876 1494 7652');
INSERT INTO PHONECUSTOMER VALUES(PCUSTSEQ.NEXTVAL, 'Mary White', '49 Summer Set, Dublin 8',
                                         'marywhite@gmail.com', '24-FEB-2016', 189274,'4459 7612 3211 3808');
INSERT INTO PHONECUSTOMER VALUES(PCUSTSEQ.NEXTVAL, 'Michael Caine', '53 Black Hourse Avenue, Dublin 20',
                                         'Michael.Cane@gmail.com', '30-OCT-2013', 429753,'1313 4546 8765 2763');
                                         
/*2. Insert values into table PHONE SUPPLIER. Inserted by ELIZABETH GOVAN*/
INSERT INTO PHONESUPPLIER VALUES(PSUPPSEQ.NEXTVAL, 'Apple', 'Hollyhill Industrial Estate. Hollyhill, Cork, Ireland');
INSERT INTO PHONESUPPLIER VALUES(PSUPPSEQ.NEXTVAL, 'Samsung','The Grange Offices. Stillorgan Road Blackrock, Dublin, Ireland');
INSERT INTO PHONESUPPLIER VALUES(PSUPPSEQ.NEXTVAL, 'HTC', 'Unit 2 Fonthill Industrial Estate. Clondalkin, Dublin 22, Ireland');
INSERT INTO PHONESUPPLIER VALUES(PSUPPSEQ.NEXTVAL, 'Nokia', '1B Beech Hill Office. Clonskeagh, Dublin 4, Ireland');
INSERT INTO PHONESUPPLIER VALUES(PSUPPSEQ.NEXTVAL, 'Sony', '4-6 Riverwalk Citywest, Dublin 24, ireland');
INSERT INTO PHONESUPPLIER VALUES(PSUPPSEQ.NEXTVAL, 'Huawei', '1 Custom House Quay. 4 Harbour Master Place,Dublin, Ireland');

/*3. Insert values into table LIST OF STORES. Inserted by Nataliya Kizyuk*/ 
INSERT INTO STORES VALUES(STORESEQ.NEXTVAL,'Liffey Valley Shopping Centre 20 Fonthill Road','(01) 652 6608');
INSERT INTO STORES VALUES(STORESEQ.NEXTVAL,'Donaghmede Shopping Centre Unit 11 Level 2','(01) 823 8734');
INSERT INTO STORES VALUES(STORESEQ.NEXTVAL,'Dun Laoghaire 75 George Street Lower','(01) 623 8743');
INSERT INTO STORES VALUES(STORESEQ.NEXTVAL,'Liffey Valley Shopping Centre Unit 40a','(01) 683 8098');
INSERT INTO STORES VALUES(STORESEQ.NEXTVAL,'43 Grafton Street Dublin 2','(01) 671 8239');
INSERT INTO STORES VALUES(STORESEQ.NEXTVAL,'Dundrum Town Centre Unit 14a Level 3','(01) 664 3530');
INSERT INTO STORES VALUES(STORESEQ.NEXTVAL,'Santry Swords Rd 25','(01) 670 5577');
INSERT INTO STORES VALUES(STORESEQ.NEXTVAL,'Blanchardstown Shopping Centre Level 1','(01) 616 7407');

/*4.Insert values into table Type of usage. Inserted by Nataliya Kizyuk*/      
INSERT INTO TYPEOFUSAGE VALUES ('Local Text Message','MyPhone','Local',0.05,50,' Characters ');
INSERT INTO TYPEOFUSAGE VALUES ('Overseas Text Message','MyPhone','Overseas',0.10,50,' Characters ');
INSERT INTO TYPEOFUSAGE VALUES ('International Text Message','MyPhone','Local',1.00,50,' Characters ');
INSERT INTO TYPEOFUSAGE VALUES ('Local Phone Call','MyPhone','International',0.20,1,' Minutes ');
INSERT INTO TYPEOFUSAGE VALUES ('Overseas Phone Call','MyPhone','Overseas',0.40,1,' Minutes ');
INSERT INTO TYPEOFUSAGE VALUES ('International Phone Call','MyPhone','International',1.50,1,' Minutes ');
INSERT INTO TYPEOFUSAGE VALUES ('Local Data Usage','MyPhone','Inside Country',0.50,1,' Days');
INSERT INTO TYPEOFUSAGE VALUES ('International Data Usage','MyPhone','Outside Country',2.50,1,' Days'); 
--
-- INSERT DATA INTO SECOND LAYER: CUSTOMER_BANK_DETAILS, MOBILE_ACCOUNT, PHONE_STATUS, PHONE_DESCRIPTION.
--

/*5.insert values into table Customer Bank Details. Inserted by Michael Kane
INSERT INTO CUSTOMER_BANK_DETAILS VALUES(100,'Sarah White',  129835,'3458 9876 1432 7638');
INSERT INTO CUSTOMER_BANK_DETAILS VALUES(101,'Connor Carr',  809129,'4583 8769 4321 6387');
INSERT INTO CUSTOMER_BANK_DETAILS VALUES(102,'John Black',   398350,'5834 7698 3214 3876');
INSERT INTO CUSTOMER_BANK_DETAILS VALUES(103,'Joanna Cerise',149836,'8345 6987 2143 8763');
INSERT INTO CUSTOMER_BANK_DETAILS VALUES(104,'Nicole Doyle', 629535,'2458 5876 9432 1638');
INSERT INTO CUSTOMER_BANK_DETAILS VALUES(105,'Franc Blank',  227835,'3476 9876 1494 7652');
INSERT INTO CUSTOMER_BANK_DETAILS VALUES(106,'Mary White',   189274,'4459 7612 3211 3808');
INSERT INTO CUSTOMER_BANK_DETAILS VALUES(107,'Michael Caine',429753,'1313 4546 8765 2763');
*/
/*6. Insert values into table PHONE DESCRIPTION. Inserted by Michael Kane*/ 
INSERT INTO Phone_Description VALUES('Galaxy S6', 'Samsung', '32GB', 'Samsung Galaxy S6', 559, 48,201);
INSERT INTO Phone_Description VALUES('Iphone 6', 'APPLE', '16GB', 'Iphone 6', 669, 52,200);
INSERT INTO Phone_Description VALUES('Iphone 6S', 'APPLE', '16GB', 'Iphone 6S', 699, 80,200);
INSERT INTO Phone_Description VALUES('One AG', 'HTC', '16GB', 'HTC one AG', 529, 55,202);
INSERT INTO Phone_Description VALUES('Galaxy Grand Prime', 'Samsung', '34GB', 'Samsung Galaxy Grand Prime', 129, 24,201);
INSERT INTO Phone_Description VALUES('Galaxy Core Prime', 'Samsung', '16GB', 'Samsung Galaxy Core Prime', 99, 21,201);
INSERT INTO Phone_Description VALUES('M4 Aqua', 'Sony', '8GB', 'Sony M4Aqua', 199, 25,204);
INSERT INTO Phone_Description VALUES('Lumia 635', 'Nokia', '16GB', 'Nokia Lumia 635', 69, 35,203);

/*7. Insert values into table MOBILE ACCOUNT. Inserted by Michael Kane*/ 
INSERT INTO Mobile_Account VALUES(ACCSEQ.NEXTVAL, 'Business', 'Online', 85.00, 'N',100);
INSERT INTO Mobile_Account VALUES(ACCSEQ.NEXTVAL, 'Personal', 'Retail', 60.00 ,'N',101);
INSERT INTO Mobile_Account VALUES(ACCSEQ.NEXTVAL, 'Business', 'Online', 85.00, 'Y',102);
INSERT INTO Mobile_Account VALUES(ACCSEQ.NEXTVAL, 'Personal', 'Retail', 60.00 ,'Y',103);
INSERT INTO Mobile_Account VALUES(ACCSEQ.NEXTVAL, 'Business', 'Online', 95.00, 'N',104);
INSERT INTO Mobile_Account VALUES(ACCSEQ.NEXTVAL, 'Personal', 'Retail', 65.00 ,'Y',105);
INSERT INTO Mobile_Account VALUES(ACCSEQ.NEXTVAL, 'Business', 'Online', 70.00, 'N',106);
INSERT INTO Mobile_Account VALUES(ACCSEQ.NEXTVAL, 'Personal', 'Retail', 45.00 ,'Y',107);

/*8. Insert values into table PHONE STATUS. Inserted by Elizabeth Govan */ 
INSERT INTO PHONE_STATUS VALUES(70078,'Replaced', 80087007,400);
INSERT INTO PHONE_STATUS VALUES(70079,'New', 80087008,401);
INSERT INTO PHONE_STATUS VALUES(70080,'Upgraded', 80087009,402);
INSERT INTO PHONE_STATUS VALUES(70081,'Replaced', 80087010,403);
INSERT INTO PHONE_STATUS VALUES(70082,'New', 80087011,404);
INSERT INTO PHONE_STATUS VALUES(70083,'Upgraded', 80087012,405);
INSERT INTO PHONE_STATUS VALUES(70084,'New', 80087013,406);
INSERT INTO PHONE_STATUS VALUES(70085,'New', 80087014,407);
--
-- INSERT DATA INTO THIRD LAYER: PHONE_STOCK, PHONE_NUMBER, BILL.
--  
/*9. Insert values into table PHONE STOCK. Inserted by NATALIYA KIZYUK */ 
INSERT INTO PHONE_STOCK VALUES('IP60', '16GB', 'Iphone 6', 499.99 ,18, 2, 400, 200);
INSERT INTO PHONE_STOCK VALUES('SGS6', '32GB', 'Galaxy S6',459.99 ,18, 2,401, 201);
INSERT INTO PHONE_STOCK VALUES('IP6S', '16GB', 'Iphone 6S',499.99 ,18, 2, 402, 200);
INSERT INTO PHONE_STOCK VALUES('HTC1', '16GB', 'One AG',   329.99 ,10, 0, 403, 202);
INSERT INTO PHONE_STOCK VALUES('SGGP', '34GB', 'Galaxy Grand Prime',69.99 ,20, 0,404, 201);
INSERT INTO PHONE_STOCK VALUES('SGCP', '16GB', 'Galaxy Core Prime',59.99 ,20, 0, 405, 201);
INSERT INTO PHONE_STOCK VALUES('SM4A', '8GB',  'M4 Aqua',  99.99 ,9, 1, 406, 204);
INSERT INTO PHONE_STOCK VALUES('NLUM', '16GB', 'Lumia 635',49.99 ,9, 1,407, 203);

/*10. Insert values into table Phone Number. Inserted by Michael Kane */ 
INSERT INTO SIM_CARD VALUES('(087) 1331067', 70078, 'iPhone 6',  80087007);
INSERT INTO SIM_CARD VALUES('(087) 1331075', 70079, 'Iphone 6S', 80087008);
INSERT INTO SIM_CARD VALUES('(087) 1331087', 70080, 'Galaxy S6', 80087009);
INSERT INTO SIM_CARD VALUES('(087) 1331095', 70081, 'iPhone 6',  80087010);
INSERT INTO SIM_CARD VALUES('(087) 1331117', 70082, 'iPhone 6S', 80087011);
INSERT INTO SIM_CARD VALUES('(087) 1331125', 70083, 'Galaxy S6', 80087012);
INSERT INTO SIM_CARD VALUES('(087) 1331137', 70084, 'M4 Aqua',   80087013);
INSERT INTO SIM_CARD VALUES('(087) 1331145', 70085, 'Lumia 635', 80087014);

/*11. Insert values into table BILL. Inserted by Nataliya Kizyuk*/       
INSERT INTO BILL(ACCOUNT_NUMBER,TYPE_OF_USAGE, PHONE_NO_ACCESSED, ACCESS_PROVIDER, NO_OF_UNITS_USED)
       VALUES (80087007,'Local Text Message',   '(085)135 5057', ' MyPhone', 20);
INSERT INTO BILL(ACCOUNT_NUMBER,TYPE_OF_USAGE,PHONE_NO_ACCESSED,ACCESS_PROVIDER,NO_OF_UNITS_USED) 
       VALUES (80087007,'Overseas Text Message','(086)195 5453', ' Tree', 20);
INSERT INTO BILL(ACCOUNT_NUMBER,TYPE_OF_USAGE,PHONE_NO_ACCESSED,ACCESS_PROVIDER,NO_OF_UNITS_USED) 
       VALUES (80087007,'International Text Message','(0035)096 513 5051', ' KievStar', 5);
INSERT INTO BILL(ACCOUNT_NUMBER,TYPE_OF_USAGE,PHONE_NO_ACCESSED,ACCESS_PROVIDER,NO_OF_UNITS_USED) 
       VALUES (80087007,'Local Phone Call','(085)135 5057', ' MyPhone', 30);
INSERT INTO BILL(ACCOUNT_NUMBER,TYPE_OF_USAGE,PHONE_NO_ACCESSED,ACCESS_PROVIDER,NO_OF_UNITS_USED) 
       VALUES (80087007,'Overseas Phone Call','(086)195 5453', ' Tree', 20);
INSERT INTO BILL(ACCOUNT_NUMBER,TYPE_OF_USAGE,PHONE_NO_ACCESSED,ACCESS_PROVIDER,NO_OF_UNITS_USED) 
       VALUES (80087007,'International Phone Call','(0035)096 513 5051',' KievStar',10);
INSERT INTO BILL(ACCOUNT_NUMBER,TYPE_OF_USAGE,PHONE_NO_ACCESSED,ACCESS_PROVIDER,NO_OF_UNITS_USED) 
       VALUES (80087007,'Local Data Usage','(085)146 7386', ' MyPhone', 40);
INSERT INTO BILL(ACCOUNT_NUMBER,TYPE_OF_USAGE,PHONE_NO_ACCESSED,ACCESS_PROVIDER,NO_OF_UNITS_USED) 
       VALUES (80087007,'International Data Usage','(085)146 7386', ' MyPhone', 2);
       
/* To insert the BILL RENEW DATE  that is = BILL START DATE + 60; Nataliya Kizyuk*/
UPDATE BILL
      SET BILL.RENEW_DATE = START_DATE + 60
      WHERE START_DATE = BILL.START_DATE;

/* To calculate Total Cost: BILL.Total_Cost =BILL. No_Of Units * TypeOfUsage.Cost_per_unit. Nataliya Kizyuk*/
UPDATE BILL
      SET BILL.TOTAL_COST = NO_OF_UNITS_USED*(SELECT COST_PER_UNIT FROM TYPEOFUSAGE 
      WHERE TYPE_OF_USAGE = BILL.TYPE_OF_USAGE);
      
/* To calculate Billing Amount: BILL.Billing_Amount = SUM OF Total_Cost + Rental_charge. Prepared by nataliya Kizyuk */       
UPDATE BILL
      SET BILL.BILLING_AMOUNT =(SELECT SUM(TOTAL_COST)FROM BILL
      WHERE TOTAL_COST = BILL.TOTAL_COST) +
                              (SELECT Monthly_Charge FROM Mobile_Account
      WHERE ACCOUNT_NUMBER = 80087007);

commit;
PURGE RECYCLEBIN;

SELECT * FROM BILL JOIN TYPEOFUSAGE USING (TYPE_OF_USAGE); /*to display data from both tables. Prepared by nataliya Kizyuk */

/*QUERY TO DISPLAY BILL FOR THE CUSTOMER. Prepared by nataliya Kizyuk */
SELECT TYPE_OF_USAGE,PHONE_NO_ACCESSED, ACCESS_PROVIDER, NO_OF_UNITS_USED,
       TO_CHAR(TYPEOFUSAGE.COST_PER_UNIT,'U9,999.99') AS COST_PER_UNIT,
       TO_CHAR(TOTAL_COST,'U9,999.99') AS TOTAL_COST,
       TO_CHAR(BILLING_AMOUNT,'U9,999.99') AS BILLING_AMOUNT, RENEW_DATE
       FROM BILL JOIN TYPEOFUSAGE USING (TYPE_OF_USAGE);

SELECT * FROM BILL;
SELECT * FROM SIM_CARD;
SELECT * FROM SIM_CARD JOIN PHONE_STATUS USING(SERIAL_NUMBER);
SELECT * FROM SIM_CARD JOIN MOBILE_ACCOUNT USING(ACCOUNT_NUMBER);

SELECT * FROM PHONECUSTOMER;
/*SELECT * FROM CUSTOMER_BANK_DETAILS JOIN PHONECUSTOMER USING(CUSTOMER_ID);
*/

SELECT * FROM MOBILE_ACCOUNT;
SELECT * FROM MOBILE_ACCOUNT JOIN PHONECUSTOMER USING(CUSTOMER_ID);
SELECT * FROM MOBILE_ACCOUNT JOIN SIM_CARD USING(ACCOUNT_NUMBER);

SELECT * FROM PHONE_STOCK;
SELECT * FROM PHONE_STOCK JOIN STORES USING(STORE_ID);
SELECT * FROM PHONE_STOCK JOIN PHONE_DESCRIPTION USING(PHONE_NAME);

SELECT * FROM PHONECUSTOMER;
SELECT * FROM PHONECUSTOMER JOIN MOBILE_ACCOUNT USING(CUSTOMER_ID);

SELECT * FROM PHONESUPPLIER;
SELECT * FROM PHONESUPPLIER JOIN PHONE_DESCRIPTION USING(SUPPLIER_ID) ;


SELECT * FROM STORES;
SELECT * FROM STORES JOIN PHONE_STATUS USING(STORE_ID);
SELECT * FROM STORES JOIN PHONE_STOCK USING(STORE_ID);


SELECT * FROM PHONE_DESCRIPTION;
SELECT * FROM PHONE_DESCRIPTION JOIN PHONESUPPLIER USING(SUPPLIER_ID);
SELECT * FROM PHONE_DESCRIPTION JOIN PHONE_STOCK USING(PHONE_NAME);

SELECT * FROM TYPEOFUSAGE;
SELECT * FROM TYPEOFUSAGE JOIN BILL  USING (TYPE_OF_USAGE);      