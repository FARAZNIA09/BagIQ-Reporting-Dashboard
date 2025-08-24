---------------------------- DataBase Name -------------------------------------------------
USE Internship;

--------------------------- Enter Date OF Report -------------------------------------------
DECLARE @reportDate DATE = '2025-08-18';

--------------------------- Enter Interval In Minutes --------------------------------------
---------------------- change this to 1, 5, 10, 30, 60,1440(1 DAY) -------------------------
DECLARE @intervalMinutes INT = 60; 

----------------- Creating a New Table to Store The Time Slot (00:00:00 - 01:00:00)---------
WITH TimeSlots AS (
    SELECT 
        DATEADD(MINUTE, (@intervalMinutes * n), CAST(@reportDate AS DATETIME)) AS SlotStart
    FROM (
        SELECT TOP (1440) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n
        FROM master.dbo.spt_values
    ) AS x
    WHERE (@intervalMinutes * n) < 1440   
)
--------------------- This Query Is To Display The Output by the use of Left Join -----------
-- We Use Left Join Because It include all data from left table and matching data from right table and also include Null Data 
SELECT 
    FORMAT(@reportDate, 'dd.MM.yyyy') AS Date_Of_Report,
    FORMAT(S.SlotStart, 'HH:mm:ss') + ' to ' + FORMAT(DATEADD(MINUTE, @intervalMinutes, S.SlotStart), 'HH:mm:ss') AS Time_Range,
    COUNT(F.Time_Stamp) AS Total_Records
FROM TimeSlots S
LEFT JOIN bag_discharge F
    ON F.Time_Stamp >= S.SlotStart
   AND F.Time_Stamp < DATEADD(MINUTE, @intervalMinutes, S.SlotStart)
GROUP BY S.SlotStart
ORDER BY S.SlotStart;
