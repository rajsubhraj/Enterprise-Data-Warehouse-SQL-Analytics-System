CREATE or ALTER PROCEDURE InterMediate.load_intermediate AS
BEGIN 
DECLARE @StartTime DATETIME,@EndTime DATETIME,@LoadStart DATETIME,@LoadEnd DATETIME


BEGIN TRY

SET @LoadStart = GETDATE();
PRINT '***	Intermediate Layer Loading	***'
PRINT '================================================================='

PRINT '***	Loading From CRM Table	****'
PRINT '*************************************************************'

SET @StartTime = GETDATE()
PRINT '***	Truncate InterMediate.crm_cust_info TABLE 	***'
TRUNCATE TABLE InterMediate.crm_cust_info
PRINT '***	Insert Data in InterMediate.crm_cust_info TABLE 	***'
INSERT INTO InterMediate.crm_cust_info(
	cust_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)
SELECT 
cust_id,
cst_key,
TRIM(cst_lastname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,

CASE UPPER(TRIM(cst_marital_status))
	WHEN 'M' THEN 'Married'
	WHEN 'S' THEN 'Single'
	else 'N.A'
END AS cst_marital_status,

CASE UPPER(TRIM(cst_gndr))
	WHEN 'M' THEN 'Male'
	WHEN 'F' THEN 'Female'
	ELSE 'N.A'
END AS cst_gndr,

cst_create_date
FROM ( 
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY cust_id ORDER BY cst_create_date DESC) as flag
	FROM Beginner.crm_cust_info
	) t 
WHERE flag = 1 and cust_id IS NOT NULL;
PRINT '***	 Load Completed crm_cust_info TABLE 	***'
SET @EndTime = GETDATE()
PRINT 'Completed Time :' + CAST(DATEDIFF(SECOND,@StartTime,@EndTime)AS VARCHAR) +'Second'
PRINT '*************************************************************'

--- crm_prd_info

PRINT ''
SET @StartTime = GETDATE();
PRINT '***	Truncate InterMediate.crm_prd_info TABLE 	***'
TRUNCATE TABLE  InterMediate.crm_prd_info; 
PRINT '***	Insert Data into InterMediate.crm_prd_info TABLE		***'
INSERT INTO InterMediate.crm_prd_info(
		prd_id,
		cat_id,
		prd_key,
		prd_nm,
		prd_cost,
		prd_line,
		prd_start_dt,
		prd_end_dt
)
SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key,1,5),'-','_' )AS cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost,0) AS prd_cost,
CASE UPPER(TRIM(prd_line))
	WHEN 'R' THEN 'Road'
	WHEN 'S' THEN 'Other Sale'
	WHEN 'M' THEN 'Mountain'
	WHEN 'T' THEN 'Touring'
	ELSE 'N/A'
END as prd_line,
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1  AS DATE) as prd_end_dt
FROM Beginner.crm_prd_info

PRINT '***	 Load Completed crm_prd_info TABLE 	***'
SET @EndTime = GETDATE()
PRINT 'Completed Time :' + CAST(DATEDIFF(SECOND,@StartTime,@EndTime)AS VARCHAR) +'Second'
PRINT '*************************************************************'
-- crm_sales_info
	PRINT ''
	SET @StartTime = GETDATE();
	PRINT '***	Truncate InterMediate.crm_sales_details TABLE 	***'
	TRUNCATE TABLE InterMediate.crm_sales_details
	PRINT '***	Insert Data in InterMediate.crm_cust_info TABLE 	***'
	INSERT INTO InterMediate.crm_sales_details(
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		sls_order_dt,
		sls_ship_dt,
		sls_due_dt,
		sls_sales,
		sls_quantity,
		sls_price
	)
	SELECT 
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	CASE 
		WHEN sls_order_dt = 0 OR LEN(sls_order_dt)!= 8 THEN NULL
		ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
	END AS sls_order_dt,
	CASE 
		WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt)!= 8 THEN NULL
		ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
	END AS sls_ship_dt,
	CASE 
		WHEN sls_due_dt = 0 OR LEN(sls_due_dt)!= 8 THEN NULL
		ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
	END AS sls_due_dt,
	CASE 
		WHEN sls_sales <= 0 OR sls_sales IS NULL OR sls_sales != sls_quantity*ABS(sls_price)
		THEN  sls_quantity*ABS(sls_price)
		ELSE sls_sales
	END AS sls_sales,
	sls_quantity,
	CASE 
		WHEN sls_price IS NULL OR sls_price <= 0
		THEN ABS(sls_sales/ISNULL(sls_quantity,0))
	ELSE ABS(sls_price)	
	END AS sls_price
	FROM Beginner.crm_sales_details
	PRINT '***	 Load Completed crm_sales_details TABLE 	***'
	SET @EndTime = GETDATE()
	PRINT 'Completed Time :' + CAST(DATEDIFF(SECOND,@StartTime,@EndTime)AS VARCHAR) +'Second'
	PRINT '*************************************************************'
	
-- *** ERP TABLE
	PRINT '================================================================'
	PRINT '***	Loading From ERP Table	****'
	PRINT '================================================================'
	-- erp_cust_az12
	PRINT ''
	SET @StartTime = GETDATE();
	PRINT '***	Truncate InterMediate.erp_cust_az12 TABLE 	***'
	TRUNCATE TABLE InterMediate.erp_cust_az12
	PRINT '***	Insert Data in InterMediate.erp_cust_az12 Table	***'
	INSERT INTO InterMediate.erp_CUST_AZ12(
	cid,bdate,gen
	)
	SELECT 
	CASE 
		WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
		ELSE cid
	END AS cid,
	CASE
		WHEN bdate>GETDATE() THEN NULL
		ELSE bdate
	END AS bdate,
	CASE 
		WHEN UPPER(TRIM(gen)) IN('M','MALE') THEN 'Male'
		WHEN UPPER(TRIM(gen)) IN('F','FEMALE') THEN 'Female'
		ELSE 'N/A'
		END AS gen
	FROM Beginner.erp_CUST_AZ12
	PRINT '***	 Load Completed erp_CUST_AZ12 TABLE 	***'
	SET @EndTime = GETDATE()
	PRINT 'Completed Time :' + CAST(DATEDIFF(SECOND,@StartTime,@EndTime)AS VARCHAR) +'Second'
	PRINT '*************************************************************'
-- -- erp_LOC_A101

	PRINT ''
	SET @StartTime = GETDATE();
	PRINT '***	Truncate InterMediate.erp_LOC_A101 TABLE 	***'
	TRUNCATE TABLE InterMediate.erp_LOC_A101
	PRINT '***	Insert Data in InterMediate.erp_LOC_A101 TABLE 	***'
	INSERT INTO InterMediate.erp_LOC_A101(
		cid,
		cntry
	)
	SELECT 
	REPLACE(cid,'-','') AS cid,
	CASE 
		 WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		 WHEN TRIM(cntry) IN ('US' ,'USA')THEN 'United States'
		 WHEN TRIM(cntry) = ' ' OR cntry IS NULL  THEN 'N/A'
		 ELSE TRIM(cntry)
	END AS cntry
	FROM Beginner.erp_LOC_A101 

	PRINT '***	 Load Completed erp_LOC_A101  TABLE 	***'
	SET @EndTime = GETDATE()
	PRINT 'Completed Time :' + CAST(DATEDIFF(SECOND,@StartTime,@EndTime)AS VARCHAR) +'Second'
	PRINT '*************************************************************'


	PRINT ''
	SET @StartTime = GETDATE();
	PRINT '***	Truncate InterMediate.cerp_PX_CAT_G1V2 TABLE 	***'
	TRUNCATE TABLE InterMediate.erp_PX_CAT_G1V2
	PRINT '***	Insert Data in InterMediate.erp_PX_CAT_G1V2 TABLE 	***'
	INSERT INTO InterMediate.erp_PX_CAT_G1V2(
		id,
		cat,
		subcat,
		maintenance
	)
	SELECT
		id,
		cat,
		subcat,
		maintenance
	FROM Beginner.erp_PX_CAT_G1V2
	PRINT '***	 Load Completed erp_PX_CAT_G1V2  TABLE 	***'
	SET @EndTime = GETDATE()
	PRINT 'Completed Time :' + CAST(DATEDIFF(SECOND,@StartTime,@EndTime)AS VARCHAR) +'Second'
	PRINT '*************************************************************'

	SET @LoadEnd = GETDATE()
	PRINT'***	Loading Intermediate Layer Is Completed		*** '
	PRINT 'Total Load Completed Time : '+ CAST(DATEDIFF(second,@LoadStart,@LoadEnd) AS VARCHAR) +'Second'

END TRY
BEGIN CATCH
	PRINT 'Error Occured'
END CATCH

END

EXEC InterMediate.load_intermediate

