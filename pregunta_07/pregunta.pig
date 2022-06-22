/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' USING PigStorage('\t') AS (f1:CHARARRAY, f2:BAG{}, f3:MAP[]);
reemplazo = FOREACH lines GENERATE f1, SIZE(f2) AS col2 , SIZE(f3) AS col3;
ordered = ORDER reemplazo BY f1, col2, col3;
STORE ordered INTO 'output' USING PigStorage(',');
