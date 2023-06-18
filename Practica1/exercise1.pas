//Fundamentos de Organizacion de Datos - Enunciado:
(* Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo. *)

program exercise1;
type
   archive = file of integer;
var
   arcLogico: archive;
   arcFisico: string;
   nro: integer;
begin
   write('Enter the file PATH: '); readln(arcFisico);
   assign(arcLogico, arcFisico); //Conecta el archivo logico con el archivo fisico, es decir, la ruta
   rewrite(arcLogico); //Se crea el archivo

   write('- Enter a number: '); readln(nro);
   while(nro <> 300)do begin
      write(arcLogico, nro);
      write('- Enter a number: '); readln(nro);
   end;
   close(arcLogico);
   
   reset(arcLogico);
   while(not EOF(arcLogico))do begin
      read(arcLogico, nro);
      writeln(nro);
   end;
   close(arcLogico);

end.