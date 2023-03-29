program textoBinario2;
type
   votos = record
      codProvincia: integer;
      codLocalidad: integer;
      nroMesa: integer;
      cantVotos: integer;
      descripcion: string;
   end;
   archivoVotos = file of votos;

var
   arcLogico: archivoVotos;
   carga: Text;
   fisicoB, fisicoT: string;
   v:votos;
   opcion: integer;
   pos:integer;
begin
   pos:=1;
   writeln(' === === ===  SISTEMA DE VOTOS  === === ===');
   writeln();

   writeln('0- Terminar programa');
   writeln('1- Crear un archivo binario desde un archivo de texto');
   writeln('2- Abrir un archivo binario y exportar a texto');
   writeln();

   write('Opcion_ '); readln(opcion);
   if(opcion = 0)then 
      writeln('Ok, Vuelve pronto!...')
   else if((opcion = 1) OR (opcion = 2))then begin
      write('Ingrese el PATH del archivo fisico binario: '); readln(fisicoB);
      assign(arcLogico, fisicoB); //Vinculamos el archivo fisico al binario

      case opcion of
      1: begin
         write('Ingrese el PATH del archivo fisico de Texto: '); readln(fisicoT);
         assign(carga, fisicoT);
         rewrite(arcLogico);
         reset(carga);

         while(not EOF(carga))do begin
            readln(carga, v.codProvincia, v.codLocalidad, v.nroMesa, v.cantVotos, v.descripcion);
            write(arcLogico, v);
         end;

         writeln(' === ARCHIVO CARGADO === ');
         writeln();
         close(arcLogico); close(carga);
      end;
      2: begin
         reset(arcLogico);
         write('Ingrese el PATH del archivo fisico de Texto: '); readln(fisicoT);
         assign(carga, fisicoT);
         rewrite(carga);
         
         while(not EOF(arcLogico))do begin
            read(arcLogico, v);
            writeln(carga, '------- Voto nro ',pos,' ---------');
            writeln(carga, 'Codigo Provincia -> ',v.codProvincia);
            writeln(carga, 'Codigo Localidad -> ',v.codLocalidad);
            writeln(carga, 'Nro de Mesa -> ',v.nroMesa);
            writeln(carga, 'Cantidad de Votos -> ',v.cantVotos);
            writeln(carga, 'Descripcion -> ',v.descripcion);
            writeln(carga, '');
            pos:=pos + 1;
         end;
         close(arcLogico); close(carga);
         end;
      end;
   end;

   writeln();
   write('Presione enter para finalizar_'); readln();
end.