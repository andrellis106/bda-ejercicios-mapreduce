/opt/hadoop/bin/hadoop jar $(find / -name hadoop-mapreduce-examples-*.jar 2>/dev/null | head -n 1) wordcount datos_entrada resultados_salida
