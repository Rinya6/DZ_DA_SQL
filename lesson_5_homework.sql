--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5) +)
-- ������������ �����: ������� view (pages_all_products), � ������� ����� ������������ �������� ���� ���������
--(�� ����� ���� ��������� �� ����� ��������). �����: ��� ������ �� laptop, ����� ��������, ������ ���� �������

create or replace view pages_all_products as
SELECT * ,
	CASE WHEN total % 2 = 0 THEN total/2 ELSE total/2 + 1 END AS page_number, 
    CASE WHEN num_of_pages % 2 = 0 THEN num_of_pages/2 ELSE num_of_pages/2 + 1 END AS number_pages
FROM (
      SELECT *, ROW_NUMBER() OVER(ORDER BY price DESC) AS total, 
             COUNT(*) OVER() AS num_of_pages 
      FROM Laptop
) a;
select * from pages_all_products 

        
--task2 (lesson5) +
-- ������������ �����: ������� view (distribution_by_type), � ������ �������� ����� ���������� ����������� ���� ������� �� ���� ����������. 
--�����: �������������,

create or replace view distribution_by_type as
select maker, ROUND(count(model)*100/(select count(model) from product))
from 
(
select *
from 
	(select product.model, product.type, maker
	from product
	join pc 
	on product.model = pc.model 
union all 
	select product.model, product.type, maker
	from product
	join printer
	on product.model = printer.model 
)a 
)a1
group by maker;

select * from distribution_by_type


--task3 (lesson5) -
-- ������������ �����: ������� �� ���� ����������� view ������ - �������� ���������

----- ���� ������ 

--task4 (lesson5) +
-- �������: ������� ����� ������� ships (ships_two_words), �� � �������� ������� ������ �������� �� ���� ����

create or replace view ships_two_words as
select * from ships where name like '% %';

 --- ��������
select * from ships_two_words

--task5 (lesson5) +
-- �������: ������� ������ ��������, � ������� class ����������� (IS NULL) � �������� ���������� � ����� "S"

select *
from ships 
where class is NULL AND class LIKE 'S%';


--task6 (lesson5) +?
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'C' 
-- � ��� ����� ������� (����� ������� �������). ������� model


SELECT *  FROM (
select p1.model, row_number () over (order by price) as rn
from printer p1 join product p2 on p1.model = p2.model where maker = 'A'
and price > (select avg(price) from  printer p1 join product p2 on p1.model = p2.model where maker = 'C' is not null)
) a 
where rn <= 3


