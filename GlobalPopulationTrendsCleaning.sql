UPDATE population.trends
SET `Birth Rate` = NULL
WHERE `Birth Rate` = 0;

UPDATE population.trends
SET `Death Rate` = NULL
WHERE `Death Rate` = 0;

UPDATE population.trends
SET `Fertility Rate` = NULL
WHERE `Fertility Rate` = 0;