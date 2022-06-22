/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.csv' USING PigStorage(',') AS (f1:CHARARRAY, f2:CHARARRAY, f3:CHARARRAY, f4:CHARARRAY, f5:CHARARRAY);
origen = FOREACH lines GENERATE ToDate(f4, 'yyyy-MM-dd') AS datos;
selected_data = FOREACH origen GENERATE ToString(datos,'yyyy-MM-dd') AS date, ToString(datos,'dd') AS dia, GetDay(datos) AS day, REPLACE(LOWER(ToString(datos, 'EEE')), 'mon', 'lun') AS dayname, REPLACE(LOWER(ToString(datos, 'EEEE')), 'monday', 'lunes') AS fullday;
selected_data = FOREACH selected_data GENERATE date, dia, day, REPLACE(dayname, 'thu', 'jue') AS dayname, REPLACE(fullday, 'thursday', 'jueves') AS fullday;
selected_data = FOREACH selected_data GENERATE date, dia, day, REPLACE(dayname, 'sun', 'dom') AS dayname, REPLACE(fullday, 'sunday', 'domingo') AS fullday;
selected_data = FOREACH selected_data GENERATE date, dia, day, REPLACE(dayname, 'wed', 'mie') AS dayname, REPLACE(fullday, 'wednesday', 'miercoles') AS fullday;
selected_data = FOREACH selected_data GENERATE date, dia, day, REPLACE(dayname, 'fri', 'vie') AS dayname, REPLACE(fullday, 'friday', 'viernes') AS fullday;
selected_data = FOREACH selected_data GENERATE date, dia, day, REPLACE(dayname, 'tue', 'mar') AS dayname, REPLACE(fullday, 'tuesday', 'martes') AS fullday;

STORE selected_data INTO 'output' USING PigStorage(',');
