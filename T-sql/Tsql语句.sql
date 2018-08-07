use master
go
create database mydata
ON PRIMARY
(NAME=student2,FILENAME='E:\Data\mydata.mdf',SIZE=3MB,MAXSIZE=6MB,FILEGROWTH=2MB)
LOG ON
(NAME=student2_log,FILENAME='E:\Data\mydata_log.ldf',SIZE=1MB,MAXSIZE=2MB,FILEGROWTH=1MB)
go
use mydata
go

drop table Category

create table Customers
(
  �û�ID int identity(600,1) primary key,
  �û��� nvarchar(100) not null,
  ���� nvarchar(200) not null,
  �Ա� nvarchar(2)  check(�Ա� in('��','Ů')),
  ���� int not null,
  ��ַ nvarchar(500) not null,
  �绰 nvarchar(20) not null,
  ��� decimal(18,2) default 0,
  �µ����� int default 0,
  ʡ�� nvarchar(100) ,
  ���� nvarchar(100) ,
)
go

--drop table Customers 
go

select * from Customers

update Customers set �µ�����=2 where �û�ID=601

insert into Customers(�û���,����,�Ա�,����,��ַ,�绰,���,ʡ��,����) values('������','cool','��',18,'��������ѧԺ','18857510000',10000,'�㽭ʡ','������')

 --����Ա��
CREATE TABLE [dbo].[admin](
	����Ա�� nvarchar(100) UNIQUE,
	���� nvarchar(200) NULL  
)
--drop table [admin]

insert into admin values('admin','admin')

select *from admin

--��Ʒ����
create table Category
(
���ID int identity(1,1) primary key,
����� nvarchar(100) not null
)
go
insert into Category(�����) values('new')
insert into Category(�����) values('hot')
insert into Category(�����) values('special')
go
--��Ʒ��
create table Product
(
   ��ƷID int identity(1,1) primary key,
   ��Ʒ�� nvarchar(100) not null,
   ԭ�� decimal(18,2) ,
   �ּ� decimal(18,2) ,   
   ��� nvarchar(Max) ,
   ͼƬ nvarchar(1000) not null,
   ��ͼ nvarchar(1000) ,
   ��Ʒ��� int foreign key references Category(���ID),
   ���� datetime default getdate(),
   ��ǩ nvarchar(20) ,
   ���� int default 0,
   UNIQUE (��Ʒ��)
)
select * from Product
insert into Product(��Ʒ��,ԭ��,�ּ�,���,ͼƬ,��ͼ,��Ʒ���,��ǩ) values('ICE CREAM PRINCESS',25.00,24.00,'ICE CREAM PRINCESS ICE CREAM PRINCESS','~\images\cake\img-cake-1.jpg','~\images\cake\img-cake-1.jpg',2,'hot')
insert into Product(��Ʒ��,ԭ��,�ּ�,���,ͼƬ,��ͼ,��Ʒ���,��ǩ) values('BREAD CAKE 1',30.00,24.00,'BREAD CAKE 1 BREAD CAKE 1','~\images\cake\img-cr-1.jpg','~\images\cake\img-cr-1.jpg',3,'special')
insert into Product(��Ʒ��,ԭ��,�ּ�,���,ͼƬ,��ͼ,��Ʒ���,��ǩ) values('BREAD CAKE 2',30.00,24.00,'BREAD CAKE 2 BREAD CAKE 2','~\images\cake\img-cr-2.jpg','~\images\cake\img-cr-2.jpg',3,'special')
insert into Product(��Ʒ��,ԭ��,�ּ�,���,ͼƬ,��ͼ,��Ʒ���,��ǩ) values('BREAD CAKE 3',30.00,24.00,'BREAD CAKE 3 BREAD CAKE 3','~\images\cake\img-cr-3.jpg','~\images\cake\img-cr-3.jpg',3,'special')
insert into Product(��Ʒ��,ԭ��,�ּ�,���,ͼƬ,��ͼ,��Ʒ���,��ǩ) values('BREAD CAKE 4',30.00,24.00,'BREAD CAKE 4 BREAD CAKE 4','~\images\cake\img-cr-4.jpg','~\images\cake\img-cr-4.jpg',3,'special')

update Product set ԭ��=0 where ��ƷID=1

--5.������������(�Զ����)���û��š��µ����ڡ��ܼۡ�����״̬
CREATE TABLE [dbo].[orders]
(
	������ int identity(100001,1) primary key,
	�û��� [int] foreign key references Customers(�û�ID),
	�µ����� [datetime]  default getdate(),
	�ܼ� [numeric](18, 2) NULL,
	����״̬ nvarchar(100), 
	�������� nvarchar(1000)
)
--drop table Product

GO
--6.��������������š���Ʒ�š�������С���ܼ�
CREATE TABLE [dbo].[orderDetails](
	������ int foreign key references [orders](������),
	��Ʒ�� [int] NOT NULL foreign key references [product](��ƷID),
	��Ʒ�� nvarchar(100) not null,
	��Ʒͼ nvarchar(1000) not null,
	���� [int] ,
	С���ܼ� [decimal](18, 2) ,
 CONSTRAINT [PK_orderDetails] PRIMARY KEY CLUSTERED (������ ASC,��Ʒ�� ASC)
) 
go

select * from [orders]
select * from [orderDetails]
go

--7.��Ʒ�ղر��û��š���Ʒ�š���Ʒ������Ʒͼ����Ʒ�۸�
CREATE TABLE [dbo].[Collection](
	�û��� int foreign key references Customers(�û�ID),
	��Ʒ�� [int] NOT NULL foreign key references [product](��ƷID),
	��Ʒ�� nvarchar(100) not null,
	��Ʒͼ nvarchar(1000) not null,
	��Ʒ�۸� [decimal](18, 2) ,
 CONSTRAINT [PK_Collection] PRIMARY KEY CLUSTERED (�û��� ASC,��Ʒ�� ASC)  --��������Ψһ��
) 
go

select * from [Collection]

delete from [Collection] where ��Ʒ��=1 and �û���=600

--8.���۱��û��ţ��û�������Ʒ�ţ���Ʒ�������ۣ��������ͣ�����ʱ��
CREATE TABLE [dbo].[Evaluate](
	������ int foreign key references [orders](������),    
	�û��� int foreign key references Customers(�û�ID),
	�û��� nvarchar(100) not null,
	��Ʒ�� [int] NOT NULL foreign key references [product](��ƷID),
	��Ʒ�� nvarchar(100) not null,
	���� nvarchar(1000) DEFAULT '���û�û����д���ۡ�',	
	�������� int check (�������� in(-1,0,1)),
	����ͼ nvarchar(1000),
	����ʱ�� datetime default getdate(),
) 
go
select * from [Evaluate]

--get_Orderid�洢���̣�[orders]��top id ��[orderDetails]
create proc get_Orderid @userid nvarchar(20)
as
select top 1 ������
from orders
where �û���=@userid order by ������ desc
go

exec get_Orderid '101'
go

--update_Product�洢���̣��޸���Ʒ��Ϣ
create proc update_Product @name nvarchar(100), @price decimal(18,2),  @desc nvarchar(1000), @imgpath nvarchar(1000), @typeid int, @id int
as
update Product set ԭ��=�ּ� where ��ƷID=@id
update Product set ��Ʒ��=@name,�ּ�=@price,���=@desc,ͼƬ=@imgpath,��Ʒ���=@typeid where ��ƷID=@id
go

--drop proc Order_User
select * from Product
exec update_Product 'pptest','20','test test','~\images\cake\img-cake-1.jpg','2',1
go

--Order_User�洢���̣��µ��������޸Ķ���״̬���޸Ŀͻ����
create proc Order_User @userid nvarchar(20), @orderid int
as
declare @toPrice decimal(18,2)
select @toPrice=(select �ܼ� from orders where ������=@orderid)
if((select ����״̬ from orders where ������=@orderid)='������' and (select ��� from Customers where �û�ID=@userid) >=@toPrice) 
begin
update  orders set ����״̬='�Ѹ���' where ������=@orderid
update  Customers set ���=���-@toPrice where �û�ID=@userid
end
go

exec Order_User '101',11
go

--drop proc update_Product
go

--Update_Order�洢���̣��޸Ķ���״̬
create proc Update_Order @oldstate nvarchar(20),@newstate nvarchar(20), @orderid int
as
update  [orders] set ����״̬=@newstate where ������=@orderid and ����״̬=@oldstate
go

exec Update_Order '�Ѹ���','���ջ�',17
go

--order_addnum��������orders��Ӷ���ʱ�������û��µ�����+1,(orderDetails���Ϊ��������)
create trigger order_addnum
on orders 
after  insert
as
update Customers set �µ�����=�µ�����+1 where �û�ID in(select �û��� from inserted)
go

drop trigger order_addnum
insert into [orders](������,�û���) values(100001,603)

select * from [orders]
select * from [orderDetails]

create trigger order_delnum
on orders 
after  delete
as
update Customers set �µ�����=�µ�����-1 where �û�ID in(select �û��� from deleted) and �µ�����>0
go

--order_ddel��������[orderDetails]��ĳ������ɾ��֮���ͬʱ����ɾ��orders�Ķ�����,�����û��µ�����-1��
--��orders��orderDetails���Լ����������ɾ�����ɿ����� Instead of ��������
--������ʹ�õ�����ɾ��orderDetails������ɾ��orders��Ӧ��ķ���������orders�ͱܿ���orderDetails���Լ����
--��Ȼ���߼����е���룬��Ч������ Instead of ������������һ���ġ�

create trigger order_ddel
on [orderDetails]
after  delete
as
if (select ����״̬ from orders where ������ in(select ������ from deleted))<>'������'
begin
raiserror('�û��Ѹ��������ɾ����',16,1)
rollback transaction
end
else
begin
delete from orders where ������ in(select ������ from deleted)
update Product set ����=����-(select ���� from deleted) where ��ƷID in(select ��Ʒ�� from deleted) and ����>0
end
go

select * from Product 


drop trigger order_ddel
go

--һ��������������ÿ��[orderDetails]����һ����Ϣ���򴥷���Ӧ��Ʒ����+n
create trigger sales_order
on [orderDetails]
after  insert
as
update Product set ����=����+(select ���� from inserted) where ��ƷID in(select ��Ʒ�� from inserted)
go

--drop trigger sales_order

--����ToCustomers��ͼ,��ȡ�û�������Ϣ
create view ToCustomers
as
select �û�ID,�û���,�Ա�,����,��ַ,�绰,�µ����� from Customers
go

--drop view ToCustomers

select *from ToCustomers
go

--����ToOrders��ͼ,��ȡ������������������Ϣ
create view ToOrders(������,�ܼ�,����״̬,��Ʒ��,��Ʒ��,��Ʒͼ,����,С���ܼ�)
as
select orderDetails.������,�ܼ�,����״̬,��Ʒ��,��Ʒ��,��Ʒͼ,����,С���ܼ� from orders,orderDetails 
where orders.������=orderDetails.������
go

--drop view ToOrders

select *from ToOrders
go

--����SpecialProdect��ͼ,��ȡSpecial(3)������Ʒ��������վ�����ֲ�չʾ
create view SpecialProdect
as
SELECT * FROM Product where ��Ʒ���=3
go

--drop view SaleProdect

select *from SpecialProdect
go

--SaleProdect��Ʒ������ͼ,�ṩ����Աͳ������
create view SaleProdect
as
SELECT ��ƷID,��Ʒ��,��Ʒ���,����,(�ּ�*����)�����ܶ� FROM Product 
go

select * from SaleProdect order by ���� desc,�����ܶ� desc

select SUM(����),SUM(�����ܶ�) from SaleProdect


delete from [orderDetails] where ������='8'


update  [orders] set ����״̬='���ջ�' where ������=11 and ����״̬='�Ѹ���'
update  [orders] set ����״̬='������' where ������=@orderid and ����״̬='���ջ�'
update  Customers set ���+=100 where �û�ID=101
select * from Customers
select * from [orders]
select * from [orderDetails]
select * from Product
go
delete from Customers where �û�ID=602

