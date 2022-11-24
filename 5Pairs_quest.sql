CREATE DATABASE pair;
USE pair;

CREATE TABLE pairs (m INT, n INT);

INSERT INTO pairs VALUES (1,2), (2,4), (2,1), (2,3), (3,2), (4,2), (5,6), (6,5), (7,8);


--  # REOMOVE reversed pairs
--  M-1 : JOIN
SELECT lt.* FROM pairs lt LEFT JOIN pairs rt ON rt.m = lt.n AND rt.n = lt.m
WHERE rt.m IS NULL OR lt.m < rt.m;

-- M-2 : Co-related Sub-query
SELECT lt.* FROM pairs lt WHERE NOT EXISTS
(SELECT rt.* FROM PAIRS rt WHERE lt.m = rt.n AND lt.n = rt.m AND lt.m > rt.m);