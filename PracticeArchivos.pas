program practiceArchivos;
Uses sysutils;

type
   archivo  = file of integer;
var
   arcLogico: archivo;
   arcFisico: string;
begin
   write('Ingrese en nombre del archivo: '); readln(arcFisico);
   assign(arcLogico, arcFisico);
   rewrite(arcLogico);
   if(FileExists(arcFisico))then
      writeln('El archivo existe')
   else
      writeln('El archivo NO existe');

   write('Presione enter para finalizar_'); readln();
end.