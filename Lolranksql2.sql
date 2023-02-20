
USE LeagueRankeds;
--Querys for counting on how many games there weren't first turret kills

SELECT COUNT(*) FROM GM_Games  WHERE bluefirsttower = 0 and redfirsttower = 0
--Let's make that percentual
SELECT SUM(CASE WHEN redfirsttower = 0 and bluefirsttower = 0 THEN 1 ELSE 0 END) * 1.0/COUNT(gameId) * 100 FROM GM_Games;


-- Querys for counting on how many games there weren't first blood kills
SELECT COUNT(bluefirstblood) FROM GM_Games WHERE bluefirstblood = 0 and redfirstblood = 0; --TOTAL GAMES WHERE THERE WASNT FIRST BLOOD
SELECT SUM(CASE WHEN gameDuraton<220 THEN 1 ELSE 0 END) FROM GM_Games WHERE redfirstblood = 0 and bluefirstblood = 0;  -- TOTAL GAMES WHERE THERE WEREN'T FIRST BLOOD AND THERE WAS REMAKE
SELECT gameId, gameDuraton, redfirstblood, bluefirstblood FROM GM_Games WHERE gameDuraton > 220 and redfirstblood = 0 and bluefirstblood = 0; --GAMES WHERE THERE WERE FIRST BLOOD AND IT WASN'T REMAKE


-- Querys for counting on how many games there weren't first dragon kills
SELECT COUNT(gameId) FROM GM_Games WHERE redfirstdragon = 0 and bluefirstdragon= 0;
SELECT SUM(CASE WHEN gameDuraton<220 THEN 1 ELSE 0 END) FROM GM_Games WHERE redfirstdragon = 0 and bluefirstdragon = 0; -- TOTAL GAMES WHERE THERE WEREN'T FIRST BLOOD AND THERE WAS REMAKE
SELECT COUNT(*) FROM GM_Games WHERE gameDuraton > 220 and redfirstdragon = 0 and bluefirstdragon = 0; --GAMES WHERE THERE WERE FIRST BLOOD AND IT WASN'T REMAKE


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--CHALLENGER QUERYS

--Querys for counting on how many games there weren't first turret kills

SELECT COUNT(*) FROM Challenger_games  WHERE bluefirsttower = 0 and redfirsttower = 0
--Let's make that percentual
SELECT SUM(CASE WHEN redfirsttower = 0 and bluefirsttower = 0 THEN 1 ELSE 0 END) * 1.0/COUNT(gameId) * 100 FROM Challenger_games;


-- Querys for counting on how many games there weren't first blood kills
SELECT COUNT(bluefirstblood) FROM Challenger_games WHERE bluefirstblood = 0 and redfirstblood = 0; --TOTAL GAMES WHERE THERE WASNT FIRST BLOOD
SELECT SUM(CASE WHEN gameDuraton<220 THEN 1 ELSE 0 END) FROM Challenger_games WHERE redfirstblood = 0 and bluefirstblood = 0;  -- TOTAL GAMES WHERE THERE WEREN'T FIRST BLOOD AND THERE WAS REMAKE
SELECT gameId, gameDuraton, redfirstblood, bluefirstblood FROM Challenger_games WHERE gameDuraton > 220 and redfirstblood = 0 and bluefirstblood = 0; --GAMES WHERE THERE WERE FIRST BLOOD AND IT WASN'T REMAKE


-- Querys for counting on how many games there weren't first dragon kills
SELECT COUNT(gameId) FROM Challenger_games WHERE redfirstdragon = 0 and bluefirstdragon= 0;
SELECT SUM(CASE WHEN gameDuraton<220 THEN 1 ELSE 0 END) FROM Challenger_games WHERE redfirstdragon = 0 and bluefirstdragon = 0; -- TOTAL GAMES WHERE THERE WEREN'T FIRST BLOOD AND THERE WAS REMAKE
SELECT COUNT(*) FROM Challenger_games WHERE gameDuraton > 220 and redfirstdragon = 0 and bluefirstdragon = 0; --GAMES WHERE THERE WERE FIRST BLOOD AND IT WASN'T REMAKE



