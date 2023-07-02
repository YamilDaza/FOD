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
         write('Venta del dia: '); readln(v.stock);
         writeln();
      end
      else begin
         writeln('===========================================');
         writeln('=== FIN DE LA CARGA DE LA VENTA DEL DIA ===');
         writeln('===========================================');
      end;
   end;

   //Proceso 1
   procedure cargarArchivos(var maestro: archivoArticulos; var d1, d2, d3: archivoVentaArticulos);
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
         write(d1, v);
         leerVenta(v);
      end;

      leerVenta(v);
      while(v.codigo <> 0)do begin
         write(d2, v);
         leerVenta(v);
      end;

      leerVenta(v);
      while(v.codigo <> 0)do begin
         write(d3, v);
         leerVenta(v);
      end;

      close(d1);
      close(d2);
      close(d3);
   end;




var
   regM: articulo;
   regD: ventaArticulo;
   maestro: archivoArticulos;
   minimo, det1, det2, det3: archivoVentaArticulos;
begin
   cargarArchivos(maestro, det1, det2, det3); //Proceso 1
end.