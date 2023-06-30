program actualizacionV1;
const
   valorAlto = 9999;
type
   cadena = string[15];

   //Registro del maestro:
   producto = record
      codigo:integer;
      descripcion: cadena;
      stock:integer;
   end;

   //Registro del detalle:
   ingresoProducto = record
      codigo:integer;
      stock:integer;
   end;

   //Archivos:
   archivoProductos = file of producto;
   archivoIngresoProductos = file of ingresoProducto;

   //Proceso leer Producto
   procedure leerProducto(var p:producto);
   begin
      write('- Codigo de Producto: '); readln(p.codigo);
      if(p.codigo <> 0)then begin
         write('- Descripcion: '); readln(p.descripcion);
         write('- Stock: '); readln(p.stock);
         writeln();
      end
      else begin
         writeln();
         writeln(' ***** FIN DE LA CARGA DE PRODUCTOS *****');
         writeln();
      end;
   end;

   //Proceso Leer Ingreso de producto
   procedure leerIngresoDeProducto(var i:ingresoProducto);
   begin
      write('- Codigo de producto: '); readln(i.codigo);
      if(i.codigo <> 0)then begin
         write('- Stock: '); readln(i.stock);
         writeln();
      end
      else begin
         writeln();
         writeln(' ***** FIN DE LA CARGA DE LOS INGRESOS DE PRODUCTOS *****');
         writeln();
      end;
   end;

   //Proceso 1 - cargar archivos
   procedure cargarArchivos(var maestroProductos:archivoProductos; var detalleIngresos:archivoIngresoProductos);
   var
      p:producto;
      i:ingresoProducto;
   begin
      assign(maestroProductos, 'maestro.dat');
      assign(detalleIngresos, 'detalle.dat');
      rewrite(maestroProductos);
      rewrite(detalleIngresos);

      leerProducto(p);
      while(p.codigo <> 0)do begin
         write(maestroProductos, p);
         leerProducto(p);
      end;

      leerIngresoDeProducto(i);
      while(i.codigo <> 0)do begin
         write(detalleIngresos, i);
         leerIngresoDeProducto(i);
      end;

      close(maestroProductos);
      close(detalleIngresos);
   end;

   //Proceso 4
   procedure mostrarProductos(var maestroProductos: archivoProductos);
   var
      p:producto;
   begin
      writeln();

      reset(maestroProductos);
      while(not EOF(maestroProductos))do begin
         read(maestroProductos, p);
         writeln(' * Codigo de Producto: ',p.codigo);
         writeln(' * Descripcion: ',p.descripcion);
         writeln(' * Stock: ',p.stock);
         writeln();
      end;
      close(maestroProductos);
   end;

   //Proceso leer dato
   procedure leerDato(var detalleIngresos: archivoIngresoProductos; var regDetalle: ingresoProducto);
   begin
      if(not EOF(detalleIngresos))then
         read(detalleIngresos, regDetalle)
      else
         regDetalle.codigo:= valorAlto;
   end;

var
   maestroProductos: archivoProductos;
   detalleIngresos: archivoIngresoProductos;
   regMaestro: producto;
   regDetalle: ingresoProducto;
   codigoActual: integer;
   totalStock: integer;
begin
   cargarArchivos(maestroProductos, detalleIngresos); //Proceso 1
   mostrarProductos(maestroProductos); //Proceso 2

   //Abrir cada archivo para procesar la actualización
   reset(maestroProductos);
   reset(detalleIngresos);

   //Leemos un dato del archivo maestro y leemos un dato del archivo detalle con el proceso leerDato para evadir problemas
   read(maestroProductos, regMaestro);
   leerDato(detalleIngresos, regDetalle);
   while(regDetalle.codigo <> valorAlto)do begin
      codigoActual:= regDetalle.codigo;
      totalStock:=0;

      //Debo buscar y acumular el stock de todos los registros del archivo detalle que sean iguales.
      while(regDetalle.codigo = codigoActual)do begin
         totalStock:= totalStock + regDetalle.stock;
         leerDato(detalleIngresos, regDetalle)
      end;

      //Buscar en el maestro, el registro que procesamos en el detalle para actualizar
      while(regMaestro.codigo <> codigoActual)do 
         read(maestroProductos, regMaestro);

      regMaestro.stock:= regMaestro.stock + totalStock;
      seek(maestroProductos, filepos(maestroProductos) - 1);
      write(maestroProductos, regMaestro);

      if(not EOF(maestroProductos))then
         read(maestroProductos, regMaestro)

   end;
   close(maestroProductos);
   close(detalleIngresos);

   mostrarProductos(maestroProductos); //Proceso 2

end.