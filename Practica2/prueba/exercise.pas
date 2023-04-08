program practice;
type
   cadena = string[30];
   empleado = record
      name: cadena;
      adress: cadena;
      workHours:integer;
   end;

   emp_diario = record
      name: cadena;
      workHours: integer;
   end;

   detalle = file of emp_diario;
   maestro = file of empleado;

   //Process One.A
   procedure readEmpleado(var e:empleado);
   begin
      write('- Name: '); readln(e.name);
      if(e.nombre <> '')then begin
         write('- Adress: '); readln(e.adress);
         write('- Work hours: '); readln(e.workHours);
         writeln();
      end;
   end;

   //Process One
   procedure loadFiles(var mae1: maestro; var det1: detalle);
   var
      mae1Fisico: cadena;
      det1Fisico: cadena;
      e: empleado;
      empD: emp_diario;
   begin
      write('Enter the name of the master file: '); readln(mae1Fisico);
      write('Enter detail file name: '); readln(det1Fisico);
      rewrite(mae1);
      rewrite(det1);
      writeln();

      writeln(' *** Master file load ***');
      readEmpleado(e); //Process One.A
      while(e.name <> '')do begin
         write(mae1, e);
         readEmpleado(e);
      end;
      writeln();

      writeln('*** Detail file load ***');
      emp_diario.nombre:= 'CCC';
      emp_diario.horasDeTrabajo:= 14;

   end;

var
   det1: detalle;
   mae1: maestro;
begin
   loadFiles(mae1, det1); //Process One
   showMaster(mae1); //Process Two *
   updateMaster(mae1, det1); //Process Three
   showMaster(mae1); // Two *
   write('Press enter to finalize_'); readln();
end.
