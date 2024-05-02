--Task 1:
--Creating Datbase for Courier Management
CREATE DATABASE Courier

USE  Courier
--Creating Table for Users
CREATE TABLE Users(
UserId INT PRIMARY KEY,
Name VARCHAR(255),
Email VARCHAR(255) UNIQUE,
Password VARCHAR(255),
ContactNumber VARCHAR(20),
ADDRESS TEXT
)
SELECT * FROM Users

--Creating Table for Courier
CREATE TABLE Courier(
CourierID INT PRIMARY KEY,
SenderName VARCHAR(255),
SenderAddress TEXT,
ReceiverName VARCHAR(255),
ReceiverAddress TEXT,
Weight DECIMAL(5, 2),
Status VARCHAR(50),
TrackingNumber VARCHAR(20) UNIQUE,
DeliveryDate DATE,
EmployeeID int,
LocationID int,
UserID int, FOREIGN KEY (UserID) REFERENCES Users(UserID),
ServiceID int, FOREIGN KEY (ServiceID) REFERENCES courierservices(ServiceID),
) 

--Creating Table for CourierServices
CREATE TABLE CourierServices(
ServiceID INT PRIMARY KEY,
ServiceName VARCHAR(100),
Cost DECIMAL(8, 2))

-- Creating  EmployeeTable
CREATE TABLE EmployeeTable(
EmployeeID INT PRIMARY KEY,
Name VARCHAR(255),
Email VARCHAR(255) UNIQUE,
ContactNumber VARCHAR(20),
Role VARCHAR(50),
Salary DECIMAL(10, 2))

--Creating OrderTable
CREATE TABLE OrderTable (
OrderID INT PRIMARY KEY,
CustomerName VARCHAR(255),
CustomerAddress TEXT,
ItemDescription TEXT,
CourierID INT,
OrderDate DATE,
CONSTRAINT fk_Courier_Order FOREIGN KEY (CourierID) REFERENCES Courier(CourierID)
)



--Creating LocationTable
CREATE TABLE LocationTable(
LocationID INT PRIMARY KEY,
LocationName VARCHAR(100),
Address VARCHAR(60))



--Creating PaymentTable
CREATE TABLE PaymentTable(
PaymentID INT PRIMARY KEY,
CourierID INT,
LocationId INT,
Amount DECIMAL(10, 2),
PaymentDate DATE,
FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
FOREIGN KEY (LocationID) REFERENCES LocationTable(LocationId)
)

-- INSERTING VALUES INTO USERS TABLE
INSERT INTO Users values(1953,'Mohan Kumar','mohan@gmail.com','mhm45th',9100000000,'123,Main city')
INSERT INTO Users values(1954,'Babu Dev','babu@gmail.com','bdb45g',8900000000,'111,blue city')
INSERT INTO Users values(1955,'Usha Sandra','ushas@gmail.com','ushsa43fd',9123000000,'356,Epic city')
INSERT INTO Users values(1956,'Varsha Kala','varsha@gmail.com','vrsdg5jh',9674000000,'563, Moon city')
INSERT INTO Users values(1957,'Kamal Nandan','kamal@gmail.com','lmk6hd',9176000000,'878, Park city')
SELECT * FROM Users

--INSERTING VALUES INTO COURIER TABLE
INSERT INTO Courier values(301,'Mohan Kumar','123,Main city','Asha Steve','91, Cherry St, Ciy-1',6.90,'Delivered','AB015','2024-03-18',75,18,1953,5),
(302,'Babu Dev','111,blue city','Meena Kumari','67, Lamp St, City-89',8.15,'Undelivered','GP987','2024-02-06',76,19,1954,6),
(303,'Usha Sandra','356,Epic city','Ved Vinay','34, Patrol St, New City',7.43,'In-Transit','DF675','2024-03-10',77,20,1955,7),
(304,'Jacob Sean','123,Main city','John Mathew','87, Lakeview St, City-9',5.98,'Delivered','HG543','2024-03-08',78,21,1956,8),
(305,'Kamal Nandan','878, Park city','Siara Glen','8, Cev St, City-8',4.67,'Undelivered','YT412','2024-02-18',79,22,1957,9)
SELECT * FROM Courier

--INSERTING VALUES INTO COURIERSERVICES
INSERT INTO CourierServices values(5,'Parcel Services',750)
INSERT INTO CourierServices values(6,'Same-Day Delivery',1500)
INSERT INTO CourierServices values(7,'International Shipping',2500)
INSERT INTO CourierServices values(8,'On-Demand Delivery',1800)
INSERT INTO CourierServices values(9,'Express Delivery',1900)

SELECT * FROM CourierServices

--INSERTING VALUES INTO Employee Table
INSERT INTO EmployeeTable values(75,'Tom Barkley','tombark@gmail.com',7645000000,'Manager',55000)
INSERT INTO EmployeeTable values(76,'John Ralph','jeanralph@gmail.com',9642000000,'HR',49000)
INSERT INTO EmployeeTable values(77,'Gina Besten','gina123@gmail.com',9213000000,'Sales Executive',35000)
INSERT INTO EmployeeTable values(78,'Nathan Sid','nathansid@gmail.com',9876000000,'Customer Support',30000)
INSERT INTO EmployeeTable values(79,'Batty Pal','bpo43@gmail.com',8653000000,'Sales Executive',35000)

SELECT * FROM EmployeeTable

--Inserting Values Into Order Table
Insert into OrderTable (OrderID, CustomerName, CustomerAddress, ItemDescription, CourierID, OrderDate)
 values
 (1, 'Mohan Kumar', '123,Main city', 'Electronics', 301, '2024-01-16'),
 (2, 'Babu Dev', '111,blue city', 'Toys', 302, '2024-01-10'),
 (3, 'Usha Sandra', '356,Epic city', 'Books', 303, '2024-01-16'),
 (4, 'Jacob Sean', '123,Main city', 'Electronics', 304, '2024-01-12'),
 (5, 'Kamal Nandan','878, Park city', 'Clothes', 305, '2024-01-10')
 SELECT * FROM OrderTable

--INSERTING VALUES INTO LOCATIONTABLE
INSERT INTO LocationTable values(18,'Company 1','321, Super City')
INSERT INTO LocationTable values(19,'Store A','65, Fathom St, City-98')
INSERT INTO LocationTable values(20,'Company XYZ','53, Purple St, City-0')
INSERT INTO LocationTable values(21,'Warehouse','52, C-Zone, KCity')
INSERT INTO LocationTable values(22,'Store B','21, D-Block,City-9')

SELECT * FROM LocationTable

-- INSERTING VALUES INTO PAYMENT TABLE
INSERT INTO PaymentTable values(55,301,19,2500,'2024-03-18'),
                              (56,302,18,1800,'2024-02-10'),
                              (57,303,20,750,'2024-03-08'),
                              (58,304,19,1900,'2024-03-21'),
                              (59,305,18,1800,'2024-03-30')

SELECT * FROM PaymentTable


--Task 2:
--1. List all customers: 

SELECT * FROM Users

--2. List all orders for a specific customer: 

SELECT * FROM OrderTable WHERE CustomerName = 'Kamal Nandan'

SELECT * FROM OrderTable

--3. List all couriers: 

SELECT * FROM Courier

--4. List all packages for a specific order: 

SELECT * FROM OrderTable WHERE CourierID = 303

--5. List all deliveries for a specific courier:

SELECT *from Courier WHERE CourierId =303

--6. List all undelivered packages: 

SELECT * FROM Courier WHERE Status = 'Undelivered'

--7. List all packages that are scheduled for delivery today:

SELECT * FROM CourierServices WHERE ServiceName = 'Same-day delivery'

--8. List all packages with a specific status: 

SELECT * FROM Courier WHERE Status = 'Delivered'

--10. Find the average delivery time for each courier

select c.CourierID, AVG(datediff(DAY,c.DeliveryDate, o.OrderDate)) as AvgDeliveryTime
from Courier as c
join OrderTable as o 
ON
c.CourierID = o.CourierID
group by c.CourierID


--11. List all packages with a specific weight range: 

SELECT * FROM Courier WHERE Weight BETWEEN 1 AND 7

-- 12. Retrieve employees whose names contain 'John':

SELECT * FROM EmployeeTable WHERE NAME LIKE '%John%'

--13.Retrieve all courier records with payments greater than $50. 

SELECT * FROM PaymentTable WHERE Amount > 50.00




--TASK 3:
--14. Find the total number of couriers handled by each employee:

SELECT
e.EmployeeID,
e.Name AS EmployeeName,
COUNT(c.CourierID) AS TotalCouriers
FROM EmployeeTable e
LEFT JOIN Courier c 
ON 
e.EmployeeID = c.EmployeeId
GROUP BY e.EmployeeID, e.Name 

SELECT * FROM EmployeeTable
SELECT * FROM Courier

--15. Calculate the total revenue generated by each location:

SELECT
l.LocationID, 
l.LocationName, 
SUM(p.Amount) as TotalRevenueGenerated
FROM LocationTable as l
LEFT JOIN PaymentTable as p
ON 
l.LocationID = p.LocationID
GROUP BY l.LocationID, l.LocationName

SELECT * FROM PaymentTable
SELECT * FROM LocationTable

--16. Find the total number of couriers delivered to each location: 

SELECT
l.LocationID, l.LocationName, 
COUNT(c.CourierID) as TotalCouriersDelivered
FROM LocationTable as l
LEFT JOIN Courier as c
ON 
l.LocationID = c.LocationID
GROUP BY l.LocationID, l.LocationName

SELECT * FROM Courier

--17. Find the courier with the highest average delivery time: 

SELECT TOP 1
c.CourierID,
AVG(DATEDIFF(DAY, c.DeliveryDate, p.PaymentDate)) AS AverageDeliveryTime
FROM Courier c
JOIN PaymentTable p 
ON 
c.CourierID = p.CourierID
GROUP BY c.CourierID
ORDER BY AverageDeliveryTime DESC


--18. Find Locations with Total Payments Less Than a Certain Amount 

SELECT
l.LocationID, l.LocationName, SUM(p.Amount) as TotalPayment
FROM Locationtable as l
JOIN PaymentTable as p
ON 
l.LocationID = p.LocationID
GROUP BY l.LocationID, l.LocationName
HAVING sum(p.Amount) < 1000

--19. Calculate Total Payments per Location 

SELECT
l.LocationID, l.LocationName, SUM(p.Amount) as TotalPayments
FROM LocationTable as l
JOIN PaymentTable as p
ON 
l.LocationID = p.LocationID
GROUP BY l.LocationID, l.LocationName

--20. Retrieve couriers who have received payments totaling more than $1000 in a specific location(LocationID = X): 

SELECT
c.CourierID,c.SenderName,c.SenderAddress,c.ReceiverName,c.ReceiverAddress,c.Weight,c.Status,c.TrackingNumber,c.DeliveryDate,p.TotalPayments
FROM Courier c
JOIN (
    SELECT CourierID, SUM(Amount) AS TotalPayments
    FROM PaymentTable
    WHERE LocationID = 19 
    GROUP BY CourierID
    HAVING SUM(Amount) > 1000
) p ON 
c.CourierID = p.CourierID

--21. Retrieve couriers who have received payments totaling more than $1000 after a certain date(PaymentDate > 'YYYY-MM-DD'): 


SELECT
c.CourierID,c.SenderName,c.SenderAddress,c.ReceiverName,c.ReceiverAddress,c.Weight,c.Status,c.TrackingNumber,c.DeliveryDate,p.TotalPayments
FROM Courier c
JOIN 
(
    SELECT CourierID, SUM(Amount) AS TotalPayments
    FROM PaymentTable
    WHERE PaymentDate > '2023-03-18' 
    GROUP BY CourierID
    HAVING SUM(Amount) > 1000
) p ON c.CourierID = p.CourierID

--22. Retrieve locations where the total amount received is more than $5000 before a certain date(PaymentDate < 'YYYY-MM-DD') :

SELECT c.CourierID,c.SenderName,c.SenderAddress,c.ReceiverName,c.ReceiverAddress,c.Weight,c.Status,c.TrackingNumber,c.DeliveryDate,p.TotalPayments
FROM Courier c
JOIN 
(
    SELECT CourierID,SUM(Amount) AS TotalPayments
    FROM PaymentTable
    WHERE PaymentDate < '2023-03-18' 
    GROUP BY CourierID
    HAVING SUM(Amount) > 5000
) p ON c.CourierID = p.CourierID

--Task 4: Inner Join,Full Outer Join, Cross Join, Left Outer Join,Right Outer Join 

--23. Retrieve Payments with Courier Information 
SELECT p.PaymentID,c.CourierID,c.SenderName,c.SenderAddress,c.ReceiverName,c.ReceiverAddress,c.Weight,c.Status,c.TrackingNumber,c.DeliveryDate,p.Amount,p.PaymentDate
FROM paymenttable as p
JOIN Courier AS c
ON p.CourierID = c.CourierID


--24. Retrieve Payments with Location Information 

SELECT * FROM PAYMENTTABLE

SELECT l.locationID,p.courierid,l.locationName,l.address,p.amount,p.paymentdate
FROM locationtable as l
JOIN paymenttable as p
ON  l.LocationID = p.LocationID
    
--25. Retrieve Payments with Courier and Location Information 

SELECT p.paymentid,p.courierid,l.locationid,l.locationname,c.sendername,c.senderaddress,c.receivername,c.receiveraddress,c.weight,c.status,c.trackingnumber,c.deliverydate,l.address,p.amount,p.paymentdate
FROM paymenttable as p
JOIN courier as c
ON 
p.courierid = c.courierid
JOIN locationtable as l
ON 
c.locationid = l.locationid

--26. List all payments with courier details 

SELECT c.courierid,p.paymentid,c.sendername,c.senderaddress,c.receivername,c.receiveraddress,c.weight,c.status,c.trackingnumber,c.deliverydate,c.locationid,p.amount,p.paymentdate
FROM paymenttable as p
JOIN courier as c
ON 
p.courierid = c.courierid;

--27. Total payments received for each courier

SELECT c.CourierID,c.SenderName,
c.Weight,c.Status,c.TrackingNumber,c.DeliveryDate,
SUM(p.Amount) AS TotalPaymentsReceived
FROM 
    Courier c
JOIN 
    PaymentTable p ON c.CourierID = p.CourierID
GROUP BY c.CourierID,c.SenderName,
c.Weight,c.Status,c.TrackingNumber,c.DeliveryDate

--28. List payments made on a specific date 


SELECT p.paymentid,p.courierid,p.locationid,c.sendername,c.senderaddress,c.receivername,c.receiveraddress,c.weight,c.status,c.trackingnumber,c.deliverydate,p.amount,p.paymentdate
FROM paymenttable as p
JOIN courier as c 
ON 
p.courierid = c.courierid
WHERE p.paymentdate = '2024-03-30'

--29. Get Courier Information for Each Payment 

SELECT p.paymentid,p.courierid,p.locationid,c.sendername,c.senderaddress,c.receivername,c.receiveraddress,c.weight,c.status,c.trackingnumber,c.deliverydate,p.amount,p.paymentdate
FROM paymenttable as p
JOIN courier as c 
ON 
p.courierid = c.courierid

--30. Get Payment Details with Location 

SELECT p.paymentid,p.courierid,l.locationid,l.locationname,l.address,c.sendername,c.senderaddress,c.receivername,c.receiveraddress,p.amount,p.paymentdate
FROM paymenttable as p
JOIN courier as c 
ON 
p.courierid = c.courierid
JOIN locationtable as l
ON 
c.locationid = l.locationid
ORDER BY p.paymentid asc


--31. Calculating Total Payments for Each Courier:

SELECT c.CourierID,c.SenderName,
c.Weight,c.Status,c.TrackingNumber,
c.DeliveryDate,SUM(pt.Amount) AS TotalPaymentsReceived
FROM 
    Courier c
LEFT JOIN 
    PaymentTable pt ON c.CourierID = pt.CourierID
GROUP BY c.CourierID,c.SenderName,
c.Weight,c.Status,c.TrackingNumber,c.DeliveryDate

--32. List Payments Within a Date Range

SELECT p.paymentid,p.courierid,c.sendername,c.receivername,p.amount,p.paymentdate
FROM paymenttable as p
JOIN courier as c
ON p.courierid = c.courierid
WHERE p.paymentdate BETWEEN '2024-01-11' AND '2024-03-16'


--33. Retrieve a list of all users and their corresponding courier records, including cases where there are no matches on either side:

SELECT u.UserId,u.Name,u.Email,c.CourierID,c.SenderName,u.Address,c.ReceiverName,c.ReceiverAddress,c.Status,u.Password,u.ContactNumber
FROM Users AS u
LEFT JOIN Courier AS c 
ON 
u.UserId = c.EmployeeID

--34. Retrieve a list of all couriers and their corresponding services, including cases where there are no matches on either side:


select * from Courier c
 full outer join CourierServices cs
 on c.ServiceID=cs.ServiceID

--35. Retrieve a list of all employees and their corresponding payments, including cases where there are no matches on either side:


 select e.Name,c.CourierID,sum(p.Amount)as CorrespondPayments from EmployeeTable e
 full outer join Courier c
 on c.EmployeeID = e.EmployeeID
 full outer join PaymentTable p
 on p.CourierID=c.CourierID
 Group by e.Name,c.CourierID

--36. List all users and all courier services, showing all possible combinations:

SELECT u.userid,u.name,u.email,c.serviceid,c.servicename,c.cost
FROM users as u
CROSS JOIN courierservices as c

--37. List all employees and all locations, showing all possible combinations: 

SELECT e.employeeid,e.name,e.email,e.role,l.locationid,l.locationname,l.address
FROM employeetable as e
CROSS JOIN locationtable as l

--38. Retrieve a list of couriers and their corresponding sender information (if available) 

SELECT c.courierid,c.userid,c.sendername,c.senderaddress,u.email as senderemail,u.password as senderpassword,u.contactnumber as sendercontactnumber,c.status
FROM courier as c
LEFT JOIN users as u
ON 
c.userid = u.userid

--39. Retrieve a list of couriers and their corresponding receiver information (if available):

SELECT c.courierid,c.userid as receiverid,c.receivername,c.receiveraddress
FROM courier as c
LEFT JOIN users as u
ON 
c.receivername = u.name

--40. Retrieve a list of couriers along with the courier service details (if available): 

SELECT c.courierid,c.userid,s.serviceid,c.sendername,c.deliverydate,s.servicename,s.cost,c.status
FROM courier as c
LEFT JOIN courierservices as s
ON 
c.serviceid = s.serviceid	

--41. Retrieve a list of employees and the number of couriers assigned to each employee: 

SELECT e.EmployeeID, e.Name AS EmployeeName,COUNT(c.CourierID) AS NumCouriersAssigned
FROM EmployeeTable e
LEFT JOIN Courier c 
ON 
e.EmployeeID = c.EmployeeID
GROUP BY e.EmployeeID,e.Name

--42. Retrieve a list of locations and the total payment amount received at each location: 

SELECT l.LocationID,l.LocationName,l.Address,SUM(p.Amount) AS TotalPaymentAmount
FROM LocationTable AS l
LEFT JOIN PaymentTable AS p ON l.LocationID = p.LocationId
GROUP BY l.LocationID,l.LocationName,l.Address

--43. Retrieve all couriers sent by the same sender (based on SenderName):

SELECT c.courierid,c.sendername,u.email as senderemail,u.contactnumber as sendercontactnumber,u.address as senderaddress,c.status,c.trackingnumber,c.deliverydate
FROM courier as c
LEFT JOIN users as u
ON 
c.userid = u.userid
WHERE c.sendername = 'Mohan Kumar'


--44. List all employees who share the same role:

SELECT * FROM employeetable WHERE Role = 'HR'


--45. Retrieve all payments made for couriers sent from the same location:

 select c.CourierID,p.* from Courier c
join PaymentTable p
on 
c.CourierID=p.CourierID
where p.LocationID=19

--46. Retrieve all couriers sent from the same location (based on SenderAddress):

 select * from Courier c
where c.SenderAddress Like '%Main City'

SELECT * FROM Courier

--47. List employees and the number of couriers they have delivered: 

SELECT e.EmployeeID,e.Name,
COUNT(c.CourierID) AS NumberOfCouriersDelivered,e.Role
FROM EmployeeTable AS e
LEFT JOIN Courier AS c 
ON 
e.EmployeeID = c.EmployeeID
GROUP BY e.EmployeeID, e.Name, e.Role

--48. Find couriers that were paid an amount greater than the cost of their respective courier services:

SELECT c.courierid,c.userid,c.serviceid,c.sendername,c.senderaddress,p.amount as paidamount,s.cost as couriercost,
c.weight,c.status,c.trackingnumber,c.deliverydate
FROM courier c
JOIN paymenttable p 
on 
c.courierid = p.courierid
JOIN courierservices s 
on 
c.serviceid = s.serviceid
WHERE p.amount > s.cost


--Scope: Inner Queries, Non Equi Joins, Equi joins,Exist,Any,All 

--49. Find couriers that have a weight greater than the average weight of all couriers:

select * from Courier c
where c.weight>
(select avg(weight) from Courier)

--50. Find the names of all employees who have a salary greater than the average salary: 

 select e.Name from EmployeeTable e
 where e.Salary>
 (select avg(e.Salary) from EmployeeTable e)

--51. Find the total cost of all courier services where the cost is less than the maximum cost:

select sum(c.cost) from CourierServices c 
where c.cost <ANY
(select c.cost from CourierServices c)

--52. Find all couriers that have been paid for:

select * from Courier c
where c.CourierID not in
(select c.CourierID from Courier c where c.EmployeeID is Null)

--53. Find the locations where the maximum payment amount was made:

SELECT TOP(1)p.LocationID,sum(p.Amount) AS MaximumPayment FROM PaymentTable p
GROUP BY LocationID
ORDER BY sum(p.Amount) desc

--54. Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender(e.g., 'SenderName'): 

SELECT * FROM Courier c
WHERE c.WEIGHT>ALL
(SELECT sum(WEIGHT) FROM Courier c
WHERE c.SenderName='Usha Sandra'
GROUP BY c.SenderName)

		  
