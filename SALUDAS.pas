Program TP3;
 Uses
  crt,dos;

 TYPE
  chek = array[1..2,1..3]of word;

  Unusuario = Record
    dni:string[8];
    contra:string;
    nbre:string[30];
    mail:string[40];
  end;

  Cuenta = Record
    codban:integer;
    tipotar:char;
    saltar: real;
  end;

  Tarj = array [1..5] of cuenta;

  UnaCuentasVirtual = Record
    dni:string [8];
    tar:tarj;
    salbill: real;
  end;

  Unmovimiento = Record
    Dni:string[8];
    codban:integer;
    tiptar:char;
    Imp:real;
    tipmov:char;
    day, month, year: word;
    codcom:integer;
    dnio:string[8];
  end;

  Uncomer = record
    codcom:integer;
    nbre:string[30];
    cuit:string[12];
    est:Boolean;
  end;

  Unbanco = record
    nbre:string[30];
    cod:integer;
  end;

 Usuario          = File of unUsuario;
 Cuentasvirtuales = File of unaCuentasVirtual;
 Movimientos      = File of unMovimiento;
 Bancos           = File of unbanco;
 Comercios        = File of uncomer;

 VAR

  usu:usuario;
  u:unusuario;

  cuen:cuentasvirtuales;
  cv:unacuentasvirtual;

  mov:movimientos;
  m:unmovimiento;

  com:comercios;
  c:uncomer;

  ban:Bancos;
  b:unbanco;

  Hour,Min,Sec,HSec : word;
  ano,mes,dia,sem: word;

  opbanco:integer;
  g_mab: integer;
  cod_baja: integer;
  codigodebanco:integer;
  ccom:integer;
  op:integer;
  g_usu: integer;
  err:integer;
  t,k,i,j:integer;
  cont: integer;

  band:boolean;

  log_dni:string[8];
  odni:string[8];
  contra:string;


  env:real;
  r:real;

  tecla:char;
  opaltac:char;

 Procedure Valida (var v:integer;ini,fin:integer );
 Begin
  Repeat
      readln(v);
  until (v>=ini) and (v<=fin);
 end;

 ///////////////////BANCOS///////////////////

 Procedure Altabancos;
 Begin
  clrscr;
  TextBackGround(15);
  TextColor(0);
  gotoxy(10,3); writeln ('BIENVENID@ A ALTAS DE BANCOS');
  writeln( );
  TextBackGround(0);
  TextColor(15);
  GotoXY(50,20); Write('Con codigo de banco=0, cierra el programa');
  GotoXY(10,6);write('Ingrese codigo del banco(numero entre 0 y 10000): ');
  valida (b.cod,0,10000);
  While b.cod <>0 do
  Begin
   GotoXY(10,7);Write('Ingrese nombre del nuevo banco: '); readln(b.nbre);
   seek(ban,filesize(ban));
   write(ban,b);
   writeln( );
   writeln( );
   TextBackGround(2);
   TextColor(0);
   GotoXY(30,10);writeln('BANCO REGISTRADO CON EXITO');
   Delay(2000);
   TextBackGround(0);
   TextColor(15);
   clrscr;
   TextBackGround(15);
   TextColor(0);
   gotoxy(10,3); writeln ('BIENVENID@ A ALTAS DE BANCOS');
   writeln( );
   TextBackGround(0);
   TextColor(15);
   GotoXY(50,20); Write('Con codigo de banco=0, cierra el programa');
   GotoXY(10,6);write('Ingrese codigo del banco(numero entre 0 y 10000): ');
   valida (b.cod,0,10000);
  end;
 end;

 Procedure Listadobancos;
 Begin
  clrscr;
  TextBackGround(15);
  TextColor(0);
  gotoxy(10,2); writeln (' LISTADO DE BANCOS ACTUALES ');
  writeln( );
  TextBackGround(15);
  TextColor(0);
  writeln( );
  reset (ban);
  GotoXY(10,5); writeln (' CODIGO DEL BANCO ');
  GotoXY(40,5); writeln (' NOMBRE DEL BANCO ');
  TextBackGround(0);
  TextColor(15);
  writeln ('---------------------------------------------------------------------');
  While not (eof(ban)) do begin
      read (ban,b) ;
      write ('               ',b.cod);
      write  ('                            ',b.nbre);
      writeln( );
      end;
      GotoXY(70,3); Write('Presione una tecla para salir');
      repeat until keypressed;
 end;

 Procedure Bancos_p;
 Begin
  Repeat
      clrscr;
      TextBackGround(15);
      TextColor(0);
      gotoxy(30,2); writeln ('BIENVENID@ A LA OPCION BANCOS');
      gotoxy (10,4); writeln ('MENU DE OPCIONES BANCOS');
      TextBackGround(0);
      TextColor(15);
      gotoxy (12,6); writeln ('1- Alta de bancos');
      gotoxy (12,7); writeln ('2- Listado de todos los bancos');
      gotoxy (12,8); writeln ('0- Fin');
      gotoxy (12,9); write ('Ingrese su Opcion:  ');
      repeat
            readln (op)
      until (op>= 0)  and (op<=4);
      case op of
           1: altabancos;
           2: listadobancos;
           0: ;
      end;
 until op = 0;
end;
  ///////////////////BANCOS///////////////////


 //////////////////COMERCIOS//////////////////

 Procedure altacomer;
 Begin
  clrscr;
  TextBackGround(15);
  TextColor(0);
  gotoxy(15,2); writeln ('BIENVENIDO A ALTAS DE COMERCIOS ADHERIDOS');
  writeln( );
  TextBackGround(0);
  TextColor(15);
  Gotoxy(70,3);write('Con codigo de comercio=0, cierra el programa');
  gotoxy(10,5);write('Ingrese codigo del comercio(numero entre 0 y 1000): ');
  valida(c.codcom,0,10000);
  while c.codcom <>0 do
  begin
      gotoxy(10,6);write ('Ingrese nombre del comercio adherido: ');readln(c.nbre);
      gotoxy(10,7);write('Ingrese el cuit de ',c.nbre, ': '); readln(c.cuit);
      seek(ban,filesize(ban));
      write(com,c);
      TextBackGround(2);
      TextColor(15);
      gotoxy(30,10);write('COMERCIO ADHERIDO CON EXITO');
      Delay(2000);
      TextBackGround(0);
      clrscr;
      writeln( );
      writeln( );
      TextBackGround(15);
      TextColor(0);
      gotoxy(15,2); writeln ('BIENVENIDO A ALTAS DE COMERCIOS ADHERIDOS');
      writeln( );
      TextBackGround(0);
      TextColor(15);
      Gotoxy(70,3);write('Con codigo de comercio=0, cierra el programa');
      gotoxy(10,5);write('Ingrese codigo del comercio(numero entre 0 y 1000): ');
      valida(c.codcom,0,10000);
  end;
end;


 Procedure listadocomer;
 Begin
  cont:=cont+1;
  clrscr;
  TextBackGround(15);
  TextColor(0);
  gotoxy(30,2); writeln (' LISTADO DE COMERCIOS ');
  writeln( );
  TextBackGround(0);
  TextColor(15);
  GotoXY(70,3); Write('Presione una tecla para salir');
  seek(com,0);;
  GotoXY(2,5);writeln ('CODIGO');
  GotoXY(20,5);writeln ('NOMBRE');
  GotoXY(40,5);writeln ('CODIGO');
  GotoXY(2,6);writeln ('---------------------------------------------');
  while not (eof(com)) do begin
      cont:=cont+1;
      read (com,c) ;
      GotoXY(4,5+cont);writeln (c.codcom);
      GotoXY(17,5+cont);writeln (c.nbre);
      GotoXY(40,5+cont);writeln (c.cuit);
      writeln( );end;  repeat until keypressed;

 end;

Function busadorcomercios(a: integer):boolean;
  Begin
   Seek(com,0);
   While(not EOF(com))and(c.codcom<>a)  do
   Begin
    Read(com,c);
   end;
   If(c.codcom=a)
   Then
    begin
     busadorcomercios:=true;
    end
   Else
    Begin
    busadorcomercios:=false;
    end;
  end;


 procedure modificacomer;
var cod_modwf:integer;
op_modwf:integer;
begin
repeat
  clrscr;
  TextBackGround(15);
  TextColor(0);
  GotoXY(5,2); write('BIENVENID@ A MODIFICADOR DE COMERCIOS ADHERIDOS');
  TextBackGround(0);
  TextColor(15);
  gotoxy(10,5);write('Ingrese codigo del comercio a modificar: '); read(cod_modwf);
  if (busadorcomercios(cod_modwf))
  Then
   Begin
    c.codcom:=cod_modwf;
    seek(com,filepos(com)-1);
    gotoxy(10,6);write('Ingrese nuevo nombre: ');  readln; read(c.nbre);readln;
    gotoxy(10,7);write('Ingrese nuevo cuit: '); read(c.cuit);readln;
    write(com,c);
    TextBackGround(2);
    TextColor(15);
    gotoxy(15,12);write(' MODIFICACION EXITOSA ');
    delay(2000);
    TextBackGround(0);
    TextColor(15);
    gotoxy(10,12);write('         ');
   end
  else
  begin
   clrscr;
   Write('Comercio no adherido');
   readln();
  end;
  clrscr;
  gotoxy(10,10);write('Desea modificar otro comercio?: ');
  gotoxy(10,11);write('1)Si');
  gotoxy(10,12);write('2)No');
  gotoxy(42,10);read(op_modwf);
  gotoxy(10,10);write(''                                 );
  gotoxy(10,7);write('                             ');
  gotoxy(10,9);write('                                              ');
  gotoxy(10,10);write('                                             ');
  gotoxy(10,11);write('    ');

  gotoxy(10,8);write('                    ');
  gotoxy(10,9);write('                                                ');
until(op_modwf=2);
end;

 Procedure baja_logica;
 var
  codigo,cont, band:integer;
  rta: char;
 Begin
  clrscr;
  textcolor(0);
  textbackground(15);
  gotoxy(30,2); writeln ('BAJA LOGICA DE COMERCIOS ADHERIDOS');
  textcolor(15);
  textbackground(0);
  GotoXY(70,3); Write('Con codigo de comercio=0, cierra programa');
  writeln( );
  gotoxy(10,4);write('Ingrese codigo del comercio a dar de baja:  ');
  valida(codigo,0,10000);
  while (codigo<>0)do
   begin
      reset (com);
      cont:=0;
      band := 0;
      while (not eof(com))and (band = 0) do
      begin
           read (com,c) ;
           cont:=filepos(com);
           if c.codcom=codigo then
              begin
                   writeln ( );
                   gotoxy(15,6);writeln('Codigo del comercio: ', c.codcom);
                   gotoxy(15,7);writeln('Nombre del comercio: ', c.nbre);
                   gotoxy(15,8);writeln('Cuit del comercio:  ',c.cuit);
                   gotoxy(15,9);write('Seguro desea dar de baja este comercio?(S/N): ');
                   repeat
                        read(rta)
                   until (rta='S')or  (rta='N') or (rta='s')or (rta='n');
                   if  (rta='S')or (rta='s') then
                                             begin

                                             c.codcom :=0 ;
                                             c.nbre:='***';
                                             c.cuit:='***';
                                             seek(com,cont-1);
                                             write(com,c);
                                             band:= 1
                                             end;
              end;
      end;
      clrscr;
      textcolor(0);
      textbackground(15);
      gotoxy(30,2); writeln ('BAJA LOGICA DE COMERCIOS ADHERIDOS');
      textcolor(15);
      textbackground(0);
      GotoXY(70,3); Write('Con codigo de comercio=0, cierre programa');
      writeln( );
      gotoxy(10,4);write('Ingrese codigo del comercio a dar de baja:  ');
      valida(codigo,0,10000);
   end;
end;

Procedure comercios123;
Begin
repeat
      textcolor(15);
      textbackground(0);
       clrscr;
      textcolor(0);
      textbackground(15);
      Gotoxy(30,2); writeln (' BIENVENID@ A ABM DE COMERCIOS ADHERIDOS ');
      gotoxy (10,4); writeln (' MENU DE OPCIONES ');
      textcolor(15);
      textbackground(0);
      gotoxy (15,6); writeln ('1- Alta de comercios');
      gotoxy (15,7); writeln ('2- Modifica comercios');
      gotoxy (15,8); writeln ('3- Listado de los comercios adheridos');
      gotoxy (15,9); writeln ('4- Baja de comercios');
      gotoxy (15,10); writeln ('0- Fin');
      gotoxy (15,11); write ('Ingrese su Opcion:  ');
      repeat
            readln (op)
      until (op>= 0)  and (op<=5);
      case op of
           1: altacomer;
           2: modificacomer;
           3: listadocomer;
           4: baja_logica;
           0: ;
      end;
 until op = 0;
end;


  //////////////////COMERCIOS//////////////////
  //////////////////USUARIOS//////////////////

  Function busadordnicuentas(v:string[8]):boolean;
  Begin
   Seek(cuen,0);
   While(not EOF(cuen))and(cv.dni<>v)  do
   Begin
    Read(cuen,cv);
   end;
   If(cv.dni=v)
   Then
    begin
     busadordnicuentas:=true;
    end
   Else
    Begin
    busadordnicuentas:=false;
    end;
  end;

   Function Buscadordniusuarios(k:string[8]):boolean;
   Begin
    Seek(usu,0);
    While(not EOF(usu))and(u.dni<>k)  do
    Begin
     Read(usu,u);
    end;
    If(u.dni=k)
    Then
     begin
       Buscadordniusuarios:=true;
     end
    Else
     Begin
       Buscadordniusuarios:=false;
     end;
   end;

  Procedure Altasdeusuarios;
  Begin
   Seek(usu,FileSize(usu));
   textcolor(0);
   textbackground(15);
   GOTOXY(5,2);write(' BIENVENID@ - ALTA DE USUARIOS ');
   textcolor(15);
   textbackground(0);
   GOTOXY(10,4);write('Ingrese su nombre y apellido: '); readln; read(u.nbre);
   Gotoxy(10,5);write('Ingrese Mail: '); readln; read(u.mail);
   u.dni:=log_dni;
   u.contra:=contra;
   Write(usu,u);
   textcolor(15);
   textbackground(2);
   GOTOXY(30,8);write('USUARIO REGISTRADO CON EXITO');
   DELAY(1000);
   textcolor(15);
   textbackground(0);
   GotoXY(45,10); Write('Presione una tecla para continuar');
   Repeat until keypressed;
   Seek(usu,0);
  end;

   Procedure listadousuarios;
    Begin
     clrscr;
     Seek(usu,0);
     If(Not EOF(usu))
     Then
     Begin
      For i:= 1 to FileSize(usu) do
      Begin
       read(usu,u);
       textcolor(0);
       textbackground(15);
       gotoxy(10,1); write(' USUARIOS REGISTRADOS ');
       textcolor(15);
       textbackground(0);
       GOTOXY(10,3); Write('DNI');
       GOTOXY(40,3); Write('NOMBRE Y APELLIDO');
       GOTOXY(80,3); Write('MAIL');
       GOTOXY(20,4); Write('----------------------------------------------------------------------------------');
       gotoxy(10,6+i);write(U.dni);
       gotoxy(40,6+i);write(U.NBRE);
       gotoxy(80,6+i);write(u.mail);
      end;
      repeat until keypressed;
     end
   Else
    begin
    gotoxy(70,4); write('No hay usuarios registrados al momento');
    end;
   end;

   //////////////////INICIO SECION///////////////////

   Procedure verclave;
   Begin
    If (u.contra=contra)
    Then
     Begin
      textcolor(15);
      textbackground(2);
      gotoxy(20,10);write('Clave correcta');
      textcolor(15);
      textbackground(0);
     end
    Else
     Begin
      textcolor(15);
      textbackground(4);
      gotoxy(20,10);write('Clave incorrecta');
      err:=err+1;
      textcolor(15);
      textbackground(0);
     end;
   end;

    Procedure Contrasena;
    Begin
    i := 1; t :=0;
    Repeat
     gotoxy(10,7);write('Ingrese Clave : ');
     gotoxy(26,7);
     If(t=1)and(i=9)
     Then
      Begin
       clrscr;
       gotoxy(10,7);write('Ingrese Clave : ********');
       gotoxy(33,7);
      end;
      tecla := readkey;
      If tecla in[#48..#57,#65..#90,#97..#122,#164,#165,#32]
      Then
       Begin
        contra[i] := upcase(tecla);
        contra[0] := chr(i);
        gotoxy(25 + i,7);write('*');
        i := i + 1;
       end;
      If tecla = #08 then
      Begin
       i := i - 1;
       If i < 1 then
       i := 1;
       contra[i] := ' ';
       contra[0] := chr(i);
       gotoxy(25 + i,7);write(' ');
      end;
     Until (tecla = #13);
     ClrScr;
     end;

     Procedure IniciodeSecion;
     BEGIN
      ClrScr;
      textcolor(0);
      textbackground(15);
      GotoXY(5,2); write(' BIENVENIDO A INICIO DE SECION ');
      textcolor(15);
      textbackground(0);
      gotoxy(10,5); write('Ingrese DNI: '); read(log_dni);
      If (Buscadordniusuarios(log_dni))
      Then
       begin
        band:=true;
        Repeat
         contrasena;
         verclave;
         delay(1000);
         If(err=3)
         Then
          begin
           ClrScr;
           gotoxy(10,10); write('Ups, lo sentimos ustes supero el intento maximo permitido ');
           delay(1000);
          band:=false;
         end;
       Until(contra=u.contra)or(err=3);
      end
      Else begin
    band:=false;
    gotoxy(10,10); write('                   ');
   ClrScr;
    textcolor(15);
    textbackground(0);
    GotoXY(10,10); Write(' USTED NO ESTA REGISTRADO ');
    Delay(2000);
    ClrScr;
   contrasena;
   altasdeusuarios;
   gotoxy(20,10);write('Registracion completada');
   Listadousuarios;
   end
   end;

   //////////////////INICIO SECION///////////////////

   ///////////CUENTAS///////////////////


   Procedure listadocuenta;
   Begin
    seek(cuen,filepos(cuen)-1);
    if(Not EOF(cuen))
    Then
     begin
      for i:= 1 to FileSize(cuen) do
      begin
        ClrScr;
        read(cuen,cv);
        textcolor(0);
        textbackground(15);
        gotoxy(10,2); write(' CUENTAS REGISTRADAS ');
        textcolor(15);
        textbackground(0);
        GOTOXY(12,4); Write('DNI');
        GOTOXY(25,4); Write('SALDO BILLETERA');
        GOTOXY(10,5); Write('--------------------------------');
        gotoxy(10,6);write(CV.dni);
        gotoxy(30,6);write('$',CV.SALBILL:2:2);
        textcolor(0);
        textbackground(15);
        gotoxy(10,8); WRITE('TARJETAS VINCULADAS');
        textcolor(15);
        textbackground(0);
        GOTOXY(12,10); Write('CODIGO DE BANCO');
        GOTOXY(32,10); Write('TIPO DE TARJETA');
        GOTOXY(52,10); Write('SALDO DE LA TARJETA');
        GOTOXY(10,11); Write('---------------------------------------------------------------');
        fOR I:=1 TO 5 DO
        BEGIN
         gotoxy(19,11+I);WRITE(CV.TAR[I].CODBAN);
         gotoxy(39,11+I);WRITE(CV.TAR[I].TIPOTAR);
         gotoxy(59,11+I);WRITE('$',CV.TAR[I].SALTAR:2:2);
        end;
      repeat until keypressed;
     end;
      end
     ELSE
      begin
       textcolor(0);
       textbackground(15);
       gotoxy(70,4); write(' Usted no posee una cuenta');
       textcolor(15);
       textbackground(0);
       readkey;
       END;
   end;


 
   Procedure altadecuentas;
    Var
     opaltac:char;
    Begin
     ClrScr;
     textcolor(0);
     textbackground(15);
     GotoXY(5,2);Write(' ALTAS DE CUENTAS ');
     textcolor(15);
     textbackground(0);
     gotoxy(5,4);write(' Desea registrar tarjetas a su cuenta?(s/n): ');readln; read(opaltac);
     ClrScr;
    if(opaltac='s')
     Then
      begin
       textcolor(0);
       textbackground(15);
       GotoXY(5,2);Write(' ALTAS DE CUENTAS ');
       textcolor(15);
       textbackground(0);
       seek(cuen,FileSize(cuen));
       cv.dni:=log_dni;
       For i:= 1 to 5 do
       begin
        ClrScr;
        textcolor(0);
        textbackground(15);
        GotoXY(5,2);Write(' TARJETA NUMERO: ',I);
        textcolor(15);
        textbackground(0);
        gotoxy(8,4);write('Ingrese codigo de banco: '); readln; read(cv.tar[i].codban);
        Repeat
         gotoxy(8,5);write('Ingrese tipo de tarjeta: '); readln; read(cv.tar[i].tipotar);
        until(cv.tar[i].tipotar='d')or(cv.tar[i].tipotar='c');
        gotoxy(8,6);write('Ingrese saldo de la tarjeta: $'); readln; read(cv.tar[i].saltar);
       end;
       ClrScr;
       gotoxy(8,4);write('Ingrese saldo de billetera: $'); readln; read(cv.salbill);
       ClrScr;
       write(cuen,cv);
       seek(cuen,0);
      end;
     end;

  Procedure cuentas;
  begin
    ClrScr;
  log_dni:=u.dni;
  if (busadordnicuentas(log_dni))
   then begin listadocuenta; end
   else begin altadecuentas; end;

end;
   ///////////CUENTAS///////////////////

   ////////////MOVIMIENTOS//////////////
   Procedure registromovimientos;                                                                                                                                     //Trabajando en esto//
   Begin
    seek(mov,FileSize(mov));
    m.Dni:=log_dni;
    m.Imp:=env;
    m.tipmov:='E';
    write(mov,m);
    seek(mov,0);
   end;

   Procedure movcom;
   Begin
    seek(mov,FileSize(mov));
    m.Dni:=log_dni;
    gotoxy(10,5);write('Ingrese importe: $');read(m.Imp);
    Repeat
     gotoxy(10,6);write('Tipo de tarjeta: '); read(m.tiptar);
     until(m.tiptar='d')or(m.tiptar='c')or(m.tiptar='D')or(m.tiptar='C');
     repeat
     gotoxy(10,7);write('codigo de banco: '); readln;read(m.codban);
     codigodebanco:=m.codban;
     if(m.codban<0) then begin ClrScr; gotoxy(10,12);write('Codigo de banco incorrecto'); delay(2000);  end;
     until(m.codban>=0);
     Repeat
      gotoxy(10,7);
      write('Ingrese numero de cuenta de sus tarjetas a debitar:  '); readln;read(i);
      if(cv.tar[i].saltar<m.Imp)then begin ClrScr; gotoxy(10,12);write('Saldo insuficiente'); delay(2000);end;
      until(i>=0)and(i<=6)and(cv.tar[i].saltar>=m.Imp);
      ClrScr;
      busadordnicuentas(log_dni);

      cv.tar[i].saltar:=cv.tar[i].saltar-m.Imp;
      write(cuen,cv);
      m.tipmov:='C';
      GetDate(ano,mes,dia,sem);
      m.day:=dia;
      m.month:=mes;
      m.year:=ano;
      m.dnio:='--';
      m.codcom:=ccom;
      write(mov,m);
      seek(mov,0);
     end;



 Procedure envios;
  Begin
   ClrScr;
   textcolor(0);
   textbackground(15);
   GotoXY(5,2);Write('BIENVENID@ A ENVIOS');
   textcolor(15);
   textbackground(0);
   gotoxy(8,4); write('Ingrese el DNI del usuario que desea enviarle: '); readln; read(odni);
   gotoxy(8,6); write('Ingrese el monto que desea enviar: $'); read(env);
   If (busadordnicuentas(odni))and(Buscadordniusuarios(odni))and(odni<>log_dni)
    Then
     begin
      busadordnicuentas(log_dni);
      if(cv.salbill>=env)then begin
      registromovimientos;
      busadordnicuentas(log_dni);
      cv.salbill:=cv.salbill-env;
      write(cuen,cv);
      busadordnicuentas(odni);
      seek(cuen,filepos(cuen)-1);
      cv.salbill:=cv.salbill+env;
      write(cuen,cv);
      seek(cuen,0);
      ClrScr; gotoxy(10,9);
      ClrScr;
      textcolor(15);
      textbackground(2);
      GotoXY(30,10); Write(' OPERACION REALIZADA CON EXITO ');  delay(1500);
      textcolor(15);
      textbackground(0);
     end
    Else
     Begin
      textcolor(15);
      textbackground(4);
      ClrScr; gotoxy(30,10); write(' SALDO INSUFICIENTE ');delay(1500); end;
      textcolor(15);
      textbackground(0);
     end
   Else
    begin
     ClrScr;
     textcolor(15);
     textbackground(4);
     gotoxy(10,10); write(' DNI NO REGISTRADO EN BILLETERA VIRTUAL '); delay(1500); end;
     textcolor(15);
     textbackground(0);
   ClrScr;
  end;

function buscacom(d:integer):boolean;
var imax,imin,imedio:integer;
begin
 seek(com,0);
 while not eof(com) do
 read(com,c);
 imin:=0;imax:=filesize(com)-1;imedio:=(imin+imax) div 2;
 seek(com,imedio);read(com,c);
 while (d<>c.codcom) and (imin<=imax) do
 begin if d<c.codcom then imax:=imedio-1
 else imin:=imedio+1; 
 imedio:=(imin+imax) div 2; 
 seek(com,imedio);read(com,c);
 end; 
if(c.codcom=d)then begin buscacom:=true;
end
else
begin
buscacom:=TRUE;
end;
end;

Function buscabanco(f:integer):boolean;
begin
seek(ban,0);
while(not EOF(ban))and(b.cod<>f)  do
begin
read(ban,b);
end;
if(b.cod=f)
then
begin
 buscabanco:=true;
end
else
begin
 buscabanco:=FALSE;
end;
end;

procedure muestracuenta;
var i,t:integer;
begin
 seek(cuen,filepos(cuen));
 if(Not EOF(cuen)) then
 begin
   for i:= 1 to FileSize(cuen) do
   begin
   read(cuen,cv);
   gotoxy(10,3); write('Su cuenta registrada es ');
   gotoxy(34,3);write('/Dni: ',cv.dni);
   gotoxy(55,25);write('Saldo de su billetera: ',cv.salbill:2:2);

    for t:=1 to 5 do
    begin
    gotoxy(40,5+t*2);write('Codigo de banco: ', cv.tar[t].codban);
    gotoxy(70,5+t*2);write('Tipo de tarjeta: ',cv.tar[t].tipotar);
    gotoxy(100,5+t*2);write('Saldo: ',cv.tar[t].saltar:2:2);

    end;
   end;
  end
  
 ELSE
 begin
 gotoxy(70,4); write('No tiene cuentas registradas');
 readkey;
 end;
end;

 Procedure Compras;
 Begin
  clrscr;
  textcolor(0);
  textbackground(15);
  GotoXY(5,2);Write(' BIENVENID@ A COMPRAS ');
  textcolor(15);
  textbackground(0);
  Repeat
   clrscr;
   textcolor(0);
   textbackground(15);
   GotoXY(5,2);Write(' BIENVENID@ A COMPRAS ');
   textcolor(15);
   textbackground(0);
   ClrScr; gotoxy(10,5);write('Ingrese codigo de comercio: ');readln(ccom);ClrScr;
   until(ccom>=0);
   If(buscacom(ccom))
   Then
    begin
     textcolor(0);
     textbackground(15);
     GotoXY(5,5);Write(' DATOS DEL COMERCIO ');
     textcolor(15);
     textbackground(0);
     gotoxy(10,7); write('Negocio: ',c.nbre);
     gotoxy(10,8); write('Codigo: ',c.codcom);
     gotoxy(10,9); write('Cuit: ',c.cuit);
     gotoXY(15,12); write('Para continuar presione una tecla');
     repeat until keypressed;
     clrscr;
     muestracuenta;
     Delay(3000);
     ClrScr;
     textcolor(0);
     textbackground(15);
     GotoXY(5,2);Write(' BIENVENID@ A COMPRAS ');
     textcolor(15);
     textbackground(0);
     GotoXY(10,4); write('Ingrese codigo de banco de la tarjeta: ');readln(codigodebanco);
     if (buscabanco(codigodebanco))
      Then
       begin
        movcom;
        ClrScr;
        ClrScr;
        textcolor(0);
        textbackground(15);
        gotoxy(15,4); write(' FACTURA ');
        textcolor(15);
        textbackground(0);
        gotoxy(10,6); write('Banco: ',codigodebanco);
        GotoXY(10,7); write('Comercio: ',c.nbre);
        GotoXY(10,8); write('Fecha de compra: ',dia,'/',mes,'/',ano );
        GotoXY(10,9); write('Monto: $',m.imp:2:2);
        GotoXY(30,12); write('Presione una tecla para continuar');
        Repeat until keypressed;
        ClrScr;
       end
      Else
       begin
        Write('banco no registrado');
       end;
    end
   Else
    Begin
     Write('Comercio no adherido');
    end;
end;

procedure movi;
begin
clrscr;
textcolor(0);
textbackground(15);
gotoxy(10,2); write (' LISTADO DE MOVIMIENTOS ');
textcolor(15);
textbackground(0);
GotoXY(12,5);write ('DNI');
GotoXY(25,5);write ('CODIGO DE BANCO');
GotoXY(50,5);write ('TIPO DE TARJETA');
GotoXY(80,5);write ('IMPORTE');
GotoXY(100,5);write ('TIPO DE MOVIMIENTO');
GotoXY(120,5);write ('CODIGO DE COMERCIO');
writeln( );
reset (MOV);
CONT:=0;
while not (eof(MOV)) do begin
      cont:=cont+1;
      read (MOV,M) ;
      GotoXY(8,8+cont);write (M.DNI);
      GotoXY(29,8+cont);write (M.codban);
      GotoXY(54,8+cont);write (M.tiptar);
      GotoXY(82,8+cont);write (M.imp:2:2);
      GotoXY(104,8+cont);write (M.tipmov);
      GotoXY(134,8+cont);write (M.codcom);
      writeln( );end;  repeat until keypressed;
end;

  Procedure usuarios_pr;
  begin
    ClrScr;
    IniciodeSecion;
    ClrScr;
    While (band=true) do
    Begin
     Repeat
        ClrScr;
        textcolor(0);
        textbackground(15);
        GotoXY(15,2);Write(' BIENVENID@ ',u.nbre,' A SU BILLETERA VIRTUAL ');
        textcolor(15);
        Textbackground(0);
        textcolor(0);
        textbackground(15);
        GotoXY(5,4);Write(' MENU DE OPCIONES ');
        textcolor(15);
        Textbackground(0);
        gotoxy(5,6);write ('1- Cuentas');
        gotoxy(5,8);write ('2- Envios');
        gotoxy(5,10);write('3- Compras');
        gotoxy(5,12);write('4- Movimientos');
        gotoxy(5,14);write('5- Listado de usuario');
        Repeat
         gotoxy(10,18);write('Ingrese una opcion: '); readln;
         read;
         GotoXY(30,18); read(g_usu);
        until(g_usu<=5)or(g_usu>=1);
        case g_usu of
         1:begin cuentas;  end;
         2:begin envios;  end;
         3:begin compras; end;
         4:begin movi; end;
         5:Begin listadousuarios; end;
         6:;
        end;
    until(g_usu=6);
   end;
   readkey;
  end;

procedure direct;
begin

case op of
1: bancos_p;
2: comercios123;
3: usuarios_pr;
4:;
end;
ClrScr;
end;

procedure Assignabre1;
begin
Assign(com,'C:\Users\FAU\Desktop\a\comercios.dat');
Assign(ban,'C:\Users\FAU\Desktop\a\bancos.dat');
Assign(cuen,'C:\Users\FAU\Desktop\a\cuentasvirtuales.dat');
Assign(usu,'C:\Users\FAU\Desktop\a\usuarios.dat');
Assign(mov,'C:\Users\FAU\Desktop\a\movimientos.dat');

{I-}
reset(com); if(IOResult=2)then begin rewrite(com);end;
reset(ban); if(IOResult=2)then begin Rewrite(ban); end;
reset(mov);  if(IOResult=2)then begin rewrite(mov)end;
reset(cuen);  if(IOResult=2)then begin rewrite(cuen)end;
reset(usu);  if(IOResult=2)then begin rewrite(usu)end;
{I+}

end;
procedure Cerrado1;
begin
close(mov);
close(cuen);
close(usu);
Close(ban);
Close(com);

end;

Procedure PPAL;
 begin
 op:=0;
   ClrScr;
   textcolor(0);
   textbackground(15);
   GotoXY(15,8); Write('                                                        ');
   GotoXY(15,9); Write('                                                        ');
   GotoXY(15,10);Write('             BIENVENID@ A BILLETERA VIRTUAL             ');
   GotoXY(15,11);Write('                                                        ');
   GotoXY(15,12);Write('                                                        ');
   textcolor(15);
   textbackground(0);
   GotoXY(40,15);Write(' Presione una tecla para continuar');
   Repeat until keypressed;
    ClrsCr;
    Repeat
    textcolor(0);
    textbackground(15);
    GotoXY(15,9); Write('                                    ');
    GotoXY(15,10);Write(' MENU PRINCIPAL - BILLETERA VIRTUAL ');
    GotoXY(15,11);Write('                                    ');
    textcolor(15);
    textbackground(0);
    gotoxy(10,13); write(' 1 - Bancos');
    gotoxy(10,14); write(' 2 - ABM de Comercios Adheridos');
    gotoxy(10,15); write(' 3 - Usuarios');
    gotoxy(10,16); write(' 4 - Salir');
    gotoxy(20,18); write(' Elja su opcion: ');readln(op);
   direct;
   until(op=4);
  end;

       begin
       Assignabre1;


       PPAL;
       Cerrado1;

       end.

