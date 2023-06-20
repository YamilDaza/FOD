program prueba;
type
   person = record
      name: string;
      lastName: string;
      age: integer;
      job: string;
      code: integer;
   end;

   filePerson = file of person;

   //Process 1 - Connection
   procedure connection(var personLogico: filePerson; var personFisico: string);
   begin
      write('Welcome, Enter Path of file: '); readln(personFisico);
      assign(personLogico, personFisico);
   end;

   //Process 2.A - loadPerson
   procedure loadPerson(var p:person);
   begin
      write('Entre Name: '); readln(p.name);
      if(p.name <> '')then begin
         write('Entre lastName: '); readln(p.lastName);
         write('Entre Age: '); readln(p.age);
         write('Entre Job: '); readln(p.job);
         write('Entre Code: '); readln(p.code);
      end;
      writeln();
   end;

   //Process 2 - loadData
   procedure loadData(var personLogico: filePerson);
   var
      p:person;
   begin
      writeln();
      rewrite(personLogico); //create file
      loadPerson(p); //Process 2.A

      while(p.name <> '')do begin
         write(personLogico, p);
         loadPerson(p);
      end;
      close(personLogico);
   end;

   //Process 3.A - ShowPerson
   procedure showPerson(p:person);
   begin
      writeln('Name -> ',p.name);
      writeln('LastName -> ',p.lastName);
      writeln('Age -> ',p.age);
      writeln('Job -> ',p.job);
      writeln('Code -> ',p.code);
      writeln();
   end;

   //Process 3 - ShowData
   procedure showData(var personLogico: filePerson);
   var
      p:person;
   begin
      reset(personLogico);
      while(not EOF(personLogico))do begin
         read(personLogico, p);
         showPerson(p); //Process 3.A
      end;
      writeln();
   end;

   //Process 4
   procedure addPersonData(var personLogico: filePerson);
   var
      p:person;
   begin
      reset(personLogico);
      writeln('Enter data of new person: ');
      seek(personLogico, fileSize(personLogico));
      loadPerson(p);
      write(personLogico, p);
      close(personLogico);
   end;

var
   personLogico: filePerson;
   personFisico: string;
begin
   connection(personLogico, personFisico); //Process 1
   loadData(personLogico); //Process 2
   showData(personLogico); //Process 3
   addPersonData(personLogico); //Process 4
   showData(personLogico);
end.