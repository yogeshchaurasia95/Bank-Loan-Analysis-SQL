
# Total Loan Applications
SELECT COUNT(id) AS Total_Loan_Application
FROM financial_loan;
 
# MTD Loan Applications
SELECT COUNT(id) AS MTD_Total_Applications 
FROM financial_loan
WHERE MONTH(str_to_date(issue_date, '%d-%m-%Y')) = 12 
AND Year(str_to_date(issue_date, '%d-%m-%Y')) = 2021;

#PMTD Loan Applications
SELECT COUNT(id) AS PMTD_Total_Application
FROM financial_loan
WHERE MONTH(str_to_date(issue_date, '%d-%m-%Y')) = 11
AND Year(str_to_date(issue_date, '%d-%m-%Y')) = 2021;

#Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM FINANCIAL_LOAN;

# MTD Total Funded Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM FINANCIAL_LOAN
WHERE MONTH(str_to_date(issue_date, '%d-%m-%Y')) = 12 
AND Year(str_to_date(issue_date, '%d-%m-%Y')) = 2021;

# PMTD Total Funded Amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM FINANCIAL_LOAN
WHERE MONTH(str_to_date(issue_date, '%d-%m-%Y')) = 11 
AND Year(str_to_date(issue_date, '%d-%m-%Y')) = 2021;

#Total Amount Received 
SELECT SUM(total_payment) AS Total_Amount_Received
FROM FINANCIAL_LOAN;

# MTD Total Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM FINANCIAL_LOAN
WHERE MONTH(str_to_date(issue_date, '%d-%m-%Y')) = 12 
AND Year(str_to_date(issue_date, '%d-%m-%Y')) = 2021;

# PMTD Total Amount Received
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM FINANCIAL_LOAN
WHERE MONTH(str_to_date(issue_date, '%d-%m-%Y')) = 11
AND Year(str_to_date(issue_date, '%d-%m-%Y')) = 2021;

# Average Ineterst Rate
SELECT AVG(int_rate)*100 AS Average_Int_Rate
FROM financial_loan;

# MTD Average Ineterst Rate
SELECT AVG(int_rate)*100 AS MTD_Average_Int_Rate
FROM financial_loan
WHERE MONTH(str_to_date(issue_date, '%d-%m-%Y')) = 12 
AND Year(str_to_date(issue_date, '%d-%m-%Y')) = 2021;

# PMTD Average Ineterst Rate
SELECT AVG(int_rate)*100 AS PMTD_Average_Int_Rate
FROM financial_loan
WHERE MONTH(str_to_date(issue_date, '%d-%m-%Y')) = 11
AND Year(str_to_date(issue_date, '%d-%m-%Y')) = 2021;

# Average DTI
SELECT AVG(dti)*100 AS Avg_DTI
FROM financial_loan;

# MTD Average DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI
FROM financial_loan
WHERE MONTH(str_to_date(issue_date, '%d-%m-%Y')) = 12
AND Year(str_to_date(issue_date, '%d-%m-%Y')) = 2021;

# PMTD Average DTI
SELECT AVG(dti)*100 AS PMTD_Avg_DTI
FROM financial_loan
WHERE MONTH(str_to_date(issue_date, '%d-%m-%Y')) = 11
AND Year(str_to_date(issue_date, '%d-%m-%Y')) = 2021;

# Good Loan Application Percentage
SELECT
	(COUNT(CASE WHEN loan_status IN ('fully paid','current') THEN id END)*100)
    / 
    COUNT(id) AS Good_loan_percentage
FROM financial_loan;

# Good loan applications
SELECT COUNT(loan_status) AS Good_loan_Applications
FROM financial_loan
WHERE loan_status in ('fully paid','current');

# Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_loan_Funded_amount
FROM financial_loan
WHERE loan_status IN ('fully paid','current');

# Good loan amount received 
SELECT SUM(total_payment) AS Good_loan_amount_received
FROM financial_loan
WHERE loan_status IN ('fully paid','current');

# Bad Loan Application Percentage
SELECT
	(COUNT(CASE WHEN loan_status = 'charged off' THEN id END)*100)
    / 
    COUNT(id) AS Bad_loan_percentage
FROM financial_loan;

# Bad loan application
SELECT COUNT(loan_status) AS Good_loan_Applications
FROM financial_loan
WHERE loan_status = 'charged off';

# Bad loan funded amount
SELECT SUM(loan_amount) AS Bad_Loan_Amount
FROM financial_loan
WHERE loan_status = 'charged off';

# Bad loan amount received
SELECT SUM(total_payment) AS Bad_Loan_Amount
FROM financial_loan
WHERE loan_status = 'charged off';

# Loan Status

SELECT 
	loan_status,
    COUNT(id) AS Total_applications,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    ROUND(AVG(int_rate)*100,3) AS Average_int_rate,
    ROUND(AVG(dti)*100,3) AS Average_DTI
FROM financial_loan
GROUP BY loan_status;
    
    
# MTD loan status

SELECT 
	loan_status,
    SUM(total_payment) AS MTD_Total_Amount_Received,
    SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM
	financial_loan
WHERE
	MONTH(str_to_date(issue_date, '%d-%m-%Y')) = 12
GROUP BY 
	loan_status;

# Monthly trend by issue date
SELECT 
	MONTH(str_to_date(issue_date, '%d-%m-%Y')) AS Month_Number,
    COUNT(id) AS Loan_Application,
    SUM(loan_amount) AS Funded_amount,
    SUM(total_payment) AS Received_amount
FROM
	financial_loan
GROUP BY
	Month_Number
ORDER BY
	Month_Number;
    
# State
SELECT 
	address_state AS State,
    COUNT(id) AS Loan_Application,
    SUM(loan_amount) AS Funded_amount,
    SUM(total_payment) AS Received_amount
FROM
	financial_loan
GROUP BY
	State
ORDER BY
	State;
    
# Term
SELECT 
	term,
    COUNT(id) AS Loan_Application,
    SUM(loan_amount) AS Funded_amount,
    SUM(total_payment) AS Received_amount
FROM
	financial_loan
GROUP BY
	term
ORDER BY
	term;

# Employee Length
SELECT 
	emp_length,
    COUNT(id) AS Loan_Application,
    SUM(loan_amount) AS Funded_amount,
    SUM(total_payment) AS Received_amount
FROM
	financial_loan
GROUP BY
	emp_length
ORDER BY
	emp_length;

# Loan Purpose
SELECT 
	purpose,
    COUNT(id) AS Loan_Application,
    SUM(loan_amount) AS Funded_amount,
    SUM(total_payment) AS Received_amount
FROM
	financial_loan
GROUP BY
	purpose
ORDER BY
	COUNT(id) DESC;

# Home Ownership
SELECT 
	home_ownership,
    COUNT(id) AS Loan_Application,
    SUM(loan_amount) AS Funded_amount,
    SUM(total_payment) AS Received_amount
FROM
	financial_loan
GROUP BY
	home_ownership
ORDER BY
	COUNT(id) DESC;