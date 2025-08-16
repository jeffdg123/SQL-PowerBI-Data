PRINT '>> Truncating Table: bronze.stg_international_sales_report_2';
TRUNCATE TABLE [DataWarehouse].[silver].[erp_overall_sales_report];
INSERT INTO [DataWarehouse].[silver].[erp_overall_sales_report](
    source_record_id,
	overall_sales_report_sku_code,
	overall_sales_report_design_no,
	overall_sales_report_stock,
	overall_sales_report_category,
	overall_sales_report_size,
	overall_sales_report_color,

	-- Metadata columns
	dwh_update_date,
	source_system,
    overall_sales_report_index
)
SELECT
    overall_sales_report_index,
    UPPER(
        CASE 
            WHEN overall_sales_report_sku_code = '#REF!'
                THEN COALESCE(NULLIF(overall_sales_report_sku_code, '#REF!'), LAG(NULLIF(overall_sales_report_sku_code, '#REF!')) OVER (ORDER BY overall_sales_report_index))
            WHEN SUBSTRING(overall_sales_report_sku_code, 1, CAST(LEFT(CHARINDEX('-', overall_sales_report_sku_code) - 1, 1) AS INT)) = '' 
                THEN overall_sales_report_sku_code
            WHEN SUBSTRING(overall_sales_report_sku_code, 1, CAST(LEFT(CHARINDEX('-', overall_sales_report_sku_code) - 1, 1) AS INT)) = 'AN208' 
                THEN overall_sales_report_sku_code
            ELSE overall_sales_report_design_no + SUBSTRING(overall_sales_report_sku_code, CAST(RIGHT(CHARINDEX('-', overall_sales_report_sku_code), 1) AS INT), LEN(overall_sales_report_sku_code))
        END
    ) AS overall_sales_report_sku_code,
    UPPER(
        CASE
            WHEN SUBSTRING(overall_sales_report_sku_code, 1, CAST(LEFT(CHARINDEX('-', overall_sales_report_sku_code) - 1, 1) AS INT)) = 'AN208'
                THEN REPLACE(overall_sales_report_design_no, 'LEGG-AN208-MUSTARD', 'AN208')
            ELSE overall_sales_report_design_no
        END
    ) AS overall_sales_report_design_no,
    overall_sales_report_stock,
    UPPER(overall_sales_report_category) AS overall_sales_report_category,
    overall_sales_report_size,
    UPPER(overall_sales_report_color) AS overall_sales_report_color,
    GETDATE() AS dwh_update_date,
    'ERP' AS source_system,
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS new_index
FROM 
    [DataWarehouse].[bronze].[erp_overall_sales_report]
WHERE 
    (overall_sales_report_sku_code IS NOT NULL AND overall_sales_report_sku_code != '#REF!')
    OR
    (overall_sales_report_sku_code = '#REF!' AND overall_sales_report_stock >= 1)




WITH CleanedData AS (
	SELECT
		international_sales_report_index,
		CONVERT(DATE, REPLACE(international_sales_report_date, '-', '/'), 1) AS international_sales_report_date,
		UPPER(international_sales_report_customer) AS international_sales_report_customer,
		UPPER(
			CASE
				WHEN (international_sales_report_style = 'SHIPPING' OR international_sales_report_style = 'SHIPPING CHARGES')
					THEN 'SHIPPING'
				WHEN (international_sales_report_style = 'TAGS' OR international_sales_report_style = 'TAG PRINTING')
					THEN 'TAGS PRINTING'
				WHEN international_sales_report_style = 'TAGS(LABOUR)'
					THEN 'TAGS LABOUR'
				WHEN international_sales_report_style = 'LABEL MANUF.CHRAGE'
					THEN 'LABEL MANUFACTURING'
				WHEN international_sales_report_style = 'LABEL CHRAGE' OR international_sales_report_style = 'LABEL CHARGE'
					THEN 'LABEL LABOUR'
				ELSE international_sales_report_style
			END
		) AS international_sales_report_style,
		UPPER(
			CASE
				WHEN (
					international_sales_report_style = 'SHIPPING' OR 
					international_sales_report_style = 'SHIPPING CHARGES' OR 
					international_sales_report_style = 'TAGS' OR 
					international_sales_report_style = 'TAG PRINTING' OR
					international_sales_report_style = 'TAGS(LABOUR)' OR
					international_sales_report_style = 'LABEL MANUF.CHRAGE' OR
					international_sales_report_style = 'LABEL CHRAGE' OR 
					international_sales_report_style = 'LABEL CHARGE'
				)
					THEN 'N/A'
				WHEN (
					(UPPER(international_sales_report_size) = 'FREE' OR international_sales_report_size IS NULL) AND
					(SUBSTRING(international_sales_report_sku, 1, CAST(LEFT(CHARINDEX('-', international_sales_report_sku) - 1, 1) AS INT)) = '' OR international_sales_report_sku IS NULL)
				)
					THEN international_sales_report_style
				WHEN UPPER(international_sales_report_size) != 'FREE' AND international_sales_report_sku IS NULL
					THEN UPPER(international_sales_report_style) + '-' + UPPER(international_sales_report_size)
				WHEN international_sales_report_size IS NULL AND international_sales_report_sku IS NULL
					THEN UPPER(international_sales_report_style)
				ELSE international_sales_report_sku
			END
		) AS international_sales_report_sku,
		SUBSTRING(international_sales_report_sku, 1, CAST(LEFT(CHARINDEX('-', international_sales_report_sku) - 1, 1) AS INT)) AS sku2,
		international_sales_report_sku AS sku_OG,
		UPPER(international_sales_report_size) AS international_sales_report_size,
		international_sales_report_pcs,
		international_sales_report_rate,
		international_sales_report_gross_amount,
		international_sales_report_stock,

		-- metadata columns
		GETDATE() AS dwh_update_date,
		'ERP' AS source_system,
		ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS new_index

	FROM [DataWarehouse].[bronze].[erp_international_sales_report]
	WHERE
		international_sales_report_date IS NOT NULL
)
SELECT *
FROM CleanedData
WHERE 
	international_sales_report_sku LIKE 'SET322%'
	-- SUBSTRING(international_sales_report_sku, 1, CAST(LEFT(CHARINDEX('-', international_sales_report_sku) - 1, 1) AS INT)) != international_sales_report_style
	-- AND international_sales_report_size != 'FREE'.
