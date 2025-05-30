--Validation Queries
SELECT COUNT(*) FROM DimCountry;
SELECT COUNT(*) FROM DimYear;
SELECT COUNT(*) FROM DimLaunchSite;
SELECT COUNT(*) FROM DimMissionType;
SELECT COUNT(*) FROM DimSatelliteType;
SELECT COUNT(*) FROM DimTechnology;
SELECT COUNT(*) FROM DimEnvironmentalImpact;
SELECT COUNT(*) FROM DimCollaboratingCountries;

SELECT COUNT(*) FROM FactMissions;


SELECT * FROM FactMissions 
WHERE Country_Key IS NULL 
   OR Year_Key IS NULL 
   OR LaunchSite_Key IS NULL 
   OR MissionType_Key IS NULL 
   OR SatelliteType_Key IS NULL 
   OR Tech_Key IS NULL 
   OR EnvImpact_Key IS NULL 
   OR CollabCountries_Key IS NULL;




--Mission Count by Country: Identify countries with the most space missions
SELECT DC.Country,COUNT(*) AS Total_Missions
FROM FactMissions FM
JOIN DimCountry DC
ON FM.Country_key=DC.Country_Key
GROUP BY DC.Country
ORDER BY Total_Missions DESC

--Mission Distribution by Mission Type: Find the most common types of missions
SELECT MT.MissionType,COUNT(*) AS Count
FROM FactMissions FM
JOIN DimMissionType MT
ON FM.MissionType_key=MT.MissionType_Key
GROUP BY MT.MissionType
ORDER BY Count DESC

--Average Budget by Country: Analyze which countries spend more on average per mission
SELECT DC.Country,AVG(FM.Budget) AS AvgBudget
FROM FactMissions FM
JOIN DimCountry DC
ON FM.Country_key=DC.Country_Key
GROUP BY DC.Country
ORDER BY AvgBudget DESC


--Technology vs. Success Rate: Determine how different technologies affect success
SELECT T.Technology, AVG(FM.SuccessRate) AS AvgSuccessRate
FROM FactMissions FM
JOIN DimTechnology T
ON FM.Tech_key=T.Tech_Key
GROUP BY T.Technology
ORDER BY AvgSuccessRate DESC


--Mission Volume by Decade: See the trend of mission counts over decades
SELECT DY.Decade , COUNT(*) AS MissionCount 
FROM FactMissions FM
JOIN DimYear DY
ON FM.Year_key=DY.Year_Key
GROUP BY DY.Decade
ORDER BY MissionCount DESC


--Satellite Type vs. Average Duration: Analyze which satellite types are used in longer missions
SELECT ST.SatelliteType,AVG(FM.Duration) AS AvgDuration
FROM FactMissions FM
JOIN DimSatelliteType ST
ON FM.SatelliteType_key=ST.SatelliteType_Key
GROUP BY ST.SatelliteType
ORDER BY AvgDuration DESC


--Mission Type by Country: Discover which countries specialize in which mission types
SELECT DC.Country,MT.MissionType,COUNT(*) AS Count
FROM FactMissions FM
JOIN DimMissionType MT
ON FM.MissionType_key=MT.MissionType_Key
JOIN DimCountry DC
ON FM.Country_key=DC.Country_Key
GROUP BY DC.Country,MT.MissionType
ORDER BY Count DESC


--Collaborating Countries: Explore how often countries collaborated in missions
SELECT CC.CollaboratingCountries ,COUNT(*) AS MissionWithCollab
FROM FactMissions FM
JOIN DimCollaboratingCountries CC
ON FM.CollabCountries_key=CC.CollabCountries_Key
GROUP BY CC.CollaboratingCountries
ORDER BY MissionWithCollab DESC


--Technology vs. Mission Stats: Get both average success and count of missions for each technology
SELECT DT.Technology,AVG(FM.SuccessRate) AS AvgSuccessRate,COUNT(*) AS TotalMissions
FROM FactMissions FM
JOIN DimTechnology DT
ON FM.Tech_key=DT.Tech_Key
GROUP BY DT.Technology
ORDER BY AvgSuccessRate DESC

--Count of missions by each Mission Type and Satellite Type combination
SELECT MT.MissionType,ST.SatelliteType, COUNT(*) AS MissionCount
FROM FactMissions FM
JOIN DimSatelliteType ST 
ON FM.SatelliteType_key=ST.SatelliteType_Key
JOIN DimMissionType MT
ON FM.MissionType_key=MT.MissionType_Key
GROUP BY MT.MissionType,ST.SatelliteType
ORDER BY MissionCount DESC

--Average Budget per Decade: Analyze financial trends over time
SELECT DY.Decade,AVG(Budget) AS AvgBudget
FROM FactMissions FM
JOIN DimYear DY
ON FM.Year_key=DY.Year_Key
GROUP BY DY.Decade
ORDER BY DY.Decade

--Environmental Impact vs. Mission Count and Success Rate
SELECT EI.EnvironmentalImpact , COUNT(*) AS MissionCount , AVG(FM.SuccessRate) AS AvgSuccessRate
FROM FactMissions FM
JOIN DimEnvironmentalImpact EI
ON FM.EnvImpact_key=EI.EnvImpact_Key
GROUP BY EI.EnvironmentalImpact
ORDER BY AvgSuccessRate DESC

--Mission Distribution by Launch Site: Popular launch sites
SELECT LS.LaunchSite, COUNT(*) AS MissionCount
FROM FactMissions FM
JOIN DimLaunchSite LS ON 
FM.LaunchSite_Key = LS.LaunchSite_Key
GROUP BY LS.LaunchSite
ORDER BY MissionCount DESC;

