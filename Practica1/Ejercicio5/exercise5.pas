program exercise5;
type
   celulares = record
      codCelular: integer;
      nombre: string[20];
      precio: integer;
      descripcion: string[20];
      stockActual: integer;
      stockMinimo: integer;
      marca: string[20];
   end;
   archivoCelulares = file of celulares;

   //PROCESO 1
   procedure pedirDatos(var celularesFisico:string; var textoFisico: string);
   begin
      write('Ingrese el PATH del archivo binario de Fisico: '); readln(celularesFisico);
      write('Ingrese el PATH del archivo de texto Fisico: '); readln(textoFisico);
      writeln();
   end;

   //PROCESO 2
   procedure pasarDatosABinario(var celularesLogico: archivoCelulares; var celularesFisico:string; var textoLogico: Text; var textoFisico: string);
   var
      c:celulares;
   begin
      writeln('ARCHIVO BINARIO FISICO -> ',celularesFisico);
      writeln('ARCHIVO DE TEXTO FISICO -> ',textoFisico);
      assign(celularesLogico, celularesFisico);
      assign(textoLogico, textoFisico);
      writeln('***** Enlace finalizado correctamente *****');
      
      writeln('***** Convirtiendo.... *****');
      reset(textoLogico); //Abrimos el archivo de texto ya creado
      rewrite(celularesLogico); //Creamos el archivo binario nuevo

      while(not EOF(textoLogico))do begin
         writeln('LLEGUEEEEEE');
         readln(textoLogico, c.codCelular, c.nombre);
         readln(textoLogico, c.precio, c.descripcion);
         readln(textoLogico, c.stockActual, c.stockMinimo, c.marca);
         write(celularesLogico, c);
         writeln('SALIIIII');
      end;

      close(celularesLogico); 
      close(textoLogico);
      writeln(' **** Finalizado correctamente.... ****');
      writeln();
   end;

   //PROCESO LEER CELULAR
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

   //PROCESO 3
   procedure listar1(var celularesLogico:archivoCelulares);
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
            writeln(' === Celular nro ',pos,' ===');
            leerCelular(c); //PROCESO 3.1
            pos:=pos + 1;
         end;
      end;
      close(celularesLogico);
   end;

   //PROCESO 5
   procedure listar2(var celularesLogico:archivoCelulares);
   var
      buscador: string[20];
      c:celulares;
      aux:integer;
   begin
      aux:= 0;
      reset(celularesLogico); //Abrimos el archivo binario logico
      writeln();
      write('Ingrese la descripcion del celular que desea buscar: '); readln(buscador);
      while(not EOF(celularesLogico))do begin
         read(celularesLogico, c);
         if(buscador = c.descripcion)then begin
            writeln('ENTREEE');
            leerCelular(c);
            aux:= aux + 1;
         end;
      end;
      if(aux = 0)then   
         writeln('Ningun celular con la descripcion "',buscador,'"');
      close(celularesLogico);
   end;

   //PROCESO 5
   procedure pasarDatosATexto(var celularesLogico:archivoCelulares);
   var
      texto: Text;
      textoFisico: string;
      c:celulares;
      pos:integer;
   begin
      pos:=0;
      reset(celularesLogico);
      write('Ingresar el PATH del texto fisico: '); readln(textoFisico);
      assign(texto, textoFisico);
      rewrite(texto);

      while(not EOF(celularesLogico))do begin
         pos:=pos + 1;
         read(celularesLogico,c);
         writeln(texto, ' --- Registro nro ',pos, ' --- ');
         writeln(texto, ' Codigo de celular -> ',c.codCelular);
         writeln(texto, ' Nombre -> ',c.nombre);
         writeln(texto, ' Descripcion -> ',c.descripcion);
         writeln(texto, ' Precio -> ',c.precio);
         writeln(texto, ' Marca -> ',c.marca);
         writeln(texto, ' Stock Actual -> ',c.stockActual);
         writeln(texto, ' Stock Minimo -> ',c.stockMinimo);
      end;
      close(celularesLogico); close(texto);
   end;

var
   celularesLogico: archivoCelulares;
   celularesFisico: string;
   textoLogico: Text;
   textoFisico: string;
begin
   pedirDatos(celularesFisico, textoFisico); //PROCESO 1
   pasarDatosABinario(celularesLogico, celularesFisico, textoLogico, textoFisico); //PROCESO 2
   listar1(celularesLogico); //PROCESO 3
   listar2(celularesLogico); //PROCESO 4
   pasarDatosATexto(celularesLogico); //PROCESO 5
end.