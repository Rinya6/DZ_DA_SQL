--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). 
---В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

--???

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/

select distinct Email 
from Person
where Email in (select Email from Person
group by Email having count(Email) > 1)


--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/

select s.name as Employee
from employee s join employee m 
on s.managerid = m.id
where s.salary > m.salary


--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/

select Score, Dense_Rank() over(order by Score desc) as 'Rank' 
from Scores


--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/

select FirstName, LastName, City, State
from Person p
left Join Address a
on p.PersonId = a.PersonId

