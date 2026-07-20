CREATE OR ALTER PROCEDURE Beginner.load_beginner AS
BEGIN
	DECLARE @StartTime DATETIME,@EndTime DATETIME,@LoadStartTime DATETIME ,@LoadEndTime DATETIME

	SET @LoadStartTime = GETDATE();
	BEGIN TRY 

		PRINT '***	Beginner Layer Loading	***'
		PRINT '	'

		PRINT '***	Loading CRM Tables ***'
		
		SET @StartTime  = GETDATE()
		PRINT '***	Truncate crm_cust_info TABLE	***'
		TRUNCATE TABLE Beginner.crm_cust_info
		PRINT '***	Load crm_cust_info TABLE	***'
		BULK INSERT Beginner.crm_cust_info
		FROM 'D:\Data_Engg\SQL\Project\EnterpriseDataWarehouseSQLAnalytics-System\Beginner\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		SET @EndTime  = GETDATE();
		PRINT 'Completed Time '+ CAST(DATEDIFF(SECOND,@StartTime,@EndTime) AS VARCHAR) +'second'
		PRINT '****************************************************'

		PRINT '	'
		SET @StartTime = GETDATE()
		PRINT '***	Truncate crm_prd_info TABLE	***'
		TRUNCATE TABLE Beginner.crm_prd_info
		PRINT '***	Load crm_prd_info TABLE	***'
		BULK INSERT Beginner.crm_prd_info
		FROM 'D:\Data_Engg\SQL\Project\EnterpriseDataWarehouseSQLAnalytics-System\Beginner\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		SET @EndTime = GETDATE()
		PRINT 'Completed Time '+ CAST(DATEDIFF(SECOND,@StartTime,@EndTime) AS VARCHAR ) +'Second'
		PRINT '****************************************************'


		PRINT '	'
		SET @StartTime = GETDATE()
		PRINT '***	Truncate crm_sales_details Table	***'
		TRUNCATE TABLE Beginner.crm_sales_details
		PRINT '***	Load crm_sales_details Table	***'
		BULK INSERT Beginner.crm_sales_details
		FROM 'D:\Data_Engg\SQL\Project\EnterpriseDataWarehouseSQLAnalytics-System\Beginner\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @EndTime = GETDATE();
		PRINT 'Completed time : '+CAST(DATEDIFF(SECOND,@StartTime,@EndTime) AS VARCHAR) + 'Second'
		PRINT '****************************************************'
		PRINT '	'
		PRINT '***	Load Completed OF CRM Table	***'
		PRINT '============================================================================'
		PRINT '***	Loading ERP Tables ***'
		PRINT ''

		SET @StartTime = GETDATE()
		PRINT '***	Truncate erp_CUST_AZ12 TABLE	***'
		TRUNCATE TABLE Beginner.erp_CUST_AZ12
		PRINT '***	Load erp_CUST_AZ12 TABLE	***'
		BULK INSERT Beginner.erp_CUST_AZ12
		FROM 'D:\Data_Engg\SQL\Project\EnterpriseDataWarehouseSQLAnalytics-System\Beginner\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @EndTime = GETDATE();
		PRINT 'Completed Time :'+CAST(DATEDIFF(SECOND,@StartTime,@EndTime) AS VARCHAR)+ 'Second'
		PRINT '****************************************************'

		PRINT ''
		SET @StartTime = GETDATE()
		PRINT '***	Truncate erp_LOC_A101 TABLE	***'
		TRUNCATE TABLE Beginner.erp_LOC_A101
		PRINT '***	Load erp_LOC_A101 TABLE	***'
		BULK INSERT Beginner.erp_LOC_A101
		FROM 'D:\Data_Engg\SQL\Project\EnterpriseDataWarehouseSQLAnalytics-System\Beginner\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @EndTime = GETDATE();
		PRINT 'Completed Time :'+ CAST(DATEDIFF(SECOND,@StartTime,@EndTime) AS VARCHAR) + 'second'
		PRINT '****************************************************'

		PRINT ''
		SET @StartTime = GETDATE()
		PRINT '***	Truncate erp_PX_CAT_G1V2 TABLE	***'
		TRUNCATE TABLE Beginner.erp_PX_CAT_G1V2
		PRINT '***	Load erp_PX_CAT_G1V2	***'
		BULK INSERT Beginner.erp_PX_CAT_G1V2
		FROM 'D:\Data_Engg\SQL\Project\EnterpriseDataWarehouseSQLAnalytics-System\Beginner\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @EndTime = GETDATE();
		PRINT 'Completed Time :'+ CAST(DATEDIFF(SECOND,@StartTime,@EndTime) AS VARCHAR) + 'second'
		PRINT '****************************************************'
		PRINT '***	Load Completed OF ERP Table	***'
	END TRY

BEGIN CATCH
	PRINT 'Error Occured'
END CATCH
	
	SET @LoadEndTime = GETDATE();
	PRINT 'Total Completed Time :'+ CAST(DATEDIFF(SECOND,@LoadStartTime,@LoadEndTime) AS VARCHAR) +'Second'
END

EXEC Beginner.load_beginner;

