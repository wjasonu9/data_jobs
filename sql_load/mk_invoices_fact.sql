CREATE TABLE public.invoices_fact (
    activity_id INT PRIMARY KEY,
    activity_date TIMESTAMP,
    project_id INT,
    project_company VARCHAR(100),
    project_tool VARCHAR(16),
    nerd_id INT,
    nerd_role VARCHAR(28),
    hours_spent INT,
    hours_rate NUMERIC(6,3) );

ALTER TABLE public.invoices_fact OWNER to postgres;

COPY invoices_fact
-- FROM '/tmp/invoices_fact.csv'
FROM PROGRAM 'curl -L https://raw.githubusercontent.com/wjasonu9/data_jobs/refs/heads/main/csv_files/invoices_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER E'\t', ENCODING 'UTF8');
