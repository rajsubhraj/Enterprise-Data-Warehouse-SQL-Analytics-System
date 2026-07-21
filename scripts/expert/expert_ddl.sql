IF OBJECT_ID('expert.dim_customers') IS NOT NULL
	DROP VIEW expert.dim_customers;
	GO
CREATE VIEW expert.dim_customers AS
SELECT 
ci.cust_id AS customer_id,
ci.cst_key AS customer_number,
ci.cst_firstname AS first_name,
ci.cst_lastname AS last_name,
cl.cntry AS Country,
ci.cst_marital_status AS Marital_Status,
CASE 
	WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
	ELSE COALESCE(ca.gen,'n/a')
	END AS gender,
ca.bdate,
ci.cst_create_date
FROM InterMediate.crm_cust_info AS ci
LEFT JOIN InterMediate.erp_CUST_AZ12 as ca
ON ci.cst_key = ca.cid
LEFT JOIN InterMediate.erp_LOC_A101 AS cl
on ci.cst_key = cl.cid;

IF OBJECT_ID('expert.dim_products') IS NOT NULL
	DROP VIEW  expert.dim_products;
GO
CREATE VIEW expert.dim_products AS
SELECT 
ROW_NUMBER() OVER(ORDER BY pi.prd_start_dt, pi.prd_key) AS product_key,
pi.prd_id AS product_id,
pi.cat_id AS category_id,
pi.prd_key AS product_number,
pi.prd_nm AS product_name,
pi.prd_cost AS product_cost,
pi.prd_line AS product_line,
pi.prd_start_dt AS start_date,
pc.maintenance ,
pc.cat AS category,
pc.subcat AS subcategory
FROM InterMediate.crm_prd_info AS pi
LEFT JOIN InterMediate.erp_PX_CAT_G1V2	AS pc
ON pi.cat_id = pc.id
WHERE pi.prd_end_dt IS NULL;


IF OBJECT_ID('expert.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW expert.fact_sales AS
SELECT
    sd.sls_ord_num  AS order_number,
    pr.product_key  AS product_key,
    cu.customer_number AS customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt  AS shipping_date,
    sd.sls_due_dt   AS due_date,
    sd.sls_sales    AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price    AS price
FROM InterMediate.crm_sales_details sd
LEFT JOIN Expert.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN Expert.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id;
GO

SELECT DISTINCT GENDER FROM Expert.dim_customers

select * from InterMediate.crm_sales_details
Select * from Expert.dim_customers
select * from Expert.dim_products

SELECT * FROM Expert.fact_sales

