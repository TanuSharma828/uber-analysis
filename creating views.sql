/*
=========================================================================================================================================
Create Gold Views:
Script Purpose:

This script creates views for the Gold layer in the data warehouse.

The Gold layer represents the final dimension and fact tables (Star Schema)

Each view performs transformations and combines data from the Silver layer to produce a clean, enriched, and business-ready dataset.
=========================================================================================================================================
*/

-- -----------------------------------------
-- Creating dimension of retail_sales table
-- -----------------------------------------
DROP VIEW IF EXISTS gold.dim_retail_sales;
GO
CREATE VIEW gold.dim_retail_sales AS 
	SELECT 
		transaction_id,
		TRY_CONVERT(DATE, sale_date, 105) AS sale_date,
		TRY_CONVERT(TIME(0), sale_time) AS sale_time,
		customer_id,
		gender,
		age,
		category,
		quantity,
		price_per_unit unit_price,
		cogs,
		total_sales
	FROM silver.retail_sales;
GO

-- -------------------------------------
-- Creating dimension of features table
-- -------------------------------------
DROP VIEW IF EXISTS gold.dim_features;
GO
CREATE VIEW gold.dim_features AS
	SELECT
		feature_id,
		store,
		date,
		temperature,
		fuel_price,
		MarkDown1,
		MarkDown2,
		MarkDown3,
		MarkDown4,
		MarkDown5,
		CPI,
		Unemployment,
		Isholiday
	FROM silver.features;
GO

-- -------------------------------------
-- Creating dimension of Sales table
-- -------------------------------------
DROP VIEW IF EXISTS gold.dim_sale;
GO
CREATE VIEW gold.dim_sales AS
	SELECT 
		sales_id,
		store,
		dept,
		Date AS date,
		weekly_sales,
		isHoliday AS holiday
	FROM silver.sales;
GO

-- -------------------------------------
-- Creating dimension of Stoers table
-- -------------------------------------
DROP VIEW IF EXISTS gold.fact_stores;
GO
CREATE VIEW gold.fact_stores AS
	SELECT 
		store,
		Type,
		size
	FROM silver.stores;
GO