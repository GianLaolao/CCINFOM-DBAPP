
CREATE DATABASE  IF NOT EXISTS `duesDB`;
USE duesDB;

-- Homeowner

CREATE TABLE homeowner (
	homeownerid 	INT(4),
	lastname		VARCHAR(45),
    firstname		VARCHAR(45),
    primary key (homeownerid)
);

-- Homeowner Monthly Dues
 
CREATE TABLE monthlydue (
    homeownerid		INT(4),
	year			INT(4),
    month			INT(2),
    ongoing_balance DECIMAL(9,2),
	monthly_due		DECIMAL(9,2),
    due_date		DATE,
    status			ENUM('PAID', 'UNPAID'),
	primary key (homeownerid, year, month),
    foreign key (homeownerid) REFERENCES
		homeowner (homeownerid)
);

-- Paying Monthly Due Transaction

CREATE TABLE paying_due (
	paymentid		INT(4),
    homeownerid		INT(4),
    monthlydue_year	INT(4),
    monthlydue_month	INT(2),
    amountpaid		DECIMAL(9,2),
    amount_change	DECIMAL(9,2),
    payment_date	DATE,
    primary key (paymentid),
	foreign key (homeownerid, monthlydue_year, monthlydue_month) REFERENCES 
		monthlydue (homeownerid, year, month)
);

	
CREATE TABLE ref_street (
	street			VARCHAR(45),
	primary key (street)
);


CREATE TABLE house (
	houseid			INT(4),
    houseno			INT(3),
    street			VARCHAR(45),
    homeownerid		INT(4),
    primary key (houseid),
    foreign key (homeownerid) REFERENCES
		homeowner (homeownerid),
	foreign key (street) REFERENCES
		ref_street (street),
	unique (houseno)
);
            
CREATE TABLE tenant (
	tenantid		INT(4),
    houseid			INT(4),
    lastname		VARCHAR(45),
    firstname		VARCHAR(45),
    primary key (tenantid),
	foreign key (houseid) REFERENCES
		house (houseid)
);
	
CREATE TABLE parkingspace (
	parkingspaceno		INT(2),
    street				VARCHAR(45),
    status				ENUM('Occupied','Available'),
    rent_price			DECIMAL(6,2),
    primary key (parkingspaceno, street),
    foreign key (street)  REFERENCES
		ref_street (street)
);
        
CREATE TABLE renting_parkingspace (
	rentid			INT(4),
    parkingspaceno	INT(2),
    street			VARCHAR(45),
    rentdate		DATE,
    primary key (rentid),
    foreign key (parkingspaceno, street) REFERENCES
		parkingspace (parkingspaceno, street)
);
        
CREATE TABLE ho_parkspace (
	rentid			INT(4),
    homeownerid		INT(4),
    primary key (rentid, homeownerid),
    foreign key (rentid) REFERENCES
		renting_parkingspace (rentid),
	foreign key (homeownerid) REFERENCES
		homeowner (homeownerid)
);

CREATE TABLE tenant_parkspace (
	rentid			INT(4),
    tenantid		INT(4),
    primary key (rentid, tenantid),
    foreign key (rentid) REFERENCES
		renting_parkingspace (rentid),
	foreign key (tenantid) REFERENCES
		tenant (tenantid)
);




INSERT INTO homeowner(homeownerid, lastname, firstname)
	VALUES 	(1001, 'Wayne', 'Bruce'),
			(1002, 'Kent', 'Clark'),
			(1003,'Rogers', 'Steve'),
            (1004, 'Stark', 'Tony'),
            (1005, 'Richards', 'Reed'),
            (1006, 'Banner', 'Bruce'),
            (1007, 'Musk', 'Elon');

INSERT INTO monthlydue (homeownerid, year, month, ongoing_balance, monthly_due, due_date, status) 
	VALUES (1001, 2022, 10, 0.00, 1150.00, '2022-11-23', 'PAID'),
		   (1002, 2022, 10, 0.00, 1000.00, '2022-11-23', 'PAID'),
		   (1001, 2023, 10, 0.00, 1000.00, '2023-11-23', 'PAID'),
		   (1002, 2023, 10, 1000.00, 1000.00, '2023-11-23', 'UNPAID'),
           (1003, 2023, 10, 0.00, 1000.00, '2023-11-23', 'PAID'),
		   (1003, 2023, 11, 1450.00, 1450.00, '2023-12-20', 'UNPAID'),
           (1004, 2023, 11, 1000.00, 1000.00, '2023-12-20', 'UNPAID');

INSERT INTO paying_due(paymentid, homeownerid, monthlydue_year, monthlydue_month, amountpaid, amount_change, payment_date)
	VALUES	(5001, 1001, 2022, 10, 1150.00, 0.00, '2022-10-25'),
			(5002, 1002, 2022, 10, 1000.00, 0.00, '2022-11-11'),
			(5003, 1001, 2023, 10, 1000.00, 0.00, '2023-10-25'),
			(5004, 1003, 2023, 10, 500.00, 0.00, '2023-11-06'),
            (5005, 1003, 2023, 10, 500.00, 0.00, '2023-11-10');

INSERT INTO ref_street (street) 
	VALUES 	('1st Street'),
			('2nd Street'),
			('New York Street'),
            ('Park Street'),
            ('Industrial Street');

INSERT INTO	house(houseid, houseno, street, homeownerid)
	VALUES	(2001, 101, '1st Street', 1001),
			(2002, 201, '2nd Street', 1002),
            (2003, 301, 'New York Street', 1003),
            (2004, 401, 'Park Street', 1004),
            (2005, 501, 'Industrial Street', 1004),
            (2006, 102, '1st Street', 1005),
            (2007, 402, 'Park Street', 1006),
            (2008, 202, '2nd Street', 1007),
            (2009, 302, 'New York Street', 1007),
            (2010, 502, 'Industrial Street', 1005);

INSERT INTO tenant(tenantid, lastname, firstname, houseid)
	VALUES	(3001,'Parker', 'Peter', 2004),
			(3002,'Grayson','Dick',2002),
            (3003, 'Morales', 'Miles', 2004),
            (3004, 'Lang', 'Scott', 2001),
            (3005, 'Chavez', 'America', 2005),
            (3006, 'Barnes', 'Bucky', 2003);
            
INSERT INTO parkingspace(parkingspaceno, street, status, rent_price)
	VALUES	(1, 'Park Street', 'Occupied', 250.00),
			(2, 'Park Street', 'Occupied', 200.00),
            (3, 'Park Street', 'Available', 250.00),
			(1, 'Industrial Street', 'Available', 150.00),
            (2, 'Industrial Street', 'Occupied', 150.00),
            (3, 'Industrial Street', 'Available', 200.00),
            (1, 'New York Street', 'Occupied', 200.00),
            (2, 'New York Street', 'Available', 200.00);
        
INSERT INTO renting_parkingspace (rentid, parkingspaceno, street, rentdate)
	VALUES	(4001, 2, 'Industrial Street', '2022-09-05'),
			(4002, 1, 'Park Street', '2023-10-10'),
			(4003, 2, 'Park Street', '2023-10-12'),
			(4004, 2, 'Industrial Street', '2023-11-05'),
            (4005, 1, 'New York Street', '2023-11-10'),
            (4006, 2, 'Industrial Street', '2023-11-12');
					
INSERT INTO ho_parkspace (rentid, homeownerid)
	VALUES (4001, 1001),
		   (4002, 1003),
		   (4004, 1001),
           (4006, 1002);
		
        
INSERT INTO tenant_parkspace (rentid, tenantid)
	VALUES (4003, 3002),
		   (4005, 3006);
    