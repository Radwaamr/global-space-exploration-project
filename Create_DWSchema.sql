CREATE DATABASE SpaceDW;
GO
USE SpaceDW;

CREATE TABLE DimCountry(
	Country_Key INT PRIMARY KEY IDENTITY(1,1),
	Country NVARCHAR(100)
);

CREATE TABLE DimLaunchSite(
	LaunchSite_Key INT PRIMARY KEY IDENTITY(1,1),
	LaunchSite NVARCHAR(100)
);

CREATE TABLE DimMissionType(
	MissionType_Key INT PRIMARY KEY IDENTITY(1,1),
	MissionType NVARCHAR(100)
);

CREATE TABLE DimSatelliteType(
	SatelliteType_Key INT PRIMARY KEY IDENTITY(1,1),
	SatelliteType NVARCHAR(100)
);

CREATE TABLE DimTechnology(
	Tech_Key INT PRIMARY KEY IDENTITY(1,1),
	Technology NVARCHAR(100)
);

CREATE TABLE DimEnvironmentalImpact(
	EnvImpact_Key INT PRIMARY KEY IDENTITY(1,1),
	EnvironmentalImpact NVARCHAR(100)
);

CREATE TABLE DimCollaboratingCountries(
	CollabCountries_Key INT PRIMARY KEY IDENTITY(1,1),
	CollaboratingCountries NVARCHAR(255)
);

CREATE TABLE DimYear (
    Year_Key INT PRIMARY KEY,
    Decade INT,
);


CREATE TABLE FactMissions(
	Mission_ID INT PRIMARY KEY IDENTITY(1,1),
	MissionName NVARCHAR(255),
	Country_key INT,
	Year_key INT,
	LaunchSite_key INT,
	MissionType_key INT,
	SatelliteType_key INT,
	Tech_key INT,
	EnvImpact_key INT,
	CollabCountries_key INT,
	Budget FLOAT,
	SuccessRate INT,
	Duration INT,
	FOREIGN KEY (Country_Key) REFERENCES DimCountry(Country_key),
	FOREIGN KEY (Year_key) REFERENCES DimYear(Year_key),
	FOREIGN KEY (LaunchSite_Key) REFERENCES DimLaunchSite(LaunchSite_Key),
    FOREIGN KEY (MissionType_Key) REFERENCES DimMissionType(MissionType_Key),
    FOREIGN KEY (SatelliteType_Key) REFERENCES DimSatelliteType(SatelliteType_Key),
    FOREIGN KEY (Tech_Key) REFERENCES DimTechnology(Tech_Key),
    FOREIGN KEY (EnvImpact_Key) REFERENCES DimEnvironmentalImpact(EnvImpact_Key),
    FOREIGN KEY (CollabCountries_Key) REFERENCES DimCollaboratingCountries(CollabCountries_Key)
);

CREATE TABLE Staging_SpaceMissions (
    Country VARCHAR(100),
    Year INT,
    MissionName VARCHAR(255),
    MissionType VARCHAR(100),
    LaunchSite VARCHAR(150),
    SatelliteType VARCHAR(100),
    Budget_Billion FLOAT,
    SuccessRate INT,
    TechnologyUsed VARCHAR(100),
    EnvironmentalImpact VARCHAR(100),
    CollaboratingCountries VARCHAR(255),
    Duration_Days INT
);


