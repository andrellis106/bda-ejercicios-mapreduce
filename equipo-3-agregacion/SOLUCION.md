# Equipo 3 - Agregación (aggregatewordcount y aggregatewordhist)

Repositorio original: https://github.com/Sistem328282/bda-equipo-3-agregacion

## Ejercicio
1. Crear `/tmp/ejercicio_e3/entrada/texto.txt` con la frase:
   `sol luna sol estrella sol luna cometa`
2. Ejecutar `aggregatewordcount` en `/tmp/ejercicio_e3/salida_count`.
3. Ejecutar `aggregatewordhist` en `/tmp/ejercicio_e3/salida_hist`.
4. Preguntas:
   - ¿Cuántas veces aparece la palabra 'sol'?
   - ¿Qué significa la línea '1 2' en la salida del histograma?

## Pasos realizados
```
docker start hadoop
docker exec -it hadoop bash
```
Dentro del contenedor se ejecutó lo que está en [`scripts/ejecutar.sh`](scripts/ejecutar.sh).

## Resultados

**aggregatewordcount**
```
cometa    1
estrella  1
luna      2
sol       3
```

**aggregatewordhist**
```
WORD_HISTOGRAM  4  1  2  3  1.75  0.82915619758885
```

| Valor | Significado |
|---|---|
| 4 | Palabras distintas (sol, luna, estrella, cometa) |
| 1 | Frecuencia mínima |
| 2 | Frecuencia mediana (1, 1, 2, 3) |
| 3 | Frecuencia máxima (sol) |
| 1.75 | Frecuencia promedio: (1+1+2+3)/4 |
| 0.829 | Desviación estándar de las frecuencias |

## Respuestas
- **'sol' aparece 3 veces** (`sol 3`).
- **La línea `1 2` significa que hay 2 palabras que aparecen exactamente 1 vez** (`estrella` y `cometa`).
  El histograma completo agrupa las palabras por su frecuencia:
  ```
  1  2   -> estrella, cometa
  2  1   -> luna
  3  1   -> sol
  ```
  En Hadoop 3.3.6 la salida muestra el resumen (distintas, mín, mediana, máx, promedio, desviación) en lugar de esa tabla, pero los datos coinciden.

## Problema encontrado
Con el comando original, ambos ejemplos solo imprimían `record_count 1` (cuentan **líneas**, no palabras).
En Hadoop 3.3.6 estos ejemplos no cargan su plugin de agregación por sí solos, así que se usa el
descriptor por defecto, que solo cuenta registros. Por eso en el repo del Equipo 3 aparece `record_count 3`
(su archivo tiene 3 líneas).

Solución: indicar el plugin con `-D` al ejecutar:
```
-D mapreduce.aggregate.descriptor.num=1
-D 'mapreduce.aggregate.descriptor.0=UserDefined,org.apache.hadoop.examples.AggregateWordCount$WordCountPlugInClass'
```
(y `AggregateWordHistogram$AggregateWordHistogramPlugin` para el histograma).
