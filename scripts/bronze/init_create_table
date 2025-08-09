IF OBJECT_ID ('bronze.erp_amazon_sales_report', 'U') IS NOT NULL
	DROP TABLE bronze.erp_amazon_sales_report;
CREATE TABLE bronze.erp_amazon_sales_report (
	amazon_sales_report_index						INT,
	amazon_sales_report_order_id					VARCHAR(20),
	amazon_sales_report_date						VARCHAR(8),
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
	amazon_sales_report_unnamed						VARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_international_sales_report', 'U') IS NOT NULL
	DROP TABLE bronze.erp_international_sales_report;
CREATE TABLE bronze.erp_international_sales_report (
	international_sales_report_index				INT,
	international_sales_report_date					VARCHAR(8),
	international_sales_report_months				VARCHAR(8),
	international_sales_report_customer				VARCHAR(50),
	international_sales_report_style				VARCHAR(50),
	international_sales_report_sku					VARCHAR(50),
	international_sales_report_size					VARCHAR(50),
	international_sales_report_pcs					DECIMAL(10, 2),
	international_sales_report_rate					DECIMAL(10, 2),
	international_sales_report_gross_amount			DECIMAL(10, 2),
	international_sales_report_stock				DECIMAL(10, 2)
);

IF OBJECT_ID ('bronze.stg_international_sales_report_1', 'U') IS NOT NULL
	DROP TABLE bronze.stg_international_sales_report_1;
CREATE TABLE bronze.stg_international_sales_report_1 (
	international_sales_report_index				INT,
	international_sales_report_date					VARCHAR(8),
	international_sales_report_months				VARCHAR(8),
	international_sales_report_customer				VARCHAR(50),
	international_sales_report_style				VARCHAR(50),
	international_sales_report_sku					VARCHAR(50),
	international_sales_report_size					VARCHAR(50),
	international_sales_report_pcs					DECIMAL(10, 2),
	international_sales_report_rate					DECIMAL(10, 2),
	international_sales_report_gross_amount			DECIMAL(10, 2)
);

IF OBJECT_ID ('bronze.stg_international_sales_report_2', 'U') IS NOT NULL
	DROP TABLE bronze.stg_international_sales_report_2;
CREATE TABLE bronze.stg_international_sales_report_2 (
	international_sales_report_index				INT,
	international_sales_report_style				VARCHAR(50),
	international_sales_report_stock				DECIMAL(10, 2),
	international_sales_report_1					BIT NULL,
	international_sales_report_2					BIT NULL,
	international_sales_report_3					BIT NULL,
	international_sales_report_4					BIT NULL,
	international_sales_report_5					BIT NULL,
	international_sales_report_6					BIT NULL,
	international_sales_report_7					BIT NULL
);

IF OBJECT_ID ('bronze.stg_international_sales_report_3', 'U') IS NOT NULL
	DROP TABLE bronze.stg_international_sales_report_3;
CREATE TABLE bronze.stg_international_sales_report_3 (
	international_sales_report_index				INT,
	international_sales_report_customer				VARCHAR(50),
	international_sales_report_date					VARCHAR(8),
	international_sales_report_months				VARCHAR(8),
	international_sales_report_style				VARCHAR(50),
	international_sales_report_sku					VARCHAR(50),
	international_sales_report_pcs					DECIMAL(10, 2),
	international_sales_report_rate					DECIMAL(10, 2),
	international_sales_report_gross_amount			DECIMAL(10, 2),
	international_sales_report_stock				DECIMAL(10, 2)
);

IF OBJECT_ID ('bronze.erp_overall_sales_report', 'U') IS NOT NULL
	DROP TABLE bronze.erp_overall_sales_report;
CREATE TABLE bronze.erp_overall_sales_report (
	overall_sales_report_index						INT,
	overall_sales_report_sku_code					VARCHAR(50),
	overall_sales_report_design_no					VARCHAR(50),
	overall_sales_report_stock						DECIMAL(10,2),
	overall_sales_report_category					VARCHAR(50),
	overall_sales_report_size						VARCHAR(50),
	overall_sales_report_color						VARCHAR(50),
);
