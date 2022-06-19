/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'repo/pregunta_01/data.tsv' USING PigStorage('\t') AS (line:CHARARRAY, f2:CHARARRAY, f3:INT);
column  = FOREACH lines GENERATE f3;
sort = ORDER column by f3;
result = LIMIT sort 5;
STORE result INTO 'output' USING PigStorage(',');
