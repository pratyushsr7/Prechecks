import streamlit as st 
import pandas as pd 
import snowflake.connector

def prechecks_app():
    snowflake_connection = snowflake.connector.connect(
        # host = 'slb78176.us-east-1.privatelink.snowflakecomputing.com:443',
        host = 'slb78176.us-east-1.snowflakecomputing.com/',
        account = 'slb78176', 
        user = 'CSH_AUTOMATION_USER', 
        password = 'dUstaxamezif6ajef4Is',
        role = 'DATAENGINEER',
        warehouse = 'CSHNATIONALPRODWAREHOUSE',
        database = 'DAP'
    )
    snowflake_cursor = snowflake_connection.cursor()

    query = 'select * from l1.dap_attribution_prechecks_results'

    df = pd.read_sql(query, snowflake_connection)
    st.title("Pre-Execution Checks Results")
    st.dataframe(df)

    # Optional 
    columns = st.multiselect("Filter by columns")
    if columns:
        filtered_df = df[columns]

if __name__ == "__main__":
    prechecks_app()