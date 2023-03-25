(* Realice un algoritmo que permita guardar en un archivo todos los productos que actualmente se encuentran en venta en un determinado negocio. La información que es importante considerar es: nombre del producto, cantidad actual, precio unitario de venta, tipo de producto (que puede ser comestible, de limpieza o vestimenta). *)

program exercise;
type
   productos = record
      productName: string[20];
      currentAmount : integer;
      unitPrice: real;
      productType: string[20];
   end;

   archivoDeProductos = file of productos;

   //Process 1
   procedure createFileFisico(var arcFisico: string);
   begin
      write('Enter name of file: '); readln(arcFisico);
   end;

   //Process 2
   procedure createAndLoad(var arcLogico:archivoDeProductos; var arcFisico: string);
      //Proces 2.A
      procedure readProducts(var p:productos);
      begin
         write('- Product Name: '); readln(p.productName);
         if(p.productName <> 'zzz')then begin
            write('- Current Amount: '); readln(p.currentAmount);
            write('- Unit price: '); readln(p.unitPrice);
            write('- Product type: '); readln(p.productType);
            writeln();
         end;
      end;
   var 
      p:productos;
   begin
      assign(arcLogico, arcFisico); //Crear el enlace entre el archivo logico y archivo fisico
      rewrite(arcLogico); //Creamos el archivo logico para almacenar los datos
      readProducts(p); //Process 2.A
      while(p.productName <> 'zzz')do begin
         write(arcLogico, p);
         readProducts(p);
      end;
      close(arcLogico);
      writeln();
   end;

   //Process 3
   procedure showData(var arcLogico:archivoDeProductos);
      //Process 3.A
      procedure showProduct(p: productos);
      begin
         writeln(' - Product Name: ',p.productName);
         writeln(' - Current Amount: ',p.currentAmount);
         writeln(' - Unit Price: ',p.unitPrice);
         writeln(' - Product Type: ',p.productType);
      end;

   var
      amountProducts: integer;
      pos:integer;
      p:productos;
   begin
      amountProducts:= filesize(arcLogico);
      pos:= 1;
      reset(arcLogico);
      
      writeln('============  The amount of products is ',amountProducts,'  ============');     
      while(not EOF(arcLogico))do begin
         writeln('Products nro ',pos,':');
         read(arcLogico, p);
         showProduct(p); //Process 3.A
         writeln();
      end;
      close(arcLogico);
   end;
var
   arcLogico: archivoDeProductos;
   arcFisico: string[20];
begin
   createFileFisico(arcFisico); //Process 1
   createAndLoad(arcLogico, arcFisico); //Process 2
   showData(arcLogico); //Process 3
end.

