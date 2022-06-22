/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.csv' USING PigStorage(',') AS (f1:CHARARRAY, f2:CHARARRAY, f3:CHARARRAY, f4:CHARARRAY, f5:CHARARRAY);
resultado = FOREACH lines GENERATE ToDate(f4, 'YYYY-MM-dd') AS dia;
year = FOREACH resultado GENERATE GetYear(dia) AS dato;
grouped = GROUP year BY dato;
wordcount = FOREACH grouped GENERATE group , COUNT(year);
STORE wordcount INTO 'output' USING PigStorage(',');
