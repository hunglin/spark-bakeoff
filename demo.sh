#!/bin/bash

SPARK_CMD="$HOME/spark-ec2 -k spark_test -i $HOME/spark_test.pem"

$SPARK_CMD -s 20 -t c3.2xlarge --hadoop-major-version 2 —no-ganglia launch bakeoff
$SPARK_CMD --main-class PageNumberRank --app-jar --app-args "s3n://$AWS_ACCESS_KEY_ID:$AWS_SECRET_ACCESS_KEY@aws-publicdatasets/common-crawl/crawl-data/CC-MAIN-2014-35/segments/1408500800168.29/wet/CC-MAIN-20140820021320-000*.gz" submit bakeoff
$SPARK_CMD --delete-groups destroy bakeoff
