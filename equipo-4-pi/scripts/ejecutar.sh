#!/bin/bash
# Mini-ejercicio Equipo 4 (Pi por Monte Carlo) - Hadoop 3.3.6 en modo local
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export HADOOP_HOME=/opt/hadoop
export PATH=$PATH:$HADOOP_HOME/bin

JAR=/opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar
STAGING=/home/hadoop/equipo4/staging
mkdir -p "$STAGING"
cd /tmp

for MUESTRAS in 100 10000; do
  echo "== 2 tareas Map x $MUESTRAS muestras =="
  hadoop jar "$JAR" pi \
    -Dmapreduce.framework.name=local \
    -Dmapreduce.jobtracker.staging.root.dir="$STAGING" \
    2 "$MUESTRAS"
done
