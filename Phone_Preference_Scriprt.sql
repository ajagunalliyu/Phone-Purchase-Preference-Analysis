USE Phone_Preference;
SELECT TOP 5 * FROM Phone_Purchase_Preference;


-- Q1
-- SQL Query: Overall Purchase Driver Ranking

SELECT      'Price Value' AS Feature, 
            ROUND(AVG(CAST(Importance_PriceValue AS FLOAT)), 2) AS Rating
FROM        Phone_Purchase_Preference
UNION       ALL

SELECT      'BatteryLife' AS Feature, 
            ROUND(AVG(CAST(Importance_BatteryLife AS FLOAT)), 2) AS Rating
FROM        Phone_Purchase_Preference
UNION       ALL

SELECT      'Brand' AS Feature, 
            ROUND(AVG(CAST(Importance_Brand AS FLOAT)), 2) AS Rating
FROM        Phone_Purchase_Preference
UNION       ALL

SELECT      'CameraQuality' AS Feature, 
            ROUND(AVG(CAST(Importance_CameraQuality AS FLOAT)), 2) AS Rating
FROM        Phone_Purchase_Preference
UNION       ALL

SELECT      'Design' AS Feature, 
            ROUND(AVG(CAST(Importance_Design AS FLOAT)), 2) AS Rating
FROM        Phone_Purchase_Preference
UNION       ALL

SELECT      'Durability' AS Feature, 
            ROUND(AVG(CAST(Importance_Durability AS FLOAT)), 2) AS Rating
FROM        Phone_Purchase_Preference
UNION       ALL

SELECT      'AdvancedFeatures' AS Feature, 
            ROUND(AVG(CAST(Importance_AdvanceFeatures AS FLOAT)), 2) AS Rating
FROM        Phone_Purchase_Preference
UNION       ALL

SELECT      'Screen Size' AS Feature, 
            ROUND(AVG(CAST(Importance_ScreenSize AS FLOAT)), 2) AS Rating
FROM        Phone_Purchase_Preference
UNION       ALL

SELECT      'Storage Capacity' AS Feature, 
            ROUND(AVG(CAST(Importance_StorageCapacity AS FLOAT)), 2) AS Rating
FROM        Phone_Purchase_Preference
UNION       ALL

SELECT      'Warranty' AS Feature, 
            ROUND(AVG(CAST(Importance_Warranty AS FLOAT)), 2) AS Rating
FROM        Phone_Purchase_Preference
ORDER BY    Rating DESC;

        --OR--

SELECT      ROUND(AVG(CAST(Importance_PriceValue AS FLOAT)), 2) AS PriceValue,
            ROUND(AVG(CAST(Importance_BatteryLife AS FLOAT)), 2) AS BatteryLife,
            ROUND(AVG(CAST(Importance_Brand AS FLOAT)), 2) AS Brand,
            ROUND(AVG(CAST(Importance_CameraQuality AS FLOAT)), 2) AS CameraQuality,
            ROUND(AVG(CAST(Importance_Design AS FLOAT)), 2) AS Design,
            ROUND(AVG(CAST(Importance_Durability AS FLOAT)), 2) AS Durability,
            ROUND(AVG(CAST(Importance_AdvanceFeatures AS FLOAT)), 2) AS AdvancedFeatures,
            ROUND(AVG(CAST(Importance_ScreenSize AS FLOAT)), 2) AS ScreenSize,
            ROUND(AVG(CAST(Importance_StorageCapacity AS FLOAT)), 2) AS StorageCapacity,
            ROUND(AVG(CAST(Importance_Warranty AS FLOAT)), 2) AS Warranty
FROM        Phone_Purchase_Preference;


-- Q2
-- SQL Query: Advanced Feature Importance by Primary Use (Uses Binary Columns)

SELECT      'Social Media' AS Use_Case, 
            ROUND(AVG(CAST(Importance_AdvanceFeatures AS FLOAT)), 1) AS Avg_Adv_Feature_Rating
FROM        Phone_Purchase_Preference
WHERE       Use_SocialMedia = 1
UNION       ALL

SELECT      'Calls and Texting' AS Use_Case, 
            ROUND(AVG(CAST(Importance_AdvanceFeatures AS FLOAT)), 1) AS Avg_Adv_Feature_Rating
FROM        Phone_Purchase_Preference
WHERE       Use_Calls_Texting = 1
UNION       ALL

SELECT      'Work/Professional Task' AS Use_Case, 
            ROUND(AVG(CAST(Importance_AdvanceFeatures AS FLOAT)), 1) AS Avg_Adv_Feature_Rating
FROM        Phone_Purchase_Preference
WHERE       Use_Work_Profssional_Tasks = 1
UNION       ALL

SELECT      'Gaming/Entertainment' AS Use_Case, 
            ROUND(AVG(CAST(Importance_AdvanceFeatures AS FLOAT)), 1) AS Avg_Adv_Feature_Rating
FROM        Phone_Purchase_Preference
WHERE       Use_Gaming_Entertainment = 1
UNION       ALL

SELECT      'Photography/Videography' AS Use_Case, 
            ROUND(AVG(CAST(Importance_AdvanceFeatures AS FLOAT)), 1) AS Avg_Adv_Feature_Rating
FROM        Phone_Purchase_Preference
WHERE       Use_Photography_Videography = 1
UNION       ALL

SELECT      'Education' AS Use_Case, 
            ROUND(AVG(CAST(Importance_AdvanceFeatures AS FLOAT)), 1) AS Avg_Adv_Feature_Rating
FROM        Phone_Purchase_Preference
WHERE       Use_Education = 1
UNION       ALL

SELECT      'Other' AS Use_Case, 
            ROUND(AVG(CAST(Importance_AdvanceFeatures AS FLOAT)), 1) AS Avg_Adv_Feature_Rating
FROM        Phone_Purchase_Preference
WHERE       Use_Other = 1
ORDER BY    Avg_Adv_Feature_Rating DESC;


-- Q3
-- SQL Query: Purchase Channel Preference by Income Group


SELECT      Income_Range_NGN, 
            Purchase_Channel,
            COUNT(*) AS Channel_Count
FROM        Phone_Purchase_Preference
GROUP BY    Income_Range_NGN, Purchase_Channel
ORDER BY    Income_Range_NGN, Channel_Count DESC;


--Q4
-- SQL Query: Satisfaction and Switch Intent by Current Brand

SELECT      Current_Brand,
            COUNT(*) AS Total_Respondents,
            ROUND(AVG(CAST(Overall_Saisfaction AS FLOAT)), 1) AS Avg_Satisfaction,
            FORMAT(SUM(CASE WHEN Switch_Intent = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), '0\%') AS Pct_Switch_Yes,
            FORMAT(SUM(CASE WHEN Switch_Intent = 'No' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), '0\%') AS Pct_Switch_No,
            FORMAT(SUM(CASE WHEN Switch_Intent = 'Undecided' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), '0\%') AS Pct_Switch_Undecided
FROM        Phone_Purchase_Preference
GROUP BY    Current_Brand
ORDER BY    Avg_Satisfaction DESC;


--Q5
-- SQL Query: Top Switching Reasons Overall

SELECT      Reason_for_Switch,
            COUNT(Reason_for_Switch) AS Reason_Count,
            FORMAT(COUNT(Reason_for_Switch) * 100.0 / (   
                SELECT COUNT(*) 
                FROM Phone_Purchase_Preference 
                WHERE Switch_Intent = 'Yes' OR Switch_Intent = 'Undecided'), '0.0\%') AS pct_of_Switchers
FROM        Phone_Purchase_Preference
WHERE       Switch_Intent = 'Yes' OR Switch_Intent = 'Undecided'
GROUP BY    Reason_for_Switch
ORDER BY    Reason_Count DESC;


-- Q6
-- SQL Query: Budget Comparison by Age Group

SELECT      Age_Category,
            Budget_Range_NGN,
            FORMAT(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Age_Category), '0\%') AS Respondent
FROM        Phone_Purchase_Preference
GROUP BY    Age_Category, Budget_Range_NGN
ORDER BY    Age_Category, COUNT(*) DESC;


-- Q7
-- SQL Query: Upgrade Frequency vs. Budget/Price Sensitivity

SELECT      Phone_Change_Frequency,
            AVG(Importance_PriceValue) AS Avg_Price_Importance,
            Budget_Range_NGN
FROM        Phone_Purchase_Preference
WHERE       Budget_Range_NGN = 'Premium'
GROUP BY    Phone_Change_Frequency,  Budget_Range_NGN
ORDER BY    Avg_Price_Importance,  Budget_Range_NGN;

