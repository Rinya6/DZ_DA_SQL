--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

SELECT 
CASE 
    WHEN G.Grade < 8 THEN NULL
    ELSE S.Name
END,
G.Grade, S.Marks
FROM Students S
JOIN Grades G
ON S.Marks BETWEEN G.Min_Mark AND G.Max_Mark
ORDER BY G.Grade DESC, S.Name ASC;

--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem

select doctor, professor, singer, actor
from 
( 
select row_number() over(partition by Occupation order by Name) ron, Name as n, Occupation as o from OCCUPATIONS 
) pro 
pivot (max(n) for o in ('Doctor' as doctor,'Actor' as actor,'Professor' as professor,'Singer' as singer))
order by ron asc;

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem

SELECT DISTINCT CITY
FROM STATION 
WHERE
    city not LIKE 'A%' and
    city not LIKE 'E%' and
    city not LIKE 'I%' and
    city not LIKE 'O%' and
    city not LIKE 'U%' 
ORDER BY CITY ASC;

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem

SELECT DISTINCT CITY
FROM STATION 
WHERE
    city not LIKE '%a' AND
    city not LIKE '%e' AND
    city not LIKE '%i' AND
    city not LIKE '%o' AND
    city not LIKE '%u' 
ORDER BY CITY ASC;

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem

SELECT DISTINCT CITY
FROM STATION 
WHERE
    (city not LIKE 'A%' AND 
     city not LIKE 'E%' AND
     city not LIKE 'I%' AND
     city not LIKE 'O%' AND
     city not LIKE 'U%') OR
    (city not LIKE '%a' AND 
     city not LIKE '%e' AND
     city not LIKE '%i' AND
     city not LIKE '%o' AND
     city not LIKE '%u')
ORDER BY CITY ASC;

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem

SELECT DISTINCT CITY
FROM STATION 
WHERE
    (city not LIKE 'A%' AND 
     city not LIKE 'E%' AND
     city not LIKE 'I%' AND
     city not LIKE 'O%' AND
     city not LIKE 'U%') AND
    (city not LIKE '%a' AND 
     city not LIKE '%e' AND
     city not LIKE '%i' AND
     city not LIKE '%o' AND
     city not LIKE '%u')
ORDER BY CITY ASC;

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem

SELECT name
from Employee
where salary > 2000 and months < 10
order by employee_id asc

--task8  (lesson9) - ÏÎÂÒÎÐ
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
           
--------ÏÎÂÒÎÐ - task1  (lesson9)
select s.name, g.grade, s.marks 
from students s, grades g 
where g.grade>=8 and s.marks between g.min_mark and g.max_mark 
order by g.grade desc, s.name;
select 'NULL', g.grade, s.marks 
from students s, grades g 
where g.grade<8 and s.marks between g.min_mark and g.max_mark 
order by g.grade desc, s.marks;