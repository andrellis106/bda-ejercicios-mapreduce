#!/bin/bash
# Mini-ejercicio Equipo 3 (Agregacion) - Hadoop 3.3.6 en modo local
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export HADOOP_HOME=/opt/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

mkdir -p /tmp/ejercicio_e3/entrada
echo "sol luna sol estrella sol luna cometa" > /tmp/ejercicio_e3/entrada/texto.txt
rm -rf /tmp/ejercicio_e3/salida_count /tmp/ejercicio_e3/salida_hist

cd /opt/hadoop/share/hadoop/mapreduce

# Se pasa el plugin con -D porque en Hadoop 3.3.6 el ejemplo no lo carga solo
hadoop jar hadoop-mapreduce-examples-3.3.6.jar aggregatewordcount \
  -D mapreduce.aggregate.descriptor.num=1 \
  -D 'mapreduce.aggregate.descriptor.0=UserDefined,org.apache.hadoop.examples.AggregateWordCount$WordCountPlugInClass' \
  /tmp/ejercicio_e3/entrada /tmp/ejercicio_e3/salida_count 1 textInputFormat

hadoop jar hadoop-mapreduce-examples-3.3.6.jar aggregatewordhist \
  -D mapreduce.aggregate.descriptor.num=1 \
  -D 'mapreduce.aggregate.descriptor.0=UserDefined,org.apache.hadoop.examples.AggregateWordHistogram$AggregateWordHistogramPlugin' \
  /tmp/ejercicio_e3/entrada /tmp/ejercicio_e3/salida_hist 1 textInputFormat

echo "=== Salida WordCount ==="
cat /tmp/ejercicio_e3/salida_count/part-r-00000
echo "=== Salida Histograma ==="
cat /tmp/ejercicio_e3/salida_hist/part-r-00000
