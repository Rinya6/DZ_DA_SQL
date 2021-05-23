--task1  (lesson8) 
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

SELECT d.Name AS 'Department', e.Name AS 'Employee', e.Salary
FROM Employee e
JOIN Department d
ON e.DepartmentId = d.Id
WHERE 3 > (SELECT COUNT(DISTINCT e1.Salary)
           FROM Employee e1
           WHERE e1.Salary > e.Salary
           AND e.DepartmentId = e1.DepartmentId
           );


--task2  (lesson8) 
-- https://sql-academy.org/ru/trainer/tasks/17
          
SELECT member_name, status, SUM(amount*unit_price) as costs
FROM FamilyMembers f
JOIN Payments p
ON p.family_member = f.member_id
WHERE YEAR(p.date) = 2005
GROUP BY member_name, status        
          

--task3  (lesson8) 
-- https://sql-academy.org/ru/trainer/tasks/13
          
SELECT name
from Passenger
GROUP BY name
HAVING Count(name)>1 


--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT count(first_name) as count
FROM Student
where first_name = 'Anna'


--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

SELECT count(classroom) as count 
from Schedule
WHERE date = '2019-09-02'


--task6  (lesson8) - ฯฮยาฮะ
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT count(first_name) as count
FROM Student
where first_name = 'Anna'


--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

SELECT floor(avg(AGE)) AS AGE
from
(SELECT year(birthday), 
(
    (YEAR(CURRENT_DATE) - YEAR(birthday)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d'))
  ) AS age
FROM FamilyMembers)a


--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

SELECT good_type_name, SUM(p.amount*p.unit_price) as costs
FROM Goods g
JOIN Payments p
ON p.good = g.good_id
join GoodTypes gt
on gt.good_type_id = g.type
WHERE YEAR(p.date) = 2005
GROUP BY good_type_name


--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37

SELECT min(age) as YEAR 
from
(SELECT
(
    (YEAR(CURRENT_DATE) - YEAR(birthday)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d'))
  ) AS age
FROM Student)a

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44

SELECT max(age) as max_year 
from
(SELECT
(
    (YEAR(CURRENT_DATE) - YEAR(birthday)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d'))
  ) AS age
FROM Student
join Student_in_class
on Student.id = Student_in_class.student
join Class
on class.id = Student_in_class.class
where class.name like '10%')a


--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

SELECT member_name, status, SUM(amount*unit_price) as costs
FROM FamilyMembers f
JOIN Payments p
ON p.family_member = f.member_id
join Goods g
on g.good_id = p.good
join GoodTypes gt
on g.type = gt.good_type_id
WHERE good_type_name = 'entertainment'
GROUP BY member_name, status  


--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55

---???

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

---???

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

SELECT last_name
from Teacher t 
JOIN Schedule s 
on t.id = s.teacher
join Subject su 
on s.subject = su.id
where name = 'Physical Culture'
ORDER BY last_name


--task15  (lesson8) 
-- https://sql-academy.org/ru/trainer/tasks/63

---???
