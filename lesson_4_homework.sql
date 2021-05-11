--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3) +
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). 
--Вывести: model, maker, type

		select product.model, maker, product.type
		from pc 
		join product
		on pc.model = product.model
	union all
		select product.model, maker, product.type
		from printer
		join product
		on printer.model = product.model
	union all
		select product.model, maker, product.type
		from laptop
		join product
		on laptop.model = product.model



--task14 (lesson3) +
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, 
--у кого цена вышей средней PC - "1", у остальных - "0"

	select * ,
case
	when price > (select avg(price) from pc)
	then 1
	else 0
end flag 
from printer
	
	
--task15 (lesson3) +
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)

select *
from ships 
where class is null


--task16 (lesson3) +
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
 
select name
from battles
where date not in
     (select date
      from battles
      where date not in (select launched from battles CONVERT(datetime, launched)) --- нужно перевести дату в год???
      )
    

--task17 (lesson3) +
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select battle
from outcomes 
  where ship in (select name from ships where class = 'Kongo')

  
  select distinct battle from outcomes
where ship in (select name
               from ships
               where class = 'kongo')

--task1  (lesson4) +
-- Компьютерная фирма: Сделать view (название all_products_flag_0300) для всех товаров (pc, printer, laptop) 
-- с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag

create or replace view all_products_flag_0300 as
	select p1.model, price
	from product p1
	join pc p2 
	on p1.model = p2.model
union all	
	select p1.model, price
	from product p1
	join printer p2 
	on p1.model = p2.model
union all
	select p1.model, price
	from product p1
	join laptop p2 
	on p1.model = p2.model;
select *,
case
	when price > 300
	then 1
	else 0
end flag 
from all_products_flag_0300


--task2  (lesson4) +
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, 
--если стоимость больше cредней . Во view три колонки: model, price, flag

create or replace view all_products_flag_avg_price as
	select p1.model, price
	from product p1
	join pc p2 
	on p1.model = p2.model
union all	
	select p1.model, price
	from product p1
	join printer p2 
	on p1.model = p2.model
union all
	select p1.model, price
	from product p1
	join laptop p2 
	on p1.model = p2.model;
select *,
case
	when price > (select avg(price) from all_products_flag_avg_price)
	then 1
	else 0
end flag 
from all_products_flag_avg_price

--task3  (lesson4) +
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. 
--Вывести model

select printer.model
from printer
join product
on printer.model = product.model
where maker = 'A' or 
price > (select ((select avg(price) from product join printer
on printer.model = product.model where maker = 'D')
+ (select avg(price) from product join printer
on printer.model = product.model where maker = 'C'))/2)


--task4 (lesson4) +
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'.
-- Вывести model

select *
from printer
join product
on printer.model = product.model
where maker = 'A' or 
price > (select ((select avg(price) from product join printer
on printer.model = product.model where maker = 'D')
+ (select avg(price) from product join printer
on printer.model = product.model where maker = 'C'))/2)

--task5 (lesson4) +
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)

select (
((select avg(price)	from product p1 join printer p2	on p1.model = p2.model	where maker ='A')
+
(select avg(price) from product p1 join laptop p2 on p1.model = p2.model where maker ='A')
+
(select avg(price) from product p1 join pc p2 on p1.model = p2.model where maker ='A')
)/3
)

--task6 (lesson4) +
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. 
--Во view: maker, count

create or replace view count_products_by_makers as
select maker, count(model) from product group by maker;

--- проверка
select * from count_products_by_makers


--task7 (lesson4) - 
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

---График в отдельном файле "Lesson_4_homework_Colab"

--task8 (lesson4) +
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'

create table if not exists printer_updated as table printer;
delete from  printer_updated
where model in (select  p2.model from product p1 join printer p2  on p1.model = p2.model	where maker ='D');

--- проверка
select * from printer_updated u join product p1 on p1.model = u.model

--task9 (lesson4) +
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view 
---с дополнительной колонкой производителя (название printer_updated_with_makers)

create or replace view printer_updated_with_makers as 
select product.maker, printer_updated.* from printer_updated
left join product on printer_updated.model = product.model;

---проверка
select * from printer_updated_with_makers

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes).
--- Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)

--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0

--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)

--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.

--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
