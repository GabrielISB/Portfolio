

CREATE OR REPLACE FUNCTION create_table(t_name varchar(30))
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('CREATE TABLE IF NOT EXISTS public.%I (id serial PRIMARY KEY)', 't_' || t_name);
END
$func$;


SELECT create_table('Test Table');

CREATE OR REPLACE FUNCTION drop_table(t_name varchar(30))
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('DROP TABLE public.%I cascade', 't_' || t_name);
END
$func$;

SELECT drop_table('Test Table');

CREATE OR REPLACE FUNCTION add_column(c_name varchar(30), t_name varchar(30))
	RETURNS VOID
	LANGUAGE plpgsql AS
$func$
BEGIN
	EXECUTE format('ALTER TABLE	%I ADD COLUMN %I character varying(64) NOT NULL', t_name, c_name);
END
$func$;
				  
CREATE OR REPLACE FUNCTION drop_column(c_name varchar(30), t_name varchar(30))
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
	EXECUTE format('ALTER TABLE %I DROP COLUMN %I cascade', t_name, c_name);
END
$func$;

CREATE OR REPLACE FUNCTION primary_key(t_name varchar(30), c_name varchar(30))
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
	EXECUTE format('ALTER TABLE %I ADD PRIMARY KEY %I', t_name, c_name);
END
$func$;

CREATE OR REPLACE FUNCTION foreign_key(t_name varchar(30), c_name varchar(30), ref_table varchar(30), ref_col varchar(30))
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
	EXECUTE format('ALTER TABLE %I ADD FOREIGN KEY %I REFERENCES public.%I %I MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION', t_name, c_name, ref_table, ref_col);
END
$func$;

--Table Areas
SELECT create_table('Areas');
SELECT add_column('ID_Area', 't_Areas');
SELECT add_column('Area Name', 't_Areas');
SELECT add_column('Area Manager', 't_Areas');

--Table Debts to pay

SELECT create_table('Debts_pay');
SELECT add_column('ID_debt', 't_Debts_pay');
SELECT add_column('Amount of money', 't_Debts_pay');
SELECT add_column('Deadline', 't_Debts_pay');
SELECT add_column('Expected payday', 't_Debts_pay');

--Table SALES

SELECT create_table('sales');
SELECT add_column('Sale day', 't_sales');
SELECT add_column('Sold Products Number', 't_sales');
SELECT add_column('Paid Amount', 't_sales');
SELECT add_column('Id Product', 't_sales');
SELECT add_column('Id Costumer', 't_sales');

--Table Debts to charge

SELECT create_table('debts_charge');
SELECT add_column('Id Area', 't_debts_charge');
SELECT add_column('Id Payment', 't_debts_charge');
SELECT add_column('Id Sale', 't_debts_charge');

--Table DEBTS related to debts to pay

SELECT create_table('debts');
SELECT add_column('Id_reason', 't_debts');
SELECT add_column('Id Debt', 't_debts');
SELECT add_column('Debts Reason', 't_debts');

--Table/catalogue Employees related to DEBTS

SELECT create_table('c_employees');
SELECT add_column('Id_employee', 't_c_employees');
SELECT add_column('Personal Info', 't_c_employees');
SELECT add_column('Company Info', 't_c_employees');

--Catalogue Personal Info
SELECT create_table('c_personalinfo');
SELECT add_column('id_employee', 't_c_personalinfo');
SELECT add_column('Email', 't_c_personalinfo');
SELECT add_column('Name', 't_c_personalinfo');
SELECT add_column('Phone', 't_c_personalinfo');
SELECT add_column('Address', 't_c_personalinfo');
SELECT add_column('Birth', 't_c_personalinfo');
SELECT add_column('Gender', 't_c_personalinfo');

--Catalogue Company Info
SELECT create_table('c_companyinfo');
SELECT add_column('Position', 't_c_companyinfo');
SELECT add_column('Contract', 't_c_companyinfo');
SELECT add_column('Hiring Day', 't_c_companyinfo');
SELECT add_column('Bonus', 't_c_companyinfo');
SELECT add_column('Salary', 't_c_companyinfo');

--Suppliers retaled to DEBTS

SELECT create_table('suppliers');
SELECT add_column('Id_supplier', 't_suppliers');
SELECT add_column('id raw material', 't_suppliers');
SELECT add_column('Company Name', 't_suppliers');
SELECT add_column('Email', 't_suppliers');
SELECT add_column('Phone Number', 't_suppliers');
SELECT add_column('Service/Product', 't_suppliers');

--Payment related to Debts to charge 
SELECT create_table('payment');
SELECT add_column('Id payment', 't_payment');
SELECT add_column('Amount of charge', 't_payment');
SELECT add_column('Type of charge', 't_payment');
SELECT add_column('Deadline', 't_payment');
SELECT add_column('Account Number', 't_payment');
SELECT add_column('Id_costumer', 't_payment');

--Customer related to Delivery, Sales, Payment
SELECT create_table('customer');
SELECT add_column('name', 't_customer');
SELECT add_column('id_customer', 't_customer');
SELECT add_column('email', 't_customer');
SELECT add_column('address', 't_customer');
SELECT add_column('phone number', 't_customer');

--Product catalogue related to Sales
SELECT create_table('c_products');
SELECT add_column('Id Product', 't_c_products');
SELECT add_column('Id type', 't_c_products');
SELECT add_column('Product Name', 't_c_products');
SELECT add_column('Price', 't_c_products');
SELECT add_column('id raw material', 't_c_products');

--Raw Material Catalogue related to product and suppliers
SELECT create_table('raw');
SELECT add_column('Id raw material', 't_raw');
SELECT add_column('Peanapple Oil', 't_raw');
SELECT add_column('Coconut Oil', 't_raw');


----------------------------------Areas------------------------------
CREATE OR REPLACE PROCEDURE insert_area(area character varying, manager character varying)
LANGUAGE SQL
AS $$
	INSERT INTO public."t_Areas"("Area Name", "Area Manager") VALUES ("area", "manager");
	$$;
	
CALL insert_area('Debts to charge', 'Gabo Salazar');

select * from "t_Areas"
-----------------------------------Customer--------------------------------------------
CREATE OR REPLACE PROCEDURE insert_customer(costumer character varying, id_cust int, 
												email character varying, address character varying,
												phone int)
LANGUAGE SQL
AS $$
	INSERT INTO public."t_customer"("name", "id_customer", "email", "address", "phone number") VALUES (
		"costumer", "id_cust", "email", "address", "phone");
	$$;
	
CALL insert_customer('Gabo', '1909164', 'gabo@upy.edu.mx', '57B francisco de montejo', '9991');
-------------------------------Delivery----------------------------------

CREATE OR REPLACE PROCEDURE insert_delivery(delivery int, transport_id int, delivery_description character varying)
LANGUAGE SQL
AS $$
	INSERT INTO public."delivery"(delivery_id, transport_id, delivery_description) VALUES (delivery, transport_id, delivery_description);
	$$;

CALL insert_delivery('1', '1', 'Vacuns Covid')

select * from delivery
------------------------------Transportation-------------------------------------

CREATE OR REPLACE PROCEDURE insert_transport(transport_id int, description character varying)
LANGUAGE SQL 
AS $$
	INSERT INTO public.transportation(transport_id, transport_type) VALUES (transport_id, description);
	$$;

CALL insert_transport('1', 'Mustang Shelby');

select * from transportation

----------------------------------Debts to pay------------------------------

CREATE OR REPLACE PROCEDURE insert_debts_to_pay(id_pay int, id_debt int, amount int, 
												deadline timestamp, expected_payday timestamp)
LANGUAGE SQL
AS $$
	INSERT INTO public."t_Debts_pay"("id", "ID_debt", "Amount of money", "Deadline", "Expected payday") VALUES (
	id_pay, id_debt, amount, deadline, expected_payday);
	$$;

CALL insert_debts_to_pay('1', '1', '500', '8/12/2021', '15/9/2021');

select * from "t_Debts_pay"

---------------------------------Debts--------------------------------

CREATE OR REPLACE PROCEDURE debts(id_debt int, id_reason int, reason character varying)
LANGUAGE SQL
AS $$
	INSERT INTO  public.t_debts("id", "Id_reason", "Debts Reason") VALUES (id_debt, id_reason, reason);
	$$;

CALL debts('1', '1', 'salary');

select * from t_debts

--------------------------------Debts to charge ---------------------------

CREATE OR REPLACE PROCEDURE insert_debt_charge(id_debt int, id_payment int, id_sale int)
LANGUAGE SQL
AS $$
	INSERT INTO public.t_debts_charge("id", "Id Payment", "Id Sale") VALUES (id_debt, id_payment, id_sale);
	$$;
	
CALL insert_debt_charge('1', '1', '1');


------------------------------Company info---------------------------

CREATE OR REPLACE FUNCTION companyinfo(person_id int, puesto character varying, contract character varying,
											  hired timestamp, bonus int, salary int)
RETURNS character varying											  
LANGUAGE plpgsql
AS $func$

--INSERT INTO public."t_c_companyinfo"("id", "Position", "Contract", "Hiring Day", "Bonus", "Salary") VALUES (
--person_id, puesto, contract, hired, bonus, salary);
	
DECLARE salario int = id."id" from public.t_c_companyinfo id WHERE id."Salary" = "salary";

BEGIN
	IF EXISTS(SELECT "Salary" FROM public.t_c_companyinfo WHERE "Salary" > "10000") THEN
		RETURN 'Metiste a un empleado';
	ELSE 
		RETURN 'Metiste a un director';
	END IF;
END
$func$;
	
-----------------------------Employees--------------------------

CREATE OR REPLACE PROCEDURE insert_employees(id_employee int, personal_info character varying, company_info character varying)
LANGUAGE SQL
AS $$
	INSERT INTO public."t_c_employees"("id", "Personal Info", "Company Info") VALUES (id_employee, personal_info, company_info);
	$$;
	

-----------------------------Personal Info-------------------------

CREATE OR REPLACE PROCEDURE insert_personalinfo(employee_id int, email character varying,
											   e_name character varying, phone int,
											   address character varying, birth timestamp,
											   gender character varying)
LANGUAGE SQL 
AS $$
	INSERT INTO public."t_c_personalinfo"("id", "Email", "Name", "Phone", "Address", "Birth", "Gender") VALUES (
	employee_id, email, e_name, phone, address, birth, gender);
	$$;
		







