USE HR_Data;
SELECT * FROM Salary_HR_Data;

-- IDENTIFYING AND SOLVING MISSING VALUE PROPLEM
SELECT * FROM Salary_HR_Data
WHERE EmployeeID IS NULL OR BaseSalary IS NULL OR OvertimePay IS NULL OR Deductions IS NULL OR GrossSalary IS NULL OR NetSalary IS NULL


WITH EMP_ID_MISSING_VALUES AS (
                               SELECT EmployeeID FROM Salary_HR_Data
							   WHERE EmployeeID IS NULL
							   ) 
							   DELETE FROM EMP_ID_MISSING_VALUES

SELECT * FROM Salary_HR_Data  
WHERE    Deductions is NULL AND BaseSalary IS NOT NULL AND  OvertimePay IS NOT NULL  AND NetSalary IS NOT NULL

UPDATE Salary_HR_Data        -- SOLVED BaseSalary null values
SET BaseSalary = (NetSalary + Deductions) - OvertimePay   
WHERE BaseSalary IS NULL AND OvertimePay IS  NULL AND  Deductions IS NOT NULL

UPDATE Salary_HR_Data        -- SOLVED OvertimePay null values
SET OvertimePay = (NetSalary + Deductions ) -  BaseSalary
WHERE OvertimePay IS  NULL AND  BaseSalary IS NOT NULL AND  Deductions IS NOT NULL

UPDATE Salary_HR_Data        -- SOLVED Deductions null values XXXX
SET Deductions = (BaseSalary + OvertimePay) - NetSalary
WHERE Deductions is NULL AND BaseSalary IS NOT NULL AND  OvertimePay IS NOT NULL  AND NetSalary IS NOT NULL

UPDATE Salary_HR_Data        -- SOLVED GrossSalary null values
SET GrossSalary = (BaseSalary + OvertimePay) 
WHERE GrossSalary is NULL 

UPDATE Salary_HR_Data        -- SOLVED NetSalary null values
SET NetSalary = (BaseSalary + OvertimePay) - Deductions
WHERE NetSalary is NULL 

---------------------------------------------------------------------------------------------------------
-- SOLVING DUPLICATE PROBLEMS  IN THE ID COLUMN

SELECT EmployeeID , COUNT(1) FROM Salary_HR_Data
GROUP BY EmployeeID
HAVING COUNT(1)>1;

WITH Duplicate_ID_solve AS (
                               SELECT EmployeeID,
										ROW_NUMBER() OVER(PARTITION BY EmployeeID ORDER BY EmployeeID ) as RANKK
								FROM Salary_HR_Data
							)
							DELETE FROM Duplicate_ID_solve
							WHERE RANKK > 1;

---------------------------------------------------------------------------------------------------------------------------
-- CHANGING DATA TYPES INTO THE CORRECT FORMAT

EXEC sp_help Salary_HR_Data

ALTER TABLE Salary_HR_Data
ALTER COLUMN EmployeeID INT

UPDATE Salary_HR_Data 
SET NetSalary =ROUND(NetSalary,2)

WITH MINUS AS (
               SELECT Deductions FROM Salary_HR_Data
			   WHERE Deductions LIKE '-%'
			   )UPDATE MINUS
			    SET Deductions = ABS(Deductions)

-- CONVERT THE EmployyID Table in it's right format

ALTER TABLE Salary_HR_Data 
ALTER COLUMN EmployeeID Varchar(10)

UPDATE Salary_HR_Data
SET EmployeeID = 'E' + RIGHT('000' + CAST(EmployeeID AS VARCHAR(3)), 3);


SELECT * FROM Salary_HR_Data




SELECT @@SERVERNAME;