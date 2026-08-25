import pandas as pd
#conda install psycopg2
import sqlalchemy as sqla
#in psql: ALTER USER postgres WITH PASSWORD 'password';
engine = sqla.create_engine("postgresql+psycopg2://postgres:password@localhost/sql_luke") #dialect+driver://username:password@host:port/database
qry="""SELECT *
FROM invoices_fact
LIMIT 6"""
conn=engine.connect()
result = conn.execute(sqla.text("SELECT 1"))
result.fetchone() #sanity check: should be tuple (1,)
conn.execute(sqla.text(qry)).fetchone() #1 row as tuple
pd.read_sql(qry,engine)
