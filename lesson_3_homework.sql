--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1 +
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. 
--Вывести: класс и число потопленных кораблей.

SELECT COUNT(name), class
from ships s 
join outcomes o 
on s.name = o.ship
where result = 'sunk'
GROUP BY class 


--task2 +
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. 
--Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. 
--Вывести: класс, год.

select classes.class, min(launched)
from classes
left join ships
on ships.class = classes.class
group by classes.class


--task3 +?
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, 
--вывести имя класса и число потопленных кораблей.

select a.class, count(result)
from 
(
	select class, result
	from classes 
	join outcomes
	on classes.class = outcomes.ship
	where result = 'sunk'
union all
	select class, result
	from ships
	join outcomes
	on ships.name = outcomes.ship
	where result = 'sunk'
	
)a
group by class
HAVING COUNT(class) >= 3


--task4 +
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения 
--(учесть корабли из таблицы Outcomes).


select name, numguns, displacement
from classes c
join ships s
on s.name = c.class
join outcomes o
on s.name = o.ship
where numguns = (select max(numguns) from classes c join ships s on s.name = c.class) 
	or displacement = (select max(displacement) from classes c join ships s on  s.name = c.class)


--task5 + ?
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM 
--и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

select maker
from 
(
	select maker 
	from printer 
	join product 
	on product.model = printer.model 
union all	
	select maker
	from pc
	join product
	on pc.model = product.model
	where ram = (select min(ram) from pc) and speed = (select max(speed) from pc)
)a
group by maker
