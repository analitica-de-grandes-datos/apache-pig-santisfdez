/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'repo/pregunta_07/data.tsv' USING PigStorage('\t') AS (f1:CHARARRAY, f2:CHARARRAY, f3:CHARARRAY);
reemplazo = FOREACH lines GENERATE REPLACE(REPLACE(f2,'(\\{)',''),'(\\})','') AS col2,REPLACE(REPLACE(f3,'(\\[)',''),'(\\])','') AS col3;
subtuplas = FOREACH reemplazo GENERATE FLATTEN(TOKENIZE(col2)) As word1, col3;
subtuplas2 = FOREACH subtuplas GENERATE word1 , FLATTEN(TOKENIZE(col3)) As word2;
tuplas = FOREACH subtuplas2 GENERATE (word1, SUBSTRING(word2,0,3)) AS clave;
grouped = GROUP tuplas BY clave;
wordcount = FOREACH grouped GENERATE group, COUNT(tuplas);

STORE wordcount INTO 'output' USING PigStorage(',');
