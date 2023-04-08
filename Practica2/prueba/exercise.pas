program practice;
const 
   valor_alto = 'zzz';
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
   procedure writeEmpleado(var e:empleado);
   begin
      write('- Name: '); readln(e.name);
      if(e.name <> '')then begin
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
      assign(mae1, mae1Fisico);
      assign(det1, det1Fisico);
      rewrite(mae1);
      rewrite(det1);
      writeln();

      writeln(' *** Master file load ***');
      writeEmpleado(e); //Process One.A
      while(e.name <> '')do begin
         write(mae1, e);
         writeEmpleado(e);
      end;
      writeln();

      writeln('*** Detail file load ***');
      empD.name:= 'facundo';
      empD.workHours:= 14;
      write(det1, empD);
      close(mae1);
      close(det1);
   end;

   //Process Two
   procedure showMaster(var mae1: maestro);
      procedure readEmpleado(var mae1: maestro; var e:empleado);
      begin
         if(not EOF(mae1))then
            read(mae1, e)
         else
            e.name:= valor_alto;
      end;

      procedure showEmpleado(e:empleado);
      begin
         writeln('Name ->  ',e.name);
         writeln('Adress ->  ',e.adress);
         writeln('Work hours ->  ',e.workHours);
      end;
   var
      e:empleado;
   begin
      reset(mae1);
      readEmpleado(mae1, e);
      while(e.name <> valor_alto)do begin
         showEmpleado(e);
         writeln(); //Salto de linea
         readEmpleado(mae1, e);
      end;
      close(mae1);
   end;

   //Process Three
   procedure updateMaster(var mae1: maestro; var det1:detalle);
   var
      e:empleado;
      empD: emp_diario;
   begin
      reset(mae1);
      reset(det1);
      while(not EOF(det1))do begin
         read(mae1, e);
         read(det1, empD);
         while(e.name <> empD.name)do 
            read(mae1, e);
         
         e.workHours:= e.workHours + empD.workHours;
         seek(mae1, filepos(mae1) - 1);
         write(mae1, e);
      end;
      close(mae1);
      close(det1);
   end;

var
   det1: detalle;
   mae1: maestro;
begin
   loadFiles(mae1, det1); //Process One
   showMaster(mae1); //Process Two *
   
   write('Press enter to continue_ '); readln();

   updateMaster(mae1, det1); //Process Three
   showMaster(mae1); // Two *
   write('Press enter to finalize_'); readln();
end.
