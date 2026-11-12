# Equipo 1 - Estadística de palabras I (WordCount)

Repositorio original: https://github.com/juansebastianesq/bda-equipo-1-estadistica-de-palabras-i

## Ejercicio
Agregar un tercer archivo de texto en `datos_entrada` con el texto "KLK de nuevo",
volver a ejecutar el script y decir cuál es el nuevo valor de la palabra KLK.

## Pasos realizados
1. Copiar los datos y el script al contenedor (desde PowerShell):
   ```
   docker start hadoop
   docker cp datos/. hadoop:/datos_entrada/
   docker cp scripts/ejecutar.sh hadoop:/ejecutar.sh
   docker exec -it hadoop bash
   ```
2. Dentro del contenedor, configurar Java y Hadoop:
   ```
   export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
   export HADOOP_HOME=/opt/hadoop
   export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
   ```
3. Crear el tercer archivo, borrar la salida anterior y ejecutar:
   ```
   cd /
   echo "KLK de nuevo" > /datos_entrada/texto3.txt
   rm -rf /resultados_salida
   bash /ejecutar.sh
   cat /resultados_salida/part-r-00000
   ```

## Resultado
```
KLK     3
Mayor   1
de      1
nuevo   1
```

## Respuesta
**El nuevo valor de KLK es 3.**

En la fase **Map**, cada archivo genera un par `(KLK, 1)` (uno por archivo).
En la fase **Reduce** se suman los valores de la misma palabra: 1 + 1 + 1 = 3.
Además aparecen dos palabras nuevas, `de` y `nuevo`, con 1 cada una.

## Problemas encontrados
- `JAVA_HOME is not set`: las variables se pierden al reiniciar el contenedor; se vuelven a definir con los `export` del paso 2.
- Al clonar en Windows, `ejecutar.sh` quedó con saltos de línea CRLF y la carpeta de salida se creó como `resultados_salida\r`. Se corrigió con:
  ```
  sed -i 's/\r$//' /ejecutar.sh
  ```
