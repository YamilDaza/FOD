program binarioAtexto;
type  
   alumnos = record
      nombre: string;
      edad: integer;
      codigo: integer;
   end;

   archivoAlumnos = file of alumnos;

   procedure cargarDatos(var archivoLogico: archivoAlumnos; var archivoFisico: string);
      procedure leerAlumno(var alu: alumnos);
      begin
         write('Nombre: ');readln(alu.nombre);
         if(alu.nombre <> 'zzz')then begin
            write('Edad: ');readln(alu.edad);
            write('Codigo: ');readln(alu.codigo);
            writeln('');
         end;
      end;
   var
      alu: alumnos;
   begin
      assign(archivoLogico, archivoFisico);
      rewrite(archivoLogico);
      leerAlumno(alu);
      while(alu.nombre <> 'zzz')do begin
         write(archivoLogico, alu);
         leerAlumno(alu);
      end;
      close(archivoLogico);
   end;

   procedure pasarATexto(var archivoLogico: archivoAlumnos);
   var
      txt: Text;
      txtFisico: string;
      alu: alumnos;
   begin
      write('PATH del txt: '); readln(txtFisico);
      assign(txt, txtFisico);
      rewrite(txt);
      reset(archivoLogico);
      while(not EOF(archivoLogico))do begin
         read(archivoLogico, alu);
         writeln(txt, 'Nombre: ',alu.nombre);
         writeln(txt, 'Edad: ',alu.edad);
         writeln(txt, 'Codigo: ',alu.codigo);
         writeln(txt, ' ');
      end;
      close(archivoLogico);
      close(txt);
   end;

var
   archivoLogico: archivoAlumnos;
   archivoFisico: string;
begin
   write('Ingrese el PATH: '); readln(archivoFisico);
   cargarDatos(archivoLogico, archivoFisico);
   pasarATexto(archivoLogico);
end.

