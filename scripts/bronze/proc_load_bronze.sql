

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '==============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==============================================';

		PRINT CHAR(13) + CHAR(10); -- new line
		PRINT '----------------------------------------------';
		PRINT 'Loading Staging Tables';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT CHAR(13) + CHAR(10); -- new line
		PRINT '>> Truncating Table: bronze.stg_international_sales_report_1';
		TRUNCATE TABLE bronze.stg_international_sales_report_1;

		PRINT '>> Inserting Data Into: bronze.stg_international_sales_report_1';
		BULK INSERT bronze.stg_international_sales_report_1
		FROM 'C:\Users\Jeff\Learn SQL\Kaggle Datasets\E-Commerce Dataset\International sale Report_1.csv'
		WITH (
			FORMAT ='CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT CHAR(13) + CHAR(10); -- new line
		PRINT '>> Truncating Table: bronze.stg_international_sales_report_2';
		TRUNCATE TABLE bronze.stg_international_sales_report_2;

		PRINT '>> Inserting Data Into: bronze.stg_international_sales_report_2';
		BULK INSERT bronze.stg_international_sales_report_2
		FROM 'C:\Users\Jeff\Learn SQL\Kaggle Datasets\E-Commerce Dataset\International sale Report_2.csv'
		WITH (
			FORMAT ='CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT CHAR(13) + CHAR(10); -- new line
		PRINT '>> Truncating Table: bronze.stg_international_sales_report_3';
		TRUNCATE TABLE bronze.stg_international_sales_report_3;

		PRINT '>> Inserting Data Into: bronze.stg_international_sales_report_3';
		BULK INSERT bronze.stg_international_sales_report_3
		FROM 'C:\Users\Jeff\Learn SQL\Kaggle Datasets\E-Commerce Dataset\International sale Report_3.csv'
		WITH (
			FORMAT ='CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------';



		PRINT CHAR(13) + CHAR(10); -- new line
		PRINT CHAR(13) + CHAR(10); -- new line
		PRINT '----------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT CHAR(13) + CHAR(10); -- new line
		PRINT '>> Truncating Table: bronze.erp_amazon_sales_report';
		TRUNCATE TABLE bronze.erp_amazon_sales_report;

		PRINT '>> Inserting Data Into: bronze.erp_amazon_sales_report';
		BULK INSERT bronze.erp_amazon_sales_report
		FROM 'C:\Users\Jeff\Learn SQL\Kaggle Datasets\E-Commerce Dataset\Amazon Sale Report.csv'
		WITH (
			FORMAT ='CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT CHAR(13) + CHAR(10); -- new line
		PRINT '>> Truncating Table: bronze.erp_international_sales_report';
		TRUNCATE TABLE bronze.erp_international_sales_report;

		PRINT '>> Inserting Staging Data 1 Into: bronze.erp_amazon_sales_report';
		INSERT INTO bronze.erp_international_sales_report (
			international_sales_report_index,
			international_sales_report_date,
			international_sales_report_months,
			international_sales_report_customer,
			international_sales_report_style,
			international_sales_report_sku,
			international_sales_report_size,
			international_sales_report_pcs,
			international_sales_report_rate,
			international_sales_report_gross_amount
		)
		SELECT * FROM bronze.stg_international_sales_report_1
		SET @end_time = GETDATE();
		PRINT '>> Insert Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Inserting Staging Data 2 Into: bronze.erp_amazon_sales_report';
		INSERT INTO bronze.erp_international_sales_report (
			international_sales_report_index,
			international_sales_report_style,
			international_sales_report_stock
		)
		SELECT
			international_sales_report_index,
			international_sales_report_style,
			international_sales_report_stock
		FROM bronze.stg_international_sales_report_2
		SET @end_time = GETDATE();
		PRINT '>> Insert Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Inserting Staging Data 3 Into: bronze.erp_amazon_sales_report';
		INSERT INTO bronze.erp_international_sales_report (
			international_sales_report_index,
			international_sales_report_customer,
			international_sales_report_date,
			international_sales_report_months,
			international_sales_report_style,
			international_sales_report_sku,
			international_sales_report_pcs,
			international_sales_report_rate,
			international_sales_report_gross_amount,
			international_sales_report_stock
		)
		SELECT * FROM bronze.stg_international_sales_report_3
		SET @end_time = GETDATE();
		PRINT '>> Insert Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT CHAR(13) + CHAR(10); -- new line
		PRINT '>> Truncating Table: bronze.erp_overall_sales_report';
		TRUNCATE TABLE bronze.erp_overall_sales_report;

		PRINT '>> Inserting Data Into: bronze.erp_overall_sales_report';
		BULK INSERT bronze.erp_overall_sales_report
		FROM 'C:\Users\Jeff\Learn SQL\Kaggle Datasets\E-Commerce Dataset\Sale Report.csv'
		WITH (
			FORMAT ='CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------';
		
		SET @batch_end_time = GETDATE();
		PRINT 'All Data Loaded Successfully';
		PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------';
	END TRY
	BEGIN CATCH
		PRINT '==============================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==============================================';
	END CATCH
END
