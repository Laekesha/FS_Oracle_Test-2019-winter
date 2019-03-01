-- 3. Structure creation.

create table A_SHOPS (
	ID number(20) not null
	  constraint A_SHOP_PK primary key,
 	NAME varchar2(200) not null,
 	REGION varchar2(200) not null,
 	CITY varchar2(200) not null,
	ADDRESS varchar2(200) not null,
 	MANAGER_ID number(20) not null
);

create table A_EMPLOYEES (
	 ID number(20) not null
	   constraint A_EMPLOYEES_PK
  		primary key,
 	 FIRST_NAME varchar2(100) not null,
 	 LAST_NAME varchar2(100) not null,
 	 PHONE varchar2(50) not null,
 	 E_MAIL varchar2(50) not null,
 	 JOB_NAME varchar2(50) not null,
 	 SHOP_ID number(20,0)
 	);

alter table A_SHOPS  add constraint A_SHOPS_A_EMPLOYEES_ID_FK FOREIGN KEY (MANAGER_ID)
  references A_EMPLOYEES (ID) deferrable initially deferred;

alter table A_EMPLOYEES add constraint A_EMPLOYEES_A_SHOPS_SHOP_ID_FK foreign key (SHOP_ID)
  references A_SHOPS (ID) deferrable initially deferred;

create table A_PRODUCTS  (
	 ID number(20) not null
 		constraint A_PRODUCTS_PK
  			primary key,
 	 CODE VARCHAR2(50) not null,
 	 NAME VARCHAR2(200) not null
);

create table A_PURCHASES (
	 ID number(20) not null
		constraint A_PURCHASES_PK
  			primary key,
 	 DATETIME date not null,
 	 AMOUNT number(20) not null,
 	 SELLER_ID number(20)
		constraint A_PURCHASES_A_EMPLOYEES_ID_FK
  			references A_EMPLOYEES
);

create table A_PURCHASE_RECEIPTS (
	 PURCHASE_ID number(20) not null
		constraint A_PURCHASE_RECEIPTS_A_PURCHASES_ID_FK
 	 		references A_PURCHASES
       deferrable initially deferred,
 	 ORDINAL_NUMBER number(5) not null,
 	 PRODUCT_ID number(20) not null
		constraint A_PURCHASE_RECEIPTS_A_PRODUCTS_ID_FK
  			references A_PRODUCTS,
  			  --deferrable initially deferred,
 	 QUANTITY number(25,5) not null,
 	 AMOUNT_FULL number(20) not null,
 	 AMOUNT_DISCOUNT number(20) not null,
		constraint A_PURCHASE_RECEIPTS_PK_2
			primary key (PURCHASE_ID, ORDINAL_NUMBER)
);

create unique index A_PRODUCTS_CODE_UINDEX on A_PRODUCTS (CODE);

/

-- 4. Data generation.

-- создание и заполнение вспомогательных таблиц

create table A_SHOP_NAME
(NAME varchar2(200));

insert into A_SHOP_NAME values ('Noni');

insert into A_SHOP_NAME values ('Pepino');

insert into A_SHOP_NAME values ('Mushmula');

insert into A_SHOP_NAME values ('Datura');

insert into A_SHOP_NAME values ('Velvichia');

insert into A_SHOP_NAME values ('Kosmey');

insert into A_SHOP_NAME values ('Kinkan');

insert into A_SHOP_NAME values ('Neomarika');

insert into A_SHOP_NAME values ('Nertera');

insert into A_SHOP_NAME values ('Litops');

create table A_REGION
(REGION varchar2(200));

insert into A_REGION values ('Svealand');

insert into A_REGION values ('Norrland');

insert into A_REGION values ('Gotaland');

create table A_CITY
(CITY varchar2(200));

insert into A_CITY values ('Stockholm');

insert into A_CITY values ('Gothenburg');

insert into A_CITY values ('Malmo');

insert into A_CITY values ('Uppsala');

insert into A_CITY values ('Orebro');

insert into A_CITY values ('Linkoping');

insert into A_CITY values ('Helsinborg');

insert into A_CITY values ('Jonkoping');

insert into A_CITY values ('Lund');

insert into A_CITY values ('Umea');

create table A_ADDRESS_STREET
(STREET varchar2(200));

insert into A_ADDRESS_STREET values ('Langa Gatan');

insert into A_ADDRESS_STREET values ('Strandvagen');

insert into A_ADDRESS_STREET values ('Svartensgaten');

insert into A_ADDRESS_STREET values ('Ringvagen');

insert into A_ADDRESS_STREET values ('Storgatan');

insert into A_ADDRESS_STREET values ('Skolgatan');

insert into A_ADDRESS_STREET values ('Huvudgata');

insert into A_ADDRESS_STREET values ('Kanalgata');

insert into A_ADDRESS_STREET values ('Malarstrand');

insert into A_ADDRESS_STREET values ('Augustendalsvagen');

create table A_FIRST_NAME
(FIRST_NAME varchar2(100));

insert into A_FIRST_NAME values ('Karl');

insert into A_FIRST_NAME values ('Gustav');

insert into A_FIRST_NAME values ('Anders');

insert into A_FIRST_NAME values ('Mikael');

insert into A_FIRST_NAME values ('Olof');

insert into A_FIRST_NAME values ('Eva');

insert into A_FIRST_NAME values ('Ida');

insert into A_FIRST_NAME values ('Sara');

insert into A_FIRST_NAME values ('Katarina');

insert into A_FIRST_NAME values ('Ulrika');

create table A_LAST_NAME
(LAST_NAME varchar2(100));

insert into A_LAST_NAME values ('Svensson');

insert into A_LAST_NAME values ('Lindberg');

insert into A_LAST_NAME values ('Karlsstrom');

insert into A_LAST_NAME values ('Nilsgren');

insert into A_LAST_NAME values ('Lind');

insert into A_LAST_NAME values ('Berglund');

insert into A_LAST_NAME values ('Wallin');

insert into A_LAST_NAME values ('Lundin');

insert into A_LAST_NAME values ('Holm');

insert into A_LAST_NAME values ('Bergman');

insert into A_LAST_NAME values ('Blomqvist');

insert into A_LAST_NAME values ('Hansen');

create table A_JOB_NAME
(JOB_NAME varchar2(50));

insert into A_JOB_NAME values ('Охранник');

insert into A_JOB_NAME values ('Уборщик');

insert into A_JOB_NAME values ('Бухгалтер');

insert into A_JOB_NAME values ('Юрист');

insert into A_JOB_NAME values ('Маркетолог');

insert into A_JOB_NAME values ('Грузчик');

insert into A_JOB_NAME values ('Водитель');

insert into A_JOB_NAME values ('HR-менеджер');

insert into A_JOB_NAME values ('Менеджер по закупкам');

insert into A_JOB_NAME values ('Системный администратор');

insert into A_JOB_NAME values ('Программист');

insert into A_JOB_NAME values ('Кладовщик');

/

create function gen_select (TABLE_NAME in varchar2)
return varchar2
as

RANDOM_VALUE varchar2(200);

begin
      execute immediate 'select * from ' || TABLE_NAME || ' order by DBMS_RANDOM.value offset 0 rows fetch next 1 rows only' into RANDOM_VALUE;
      return RANDOM_VALUE;
end;

/

create function gen_select_number_field(TABLE_NAME varchar2, TABLE_FIELD varchar2)
return number
as

RANDOM_VALUE number;

begin
      execute immediate 'SELECT ' || TABLE_FIELD ||' from ' || TABLE_NAME ||
                        ' order by DBMS_RANDOM.value OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY' into RANDOM_VALUE;
      return RANDOM_VALUE;
end;

/

create function random_value (FROM_VALUE number, TO_VALUE number) return number as
begin
  return trunc(DBMS_RANDOM.value(FROM_VALUE, TO_VALUE));
end random_value;

/

create function random_string (STRING_PARAM in varchar2
	, FROM_VALUE in number
	, TO_VALUE in number)
return varchar2 as

begin
  return DBMS_RANDOM.STRING(STRING_PARAM, dbms_random.value(FROM_VALUE, TO_VALUE));
end random_string;

/

create function gen_id (TABLE_NAME in varchar2)
  return number
as

TABLE_COUNT number;
TABLE_ID number(20);

begin

  loop

    TABLE_ID := trunc(DBMS_RANDOM.value (1000000000, 99999999999999999999));
    execute immediate 'select count(*) from ' || TABLE_NAME || ' where id = ' || TABLE_ID into TABLE_COUNT;
    exit when TABLE_COUNT = 0;

  end loop;

  return TABLE_ID;

end;

/

create procedure gen_shop (SHOP_ID number, MANAGER_ID_VALUE number)
as
begin

   insert into a_shops values (SHOP_ID
        , gen_select('A_SHOP_NAME')
        , gen_select('A_REGION')
        , gen_select('A_CITY')
        , gen_select('A_ADDRESS_STREET')||' '||trunc(dbms_random.value(01, 200))
        , MANAGER_ID_VALUE
        );

end gen_shop;

/

create procedure gen_employee (EMPLOYEE_ID number, JOB_NAME_VALUE varchar2, SHOP_ID_VALUE number)
as

begin

	insert into A_EMPLOYEES values (EMPLOYEE_ID
                          , gen_select('A_FIRST_NAME')
                          , gen_select('A_LAST_NAME')
                          , random_value(0001, 9999) || '-' || random_value(00000001, 99999999)
                          , random_string('u', 10, 20) || '@' || random_string('u', 10, 20)
                          , JOB_NAME_VALUE
                          , SHOP_ID_VALUE
    	);

end gen_employee;

/

create procedure gen_purchase_receipt(PURCHASE_ID number, RECEIPT_COUNT number) AS
begin
    for ORDINAL_NUMBER in 1..RECEIPT_COUNT loop
        insert into A_PURCHASE_RECEIPTS values (PURCHASE_ID
            , ORDINAL_NUMBER
            , gen_select_number_field('A_PRODUCTS', 'ID')
            , trunc(DBMS_RANDOM.value(0.01, 100.99), 2)
            , trunc(random_value(100, 10000))
            , trunc(random_value(0, 100))
        );
    end loop;
end;

/

create function a_select_seller
return varchar2
as

SELLER_ID number;

begin

    SELECT id into SELLER_ID FROM A_EMPLOYEES
    where job_name in ('продавец-кассир', 'продавец-консультант')
    order by DBMS_RANDOM.value
    offset 0 rows fetch next 1 rows only;

    return SELLER_ID;

end a_select_seller;

/

create procedure A_DELETE_PURCHASES(EMPLOYEES_COUNT number) as
  cursor C_EMPLOYEES is
   select ID from A_EMPLOYEES
   order by DBMS_RANDOM.value;
    EMP_ID number;
    c number := 0;
  begin
    open C_EMPLOYEES;
    loop fetch C_EMPLOYEES into EMP_ID;
    exit when C_EMPLOYEES%notfound or c = EMPLOYEES_COUNT;
      dbms_output.put_line(EMP_ID);
      delete from A_PURCHASE_RECEIPTS
        where PURCHASE_ID in (select ID from A_PURCHASES where SELLER_ID = EMP_ID);
      delete from A_PURCHASES
        where SELLER_ID = EMP_ID;
    c := c + 1;
  end loop;

  commit;
end;


-- fail, wrong amount

create procedure A_DELETE_PRODUCTS(PRODUCTS_COUNT number) as
  cursor C_PRODUCTS is
   select ID from A_PRODUCTS
   order by DBMS_RANDOM.value;
    PROD_ID number;
    c number := 0;
  begin
    open C_PRODUCTS;
    loop fetch C_PRODUCTS into PROD_ID;
    exit when C_PRODUCTS%notfound or c = PRODUCTS_COUNT;
        dbms_output.put_line(PROD_ID);
        delete A_PURCHASE_RECEIPTS
          where PRODUCT_ID = PROD_ID;
    c := c + 1;
    end loop;

  commit;
end;

/

create procedure gen_main (SHOPS_COUNT number, PURCHASES_COUNT number, NOT_SEALED_EMPLOYEES_COUNT number, NOT_SEALED_PRODUCTS_COUNT number)
as

MANAGER_ID number;
SHOP_ID number;

NEW_PURCHASE_ID number;
TOTAL number;

begin

    for i in 1..shops_count loop
        SHOP_ID := gen_id('A_SHOPS');
        MANAGER_ID := gen_id('A_EMPLOYEES');
        gen_employee(MANAGER_ID,'директор магазина', SHOP_ID);
        gen_shop(SHOP_ID, MANAGER_ID);

        for i in 1..4 loop
            gen_employee(gen_id('A_EMPLOYEES'), 'продавец-кассир', SHOP_ID);
            gen_employee(gen_id('A_EMPLOYEES'), 'продавец-консультант', SHOP_ID);
        end loop;

        for i in 1..2 loop
            gen_employee(gen_id('A_EMPLOYEES'), 'уборщик', SHOP_ID);
            gen_employee(gen_id('A_EMPLOYEES'), 'охранник', SHOP_ID);
        end loop;

    end loop;

    gen_employee(gen_id('A_EMPLOYEES'), 'юрист', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'маркетолог', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'hr-менеджер', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'секретарь', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'программист', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'менеджер по закупкам', null);

    gen_employee(gen_id('A_EMPLOYEES'), 'системный администратор', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'системный администратор', null);

    gen_employee(gen_id('A_EMPLOYEES'), 'грузчик', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'грузчик', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'грузчик', null);

    gen_employee(gen_id('A_EMPLOYEES'), 'кладовшик', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'кладовшик', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'кладовшик', null);

    gen_employee(gen_id('A_EMPLOYEES'), 'водитель', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'водитель', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'водитель', null);

    gen_employee(gen_id('A_EMPLOYEES'), 'бухгалтер', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'бухгалтер', null);
    gen_employee(gen_id('A_EMPLOYEES'), 'бухгалтер', null);

    for i in 1..200 loop
        insert into A_PRODUCTS values (gen_id('A_PRODUCTS')
            , random_string('x', 10, 50)
            , random_string('u', 10, 200)
        );
    end loop;


    for i in 1..PURCHASES_COUNT loop
        NEW_PURCHASE_ID := gen_id('A_PURCHASES');
        gen_purchase_receipt(NEW_PURCHASE_ID, random_value(1, 50));
        select sum(AMOUNT_FULL * (1 - AMOUNT_DISCOUNT * 0.01)) into total from A_PURCHASE_RECEIPTS
        where A_PURCHASE_RECEIPTS.PURCHASE_ID = NEW_PURCHASE_ID;

        insert into A_PURCHASES values (NEW_PURCHASE_ID
            , add_months(sysdate, -12) + random_value(0, 86400*365*2) / 86400
            , total
            ,  a_select_seller
            );

    end loop;

    commit;

	a_delete_purchases(NOT_SEALED_EMPLOYEES_COUNT);
	a_delete_products(NOT_SEALED_PRODUCTS_COUNT);

	commit;

end gen_main;

/

-- 1.  Marketing reports.

create view A_LAST_MONTH_SALES as
select ID, DATETIME, AMOUNT, SELLER_ID from A_PURCHASES where datetime between add_months(trunc(sysdate, 'mm'), -1) and trunc(sysdate, 'mm');

-- a.

create view A_NOT_SOLD_PRODUCTS as
  select CODE, NAME from A_PRODUCTS where ID not in (select distinct PRODUCT_ID from
    (select * from A_PURCHASE_RECEIPTS where PURCHASE_ID in (select ID from A_LAST_MONTH_SALES)));

-- b.

create view A_BEST_SELLERS as
  select SELLER_ID, sum(AMOUNT) "AMOUNT", NAME from A_LAST_MONTH_SALES
  	inner join A_EMPLOYEES on A_LAST_MONTH_SALES.SELLER_ID = A_EMPLOYEES.ID
  	inner join A_SHOPS "AS" on A_EMPLOYEES.SHOP_ID = "AS".ID
  group by SELLER_ID, NAME
  order by NAME, "AMOUNT" DESC;


create view A_SEL_WITHOUT_SALES as
select FIRST_NAME || ' ' || LAST_NAME "EMPLOYEE", JOB_NAME, NAME "SHOP NAME" from A_EMPLOYEES
  inner join A_SHOPS "AS" on A_EMPLOYEES.SHOP_ID = "AS".ID
  where JOB_NAME in ('продавец-кассир', 'продавец-консультант') and
        A_EMPLOYEES.ID not in (select distinct SELLER_ID from A_LAST_MONTH_SALES)
  order by NAME;

-- c.

create view a_region_sales as
  select "AS".REGION, SUM (ALM.AMOUNT) TOTAL from A_LAST_MONTH_SALES ALM
    inner join A_EMPLOYEES AE on ALM.SELLER_ID = AE.ID
    inner join A_SHOPS "AS" on AE.SHOP_ID = "AS".ID
  group by "AS".REGION
  order by TOTAL desc;

/

-- 2. Failure report.

create view A_FAILS as
  select "AS".NAME, DATETIME, AMOUNT, WRONG_AMOUNT, ABS(AMOUNT - WRONG_AMOUNT) DIFF from
    (select AMOUNT, DATETIME, SELLER_ID, (select sum(AMOUNT_FULL * (1 - AMOUNT_DISCOUNT * 0.01)) from A_PURCHASE_RECEIPTS
                                        where A_LAST_MONTH_SALES.ID = PURCHASE_ID) WRONG_AMOUNT from A_LAST_MONTH_SALES)
    inner join A_EMPLOYEES AE on SELLER_ID = AE.ID
    inner join A_SHOPS "AS" on AE.SHOP_ID = "AS".ID
  where ABS(AMOUNT - WRONG_AMOUNT) > 1;

begin
  GEN_MAIN(SHOPS_COUNT =>  20,
    PURCHASES_COUNT => 10000,
    NOT_SEALED_EMPLOYEES_COUNT => 5,
    NOT_SEALED_PRODUCTS_COUNT =>  20);
end;