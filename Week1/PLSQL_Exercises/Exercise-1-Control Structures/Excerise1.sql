-- Customer table
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    Age NUMBER,
    Balance NUMBER,
    IsVIP VARCHAR2(5)
);

--inserting data into customers
INSERT INTO Customers VALUES (101, 'Rahul', 65, 15000, 'FALSE');
INSERT INTO Customers VALUES (102, 'Anita', 45, 8000, 'FALSE');
INSERT INTO Customers VALUES (103, 'Kumar', 70, 20000, 'FALSE');
INSERT INTO Customers VALUES (104, 'Priya', 35, 12000, 'FALSE');
INSERT INTO Customers VALUES (105, 'Arun', 62, 9500, 'FALSE');
COMMIT;

-- loans table
CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    InterestRate NUMBER,
    DueDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

--inserting data into loans
INSERT INTO Loans VALUES (201, 101, 8, DATE '2026-07-10');
INSERT INTO Loans VALUES (202, 102, 10, DATE '2026-07-05');
INSERT INTO Loans VALUES (203, 103, 9, DATE '2026-07-20');
INSERT INTO Loans VALUES (204, 104, 11, DATE '2026-08-15');
INSERT INTO Loans VALUES (205, 105, 7, DATE '2026-07-02');
COMMIT;

--scenario 1
DECLARE
   CURSOR customer_cursor IS
      SELECT c.CustomerID, c.Age
      FROM Customers c;

BEGIN
   FOR cust IN customer_cursor LOOP
      IF cust.Age > 60 THEN
         UPDATE Loans
         SET InterestRate = InterestRate - 1
         WHERE CustomerID = cust.CustomerID;
      END IF;
   END LOOP;

   COMMIT;
END;
/

--scenario 2
BEGIN
   FOR cust IN (SELECT CustomerID, Balance FROM Customers) LOOP
   
      IF cust.Balance > 10000 THEN
         UPDATE Customers
         SET IsVIP = 'TRUE'
         WHERE CustomerID = cust.CustomerID;
      END IF;

   END LOOP;

   COMMIT;
END;
/

--scenatio 3
BEGIN
   FOR loan_rec IN (
      SELECT CustomerID, DueDate
      FROM Loans
      WHERE DueDate BETWEEN SYSDATE AND SYSDATE + 30
   ) LOOP

      DBMS_OUTPUT.PUT_LINE(
         'Reminder: Customer ID ' || loan_rec.CustomerID ||
         ' has loan due on ' || loan_rec.DueDate
      );

   END LOOP;
END;
/