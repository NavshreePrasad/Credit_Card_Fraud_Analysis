CREATE DATABASE credit_card_fraud_analysis_db
use credit_card_fraud_analysis_db
select * from fraud_analysis limit 20

--Q1.Total number of transactions
select count(transaction_id) as Total_Transactions from fraud_analysis

--Q2.Total fraud transactions
select count(transaction_id) as Total_Fraud_Transactions from fraud_analysis where (is_fraud=1)

--Q3. Fraud percentage
with Total_fraud_sales as (select count(transaction_id) as Total_Fraud_Transactions from fraud_analysis where (is_fraud=1))
SELECT(Total_Fraud_Transactions * 100.0 /(SELECT COUNT(transaction_id) FROM fraud_analysis)) AS Fraud_Percentage FROM Total_fraud_sales
OR   
SELECT COUNT(CASE WHEN is_fraud = 1 THEN 1 END) * 100.0 / COUNT(*) AS Fraud_Percentage FROM fraud_analysis

--Q4.Average transaction amount
select round(avg(amount_usd),2) as Average_Transaction_Amount from fraud_analysis 

--Q5. Maximum transaction amount
select round(max(amount_usd),2) as Maximum_Transaction_Amount from fraud_analysis 

--Q6. Fraud by merchant category
select merchant_category, round(100*COUNT(CASE WHEN is_fraud = 1 THEN 1 END)/COUNT(*),2) AS Fraud_Percentage FROM fraud_analysis group by merchant_category order by Fraud_Percentage desc

--Q7. Fraud by card type
select card_type, round(100*COUNT(CASE WHEN is_fraud = 1 THEN 1 END)/COUNT(*),2) AS Fraud_Percentage FROM fraud_analysis group by card_type order by Fraud_Percentage desc

--Q8. Fraud by authentication method
select auth_method, round(100*count(case when is_fraud= 1 then 1 end)/count(*),2) AS Fraud_Percentage FROM fraud_analysis group by auth_method order by Fraud_Percentage desc

--Q9.Fraud by channel
select channel, round(100*count(case when is_fraud= 1 then 1 end)/count(*),2) AS Fraud_Percentage FROM fraud_analysis group by channel order by Fraud_Percentage desc

--Q10. Fraud by device
select device_type, round(100*count(case when is_fraud= 1 then 1 end)/count(*),2) AS Fraud_Percentage FROM fraud_analysis group by device_type order by Fraud_Percentage desc

--Q11.Average amount by merchant
select merchant_category,round(avg(amount_usd),2) as Average_Transaction_Amount from fraud_analysis group by merchant_category order by Average_Transaction_Amount desc

--Q12.Average merchant risk score
select merchant_category, round(avg(merchant_risk_score),2) as Avg_risk_score from fraud_analysis group by merchant_category order by Avg_risk_score desc

--Q13.Foreign vs Domestic fraud comparison
select is_foreign_transaction, count(is_foreign_transaction) as Total from fraud_analysis group by is_foreign_transaction 

--Q14.Average account balance of fraud customers
select round(avg(account_balance_usd),2) as Average_balance from fraud_analysis where (is_fraud=1)

--Q15.Fraud by customer age group
select age_group, round(100*count(case when is_fraud=1 then 1 end)/count(*),2) as Fraud_pct from fraud_analysis group by age_group order by Fraud_pct desc

--Q16.Fraud by day of week
select day_of_week, round(100*count(case when is_fraud=1 then 1 end)/count(*),2) as Fraud_pct from fraud_analysis group by day_of_week order by Fraud_pct desc

--Q17.Fraud by hour
select time_of_day, round(100*count(case when is_fraud=1 then 1 end)/count(*),2) as Fraud_pct from fraud_analysis group by time_of_day order by Fraud_pct desc

--Q18.High-value transaction count
select transaction_size, count(transaction_size) from fraud_analysis group by transaction_size

--Q19.Rank merchant categories by fraud and Fraud %
select merchant_category, count(case when is_fraud=1 then 1 end) as Fraud_count, rank() over (order by count(case when is_fraud=1 then 1 end)desc) as Fraud_rank from fraud_analysis group by merchant_category order by Fraud_rank
select merchant_category, round(100*count(case when is_fraud=1 then 1 end)/ COUNT(*), 2) as Fraud_Pct, rank() over (order by round(100*count(case when is_fraud=1 then 1 end)/ COUNT(*), 2) desc) as Fraud_rank from fraud_analysis group by merchant_category order by Fraud_rank

--Q20.Rank risky authentication methods
select auth_method, round(100*count(case when is_fraud=1 then 1 end)/count(*),2) as Fraud_pct, rank() over(order by round(100*count(case when is_fraud=1 then 1 end)/count(*),2)desc) as Fraud_rank from fraud_analysis group by auth_method order by Fraud_rank

--Q21.Dense Rank merchants by fraud rate
select merchant_category, round(100*count(case when is_fraud=1 then 1 end)/count(*),2) as Fraud_pct, dense_rank() over(order by round(100*count(case when is_fraud=1 then 1 end)/count(*),2) desc)as Fraud_dense_rank from fraud_analysis group by merchant_category order by Fraud_dense_rank

--Q22. Row number merchants by fraud rate
select merchant_category, round(100*count(case when is_fraud=1 then 1 end)/count(*),2) as Fraud_pct, row_number() over(order by round(100*count(case when is_fraud=1 then 1 end)/count(*),2) desc)as Fraud_row_number from fraud_analysis group by merchant_category order by Fraud_row_number

--Q23.Merchant risk quartiles
SELECT merchant_category, COUNT(CASE WHEN is_fraud = 1 THEN 1 END) AS Fraud_Count, NTILE(4) OVER (ORDER BY COUNT(CASE WHEN is_fraud = 1 THEN 1 END) DESC) AS Risk_Quartile
FROM fraud_analysis
GROUP BY merchant_category
ORDER BY Risk_Quartile

--Q24.CASEstatement for Risk Level
select transaction_id, amount_usd,is_fraud, case when amount_usd >=1000 and is_fraud=1 then 'High Risk'
when is_fraud=1 then 'Medium Risk'
else 'Low Risk'
end as Risk_level from fraud_analysis




-




