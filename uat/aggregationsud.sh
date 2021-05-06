#!/bin/bash
sleep 120
INSTANCEID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id );
aws ec2 create-tags --resources $INSTANCEID --tags Key=Name,Value=daemons-avista-aggregations Key=Environment,Value=uat Key=Component,Value=daemons Key=Owner,Value=rohini Key=Utility,Value=avista Key=QueueSuffix,Value=avista --region us-west-2
echo QUEUE_SUFFIX=avista >> /etc/environment
echo BIDGELY_ENV=uat >> /etc/environment
aws s3 cp s3://bidgely-artifacts2/avista-autoscaling/aggregationServices_3.1~SNAPSHOT_all.deb .
dpkg -i aggregationServices_3.1~SNAPSHOT_all.deb
