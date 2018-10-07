-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### BD #####
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
drop database if exists facturacion;
create database if not exists facturacion;
use facturacion;
-- TABLAS --
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

create table rol(
    codigoRol int auto_increment primary key unique,
    abrRol varchar(15),
    descRol varchar(50)
);

create table usuario(
	codigoUsuario int auto_increment primary key unique,
    nombreUsuario varchar(100),
    pass varchar(100),
    codigoRol int,
    estado int
);

create table cliente
(
	codigoCliente int(11) auto_increment primary key unique,
    nombre varchar(50),
    apellidos varchar(50),
    direccion varchar(50)
);

create table vendedor
(
	codigoVendedor int(11) auto_increment primary key unique,
    nombre varchar(50),
    apellidos varchar(50),
    dui varchar(10),
    direccion varchar(50),
    telefonoOficina varchar(10),
    telefonoMovil varchar(10),
    codigoUsuario int(11),
    estado int(11) default 1
);

create table producto
(
	codigoProducto int(11) auto_increment primary key unique,
    nombreProducto varchar(80),
    precioVenta double,
    stockMinimo int(11),
    stockActual int(11),
    codigoBarra varchar(50)
);

create table factura
(
	codigoFactura int(11) auto_increment primary key unique,
    numeroFactura varchar(10),
    codigoVendedor int(11),
    codigoCliente int(11),
    totalVenta double,
    totalIVA double,
    fechaRegistro timestamp
);

create table detalleFactura
(
	codigoDetalle int(11) auto_increment primary key unique,
    codigoFactura int(11),
    codigoProducto int(11),
    cantidad int(11),
    total double
);
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### LLAVES FORANEAS ######
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

alter table usuario add constraint fk_usuario_rol foreign key (codigoRol) references rol(codigoRol);
alter table factura add constraint fk_factura_vendedor foreign key (codigoVendedor) references vendedor(codigoVendedor);
alter table factura add constraint fk_factura_cliente foreign key (codigoCliente) references cliente(codigoCliente);
alter table detalleFactura add constraint fk_detalleFactura_factura foreign key (codigoFactura) references factura(codigoFactura);
alter table detalleFactura add constraint fk_detalleFactura_producto foreign key (codigoProducto) references producto(codigoProducto);
alter table vendedor add constraint fk_vendedor_usuario foreign key (codigoUsuario) references usuario (codigoUsuario);

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### VISTAS ######
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

create view v_usuarios as (
	select u.*, r.descRol
    from usuario u, rol r
    where u.codigoRol = r.codigoRol and u.estado = 1
);

create view v_facturas as (
	select f.*, concat(v.nombre," ", v.apellidos) as nombreVendedor, concat(c.nombre," ", c.apellidos) as nombreCliente
    from factura f, vendedor v, cliente c
    where f.codigoVendedor = v.codigoVendedor and f.codigoCliente = c.codigoCliente
);


-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### PROCEDIMIENTOS ALMACENADOS ######
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

## USUARIO

-- login
delimiter $$ 
create procedure login(
	in nom varchar(50),
	in contra varchar(50)
)
begin
	select * from v_usuarios where nombreUsuario = nom and pass = sha1(contra);
end
$$

-- registrar usuario
delimiter $$
create procedure registrarUsuario(
	in nom varchar(50),
    in contra varchar(50),
    in rol int
)
begin
	insert into usuario values(null, nom, sha1(contra), rol, 1);
end
$$

delimiter $$
create procedure getUsuarioId(
	in id int
)
begin
	select * from usuario where codigoUsuario = id;
end
$$

-- eliminar usuario
delimiter $$
create procedure eliminarUsuario(
	in id int
)
begin
	delete from usuario where codigoUsuario = id;
end
$$

-- comprobarNombre usuario
delimiter $$
create procedure compNombreUsuario(
	in nom varchar(50)
)
begin
	select * from usuario where nombreUsuario = nom;
end
$$

-- editar usuario
delimiter $$
create procedure editarUsuario(
	in nom varchar(50),
    in contra varchar(50),
    in rol int,
    in id int
)
begin
	update usuario
    set nombreUsuario = nom, pass = sha1(contra), codigoRol = rol
    where codigoUsuario = id;
end
$$

## PRODUCTO
 
-- insertar producto --
delimiter $
create procedure insertarProducto(in nomP varchar(80), in precV double, in stockMin int(11), in stockAct int(11), in codigoB varchar(50))
begin
	insert into producto values(null,nomP,precV,stockMin,stockAct,codigoB);
end $

-- modificar producto --
delimiter $
create procedure modificarProducto(in id int(11), in nomP varchar(80), in precV double, in stockMin int(11), in stockAct int(11), in codigoB varchar(50))
begin
	update producto set nombreProducto = nomP, precioVenta = precV,stockMinimo = stockMin, stockActual = stockAct, codigoBarra = codigoB where codigoProducto = id;
end $

-- eliminar producto --
delimiter $
create procedure eliminarProducto(in id int(11))
begin
	delete from producto where codigoProducto = id;
end $

-- mostrar producto --
delimiter $
create procedure mostrarProducto()
begin
	select * from producto;
end $

-- buscar por id producto --
delimiter $
create procedure buscarIDProducto(in id int(11))
begin
	select * from producto where codigoProducto = id;
end $

-- buscar por nombre producto --
delimiter $
create procedure buscarNombreProducto(in nomP varchar(11))
begin
	select * from producto where nomP like concat('%',nomP,'%');
end $

## FACTURA	------------------------------------------------------------

delimiter $
create procedure nuevaFactura(in numeroF int, vendedor int, cliente int, total double, totaliva double)
begin
	insert into factura values(null, numeroF,vendedor,cliente,total, totaliva, now());
end $

delimiter $
create procedure buscarFactura(in codigo int)
begin

select 
	f.numeroFactura as n, 
	concat(v.nombre,' ',v.apellidos) as vendedor, 
	concat(c.nombre,' ',c.apellidos) as cliente,
    Format(f.totalVenta,2) as total,
    Format(f.totalIVA,2) as totalIVA,
    f.fechaRegistro as fecha
from factura f 
inner join vendedor v on v.codigoVendedor= f.codigoVendedor
inner join cliente c on c.codigoCliente= f.codigoCliente
where f.numeroFactura=codigo;

end$


delimiter $
create procedure detalleFactura(in factura int, producto int, cantidad int, sub double)
begin
	insert into detalleFactura values(null,factura,producto,cantidad,sub);
end$

delimiter $
create procedure restarStock(in codigo int, cantidad int)
begin 
	update producto set stockActual = (stockActual - cantidad) where codigoProducto = codigo;
end $

delimiter $
create procedure detalle(in codigo int)
begin
	select p.nombreProducto as producto, Format(p.precioVenta,2) as precio, d.cantidad, Format(d.total,2) as subtotal from detalleFactura d 
	inner join producto p on p.codigoProducto= d.codigoProducto where d.codigoFactura=codigo;
end $

##	CLIENTE	--------------------------------------------
delimiter $
create procedure insertarCliente(in nombre varchar(50), apellido varchar(50), direccion varchar(50))
begin
	insert into cliente values(null, nombre, apellido, direccion);
end $

## Vendedor
 -- insertar vendedor
delimiter $
create procedure insertarVendedor(in nom varchar(50), in ape varchar(50), in dui varchar(50), in dire varchar(50), in telOf varchar(50), in telMov varchar(50), in idUs int)
begin
	insert into vendedor values(null, nom, ape, dui, dire, telOf, telMov, idUs, 1);
end $

-- modificar vendedor
delimiter $
create procedure modificarVendedor(in nom varchar(50), in ape varchar(50), in dire varchar(50), in dui varchar(50), in telOf varchar(50), in telMov varchar(50), in cod int(11))
begin
	update vendedor set nombre = nom, apellidos = ape, direccion = dire, dui = dui, telefonoOficina = telOf, telefonoMovil = telMov where codigoVendedor = cod;
end $

-- eliminar fisico vendedor
delimiter $
create procedure eliminarFisicoVendedor(in cod int(11))
begin
	delete from vendedor where codigoVendedor = cod;
end $

-- eliminar lógico vendedor
delimiter $
create procedure eliminarlogicoVendedor(in cod int(11))
begin 
	update vendedor set estado = 0 where codigoVendedor = cod;
end $

-- mostrar vendedor

delimiter $
create procedure mostrarVendedor()
begin
	select * from vendedor where estado = 1;
end $

delimiter $
create procedure grafica1()
begin 
	SET lc_time_names = 'es_MX';
	select count(*) as cantidad, MONTHNAME(fechaRegistro) as mes from factura group by MONTHNAME(fechaRegistro);
end$

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### DATOS DE PRUEBA ######
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into rol values(null, 'mMun', 'Desarrollador');
insert into rol values(null, 'lcqe0p8=', 'Administrador');
insert into rol values(null, 'ndSn', 'Vendedor');


insert into usuario values(null, 'sidgo', sha1('123'), 1, 1);
insert into usuario values(null, 'lenodardo', sha1('321'), 3, 1);
insert into usuario values(null, 'elbenja', sha1('123'), 3, 1);
insert into usuario values(null, 'anb98', sha1('123'), 1,1);
insert into usuario values(null, 'anb99', sha1('123'), 3,1);

call insertarProducto('Monitor LED 24"', 129.45, 100, 275, 'aa');
call insertarProducto('Procesador Intel Core i7 7700', 443.45, 10, 25, 'aa');
call insertarProducto('Tarjeta Gráfica AMD Radeon rx550', 550.87, 10, 18, 'aa');
call insertarProducto('Case Gamer xD', 75.90, 60, 130, 'aa');
call insertarProducto('Procesador AMD Ryzen', 780.67, 21, 30, 'aa');
-- call modificarProducto(6,'Nelprro',0.25,12,24,null);

insert into vendedor values
(null,'Alexander','Coreas','123456','por ahi','123456','789456',3,1),
(null,'Julio','Cesar','456789','por alla','123456','789456',5,1);

insert into cliente values(null, 'nombre', 'apellido', 'direccion');
