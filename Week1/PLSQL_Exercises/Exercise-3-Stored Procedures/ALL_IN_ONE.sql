--Accounts table creation
CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(50),
    AccountType VARCHAR2(20),
    Balance NUMBER
);
INSERT INTO Accounts VALUES (101, 'Rahul', 'Savings', 10000);
INSERT INTO Accounts VALUES (102, 'Anita', 'Savings', 20000);
INSERT INTO Accounts VALUES (103, 'Kumar', 'Current', 15000);
INSERT INTO Accounts VALUES (104, 'Priya', 'Savings', 30000);
COMMIT;

select * from Accounts;

--Employees table creation
CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    EmployeeName VARCHAR2(50),
    Department VARCHAR2(30),
    Salary NUMBER
);
INSERT INTO Employees VALUES (1, 'John', 'IT', 50000);
INSERT INTO Employees VALUES (2, 'Sara', 'HR', 40000);
INSERT INTO Employees VALUES (3, 'David', 'IT', 60000);
COMMIT;

select * from Employees;

--scenario 1
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
AS
BEGIN
   UPDATE Accounts
   SET Balance = Balance + (Balance * 0.01)
   WHERE AccountType = 'Savings';

   COMMIT;
END;
/

EXEC ProcessMonthlyInterest;

select * from Accounts;

--scenario 2
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    dept_name IN VARCHAR2,
    bonus_percent IN NUMBER
)
AS
BEGIN
   UPDATE Employees
   SET Salary = Salary + (Salary * bonus_percent / 100)
   WHERE Department = dept_name;

   COMMIT;
END;
/

EXEC UpdateEmployeeBonus('IT', 10);

SELECT * FROM Employees;

--sceanrio 3
CREATE OR REPLACE PROCEDURE TransferFunds(
    source_acc IN NUMBER,
    target_acc IN NUMBER,
    amount IN NUMBER
)
AS
    source_balance NUMBER;
BEGIN
    SELECT Balance INTO source_balance
    FROM Accounts
    WHERE AccountID = source_acc;
    IF source_balance >= amount THEN
        UPDATE Accounts
        SET Balance = Balance - amount
        WHERE AccountID = source_acc;
        UPDATE Accounts
        SET Balance = Balance + amount
        WHERE AccountID = target_acc;
        COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient Balance');
    END IF;
END;
/
EXEC TransferFunds(101, 102, 5000);
SELECT * FROM Accounts;


