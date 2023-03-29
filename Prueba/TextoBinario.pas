program textoBinario;
type
   empleados = record
      nroEmpleado : integer;
      nombre: string[20];
      edad: integer;
   end;
   archivoEmpleado = file of empleados;

   //PROCESO 1
   procedure cargarArchivo(var archivoLogico: archivoEmpleado; var archivoFisico: string);
      //PROCESO 1.A
      procedure leerEmpleado(var e:empleados);
      begin
         write('- Ingrese nro de empleado: '); readln(e.nroEmpleado);
         if(e.nroEmpleado <> 0)then begin
            write('- Nombre: '); readln(e.nombre);
            write('- Edad: '); readln(e.edad);
            writeln();
         end
         else begin
            writeln();
            writeln(' **** PROCESO TERMINADO **** ');
            writeln();
         end;
      end;
   var
      e:empleados;
   begin
      assign(archivoLogico, archivoFisico);
      rewrite(archivoLogico);
      leerEmpleado(e); //PROCESO 1.A
      while(e.nroEmpleado <> 0)do begin
         write(archivoLogico, e);
         leerEmpleado(e);
      end;
      close(archivoLogico);
   end;

   //PROCESO 2
   procedure pasarATexto(var archivoLogico:archivoEmpleado);
   var
      carta: Text;
      cartaFisico: string;
      e:empleados;
      pos:integer;
   begin
      write('Ingrese el PATH del archivo fisico: '); readln(cartaFisico);
      writeln();
      assign(carta, cartaFisico);
      rewrite(carta);
      reset(archivoLogico);
      pos:=1;
      
      while(not EOF(archivoLogico))do begin
         read(archivoLogico, e);
         writeln(carta, 'EMPLEADO NRO ',pos);
         writeln(carta,' - Nro de empleado: ',e.nroEmpleado);
         writeln(carta,' - Nombre: ',e.nombre);
         writeln(carta,' - Edad: ',e.edad);
         writeln(carta, '');
      end;
      
      close(carta);
      close(archivoLogico);
   end;

var
   archivoLogico: archivoEmpleado;
   archivoFisico: string;
begin
   write(' - Ingrese el PATH del archivo Fisico: '); readln(archivoFisico);
   writeln();
   cargarArchivo(archivoLogico, archivoFisico); //PROCESO 1
   pasarATexto(archivoLogico); //PROCESO 2
end.