from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

PENTAHO_DIR = "/usr/local/airflow/include/pentaho"
KITCHEN = f"{PENTAHO_DIR}/data-integration/kitchen.sh"
JOB_FILE = f"{PENTAHO_DIR}/jobs/run_all_facts.kjb"

env_config = {
    "JAVA_HOME": "/usr/lib/jvm/java-17-openjdk-amd64"
}

with DAG('national_statistics_dwh', start_date=datetime(2023, 1, 1), schedule_interval=None, catchup=False) as dag:

    run_etl = BashOperator(
        task_id='run_pentaho_job',
        bash_command=f"bash {KITCHEN} -file='{JOB_FILE}'",
        env=env_config,
        append_env=True
    )