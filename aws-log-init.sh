#!/bin/bash

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
PVT_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`

echo Sqs Arn: $1
echo Elasticsearch Host: $2
echo =====================================
echo Region: $EC2_REGION

sed -i "s/{{aws-region}}/$EC2_REGION/g" ./ls-aws-sqs3.conf
sed -i "s/{{sqs-arn}}/$1/g" ./ls-aws-sqs3.conf
sed -i "s/{{es-host}}/$2/g" ./ls-aws-sqs3.conf

./bin/logstash -f ./ls-aws-sqs3.conf