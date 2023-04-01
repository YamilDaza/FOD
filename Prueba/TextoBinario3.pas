program textoBinario3;
type
   votos = record
      codLocalidad: integer;
      nombre: string;
      cantVotos: integer;
      descripcion: string;
   end;
   archivoVotos = file of votos;

var
   votosLogico: archivoVotos;
   votosFisico: string;
   textoLogico: Text;
   // textoFisico: string;
   v, vo:votos;
   pos:integer;
begin
   //write('Ingrese el archivo de texto a convertir: '); readln(textoFisico);
   write('Ingrese el PATH del archivo fisico binario: '); readln(votosFisico);
   writeln();
   writeln('CONVIERTIENDO....');

   assign(textoLogico, 'VotosPrueba.txt');
   assign(votosLogico, votosFisico);
   reset(textoLogico);
   rewrite(votosLogico);

   while(not EOF(textoLogico))do begin
      readln(textoLogico, v.codLocalidad, v.nombre); 
      readln(textoLogico, v.cantVotos, v.descripcion);
      write(votosLogico, v);
   end;
   close(textoLogico); close(votosLogico);

   writeln();
   writeln('ARCHIVO CONVERTIDO EXITOSAMENTE... IMPRIMIENDO DATOS:');
   writeln();

   reset(votosLogico);
   pos:=1;
   while(not EOF(votosLogico))do begin
      read(votosLogico, vo);
      writeln(' - INFORMACION DE VOTOS NRO ',pos,' - ');
      writeln('Codigo de Localidad: ',vo.codLocalidad);
      writeln('Nombre: ',vo.nombre);
      writeln('Cantidad de votos: ',vo.cantVotos);
      writeln('Descripcion: ',vo.descripcion);
      writeln();
      pos:=pos + 1;
   end;
   close(votosLogico);

   write(' PRESIONE ENTER PARA FINALIZAR_ '); readln();
end.