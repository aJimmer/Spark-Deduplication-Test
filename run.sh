#!/bin/bash

readonly BASEDIR=$( dirname $0 )
readonly OUTPUTDIR=$BASEDIR/output
readonly TARGETDIR=$BASEDIR/target
readonly JARFILE=$TARGETDIR/BellCode.jar

export JAVA_HOME=${JAVAHOME:-$( ls -d1 /usr/lib/jvm/java-1.8.0 | tail -1 )}
export PATH=$JAVA_HOME/bin:$PATH

# Local setup
rm -rf $OUTPUTDIR
mkdir -p $OUTPUTDIR

hdfs dfs -rm -skipTrash -R /ded_input /ded_output

hdfs dfs -mkdir /ded_input

if [ ! -f $JARFILE ]; then
  mvn clean package
fi

# Execute
echo "Deduping - Generating data"
spark-submit --class com.hadoop.spark.dedup.GenDedupInput $JARFILE \
  /ded_input/ded.txt 1000000 100 2>&1 | tee $OUTPUTDIR/GenDedupInput.out
echo "Deduping - Executing example"
spark-submit --class com.hadoop.spark.dedup.SparkDedupExecution $JARFILE \
  /ded_input /ded_output 2>&1 | tee $OUTPUTDIR/SparkDedupExecution.out