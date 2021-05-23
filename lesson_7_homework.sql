--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: ������� �������� ������ � �� (sqlite3, project name: task1_7). 
---� ������� table1 �������� 1000 ����� � ���������� ���������� (3 �������, ��� int) �� 0 �� 1000.
-- ����� ��������� ����������� ������������� ���� ���� �������

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

