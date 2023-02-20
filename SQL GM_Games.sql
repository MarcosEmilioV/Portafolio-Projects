USE LeagueRankeds;
SELECT * FROM dbo.GM_Games;

-- First its important to know total games of the season so me know how large the sample is
SELECT COUNT(DISTINCT gameId) as Total_Games FROM GM_Games;


--Now we should know from that amount of games how many have both teams won
SELECT SUM(redwins) FROM GM_Games;
SELECT SUM(bluewins) FROM GM_Games;

--Let's make that percentual 

SELECT SUM(redwins)/count (gameId)*100 FROM GM_Games;
SELECT SUM(bluewins)/count (gameId)*100 FROM GM_Games;

--We can see that red wins around 0.88 percent more that blue does in GM, which is not that much, but let's see what metrics do they differ in


-- First let's take all early game factors 

SELECT SUM(bluefirstblood) AS Blue_FB, SUM(bluefirsttower) AS Blue_FT, SUM(bluefirstdragon) AS Blue_FD, SUM(redfirstblood) AS Red_FB, SUM(redfirsttower) AS Red_FT, SUM(redfirstdragon) as Red_FD
FROM GM_Games;



--Now let's look at percentages from total games

SELECT SUM(bluefirstblood)/count (gameID)*100 AS Blue_FB, SUM(bluefirsttower)/count (gameID)*100 AS Blue_FT, SUM(bluefirstdragon)/count (gameID)*100 AS Blue_FD, 
SUM(redfirstblood)/count (gameID)*100 AS Red_FB, SUM(redfirsttower)/count (gameID)*100 AS Red_FT, SUM(redfirstdragon)/count (gameID)*100 as Red_FD
FROM GM_Games;




--Let's take now all middle to late game elements

SELECT SUM(bluedragonkills) AS BDK, SUM(bluebaronkills) AS BBK, SUM(bluetowerkills) AS BTK, SUM(blueinhibitorkills) AS BIK, SUM(bluewardplaced) AS BWP, SUM(bluewardkills) BWK, SUM(bluekills) AS BK, SUM(bluedeath) AS BD, SUM(blueassist) AS BA,SUM(reddragonkills) AS RDK, SUM(redbaronkills) AS RBK, SUM(redtowerkills) AS RTK, SUM(redinhibitorkills) AS RIK, SUM(redwardplaced) AS RWP, SUM(redwardkills) AS RWK, SUM(redkills) AS RK, SUM(reddeath) AS RD, SUM(redassist) AS RA
FROM GM_Games;

--Percentage in middle game elements
CREATE VIEW Middle_Game AS 
SELECT SUM(reddragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 - SUM(bluedragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 AS RDK
,SUM(redbaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 - SUM(bluebaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 AS RBK
, SUM(bluetowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 - SUM(redtowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 AS RTK
, SUM(blueinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 - SUM(redinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 AS RIK
,SUM(redWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 - SUM(blueWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 AS RWP
, SUM(blueWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 - SUM(redWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 AS RWK
, SUM(bluekills)/(SUM(redKills)+ SUM(bluekills))*100 - SUM(redkills)/(SUM(redkills)+ SUM(bluekills))*100 AS RK
, SUM(redDeath)/(SUM(redDeath)+ SUM(blueDeath))*100 - SUM(blueDeath)/(SUM(redDeath)+ SUM(blueDeath))*100 AS RD
, SUM(blueAssist)/(SUM(redAssist)+ SUM(blueAssist))*100 - SUM(redAssist)/(SUM(redAssist)+ SUM(blueAssist))*100 AS RA
FROM GM_Games;


--Difference in epic mobs
SELECT SUM(bluedragonkills) AS BDK,SUM(bluebaronkills) AS BBK, SUM(reddragonkills) AS RDK, SUM(redbaronkills) AS RBK
FROM GM_Games;

--PERCENTAGE in epic mobs
SELECT SUM(reddragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 - SUM(bluedragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 AS RDK
,SUM(bluebaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 - SUM(redbaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 AS RBK
FROM GM_Games;

--Difference in structures

SELECT SUM(bluetowerkills) AS BTK, SUM(blueinhibitorkills) AS BIK, SUM(redtowerkills) AS RTK, SUM(redinhibitorkills) AS RIK
FROM GM_Games;

--PERCENTAGE in structures differenc
SELECT SUM(redtowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 - SUM(bluetowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 AS RTK
, SUM(redinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 - SUM(blueinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 AS RIK
FROM GM_Games;


--Difference in vision

SELECT SUM(bluewardplaced) AS BWP, SUM(bluewardkills) BWK, SUM(redwardplaced) AS RWP, SUM(redwardkills) AS RWK
FROM GM_Games;

--PERCENTAGE in vision difference
SELECT SUM(redWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 - SUM(blueWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 AS RWP
, SUM(blueWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 - SUM(redWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 AS RWK
FROM GM_Games;

--Difference in total levels 

SELECT SUM(bluetotallevel) AS BTL, SUM(blueavglevel)BAL, SUM(redtotallevel)RTL, SUM(redavglevel)RAL FROM GM_Games;

--PERCENTAGE total level difference
SELECT SUM(redtotallevel)/(SUM(redtotallevel)+ SUM(bluetotallevel))*100 - SUM(bluetotallevel)/(SUM(redtotallevel)+ SUM(bluetotallevel))*100 AS LevelDiff
,SUM(redavglevel)/(SUM(redavglevel)+ SUM(blueavglevel))*100 - SUM(blueavglevel)/(SUM(redavglevel)+ SUM(blueavglevel))*100 AS AVGLevelDiff
FROM GM_Games;

--Difference in gold and minions

SELECT SUM(bluetotalgold) AS BTG, SUM(bluetotalminionkills) AS BMK, SUM(bluejungleminionkills) AS BJGMK, SUM(redtotalgold)RTG, SUM(redtotalminionkills) AS RMK, SUM(redjungleminionkills) AS RJGMK 
FROM GM_Games;

--PERCENTAGE difference in gold and minions

SELECT SUM(redtotalgold)/(SUM(redtotalgold)+ SUM(bluetotalgold))*100 - SUM(bluetotalgold)/(SUM(redtotalgold)+ SUM(bluetotalgold))*100 AS TotalGoldDiff
,SUM(redtotalminionkills)/(SUM(redtotalminionkills)+ SUM(bluetotalminionkills))*100 - SUM(bluetotalminionkills)/(SUM(redtotalminionkills)+ SUM(bluetotalminionkills))*100 AS TotalMinionsDiff
,SUM(redjungleminionkills)/(SUM(redjungleminionkills)+ SUM(bluejungleminionkills))*100 - SUM(bluejungleminionkills)/(SUM(redjungleminionkills)+ SUM(bluejungleminionkills))*100 AS TotalJGMinDiff
FROM GM_Games;

SELECT * FROM Middle_game;




------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Challenger Games

SELECT * FROM dbo.Challenger_games;

-- First its important to know total games of the season so me know how large the sample is
SELECT COUNT(DISTINCT gameId) as Total_Games FROM Challenger_games;


--Now we should know from that amount of games how many have both teams won
SELECT SUM(redwins) FROM Challenger_games;
SELECT SUM(bluewins) FROM Challenger_games;

--Let's make that percentual 

SELECT SUM(redwins)/count (gameId)*100 FROM Challenger_games;
SELECT SUM(bluewins)/count (gameId)*100 FROM Challenger_games;

--We can see that red wins around 0.88 percent more that blue does in GM, which is not that much, but let's see what metrics do they differ in


-- First let's take all early game factors 

SELECT SUM(bluefirstblood) AS Blue_FB, SUM(bluefirsttower) AS Blue_FT, SUM(bluefirstdragon) AS Blue_FD, SUM(redfirstblood) AS Red_FB, SUM(redfirsttower) AS Red_FT, SUM(redfirstdragon) as Red_FD
FROM Challenger_games;



--Now let's look at percentages from total games

SELECT SUM(bluefirstblood)/count (gameID)*100 AS Blue_FB, SUM(bluefirsttower)/count (gameID)*100 AS Blue_FT, SUM(bluefirstdragon)/count (gameID)*100 AS Blue_FD, 
SUM(redfirstblood)/count (gameID)*100 AS Red_FB, SUM(redfirsttower)/count (gameID)*100 AS Red_FT, SUM(redfirstdragon)/count (gameID)*100 as Red_FD
FROM Challenger_games;




--Let's take now all middle to late game elements

SELECT SUM(bluedragonkills) AS BDK, SUM(bluebaronkills) AS BBK, SUM(bluetowerkills) AS BTK, SUM(blueinhibitorkills) AS BIK, SUM(bluewardplaced) AS BWP, SUM(bluewardkills) BWK, SUM(bluekills) AS BK, SUM(bluedeath) AS BD, SUM(blueassist) AS BA,SUM(reddragonkills) AS RDK, SUM(redbaronkills) AS RBK, SUM(redtowerkills) AS RTK, SUM(redinhibitorkills) AS RIK, SUM(redwardplaced) AS RWP, SUM(redwardkills) AS RWK, SUM(redkills) AS RK, SUM(reddeath) AS RD, SUM(redassist) AS RA
FROM Challenger_games;

--Percentage in middle game elements
CREATE VIEW Middle_Game_Challenger AS 
SELECT SUM(reddragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 - SUM(bluedragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 AS RDK
,SUM(redbaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 - SUM(bluebaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 AS RBK
, SUM(bluetowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 - SUM(redtowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 AS RTK
, SUM(blueinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 - SUM(redinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 AS RIK
,SUM(redWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 - SUM(blueWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 AS RWP
, SUM(blueWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 - SUM(redWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 AS RWK
, SUM(bluekills)/(SUM(redKills)+ SUM(bluekills))*100 - SUM(redkills)/(SUM(redkills)+ SUM(bluekills))*100 AS RK
, SUM(redDeath)/(SUM(redDeath)+ SUM(blueDeath))*100 - SUM(blueDeath)/(SUM(redDeath)+ SUM(blueDeath))*100 AS RD
, SUM(blueAssist)/(SUM(redAssist)+ SUM(blueAssist))*100 - SUM(redAssist)/(SUM(redAssist)+ SUM(blueAssist))*100 AS RA
FROM Challenger_games;
SELECT Middle_Game_Challenger FROM Challenger_games;

--Difference in epic mobs
SELECT SUM(bluedragonkills) AS BDK,SUM(bluebaronkills) AS BBK, SUM(reddragonkills) AS RDK, SUM(redbaronkills) AS RBK
FROM Challenger_games;

--PERCENTAGE in epic mobs
SELECT SUM(reddragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 - SUM(bluedragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 AS RDK
,SUM(bluebaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 - SUM(redbaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 AS RBK
FROM Challenger_games;

--Difference in structures

SELECT SUM(bluetowerkills) AS BTK, SUM(blueinhibitorkills) AS BIK, SUM(redtowerkills) AS RTK, SUM(redinhibitorkills) AS RIK
FROM Challenger_games;

--PERCENTAGE in structures differenc
SELECT SUM(redtowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 - SUM(bluetowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 AS RTK
, SUM(redinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 - SUM(blueinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 AS RIK
FROM Challenger_games;


--Difference in vision

SELECT SUM(bluewardplaced) AS BWP, SUM(bluewardkills) BWK, SUM(redwardplaced) AS RWP, SUM(redwardkills) AS RWK
FROM Challenger_games;

--PERCENTAGE in vision difference
SELECT SUM(redWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 - SUM(blueWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 AS RWP
, SUM(blueWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 - SUM(redWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 AS RWK
FROM Challenger_games;

--Difference in total levels 

SELECT SUM(bluetotallevel) AS BTL, SUM(blueavglevel)BAL, SUM(redtotallevel)RTL, SUM(redavglevel)RAL FROM Challenger_games;

--PERCENTAGE total level difference
SELECT SUM(redtotallevel)/(SUM(redtotallevel)+ SUM(bluetotallevel))*100 - SUM(bluetotallevel)/(SUM(redtotallevel)+ SUM(bluetotallevel))*100 AS LevelDiff
,SUM(redavglevel)/(SUM(redavglevel)+ SUM(blueavglevel))*100 - SUM(blueavglevel)/(SUM(redavglevel)+ SUM(blueavglevel))*100 AS AVGLevelDiff
FROM Challenger_games;

--Difference in gold and minions

SELECT SUM(bluetotalgold) AS BTG, SUM(bluetotalminionkills) AS BMK, SUM(bluejungleminionkills) AS BJGMK, SUM(redtotalgold)RTG, SUM(redtotalminionkills) AS RMK, SUM(redjungleminionkills) AS RJGMK 
FROM Challenger_games;

--PERCENTAGE difference in gold and minions

SELECT SUM(redtotalgold)/(SUM(redtotalgold)+ SUM(bluetotalgold))*100 - SUM(bluetotalgold)/(SUM(redtotalgold)+ SUM(bluetotalgold))*100 AS TotalGoldDiff
,SUM(redtotalminionkills)/(SUM(redtotalminionkills)+ SUM(bluetotalminionkills))*100 - SUM(bluetotalminionkills)/(SUM(redtotalminionkills)+ SUM(bluetotalminionkills))*100 AS TotalMinionsDiff
,SUM(redjungleminionkills)/(SUM(redjungleminionkills)+ SUM(bluejungleminionkills))*100 - SUM(bluejungleminionkills)/(SUM(redjungleminionkills)+ SUM(bluejungleminionkills))*100 AS TotalJGMinDiff
FROM Challenger_games;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- MASTER GAMES

SELECT * FROM dbo.Master_games;

-- First its important to know total games of the season so me know how large the sample is
SELECT COUNT(DISTINCT gameId) as Total_Games FROM Master_games;


--Now we should know from that amount of games how many have both teams won
SELECT SUM(redwins) FROM Master_games;
SELECT SUM(bluewins) FROM Master_games;

--Let's make that percentual 

SELECT SUM(redwins)/count (gameId)*100 FROM Master_games;
SELECT SUM(bluewins)/count (gameId)*100 FROM Master_games;

--We can see that red wins around 0.88 percent more that blue does in GM, which is not that much, but let's see what metrics do they differ in


-- First let's take all early game factors 

SELECT SUM(bluefirstblood) AS Blue_FB, SUM(bluefirsttower) AS Blue_FT, SUM(bluefirstdragon) AS Blue_FD, SUM(redfirstblood) AS Red_FB, SUM(redfirsttower) AS Red_FT, SUM(redfirstdragon) as Red_FD
FROM Master_games;



--Now let's look at percentages from total games

SELECT SUM(bluefirstblood)/count (gameID)*100 AS Blue_FB, SUM(bluefirsttower)/count (gameID)*100 AS Blue_FT, SUM(bluefirstdragon)/count (gameID)*100 AS Blue_FD, 
SUM(redfirstblood)/count (gameID)*100 AS Red_FB, SUM(redfirsttower)/count (gameID)*100 AS Red_FT, SUM(redfirstdragon)/count (gameID)*100 as Red_FD
FROM Master_games;




--Let's take now all middle to late game elements

SELECT SUM(bluedragonkills) AS BDK, SUM(bluebaronkills) AS BBK, SUM(bluetowerkills) AS BTK, SUM(blueinhibitorkills) AS BIK, SUM(bluewardplaced) AS BWP, SUM(bluewardkills) BWK, SUM(bluekills) AS BK, SUM(bluedeath) AS BD, SUM(blueassist) AS BA,SUM(reddragonkills) AS RDK, SUM(redbaronkills) AS RBK, SUM(redtowerkills) AS RTK, SUM(redinhibitorkills) AS RIK, SUM(redwardplaced) AS RWP, SUM(redwardkills) AS RWK, SUM(redkills) AS RK, SUM(reddeath) AS RD, SUM(redassist) AS RA
FROM Master_games;

--Percentage in middle game elements
CREATE VIEW Middle_Game_Master AS 
SELECT SUM(reddragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 - SUM(bluedragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 AS RDK
,SUM(redbaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 - SUM(bluebaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 AS RBK
, SUM(bluetowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 - SUM(redtowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 AS RTK
, SUM(blueinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 - SUM(redinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 AS RIK
,SUM(redWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 - SUM(blueWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 AS RWP
, SUM(blueWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 - SUM(redWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 AS RWK
, SUM(bluekills)/(SUM(redKills)+ SUM(bluekills))*100 - SUM(redkills)/(SUM(redkills)+ SUM(bluekills))*100 AS RK
, SUM(redDeath)/(SUM(redDeath)+ SUM(blueDeath))*100 - SUM(blueDeath)/(SUM(redDeath)+ SUM(blueDeath))*100 AS RD
, SUM(blueAssist)/(SUM(redAssist)+ SUM(blueAssist))*100 - SUM(redAssist)/(SUM(redAssist)+ SUM(blueAssist))*100 AS RA
FROM Master_games;

--Difference in epic mobs
SELECT SUM(bluedragonkills) AS BDK,SUM(bluebaronkills) AS BBK, SUM(reddragonkills) AS RDK, SUM(redbaronkills) AS RBK
FROM Master_games;

--PERCENTAGE in epic mobs
SELECT SUM(reddragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 - SUM(bluedragonkills)/(SUM(reddragonkills)+ SUM(bluedragonkills))*100 AS RDK
,SUM(bluebaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 - SUM(redbaronkills)/(SUM(redbaronkills)+ SUM(bluebaronkills))*100 AS RBK
FROM Master_games;

--Difference in structures

SELECT SUM(bluetowerkills) AS BTK, SUM(blueinhibitorkills) AS BIK, SUM(redtowerkills) AS RTK, SUM(redinhibitorkills) AS RIK
FROM Master_games;

--PERCENTAGE in structures differenc
SELECT SUM(redtowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 - SUM(bluetowerkills)/(SUM(redtowerkills)+ SUM(bluetowerkills))*100 AS RTK
, SUM(redinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 - SUM(blueinhibitorkills)/(SUM(redinhibitorkills)+ SUM(blueinhibitorkills))*100 AS RIK
FROM Master_games;


--Difference in vision

SELECT SUM(bluewardplaced) AS BWP, SUM(bluewardkills) BWK, SUM(redwardplaced) AS RWP, SUM(redwardkills) AS RWK
FROM Master_games;

--PERCENTAGE in vision difference
SELECT SUM(redWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 - SUM(blueWardPlaced)/(SUM(redWardPlaced)+ SUM(blueWardPlaced))*100 AS RWP
, SUM(blueWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 - SUM(redWardkills)/(SUM(redWardkills)+ SUM(blueWardkills))*100 AS RWK
FROM Master_games;

--Difference in total levels 

SELECT SUM(bluetotallevel) AS BTL, SUM(blueavglevel)BAL, SUM(redtotallevel)RTL, SUM(redavglevel)RAL FROM Master_games;

--PERCENTAGE total level difference
SELECT SUM(redtotallevel)/(SUM(redtotallevel)+ SUM(bluetotallevel))*100 - SUM(bluetotallevel)/(SUM(redtotallevel)+ SUM(bluetotallevel))*100 AS LevelDiff
,SUM(redavglevel)/(SUM(redavglevel)+ SUM(blueavglevel))*100 - SUM(blueavglevel)/(SUM(redavglevel)+ SUM(blueavglevel))*100 AS AVGLevelDiff
FROM Master_games;

--Difference in gold and minions

SELECT SUM(bluetotalgold) AS BTG, SUM(bluetotalminionkills) AS BMK, SUM(bluejungleminionkills) AS BJGMK, SUM(redtotalgold)RTG, SUM(redtotalminionkills) AS RMK, SUM(redjungleminionkills) AS RJGMK 
FROM Master_games;

--PERCENTAGE difference in gold and minions

SELECT SUM(redtotalgold)/(SUM(redtotalgold)+ SUM(bluetotalgold))*100 - SUM(bluetotalgold)/(SUM(redtotalgold)+ SUM(bluetotalgold))*100 AS TotalGoldDiff
,SUM(redtotalminionkills)/(SUM(redtotalminionkills)+ SUM(bluetotalminionkills))*100 - SUM(bluetotalminionkills)/(SUM(redtotalminionkills)+ SUM(bluetotalminionkills))*100 AS TotalMinionsDiff
,SUM(redjungleminionkills)/(SUM(redjungleminionkills)+ SUM(bluejungleminionkills))*100 - SUM(bluejungleminionkills)/(SUM(redjungleminionkills)+ SUM(bluejungleminionkills))*100 AS TotalJGMinDiff
FROM Master_games;


SELECT AVG(redkills), redwins FROM GM_Games GROUP BY redwins