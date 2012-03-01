#!/bin/sh
export JAVA_HOME=/usr/lib/jvm/default-java
export AWS_BIN=/usr
export PATH=$PATH:$EC2_HOME/bin:$AWS_BIN
export EC2_REGION=ap-northeast-1
export AWS_CREDENTIAL_FILE=/root/.ec2/cred.txt

DATE=`date '+%Y%m%d'`
DB_INSTANCE=your_instance

 rds-create-db-snapshot -i $DB_INSTANCE -s $DB_INSTANCE-$DATE
 
COUNT=0
MAX=5
 
for i in `rds-describe-db-snapshots | cut -f3 -d ' ' | sort -r`
do
  if [ $COUNT -ge $MAX ];then
     rds-delete-db-snapshot $i -f
  fi
  COUNT=`expr $COUNT + 1`
done

