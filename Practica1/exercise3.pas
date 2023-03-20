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
   FIN = 'fin'; //Corte de control de la carga de empleados en el archivo.
type
   empleados = record
      nroEmpleado: integer;
      apellido: string[20];
      nombre: string[20];
      edad: integer;
      dni: integer;
   end;

   archivo = file of empleados;

   //Process 1
   procedure menuDeOpciones1();
   begin
      writeln(' ......... Menu de opciones ..........');
      writeln(' A- Crear un archivo de empleados');
      writeln(' B- Abrir un archivo existente');
      writeln(' C- Finalizar');
   end;

   //Process 
   procedure menuDeOpciones2();
   begin
      writeln(' ......... Menu de opciones B: ..........');
      writeln(' 1- Buscar empleado con nombre o apellido determinado');
      writeln(' 2- Mostrar todos los empleados');
      writeln(' 3- Empleados proximos a jubilarse.');
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

      if(fileExists(arcFisico))then begin
         writeln('***************************************');
         writeln('***    ARCHIVO CREADO CON EXITO    ****');
         writeln('***************************************');
      end
      else
         writeln(' xxxxxx    ARCHIVO NO CREADO    xxxxxxx ');
   end;

   //Function 1
   function estaEmpleado(emp: empleados; dato:string):boolean;
   begin
      estaEmpleado:= ((dato = emp.apellido) OR (dato = emp.nombre));
   end;

   //Procerss 2.1.1
   procedure informarEmpleado(emp: empleados);
   begin
      writeln('- Nro de empleado -> ',emp.nroEmpleado);
      writeln('- Apellido -> ',emp.apellido);
      writeln('- Nombre -> ',emp.nombre);
      writeln('- Edad -> ',emp.edad);
      writeln('- DNI -> ',emp.dni);
      writeln();
   end;

   //Process 2.1
   procedure buscarEmpleado(var arcLogico: archivo);
   var
      emp: empleados;
      dato: string;
      encontre: boolean;
   begin
      write('Ingrese el nombre o apellido del empleado: '); readln(dato);
      encontre:= false;
      reset(arcLogico); //Abrimos el archivo
      while((not EOF(arcLogico)) AND (not encontre))do begin
         read(arcLogico, emp);
         if(estaEmpleado(emp, dato))then begin//function 1
            writeln(' ***** Empleado Encontrado ***** ');
            informarEmpleado(emp); //Process 2.1.1
            encontre:= true;
         end;
      end;
      close(arcLogico);
      if(not encontre)then
         writeln(' ***** EMPLEADO NO ENCONTRADO ****** ');
   end;

   //Process 2.2
   procedure listarEmpleados(var arcLogico: archivo);
   var
      emp: empleados;
      pos: integer;
   begin
      pos:= 1;
      reset(arcLogico);
      while(not EOF(arcLogico))do begin
         read(arcLogico, emp);
         writeln('******* Empleado nro ',pos, ' ********');
         informarEmpleado(emp);
         pos:= pos + 1;
      end;
      close(arcLogico);
   end;

   //Process 2.3
   procedure empleadosPorJubilarse(var arcLogico: archivo);
   var
      emp: empleados;
      pos: integer;
   begin
      pos:= 1;
      writeln(' ****** Empleados por jubilarse ***** ');
      reset(arcLogico);
      while(not EOF(arcLogico))do begin
         read(arcLogico, emp);
         if(emp.edad > 70)then begin
            writeln('- Empleado ',pos);
            informarEmpleado(emp);
         end;
      end;
      close(arcLogico);
      if(pos = 1)then
         writeln('- Cantidad de empleados proximos a jubilarse: ',0)
      else
         writeln('- Cantidad de empleados proximos a jubilarse: ', pos);
   end;

   //Process 2.B
   procedure procesoOpciones2(var arcLogico: archivo; var arcFisico: string);
   var
      opcion: integer;
   begin
      write('Opcion: '); readln(opcion);
      case opcion of
         1 : buscarEmpleado(arcLogico); //Process 2.1
         2 : listarEmpleados(arcLogico); //Process 2.2
         3 : empleadosPorJubilarse(arcLogico); //Process 2.3
      end;
   end;

   //Process 2
   procedure procesoOpciones1(var arcLogico: archivo; var arcFisico: string);
   var
      opcion: char;
   begin
      write('Opcion: '); readln(opcion);
      if(opcion = 'C')then 
         writeln('.... Fin del proceso, vuelve pronto ....')
      else if(opcion = 'A')then begin
         crearArchivo(arcLogico, arcFisico); //Process 2.A
         menuDeOpciones1(); //Process 1
         procesoOpciones1(arcLogico, arcFisico); //Process 2
      end
      else if((opcion = 'B') AND (fileExists(arcFisico)))then begin
               menuDeOpciones2(); //Process 1.A
               procesoOpciones2(arcLogico, arcFisico); //Process 2.B
            end
            else begin
               writeln(' ALERTA: Primero debes crear un archivo para poder abrirlo. ');
               procesoOpciones1(arcLogico, arcFisico); //Process 2
               menuDeOpciones1(); //Process 1
            end;
   end;

var
   arcLogico: archivo;
   arcFisico: string;
begin
   writeln(' ========= Bienvenido al sistema ==========');
   menuDeOpciones1(); //Process 1
   procesoOpciones1(arcLogico, arcFisico); //Process 2
end.


