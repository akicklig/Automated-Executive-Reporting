# Automated-Executive-Reporting
Created a workflow that queries data from SQL and then automatically updates Excel charts, generates a PowerPoint, and delivers an Outlook e-mail.

## Objective

This project is meant to demonstrate the efficiencies of automating routine reporting/analytics as a service when productionizing the process into a dashboard or other tool may not be viable.

The end-to-end stages of the project workflow are:

1. Create a synthetic data set for a hypothetical car sales company and then load the data into a simple star schema database (1 fact table and 5 dimension tables) via MySQL Workbench.
2. Query the data through SQL, creating 4 pre-formatted/aggregated pulls and 1 data dump for pivoting in Excel.
3. Build an Excel file that charts performance and uses intelligent-text to dynamically update the commentary/insights based on the data.
4. Leverage Python to automatically:
- update Excel data tabs with new data queried from SQL
- update the PivotTables in Excel
- create and save a PowerPoint with charting output from Excel
- draft and send an email to Executive Leadership with the newly created PowerPoint attached.

## Reproduction

To reproduce this process on one's own machine, walk through the following:

1. In the [Workflow Files Folder](https://github.com/akicklig/Automated-Executive-Reporting/tree/main/Workflow_Files), download the data files inside the [data folder](https://github.com/akicklig/Automated-Executive-Reporting/tree/main/Workflow_Files/data).
2. Create the `sales` SQL database. The [query](https://github.com/akicklig/Automated-Executive-Reporting/blob/main/Workflow_Files/create_db.sql) for creating the database is located in this repository. This project used MySQL Workbench 8.0 to build the database.
- The synthetic source data to load into the database is all located in the [data folder](https://github.com/akicklig/Automated-Executive-Reporting/tree/main/Workflow_Files/data) and consists of 6 CSV files: `customers.csv`, `jobs.csv`, `city_state.csv`, `cars.csv`, `transactions.csv`, and `employees.csv`.
- Of note if using MySQL to reproduce the project:
- Ensure that `local_infile = true` to load data from your machine into the database.
- If the attempt to load local data triggers an `Error Code 2068` alert, refer to [this stack overflow entry](https://stackoverflow.com/questions/63264360/error-code-2068-file-requested-rejected-due-to-restrictions-on-access-with-root/) for assitance.
- Ensure the load files are located in the correct `/Uploads/` file path: `'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'`.
3. Query the `sales` data to be used for building the Excel file. The [queries](https://github.com/akicklig/Automated-Executive-Reporting/blob/main/Workflow_Files/sql_queries.sql) for these pulls can be found in this repository. Export the queried data to the [data folder](https://github.com/akicklig/Automated-Executive-Reporting/tree/main/Workflow_Files/data) or simply use the files already downloaded from this repository.
- There are 5 data files to use when building the Excel file: `sales_datadump.xlsx`, `sales_timeseries_day.xlsx`, `sales_timeseries_month.xlsx`, `sales_top_10_states.xlsx`, and `sales_cities_states.xlsx`.
- There are duplicated versions of these files in both `xlsx` and `csv` formats in the [data folder](https://github.com/akicklig/Automated-Executive-Reporting/tree/main/Workflow_Files/data). The Jupyter Notebook file leverages the `xlsx` files to run its code.
4. Download the [Executive_Reporting.xlsx](https://github.com/akicklig/Automated-Executive-Reporting/blob/main/Workflow_Files/Executive%20Reporting.xlsx) file and save it to the relevant file path.
5. Download the [Jupyter Notebook](https://github.com/akicklig/Automated-Executive-Reporting/blob/main/Workflow_Files/pynb.ipynb) file. Running the first 7 code chunks will update the Excel worksheets with the queried SQL data; the 8th will create and save a PowerPoint presentation with the charting output from Excel; the 9th and final code chunk will draft and send an Outlook e-mail with the newly created PowerPoint presentation attached.
6. Examples of the Excel File, PowerPoint presentation, and Outlook e-mail can all be found in the [Workflow Files Folder](https://github.com/akicklig/Automated-Executive-Reporting/tree/main/Workflow_Files) as well.
