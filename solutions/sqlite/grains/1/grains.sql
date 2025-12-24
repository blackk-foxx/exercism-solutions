-- Schema: CREATE TABLE "grains" ("task" TEXT, "square" INT, "result" INT);
-- Task: update the grains table and set the result based on the task (and square fields).


WITH RECURSIVE squares(square) AS (
    SELECT 1
    UNION ALL
    SELECT square + 1 FROM squares WHERE square < 64
),
total_sum AS (
    SELECT SUM(POWER(2, square - 1)) AS total
    FROM squares
)
UPDATE grains
SET result = CASE
    WHEN task = "single-square" THEN POWER(2, square - 1) 
    WHEN task = "total" THEN (SELECT total from total_sum)
END;
