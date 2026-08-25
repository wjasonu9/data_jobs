/* Database Load Issues (follow if receiving permission denied when running SQL code below)

NOTE: If you are having issues with permissions. And you get error: 

'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM '[Insert File Path]/company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM '/home/jason/Downloads/Anaconda/sql_qjx/csv_files/skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM '[Insert File Path]/job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM '[Insert File Path]/skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/

-- NOTE: This has been updated from the video to fix issues with encoding

COPY company_dim
-- FROM '/tmp/csv_files/company_dim.csv'
FROM PROGRAM 'curl -L https://drive.usercontent.google.com/download?id=1j1PPr-6XmnL384_h4XFFHMIZpS5BL6v0&confirm=t'
-- FROM PROGRAM 'curl -L https://raw.githubusercontent.com/wjasonu9/data_jobs/refs/heads/main/csv_files/company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
-- FROM '/tmp/csv_files/skills_dim.csv'
FROM PROGRAM 'curl -L https://drive.usercontent.google.com/download?id=1wfVxoU_bkkj2lw6jNeIz-NGhv901OYN8&confirm=t'
-- FROM PROGRAM 'curl -L https://raw.githubusercontent.com/wjasonu9/data_jobs/refs/heads/main/csv_files/skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
-- FROM '/tmp/csv_files/job_postings_fact.csv'
FROM PROGRAM 'curl -L https://drive.usercontent.google.com/download?id=1z8r2PDcxHzoTbJGspCs5QzvRK1wSRFhK&confirm=t'
-- FROM PROGRAM 'curl -L https://raw.githubusercontent.com/wjasonu9/data_jobs/refs/heads/main/csv_files/job_postings_fact0.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

/* COPY job_postings_fact
FROM PROGRAM 'curl -L https://raw.githubusercontent.com/wjasonu9/data_jobs/refs/heads/main/csv_files/job_postings_fact1.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8'); */

COPY skills_job_dim
-- FROM '/tmp/csv_files/skills_job_dim.csv'
FROM PROGRAM 'curl -L https://drive.usercontent.google.com/download?id=12R67GPvefOGpbwOcOM1rf7EQjvC0cCTI&confirm=t'
-- FROM PROGRAM 'curl -L https://raw.githubusercontent.com/wjasonu9/data_jobs/refs/heads/main/csv_files/skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
