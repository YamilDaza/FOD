program ndetalles;
const
   VALOR_ALTO = 9999;
type
   // Registro para el maestro
   articulo = record
      codigo: integer;
      nombre: string[20];
      stock: integer;
   end;

   // Registro para el detalle
   ventaArticulo = record
      codigo: integer;
      venta: integer;
   end;

   archivoArticulos = file of articulo;
   archivoVentaArticulos = file of ventaArticulo;

   //Leer articulo 
   procedure leerArticulo(var a:articulo);
   begin
      write('Ingrese codigo del articulo: '); readln(a.codigo);
      if(a.codigo <> 0)then begin
         write('Nombre: '); readln(a.nombre);
         write('Stock: '); readln(a.stock);
         writeln();
      end
      else begin
         writeln('====================================');
         writeln('=== FIN DE LA CARGA DE ARTICULOS ===');
         writeln('====================================');
      end;
   end;

   //Leer venta articulo 
   procedure leerVenta(var v:ventaArticulo);
   begin
      write('Ingrese codigo del articulo: '); readln(v.codigo);
      if(v.codigo <> 0)then begin
         write('Venta del dia: '); readln(v.venta);
         writeln();
      end
      else begin
         writeln('===========================================');
         writeln('=== FIN DE LA CARGA DE LA VENTA DEL DIA ===');
         writeln('===========================================');
      end;
   end;

   //Proceso 1
   procedure cargarArchivos(var maestro: archivoArticulos; var det1, det2, det3: archivoVentaArticulos);
   var
      a:articulo;
      v:ventaArticulo;
   begin
      assign(maestro, 'articulos.dat');
      assign(det1,'detalleArticulos1.dat');
      assign(det2,'detalleArticulos2.dat');
      assign(det3,'detalleArticulos3.dat');

      rewrite(maestro);
      rewrite(det1);
      rewrite(det2);
      rewrite(det3);

      leerArticulo(a);
      while(a.codigo <> 0)do begin
         write(maestro, a);
         leerArticulo(a);
      end;
      close(maestro);

      leerVenta(v);
      while(v.codigo <> 0)do begin
         write(det1, v);
         leerVenta(v);
      end;

      leerVenta(v);
      while(v.codigo <> 0)do begin
         write(det2, v);
         leerVenta(v);
      end;

      leerVenta(v);
      while(v.codigo <> 0)do begin
         write(det3, v);
         leerVenta(v);
      end;

      close(det1);
      close(det2);
      close(det3);
   end;

   //Proceso leer dato
   procedure leerDato(var archivo: archivoVentaArticulos; var dato: ventaArticulo);
   begin
      if(not EOF(archivo))then
         read(archivo, dato)
      else
         dato.codigo:= VALOR_ALTO;
   end;

   //Proceso 2
   procedure buscarElMinimo(var det1, det2, det3: archivoVentaArticulos; var minimo, regD1, regD2, regD3: ventaArticulo);
   begin
      if((regD1.codigo <= regD2.codigo) AND (regD1.codigo <= regD3.codigo))then begin
         minimo:= regD1;
         leerDato(det1, regD1);
      end
         else if(regD2.codigo <= regD3.codigo)then begin
            minimo:= regD2;
            leerDato(det2, regD2);
         end
         else begin
            minimo:= regD3;
            leerDato(det3, regD3);
         end;
   end;

var
   regM: articulo;
   regD1, regD2, regD3, minimo: ventaArticulo;
   maestro: archivoArticulos;
   det1, det2, det3: archivoVentaArticulos;
begin
   cargarArchivos(maestro, det1, det2, det3); //Proceso 1
   
   //Abrimos los archivos ya cargados para realizar la actualizacion del maestro con los 3 detalles:
   reset(maestro);
   reset(det1);
   reset(det2);
   reset(det3);

   //Leemos de cada detalle un 1er dato buscando el minimo
   leerDato(det1, regD1);
   leerDato(det2, regD2);
   leerDato(det3, regD3);
   read(maestro, regM);
   buscarElMinimo(det1,det2,det3 , minimo, regD1, regD2, regD3); //Proceso 2

   while(minimo.codigo <> VALOR_ALTO)do begin
      while(minimo.codigo <> regM.codigo)do 
         read(maestro, regM);

      regM.stock:= regM.stock - minimo.venta;
      seek(maestro, filepos(maestro) - 1);
      write(maestro, regM);

      if(not EOF(maestro))then
         read(maestro, regM);

      buscarElMinimo(det1, det2, det3, minimo, regD1, regD2, regD3); //Proceso 2  
   end;

   close(maestro);
   close(det1);
   close(det2);
   close(det3);

   reset(maestro);
   while(not EOF(maestro))do begin
      read(maestro, regM);
      writeln('- Codigo del articulo: ',regM.codigo);
      writeln('- Nombre: ',regM.nombre);
      writeln('- Stock: ',regM.stock);
      writeln();
   end;

   close(maestro);

end.