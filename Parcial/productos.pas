program productos;
type
   cadena = string[25];
   // Registro maestro
   producto = record
      codigo:integer;
      nombre:cadena;
      stock:integer;
   end;

   // Registro detalle
   ingresoDeProducto = record
      codigo:integer;
      stock:integer;
   end;

   archivoDeProductos = file of producto;
   archivosDeIngresosDeProductos = file of ingresoDeProducto;

   //Proceso 1
   procedure enlaces(var maestroProductos: archivoDeProductos; var detalleIngresos: archivosDeIngresosDeProductos);
   var
      maestroFisico: cadena;
      detalleFisico: cadena;
   begin
      maestroFisico:= 'maestro.dat';
      detalleFisico:= 'detalle.dat';
      assign(maestroProductos, maestroFisico);
      assign(detalleIngresos, detalleFisico);
   end;

   //Proceso Leer Producto
   procedure leerProducto(var p:producto);
   begin
      write('- Codigo de Producto: '); readln(p.codigo);
      if(p.codigo <> 0)then begin
         write('- Nombre: '); readln(p.nombre);
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
   procedure leerIngresoDeProducto(var i:ingresoDeProducto);
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

   //Proceso 2
   procedure cargarArchivos(var maestroProductos: archivoDeProductos; var detalleIngresos: archivosDeIngresosDeProductos);
   var
      p:producto;
      i:ingresoDeProducto;
   begin
      rewrite(maestroProductos);
      rewrite(detalleIngresos);

      leerProducto(p); //Proceso Leer Producto
      while(p.codigo <> 0)do begin
         write(maestroProductos, p);
         leerProducto(p)
      end;
      close(maestroProductos);

      leerIngresoDeProducto(i); //Proceso Leer Ingreso de producto
      while(i.codigo <> 0)do begin
         write(detalleIngresos, i);
         leerIngresoDeProducto(i);
      end;
      close(detalleIngresos);
   end;

   //Proceso 3
   procedure actualizarMaestro(var maestroProductos: archivoDeProductos; var detalleIngresos: archivosDeIngresosDeProductos);
   var
      regProducto: producto;
      regIngreso: ingresoDeProducto;
      codigoActual:integer;
      // stockTotal:integer;
   begin

      reset(maestroProductos);
      reset(detalleIngresos);
      
      while(not EOF(detalleIngresos))do begin

         read(detalleIngresos, regIngreso);
         read(maestroProductos, regProducto);

         codigoActual:= regIngreso.codigo;
         // stockTotal:= 0;

         while(regProducto.codigo <> regIngreso.codigo)do 
            read(maestroProductos, regProducto);

(*          while(regBonoEmpleado.codigo = codigoActual)do begin
            sueldoTotal:= sueldoTotal + regBonoEmpleado.sueldo;
            read(bonosDetalle, regBonoEmpleado);
         end; *)


         regProducto.stock:= regProducto.stock + regIngreso.stock;
         seek(maestroProductos, filepos(maestroProductos) - 1);   
         write(maestroProductos, regProducto);
      end;
      close(maestroProductos);
      close(detalleIngresos);
   end;

   //Proceso 4
   procedure mostrarMaestro(var maestroProductos: archivoDeProductos);
   var
      p:producto;
   begin
      writeln();

      reset(maestroProductos);
      while(not EOF(maestroProductos))do begin
         read(maestroProductos, p);
         writeln(' * Codigo de Producto: ',p.codigo);
         writeln(' * Nombre: ',p.nombre);
         writeln(' * Stock: ',p.stock);
         writeln();
      end;
      close(maestroProductos);
   end;

var
   maestroProductos: archivoDeProductos;
   detalleIngresos: archivosDeIngresosDeProductos;
begin
   enlaces(maestroProductos, detalleIngresos); //Proceso 1
   cargarArchivos(maestroProductos, detalleIngresos); //Proceso 2
   actualizarMaestro(maestroProductos, detalleIngresos); //Proceso 3
   mostrarMaestro(maestroProductos); //Proceso 4
end.

