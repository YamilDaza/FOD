program merge;
const
   VALOR_ALTO = 9999;
type
   empleado = record
      codigo: integer;
      nombre: string[25];
      edad:integer;
   end;

   archivoDetalle = file of empleado;

   //Proceso leer empleado
   procedure leerEmpleado(var e:empleado);
   begin
      write('* Ingrese el codigo del empleado: '); readln(e.codigo);
      if(e.codigo <> 0)then begin
         write(' * Nombre: '); readln(e.nombre);
         write(' * Edad: '); readln(e.edad);
         writeln();
      end
      else begin
         writeln();
         writeln('************ Fin de la carga de empleados ************');
         writeln();
      end;
   end;

   //Proceso 1 -  CargarDetalles
   procedure cargarDetalles(var det1, det2, det3: archivoDetalle);
   var
      e:empleado;
   begin
      assign(det1, 'detalle1.dat');
      assign(det2, 'detalle2.dat');
      assign(det3, 'detalle3.dat');
      rewrite(det1);
      rewrite(det2);
      rewrite(det3);

      leerEmpleado(e);
      while(e.codigo <> 0)do begin
         write(det1, e);
         leerEmpleado(e);
      end;

      leerEmpleado(e);
      while(e.codigo <> 0)do begin
         write(det2, e);
         leerEmpleado(e);
      end;

      leerEmpleado(e);
      while(e.codigo <> 0)do begin
         write(det3, e);
         leerEmpleado(e);
      end;

      close(det1);
      close(det2);
      close(det3);
   end;

   //Proceso leer Dato
   procedure leerDato(var detalle: archivoDetalle; var reg:empleado);
   begin
      if(not EOF(detalle))then
         read(detalle, reg)
      else
         reg.codigo:= VALOR_ALTO;
   end;

   procedure buscarMinimo(var det1, det2, det3: archivoDetalle; var minimo, reg1, reg2, reg3: empleado);
   begin
      if((reg1.codigo <= reg2.codigo) AND (reg1.codigo <= reg3.codigo))then begin
         minimo:= reg1;
         leerDato(det1, reg1);
      end
         else if(reg2.codigo <= reg3.codigo)then begin
            minimo:= reg2;
            leerDato(det2, reg2);
         end
      else begin
         minimo:= reg3;
         leerDato(det3, reg3);
      end;
   end;

   //Mostrar empleado
   procedure mostrarMaestro(var maestro: archivoDetalle);
   var
      e:empleado;
   begin
      reset(maestro);
      while(not EOF(maestro))do begin
         read(maestro, e);
         writeln(' --- Codigo de empleado: ',e.codigo, ' ---');
         writeln(' --- Nombre: ',e.nombre, ' ---');
         writeln(' --- Edad: ',e.edad, ' ---'); 
         writeln('');
      end;
      close(maestro);
   end;

var
   det1, det2, det3, maestro: archivoDetalle;
   reg1, reg2, reg3, minimo: empleado;
begin
   cargarDetalles(det1, det2, det3); //Proceso 1

   //Abrimos los 3 archivos de los detalles
   reset(det1);
   reset(det2);
   reset(det3);
   assign(maestro, 'maestro.dat');
   rewrite(maestro);

   //Leemos un dato de cada detalle para tener el minimo
   leerDato(det1, reg1);
   leerDato(det2, reg2);
   leerDato(det3, reg3);   
   buscarMinimo(det1,det2, det3, minimo, reg1, reg2, reg3);

   //Estructura principal
   while(minimo.codigo <> VALOR_ALTO)do begin
      write(maestro, minimo);
      buscarMinimo(det1,det2, det3, minimo, reg1, reg2, reg3);
   end;

   close(det1);
   close(det2);
   close(det3);
   close(maestro);

   mostrarMaestro(maestro);
end.