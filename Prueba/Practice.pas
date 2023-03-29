program practice;
type
   user = record
      name:string[20];
      age:integer;
   end;

   archive = file of user;

   //Process 1
   procedure printData(var arcLogico: archive);
   var
      per: user;
   begin
      reset(arcLogico); //Abrimos el archivo existente para lectura del mismo
      while(not EOF(arcLogico))do begin
         read(arcLogico, per);
         writeln('Name: ',per.name);
         writeln('Age: ',per.age);
         writeln();
      end;
      close(arcLogico); //Cerramos el archivo
   end;

var
   arcLogico: archive;
   arcFisico: string;
   person: user;
begin
   write('Enter the file PATH: '); readln(arcFisico);
   assign(arcLogico, arcFisico); //Conecta el archivo logico con el archivo fisico, es decir, la ruta
   rewrite(arcLogico); //Se crea el archivo

   //Cargar el archivo
   write('Enter the Name: '); readln(person.name);
   while(person.name <> '')do begin
      write('Enter the Age: '); readln(person.age);
      write(arcLogico, person);
      writeln();
      write('Enter the Name: '); readln(person.name);
   end;
   //Cerrar el archivo, es decir, ya no guarda mas.
   close(arcLogico);

   //Imprimir datos del archivo
   printData(arcLogico); //Process 1

end.

