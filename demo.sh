#!/bin/bash

### local settings
SPARKEC2_SCRIPT="$SPARK_HOME/ec2/spark-ec2"
EC2_KEYPAIR="spark_test"
EC2_KEY_FILE="$HOME/spark_test.pem"

### spark cluster settings
CLUSTER_NAME="cluster1"
SLAVE_NUM="1"
EC2_TYPE="m3.medium"

### spark app settings
SPARK_APP_JAR="YOUR_SPARK_JAR_FILE"
MAIN_CLASS="MAIN_CLASS_OF_SPARK_JAR"
SPARK_APP_ARGS=""

SPARKEC2="$SPARKEC2_SCRIPT -k $EC2_KEYPAIR -i $EC2_KEY_FILE"

#$SPARKEC2 -s $SLAVE_NUM -t $EC2_TYPE --hadoop-major-version 2 --no-ganglia launch $CLUSTER_NAME
$SPARKEC2 --main-class $MAIN_CLASS --app-jar $SPARK_APP_JAR --app-args $SPARK_APP_ARGS submit $CLUSTER_NAME
$SPARKEC2 --delete-groups destroy $CLUSTER_NAME
