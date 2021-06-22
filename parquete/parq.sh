#!/bin/bash -x
/var/log/cloud-init-output.log
/var/log/cloud-init.log
TAGNAME=parquettools
TAGENV=prodna
REGION=$(curl -s 169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//');
INSTANCEID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id );
SPOTOROD=`aws ec2 describe-instances --instance-ids $INSTANCEID --region $REGION --filter "Name=instance-lifecycle,Values=spot" --out text | grep $INSTANCEID`
if [ -z "$SPOTOROD" ]; then  TAGNAME=`echo $TAGNAME | sed "s/$TAGNAME/$TAGNAME-od/g"` ;
else TAGNAME=`echo $TAGNAME | sed "s/$TAGNAME/$TAGNAME-spot/g"`
fi
aws ec2 create-tags --resources $INSTANCEID --tags Key=Purpose,Value=PS Key=Name,Value=$TAGNAME Key=Environment,Value=$TAGENV --region $REGION
