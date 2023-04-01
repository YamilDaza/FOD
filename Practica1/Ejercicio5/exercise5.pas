program exercise5;
type
   celulares = record
      codCelular: integer;
      nombre: string[20];
      descripcion: string[20];
      precio: real;
      marca: string[20];
      stockMinimo: integer;
      stockActual: integer;
   end;
   archivoCelulares = file of celulares;

   //PROCESO 1
   procedure pedirDatosYConectar(
      var celularesLogico:archivoCelulares;
      var celularesFisico:string;
      var textoLogico: Text;
      var textoFisico: string;
      );
   begin
      write('Ingrese el PATH del archivo binario de Fisico: '); readln(celularesFisico);
      write('Ingrese el PATH del archivo de texto Fisico: '); readln(textoFisico);
      assign(celularesLogico, celularesFisico);
      assign(textoLogico, textoFisico);
      write('***** Enlace finalizado correctamente *****');
      writeln();
   end;

   //PROCESO 2
   procedure pasarDatosABinario(var celularesLogico: archivoCelulares; var textoLogico: Text);
   var
      c:celulares;
   begin
      writeln(' **** Convirtiendo.... ****');
      reset(textoLogico); //Abrimos el archivo de texto ya creado
      rewrite(celularesLogico); //Creamos el archivo binario nuevo

      while(not EOF(textoLogico))do begin
         readln(textoLogico, c.codCelular, c.nombre);
         readln(textoLogico, c.descripcion, c.precio);
         readln(textoLogico, c.marca, c.stockMinimo, c.stockActual);
         write(textoLogico, c);
      end;

      close(celularesLogico); 
      close(textoLogico);
      writeln(' **** Finalizado correctamente.... ****');
      writeln();
   end;

   //PROCESO 3
   procedure listar1(var celularesLogico:archivoCelulares);
      procedure leerCelular(c : celulares);
      begin
         writeln('Codigo de celular: ',c.codCelular);
         writeln('Nombre: ',c.nombre);
         writeln('Descripcion: ',c.descripcion);
         writeln('Precio: ',c.precio);
         writeln('Marca: ',c.marca);
         writeln('Stock Minimo: ',c.stockMinimo);
         writeln('Stock Actual: ',c.stockActual);
         writeln();
      end;
   var
      c:celulares;
      pos:integer;
   begin
      writeln('- Celulares con stock actual inferior al stock minimo -');
      reset(celularesLogico); //1ro Abrir el archivo ya creado y cargado
      pos:= 1;
      while(not EOF(celularesLogico))do begin
         read(celularesLogico, c);
         if(c.stockActual < c.stockMinimo)then begin
            writeln(' === Celular nro ',pos,' ===')
            leerCelular(c); //PROCESO 3.1
            pos:=pos + 1;
         end;
      end;
   end;

var
   celularesLogico: archivoCelulares;
   celularesFisico: string;
   textoLogico: Text;
   textoFisico: string;
begin
   pedirDatosYConectar(celularesLogico, celularesFisico, textoLogico, textoFisico); //PROCESO 1
   pasarDatosABinario(celularesLogico, textoLogico); //PROCESO 2
   listar1(celularesLogico); //PROCESO 3
   listar2(celularesLogico); //PROCESO 4
end.