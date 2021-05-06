May 3rd, at 4:00 PM PT, William reported EMR jupyter cannot be attached to the new clusters. Initially, we took the dev cluster offline for half an hour to install an additional package to add the notebook functionality. However, it didn't resolve the issue. The root cause is an AWS EMR security configuration. We have opened a support ticket with AWS for resolution. 

May 3rd, at 9:00 PM PT, Gurpreet reported an error on the live Dev server. The issue affected only new tables that were created via ingestion. On May 4th at 4:28 AM, Pradeep (ISP offshore) updated the spark configuration to resolve the issue. The root cause of the incident turned out to be different parquet conventions used in Hive and Spark.

May 5th - The offshore team reported the build pipelines are failing. We checked logs and quickly found out that the issue was caused by missing python packages(Github and jq). Pradeep quickly rolled back the docker upgrade and buildspec.yml file to resolve the issue. 

To preventing similar incidents in the future, we will increase test coverage of the application to ensure that all critical parts of functionality are 100% covered




