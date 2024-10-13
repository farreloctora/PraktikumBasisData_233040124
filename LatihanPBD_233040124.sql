/*
1. Menggunakan Tabel HR.Employees, tulis pernyataan SELECT yang mengembalikan gender untuk setiap 
karyawan berdasarkan titel kesopanan. Berupa 'Ms.' dan 'Mrs.’ untuk ‘female’, ‘Mr.’ unruk ‘Male’
dan dalam semua kasus lain (misalnya, 'Dr.') mengembalikan 'Unknown’:
*/
SELECT empid, firstname, lastname, titleofcourtesy,
	CASE
		WHEN titleofcourtesy IN ('Ms.', 'Mrs.') THEN 'Female'
		WHEN titleofcourtesy = 'Mr.' THEN 'Male'
        ELSE 'Unknown'
    END AS gender
FROM HR.Employees;

/*
2. munculkan pelanggan AS, dan untuk setiap pelanggan kembalikan jumlah total pesanan dan jumlah total:
table yang digunakan: Sales.Customers, Sales.Orders, and Sales.OrderDetails
*/

SELECT C.custid, COUNT(DISTINCT O.orderid) AS numorders, SUM(OD.qty) AS totalqty
FROM Sales.Customers C
JOIN Sales.Orders O 
	ON C.custid = O.custid
JOIN Sales.OrderDetails OD 
	ON O.orderid = OD.orderid
WHERE C.country = 'USA'
GROUP BY C.custid;

/*
3. Jelaskan apa yang salah dalam kueri berikut, dan berikan alternatif yang benar:
SELECT Customers.custid, Customers.companyname, Orders.orderid, Orders.orderdate 
FROM Sales.Customers AS C   
INNER JOIN Sales.Orders AS O     
ON Customers.custid = Orders.custid;
*/

/*
Setelah memberikan alias C untuk tabel Customers dan O untuk tabel Orders, alias tersebut harus digunakan di semua bagian kueri, bukan nama tabel aslinya.
Berikut adalah perbaikan dari kueri tersebut:
*/

SELECT C.custid, C.companyname, O.orderid, O.orderdate 
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O 
ON C.custid = O.custid;

/*
4. Munculkan pelanggan dan pesanan mereka, termasuk pelanggan yang tidak melakukan pemesanan:
*/
SELECT C.custid, 
       C.companyname, 
       O.orderid, 
       O.orderdate
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O 
    ON C.custid = O.custid
ORDER BY orderdate;

/*
5. Tulis kueri yang mengembalikan semua pesanan yang dilakukan pada hari terakhir aktivitas yang dapat ditemukan di tabel Orders:
table yang digunakan: Sales.Orders
*/

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = (SELECT MAX(orderdate) FROM Sales.Orders)
ORDER BY orderid DESC;

/*
6. Tulis kueri yang mengembalikan karyawan yang tidak melakukan pemesanan pada atau setelah 1 Mei 2016:
table yang digunakan: HR.Employees and Sales.Orders
*/

SELECT E.empid, E.firstname, E.lastname
FROM HR.Employees AS E
LEFT JOIN Sales.Orders AS O
    ON E.empid = O.empid AND O.orderdate >= '2016-05-01'
WHERE O.orderid IS NULL
ORDER BY empid;