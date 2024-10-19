-- To see the dataset and analyze it
SELECT *
FROM PortfolioProjects..GS_StockPrices

-- 1. Highest and Lowest Stock Prices for Each Year
SELECT YEAR(Date) AS Year,
	   MAX(High) AS Yearly_High,
	   MIN(Low) AS Yearly_Low
FROM GS_StockPrices
GROUP BY YEAR(Date)
ORDER BY Year;

-- 2. Average Closing Price Per Year
SELECT YEAR(Date) AS Year,
	   AVG([Close]) AS Avg_Closing_Price
FROM GS_StockPrices
GROUP BY YEAR(Date)
ORDER BY Year;

-- 3. Daily Volatility
-- Measure the daily volatility by checking the difference between the high and low prices
SELECT 
    Date,
    (High - Low) AS Daily_Volatility
FROM GS_StockPrices
ORDER BY Date;

-- 4. Top 10 Days with the Highest Trading Volume
SELECT TOP 10 Date, 
       Volume 
FROM GS_StockPrices
ORDER BY Volume DESC;

-- 5. Average Daily Volume per Year
--  Allows to see how interest in trading Goldman Sachs' stock has evolved over time.
SELECT YEAR(Date) AS Year,
	   AVG(Volume) AS Avg_Daily_Volume
FROM GS_StockPrices
GROUP BY YEAR(Date)
ORDER BY Year;

-- 6. The Days with the Largest Single-Day Gains/Losses
SELECT 
    Date,
    (([Close] - [Open]) / [Open]) * 100 AS Daily_Percentage_Change
FROM GS_StockPrices
ORDER BY 
    ABS(([Close] - [Open]) / [Open]) DESC;

-- 7. The Best and Worst Performing Months Over the Entire Dataset
SELECT 
    MONTH(Date) AS Month,
    AVG([Close]) AS Avg_Closing_Price
FROM 
    GS_StockPrices
GROUP BY MONTH(Date)
ORDER BY Avg_Closing_Price DESC;

-- 8. Stock Price Trend Before and After Major Events
-- COVID-19 Effects
SELECT 
    Date,
    [Close],
    CASE 
        WHEN Date < '2020-03-01' THEN 'Before COVID'
        ELSE 'After COVID'
    END AS Period
FROM GS_StockPrices
WHERE YEAR(Date) = 2020
ORDER BY Date;
