# Online Sales Trend Analysis Using Aggregations

## Project Objective
The objective of this project is to build an analytical time-series pipeline inside MySQL using raw digital transaction records (`Online Sales Data.csv`). By converting text-based data inputs into real temporal database objects, this project executes key chronological grouping operations to track month-over-month sales velocities, order volumes, and identify peak performance windows for inventory forecasting.

## Key Technical Workflows

### 1. Schema Architecture & Idempotency
* Designed a clean staging table structure (`sales_analysis_table`) with explicit field constraints, using `DECIMAL(10,2)` for monetary values to protect against floating-point calculation errors.
* Implemented `DROP TABLE IF EXISTS` logic to guarantee script repeatability across any target environment.

### 2. ETL & Data Cleaning Pipeline
* Engineered an on-the-fly date transformation pipeline using the `STR_TO_DATE()` function. This repaired unstructured string lines (e.g., `'2024-01-01'`) and cast them into valid searchable database `DATE` entries.
* Used escaping parameters to seamlessly pull data fields from space-separated raw file layers.

### 3. Chronological Financial Aggregations
* **Monthly Performance Trends:** Deployed `EXTRACT(YEAR/MONTH FROM...)` inside a strict multi-column `GROUP BY` block to consolidate hundreds of individual rows into structured chronological milestones.
* **Volume Analysis:** Applied `COUNT(DISTINCT transaction_id)` to isolate true distinct customer order tallies alongside absolute revenue generation (`SUM()`).
* **Peak Metric Extraction:** Filtered execution boundaries using `ORDER BY DESC` and `LIMIT 3` constraints to extract the highest earning peak operations immediately for strategic analysis.

## SQL Script Modules Covered
* **Query 1:** Chronological month-by-month order volume tracking and absolute gross revenue margins.
* **Query 2:** Isolated performance analysis capturing the top 3 highest-earning calendar months.

## Project Repository File Structure
* **`Online Sales Data.csv`**: The underlying multi-dimensional raw transactional commerce data source.
* **`sales_trend_analysis.sql`**: The production-ready SQL script containing table initializations, extraction adapters, and trend calculations.
* **`sql-outputs/`**: Dedicated folder storing clear workbench snapshots capturing successful query output grids and green validation execution marks.
