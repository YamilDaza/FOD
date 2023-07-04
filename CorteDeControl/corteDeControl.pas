program corteDeControl;
const 
   VALOR_ALTO = 'zzzz';
type
   empresa = record
      provincia: string;
      ciudad: string;
      sucursal: string;
      vendedor: integer;
      gananciaDeVenta: integer;
   end;

   archivoEmpresa = file of empresa;

   //Proceso leer Dato
   procedure leerDato(var e:empresa);
   begin
      write('- Provincia: '); readln(e.provincia);
      if(e.provincia <> VALOR_ALTO)then begin
         write('- Ciudad: '); readln(e.ciudad);
         write('- Sucursal: '); readln(e.sucursal);
         write('- Vendedor: '); readln(e.vendedor);
         write('- Ganancia de Venta: $'); readln(e.gananciaDeVenta);
         writeln();
      end;
   end;

   //Proceso 1 - cargarArchivo
   procedure cargarArchivo(var archivo: archivoEmpresa);
   var
      e:empresa;
   begin
      assign(archivo, 'archivoEmpresa.dat');
      rewrite(archivo);

      leerDato(e);
      while(e.provincia <> VALOR_ALTO)do begin
         write(archivo, e);
         leerDato(e);
      end;
      close(archivo);
   end;

   procedure leerDatoArchivo(var archivo: archivoEmpresa; var reg: empresa);
   begin
      if(not EOF(archivo))then
         read(archivo, reg)
      else
         reg.provincia:= VALOR_ALTO;
   end;

var
   archivo: archivoEmpresa;
   regEmpresa: empresa;
   provincia, ciudad, sucursal: string;
   total, totalProvincia, totalCiudad, totalSucursal: integer;
begin
   cargarArchivo(archivo); //Proceso 1

   reset(archivo);
   leerDatoArchivo(archivo, regEmpresa);

   total:=0;
   while(regEmpresa.provincia <> VALOR_ALTO)do begin
      writeln(' * Provincia: ', regEmpresa.provincia, ' *');
      provincia:= regEmpresa.provincia;
      totalProvincia:=0;

      //Provincia
      while(provincia = regEmpresa.provincia)do begin
         writeln(' ** Ciudad: ', regEmpresa.ciudad, ' **');
         ciudad:= regEmpresa.ciudad;
         totalCiudad:=0;

         //Provincia - Ciudad
         while((provincia = regEmpresa.provincia) AND (ciudad = regEmpresa.ciudad))do begin
            writeln(' *** Sucursal: ',regEmpresa.sucursal, ' ****');
            sucursal:= regEmpresa.sucursal;
            totalSucursal:=0;
            
            //Provincia - Ciudad - Sucursal
            while((provincia = regEmpresa.provincia) AND (ciudad = regEmpresa.ciudad) AND (sucursal = regEmpresa.sucursal))do begin
               writeln(' **** Vendedor: ',regEmpresa.vendedor, ' ****');
               writeln(' **** Monto vendido: $',regEmpresa.gananciaDeVenta, ' ****');
               totalSucursal:= totalSucursal + regEmpresa.gananciaDeVenta;
               leerDatoArchivo(archivo, regEmpresa);
            end;

            writeln('Total de ingreso para la sucursal ',sucursal, ' es de $',totalSucursal);
            totalCiudad:= totalCiudad + totalSucursal;
         end;

         writeln('Total de ingreso para la ciudad ',ciudad, ' es de $',totalCiudad);
         totalProvincia:= totalProvincia + totalCiudad;
      end;

      writeln('Total de ingreso para la Provincia ',provincia, ' es de $',totalProvincia);
      total:= total + totalProvincia;
   end;

   writeln('El total de ingreso de la empresa es de $',total);
   close(archivo);


end.
