use EnterpriseDataWarehouse;



IF OBJECT_ID('Beginner.crm_cust_info') IS NOT NULL
   DROP TABLE Beginner.crm_cust_info
CREATE TABLE Beginner.crm_cust_info (
		cust_id INT,
		cst_key VARCHAR(20),
		cst_firstname VARCHAR(30),
		cst_lastname VARCHAR(30),
		cst_marital_status VARCHAR(10),
		cst_gndr VARCHAR(10),
		cst_create_date	DATE
		)

IF OBJECT_ID('Beginner.crm_prd_info') IS NOT NULL
	DROP TABLE Beginner.crm_prd_info
CREATE TABLE Beginner.crm_prd_info
(
	prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
)

 


IF OBJECT_ID('Beginner.crm_sales_details') IS NOT NULL
	DROP TABLE Beginner.crm_sales_details
CREATE TABLE Beginner.crm_sales_details
(
	sls_ord_num VARCHAR(50),
	sls_prd_key VARCHAR(50),	
	sls_cust_id INT,
	sls_order_dt INT,	
	sls_ship_dt INT,
	sls_due_dt INT,	
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
)


IF OBJECT_ID('Beginner.erp_CUST_AZ12') IS NOT NULL
	DROP TABLE Beginner.erp_CUST_AZ12
CREATE TABLE Beginner.erp_CUST_AZ12(
	cid VARCHAR(50),
	bdate DATE,
	gen VARCHAR(10)
	)

IF OBJECT_ID('Beginner.erp_PX_CAT_G1V2') IS NOT NULL
	DROP TABLE Beginner.erp_PX_CAT_G1V2
CREATE TABLE Beginner.erp_PX_CAT_G1V2(
	id VARCHAR(15),
	cat VARCHAR(20),
	subcat VARCHAR(30),	
	maintenance VARCHAR(10)
	)


IF OBJECT_ID('Beginner.erp_LOC_A101') IS NOT NULL
	DROP TABLE Beginner.erp_LOC_A101 
CREATE TABLE Beginner.erp_LOC_A101(
	cid VARCHAR(20),
	cntry VARCHAR(20)
	)




