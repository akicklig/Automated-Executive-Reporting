# Automated-Executive-Reporting
Created an automated workflow that queries data from SQL, updates Excel charts, generates a PowerPoint, and delivers an Outlook e-mail.

## Objective

This project is meant to demonstrate the efficiencies of automating routine reporting/analytics as a service when productionizing the process into a dashboard or other tool may not be viable.

The end-to-end stages of the project workflow are:

1. Create a synthetic data set for a hypothetical car sales company and then load the data into a simple star schema database (1 fact table and 5 dimension tables) via MySQL Workbench.
2. Query the data through SQL, creating 4 pre-formatted/aggregated pulls and 1 data dump for pivoting in Excel.
3. Build an Excel file that charts performance and uses intelligent-text to dynamically update the commentary/insights based on the data.
4. Leverage Python to automatically:
a. update Excel data tabs with new data queried from SQL.
b. Use Python to automatically update the PivotTables in Excel.
c. Run Python to automat
