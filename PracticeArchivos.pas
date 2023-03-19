(* program practiceArchivos;
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
end. *)



(* Realizar un programa con archivos para cargar, modificar un campo y imprimir antes y despues de la modificacion *)

program practiceArchivos;
type
   archivo = file of integer;
var
   arcLogico: archivo;
   arcFisico: string;
   nro: integer;
   pos: integer;
begin
   pos:= 1;

   write('Enter the path of file: '); readln(arcFisico);
   assign(arcLogico, arcFisico);
   rewrite(arcLogico);

   write('Now Enter numbers: '); 
   write('Nro -> '); readln(nro);
   while(nro <> 0)do begin
      write(arcLogico, nro);
      write('Nro -> '); readln(nro);
   end;
   close(arcLogico);

   writeln();  
   writeln('Now reading the numbers: ');  
   reset(arcLogico);
   while(not EOF(arcLogico))do begin
      read(arcLogico, nro);
      writeln('Nro ',pos,' -> ',nro);
      pos:=pos + 1;
   end;
   close(arcLogico);


   writeln('Modifying the numbers....');
   reset(arcLogico);
   while(not EOF(arcLogico))do begin
      read(arcLogico, nro);
      nro:= nro + 2;
      seek(arcLogico, filepos(arcLogico) - 1);
      write(arcLogico, nro);
   end;
   close(arcLogico);

   writeln();  
   writeln('Now reading the numbers: ');  
   reset(arcLogico);
   while(not EOF(arcLogico))do begin
      read(arcLogico, nro);
      writeln('Nro ',pos,' -> ',nro);
      pos:=pos + 1;
   end;
   close(arcLogico);

   write('Press enter to finish'); readln();

end.


