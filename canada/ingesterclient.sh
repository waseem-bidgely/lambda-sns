#!/bin/bash -x
> /var/log/cloud-init-output.log
> /var/log/cloud-init.log
echo "=================USER SCRIPT START===================="
cat <<"setvariables" > /tmp/setvariables.sh
export TAGNAME=ingesterclient
export TAGCOMPONENT=daemons
export TAGENV=prodca
export OWNER=ops
export UTILITY=all
export STARTDATE=2017-07-02T00:01:00Z
export ENDDATE=2027-07-02T00:00:00Z
export AMIID=ami-0ab2f1116d02c2ec1
export SNAPSHOTID=
export SUBNET=subnet-0b203fd84612bcbd1
export JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre
export BIDGELY_ENV=prod-ca
export SECURITYGROUP='sg-03e1f7b8b6d11fa3c'
export KEYPAIR=prodca
export INSTANCEPROFILE=prodca-iam-instance-role
export REPO=repo2.bidgely.com
export REPODIR=prodca
export S3ARTIFACTSBUCKET=bidgely-canada-setup/infra
export CLOUDWATCH=NO
export SNSTOPIC=SPOT-PROD
setvariables
chmod 700 /tmp/setvariables.sh
source /tmp/setvariables.sh
aws s3 cp s3://bidgely-canada-setup/infra/userdata.sh .
chmod 700 userdata.sh
./userdata.sh
