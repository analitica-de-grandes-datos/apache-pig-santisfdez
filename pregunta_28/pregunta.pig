/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       birthday, 
       DATE_FORMAT(birthday, "yyyy"),
       DATE_FORMAT(birthday, "yy"),
   FROM 
       persons
   LIMIT
       5;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.csv' USING PigStorage(',') AS (f1:CHARARRAY, f2:CHARARRAY, f3:CHARARRAY, f4:CHARARRAY, f5:CHARARRAY);
resultado = FOREACH lines GENERATE SUBSTRING(f4, 0, 4), SUBSTRING(f4, 2,4);
STORE resultado INTO 'output' USING PigStorage(',');
