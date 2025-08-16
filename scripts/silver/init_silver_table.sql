IF OBJECT_ID ('silver.erp_amazon_sales_report', 'U') IS NOT NULL
	DROP TABLE silver.erp_amazon_sales_report;
CREATE TABLE silver.erp_amazon_sales_report (
	amazon_sales_report_index						INT,
	amazon_sales_report_order_id					VARCHAR(20),
	amazon_sales_report_date						DATE,
	amazon_sales_report_status						VARCHAR(50),
	amazon_sales_report_fulfilment					VARCHAR(50),
	amazon_sales_report_amazon_sales_report_channel VARCHAR(50),
	amazon_sales_report_ship_service_level			VARCHAR(50),
	amazon_sales_report_style						VARCHAR(50),
	amazon_sales_report_sku							VARCHAR(50),
	amazon_sales_report_category					VARCHAR(50),
	amazon_sales_report_size						VARCHAR(50),
	amazon_sales_report_asin						VARCHAR(50),
	amazon_sales_report_courier_status				VARCHAR(50),
	amazon_sales_report_qty							INT,
	amazon_sales_report_currency					VARCHAR(50),
	amazon_sales_report_amount						DECIMAL(10, 2),
	amazon_sales_report_ship_city					VARCHAR(50),
	amazon_sales_report_ship_state					VARCHAR(50),
	amazon_sales_report_ship_postal_code			VARCHAR(50),
	amazon_sales_report_ship_country				VARCHAR(50),
	amazon_sales_report_promotion_ids				NVARCHAR(MAX),
	amazon_sales_report_b2b							VARCHAR(5),
	amazon_sales_report_fulfilled_by				VARCHAR(50),
	amazon_sales_report_unnamed						VARCHAR(50),

	-- Metadata columns
	dwh_create_date									DATETIME2 DEFAULT GETDATE(),
	dwh_update_date									DATETIME2 NULL,
	source_system									VARCHAR(50) NULL,
    source_file_name								VARCHAR(255) NULL,
    source_record_id								VARCHAR(100) NULL,
    is_active										BIT DEFAULT 1
);

IF OBJECT_ID ('silver.erp_international_sales_report', 'U') IS NOT NULL
	DROP TABLE silver.erp_international_sales_report;
CREATE TABLE silver.erp_international_sales_report (
	international_sales_report_index				INT NOT NULL,
	international_sales_report_date					DATE NOT NULL,
	international_sales_report_customer				VARCHAR(50) NOT NULL,
	international_sales_report_style				VARCHAR(50),
	international_sales_report_sku					VARCHAR(50) NOT NULL,
	international_sales_report_size					VARCHAR(50),
	international_sales_report_pcs					DECIMAL(10, 2),
	international_sales_report_rate					DECIMAL(10, 2),
	international_sales_report_gross_amount			DECIMAL(10, 2) NOT NULL,
	international_sales_report_stock				DECIMAL(10, 2),

	-- Metadata columns
	dwh_create_date									DATETIME2 DEFAULT GETDATE(),
	dwh_update_date									DATETIME2 NULL,
	source_system									VARCHAR(50) NULL,
    source_file_name								VARCHAR(255) NULL,
    source_record_id								VARCHAR(100) NULL,
    is_active										BIT DEFAULT 1
);

IF OBJECT_ID ('silver.erp_overall_sales_report', 'U') IS NOT NULL
	DROP TABLE silver.erp_overall_sales_report;
CREATE TABLE silver.erp_overall_sales_report (
	overall_sales_report_index						INT NOT NULL,
	overall_sales_report_sku_code					VARCHAR(50) NOT NULL,
	overall_sales_report_design_no					VARCHAR(50) NOT NULL,
	overall_sales_report_stock						DECIMAL(10,2) NOT NULL,
	overall_sales_report_category					VARCHAR(50) NOT NULL,
	overall_sales_report_size						VARCHAR(50) NOT NULL,
	overall_sales_report_color						VARCHAR(50) NOT NULL,

	-- Metadata columns
	dwh_create_date									DATETIME2 DEFAULT GETDATE(),
	dwh_update_date									DATETIME2 NULL,
	source_system									VARCHAR(50) NULL,
    source_file_name								VARCHAR(255) NULL,
    source_record_id								VARCHAR(100) NULL,
    is_active										BIT DEFAULT 1
);