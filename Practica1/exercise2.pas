//Fundamentos de Organización de Datos - Enunciado:
(* Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 100 y
el promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla. *)


program exercise2;
type
   archive = file of integer;

   //Process 1
   procedure loadArchive(var arcLogico: archive);
   var
      nro:integer;
   begin
      write('- Enter a number: '); readln(nro);
      while(nro <> 30000)do begin
         write(arcLogico, nro);
         write('- Enter a number: '); readln(nro);
      end;
      close(arcLogico);
   end;

   //Process 2
   procedure processArchive(var arcLogico:archive; var amountOfNumber:integer; var average:real);
   var
      nro: integer;
      sumOfNumber:integer;
      total:integer;
   begin
      writeln('Entre');
      total:= fileSize(arcLogico);
      sumOfNumber:= 0;
      
      reset(arcLogico);
      while(not EOF(arcLogico))do begin
         read(arcLogico, nro);
         sumOfNumber:= sumOfNumber + nro;
         if(nro > 100)then
            amountOfNumber:= amountOfNumber + 1;
      end;
      close(arcLogico);
      average:= total / sumOfNumber;
   end;


var
   arcLogico: archive;
   arcFisico: string;
   amountOfNumber: integer;
   average: real;
begin
   amountOfNumber:= 0;
   average:= 0;

   write('Enter the file PATH: '); readln(arcFisico);
   assign(arcLogico, arcFisico); //Conecta el archivo logico con el archivo fisico, es decir, la ruta
   rewrite(arcLogico); //Se crea el archivo

   loadArchive(arcLogico); //Process 1
   processArchive(arcLogico, amountOfNumber, average); //Process 2

   //Informamos:
   writeln('The number of numbers greater than 100 is: ',amountOfNumber);
   writeln('The average of numbers is: ',average:2:2); 

end.