--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3) +
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). 
--�������: model, maker, type

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
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, 
--� ���� ���� ����� ������� PC - "1", � ��������� - "0"

	select * ,
case
	when price > (select avg(price) from pc)
	then 1
	else 0
end flag 
from printer
	
	
--task15 (lesson3) +
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)

select *
from ships 
where class is null


--task16 (lesson3) +
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.
 
select name
from battles
where date not in
     (select date
      from battles
      where date not in (select launched from battles CONVERT(datetime, launched)) --- ����� ��������� ���� � ���???
      )
    

--task17 (lesson3) +
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.

select battle
from outcomes 
  where ship in (select name from ships where class = 'Kongo')

  
  select distinct battle from outcomes
where ship in (select name
               from ships
               where class = 'kongo')

--task1  (lesson4) +
-- ������������ �����: ������� view (�������� all_products_flag_0300) ��� ���� ������� (pc, printer, laptop) 
-- � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag

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
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, 
--���� ��������� ������ c������ . �� view ��� �������: model, price, flag

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
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. 
--������� model

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
-- ������������ �����: ������� ��� ������ ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'.
-- ������� model

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
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)

select (
((select avg(price)	from product p1 join printer p2	on p1.model = p2.model	where maker ='A')
+
(select avg(price) from product p1 join laptop p2 on p1.model = p2.model where maker ='A')
+
(select avg(price) from product p1 join pc p2 on p1.model = p2.model where maker ='A')
)/3
)

--task6 (lesson4) +
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. 
--�� view: maker, count

create or replace view count_products_by_makers as
select maker, count(model) from product group by maker;

--- ��������
select * from count_products_by_makers


--task7 (lesson4) - 
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)

---������ � ��������� ����� "Lesson_4_homework_Colab"

--task8 (lesson4) +
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'

create table if not exists printer_updated as table printer;
delete from  printer_updated
where model in (select  p2.model from product p1 join printer p2  on p1.model = p2.model	where maker ='D');

--- ��������
select * from printer_updated u join product p1 on p1.model = u.model

--task9 (lesson4) +
-- ������������ �����: ������� �� ���� ������� (printer_updated) view 
---� �������������� �������� ������������� (�������� printer_updated_with_makers)

create or replace view printer_updated_with_makers as 
select product.maker, printer_updated.* from printer_updated
left join product on printer_updated.model = product.model;

---��������
select * from printer_updated_with_makers

--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes).
--- �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)

--task11 (lesson4)
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)

--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0

--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)

--task14 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".

--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.

--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)
