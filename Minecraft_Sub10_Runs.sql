--Katherine Cinnamon
--Dataset: Minecraft Speedrun Splits for runs faster than 10 min
--Source: Minecraft RSG Leaderboard

SELECT * FROM dbo.splits_data

-- List of runners that have at least 3 sub 10s and their average time ordered by number of runs

SELECT
	Name,
	COUNT(*) as num_runs
FROM dbo.splits_data
GROUP BY Name
HAVING COUNT(*) >= 3
ORDER BY num_runs DESC

-- Which 3 runners have the most runs in the top 50 

SELECT TOP 3 WITH TIES
	Name,
	COUNT(*) as num_runs
FROM (
	SELECT TOP 50
		Name
	FROM dbo.splits_data
	ORDER BY Rank DESC) top_50_runs
GROUP BY Name
ORDER BY num_runs DESC

-- Total number of sub 10 runs by Iron_Source type

SELECT
	Iron_Source,
	COUNT(*) as num_runs
FROM dbo.splits_data
GROUP BY Iron_Source
ORDER BY num_runs DESC
	
--* I noticed there are 2 runs with typos for the Iron_Source so I want to investigate and fix this issue

SELECT
	Name,
	Time_IGT,
	Iron_Source
FROM dbo.splits_data
WHERE Iron_Source = 'Mapless Treausre'

UPDATE dbo.splits_data
SET Iron_Source = 'Mapless Treasure'
WHERE Iron_Source = 'Mapless Treausre'

-- Total number of sub 10 runs by Enter_Type

SELECT
	Enter_Type,
	COUNT(*) as num_runs
FROM dbo.splits_data
GROUP BY Enter_Type
ORDER BY num_runs DESC

-- Total number of sub 10 runs by Bastion_Type

SELECT
	Bastion_Type,
	COUNT(*) as num_runs
FROM dbo.splits_data
GROUP BY Bastion_Type
ORDER BY num_runs DESC


