
IF OBJECT_ID('Intermediate.crm_cust_info') IS NOT NULL
   DROP TABLE Intermediate.crm_cust_info
CREATE TABLE Intermediate.crm_cust_info (
		cust_id INT,
		cst_key VARCHAR(20),
		cst_firstname VARCHAR(30),
		cst_lastname VARCHAR(30),
		cst_marital_status VARCHAR(10),
		cst_gndr VARCHAR(10),
		cst_create_date	DATE,
		dwh_create_date DATETIME2 DEFAULT GETDATE()
		)

IF OBJECT_ID('Intermediate.crm_prd_info') IS NOT NULL
	DROP TABLE Intermediate.crm_prd_info
CREATE TABLE Intermediate.crm_prd_info
(
	prd_id       INT,
	cat_id		 VARCHAR(50),
    prd_key      VARCHAR(50),
    prd_nm       VARCHAR(50),
    prd_cost     INT,
    prd_line     VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt   DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)

 


IF OBJECT_ID('Intermediate.crm_sales_details') IS NOT NULL
	DROP TABLE Intermediate.crm_sales_details
CREATE TABLE Intermediate.crm_sales_details
(
	sls_ord_num VARCHAR(50),
	sls_prd_key VARCHAR(50),	
	sls_cust_id INT,
	sls_order_dt DATE,	
	sls_ship_dt DATE,
	sls_due_dt DATE,	
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)


IF OBJECT_ID('Intermediate.erp_CUST_AZ12') IS NOT NULL
	DROP TABLE Intermediate.erp_CUST_AZ12
CREATE TABLE Intermediate.erp_CUST_AZ12(
	cid VARCHAR(50),
	bdate DATE,
	gen VARCHAR(10),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
	)

IF OBJECT_ID('Intermediate.erp_PX_CAT_G1V2') IS NOT NULL
	DROP TABLE Intermediate.erp_PX_CAT_G1V2
CREATE TABLE Intermediate.erp_PX_CAT_G1V2(
	id VARCHAR(15),
	cat VARCHAR(20),
	subcat VARCHAR(30),	
	maintenance VARCHAR(10),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
	)


IF OBJECT_ID('Intermediate.erp_LOC_A101') IS NOT NULL
	DROP TABLE Intermediate.erp_LOC_A101 
CREATE TABLE Intermediate.erp_LOC_A101(
	cid VARCHAR(20),
	cntry VARCHAR(20),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
	)







