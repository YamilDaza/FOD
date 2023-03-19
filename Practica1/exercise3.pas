(* 3. Realizar un programa que presente un menú con opciones para:
- a.Crear un archivo de registros no ordenados de empleados y completarlo con datos ingresados desde teclado. De cada empleado se registra: número de empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
- b.Abrir el archivo anteriormente generado y
   i. Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.
   ii.Listar en pantalla los empleados de a uno por línea.
   iii.Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario una única vez. *)

program exercise3;
Uses sysutils;
const 
   FIN = 'fin';
type
   empleados = record
      nroEmpleado: integer;
      apellido: string[20];
      nombre: string[20];
      edad: integer;
      dni: integer;
   end;

   archivo: file of empleados;

   //Process 1
   procedure presentarMenuOne();
   begin
      writeln(' ========= Bienvenido al sistema ==========');
      writeln(' ......... Menu de opciones ..........');
      writeln(' A- Crear un archivo de empleados');
      writeln(' B- Abrir un archivo existente');
      writeln(' C- Finalizar');
   end;

   //Process 2.A.A
   procedure crearEmpleado(var emp: empleados);
   begin
      write('Nro de empleado: '); readln(emp.nroEmpleado);
      write('Apellido: '); readln(emp.apellido);
      if(emp.apellido <> FIN)then begin
         write('Nombre: '); readln(emp.nombre);
         write('EDad: '); readln(emp.edad);
         write('DNI: '); readln(emp.dni);
         writeln();
         writeln('...... Siguiente .......');
         writeln();
      end
      else begin
         writeln();
         writeln(' <<<<<<< FIN DE LA CARGA >>>>>>>');
         writeln();
      end;
   end;

   //Process 2.A
   procedure crearArchivo(var arcLogico: archivo; var arcFisico: string);
   var 
      emp: empleados;
   begin
      write('Ingrese el nombre del archivo: '); readln(arcFisico);
      assign(arcLogico, arcFisico);
      rewrite(arcLogico);
      crearEmpleado(emp); //Process 2.A.A
      while(emp.apellido <> FIN)do begin
         write(arcLogico, emp);
         crearEmpleado(emp); 
      end;
      close(arcLogico);
   end;

   //Process 2
   procedure evaluarOpcion(var arcLogico: archivo; var arcFisico: string);
   var
      opcion: char;
   begin
      write('Opcion: '); readln();
      if(opcion = 'A')then
         crearArchivo(arcLogico, arcFisico); //Process 2.A
         else 
            if((opcion = 'B') AND (fileExists(arcFisico)))then
               presentarMenuTwo();
            else
               evaluarOpcion(arcLogico, arcFisico);
      else
         writeln('..... Hasta pronto ......')
      end;

   end;

var
   arcLogico: archivo;
   arcFisico: string;
begin
   presentarMenuOne(); //Process 1
   evaluarOpcion(arcLogico, arcFisico); //Process 2
end;


