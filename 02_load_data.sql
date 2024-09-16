select default_iam_role();

COPY users 
FROM 's3://redshift-downloads/tickit/allusers_pipe.txt' 
DELIMITER '|' 
TIMEFORMAT 'YYYY-MM-DD HH:MI:SS'
IGNOREHEADER 1 
REGION 'us-east-1'
IAM_ROLE default;                    
                    
COPY event
FROM 's3://redshift-downloads/tickit/allevents_pipe.txt' 
DELIMITER '|' 
TIMEFORMAT 'YYYY-MM-DD HH:MI:SS'
IGNOREHEADER 1 
REGION 'us-east-1'
IAM_ROLE default;

COPY sales
FROM 's3://redshift-downloads/tickit/sales_tab.txt' 
DELIMITER '\t' 
TIMEFORMAT 'MM/DD/YYYY HH:MI:SS'
IGNOREHEADER 1 
REGION 'us-east-1'
IAM_ROLE default;