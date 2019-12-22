create database PlanV;

use PlanV;

create table provincia(
	id tinyint not null,
    nombre varchar(50) not null,
    codigo31662 char(4) unique,
    constraint PK_Provincia primary key (id)
);

create table localidad(
	id int(10) not null,
    provincia_id tinyint not null,
    nombre varchar(50) not null,
    codigopostal smallint(6),
    constraint PK_Provincia primary key (id),
    constraint fk_localidad_provincia_idx foreign key (provincia_id) references provincia(id)
);

create table TipoUsuarios(
	IdTipoUsuario int auto_increment not null,
    Descripcion varchar(50),
    Estado bool not null default true,
    constraint PK_TipoUsuario primary key (IdTipoUsuario)
);

create table Usuarios(
	IdUsuario int auto_increment not null,
	Mail varchar(50) not null unique,
    Dni varchar(50) not null,
    IdTipoUsuario int not null,
    Nombre varchar(50) not null,
    Apellido varchar(50) not null,
    FechaNacimiento datetime not null,
    IdProvincia tinyint not null,
    Direccion varchar(100) null,
    Telefono varchar(15) null,
    Clave varchar(50) not null,
    Ciudad int(10) not null,
    Estado bool not null default true,
    constraint PK_Usuarios primary key (IdUsuario),
    constraint fk_Usuarios foreign key (IdProvincia, Ciudad) references localidad(provincia_id,id)
);

create table TipoProductos(
	IdTipoProducto int auto_increment not null,
    Nombre varchar(50),
    Descripcion text,
    Estado bool not null default true,
    constraint PK_TipoProductos primary key (IdTipoProducto)
);

create table Productos(
	IdProducto int auto_increment not null,
    IdTipoProducto int not null,
    Nombre varchar(50) not null,
    Descripcion text not null,
    Precio int not null,
    Descuento int not null default 0,
    Stock int not null,
	UrlImagen varchar(50) not null,
    Estado bool not null default true,
    constraint PK_Productos primary key (IdProducto)
);

create table ImagenesXProducto(
	IdProducto int not null,
    UrlImagen varchar(50) not null,
	Estado bool not null default true,
    constraint PK_ImagenesXProductos primary key (IdProducto,UrlImagen)
);

create table Carrito(
	IdUsuario int not null,
	IdProducto int not null,
    Cantidad int not null,
    Estado bool not null default true,
    constraint PK_Carrito primary key (IdUsuario,IdProducto)
);

create table Facturas(
	IdFactura int auto_increment not null,
    IdUsuario int not null,
    Monto int not null,
    Fecha date not null,
    Estado bool not null default true,
    constraint PK_Factura primary key (IdFactura)
);

select * from usuarios;

create table DetallesFacturas(
	IdFactura int not null,
    IdProducto int not null,
    PrecioUnitario int not null,
    Cantidad int not null,
    Estado bool not null default true,
    constraint PK_DetalleFactura primary key (IdFactura,IdProducto)
);

create table Pedidos(
	IdPedido int auto_increment not null,
    IdUsuario int not null,
    IdTipoProducto int not null,
    Precio int not null,
    Fecha date not null,
    Estado int not null,
    constraint PK_Pedidos primary key (IdPedido)
);

create table ChatXPedido(
	IdChat int auto_increment not null,
	IdPedido int not null,
    IdUsuario int not null,
    Mensaje text,
    Fecha date not null,
    Estado int not null,
    constraint PK_ChatXPedido primary key (IdChat)
);

create table ImagenesXChat(
	IdChat int auto_increment not null,
	UrlImagen varchar(100) not null,
    Estado int not null,
    constraint PK_ImagenesXChat primary key (IdChat,UrlImagen)
);

alter table Usuarios 
add constraint FK_Usuarios_Tipo foreign key (IdTipoUsuario)
references TipoUsuarios(IdTipoUsuario);

alter table Productos 
add constraint FK_Productos foreign key (IdTipoProducto)
references TipoProductos(IdTipoProducto);

alter table ImagenesXProducto
add constraint FK_ImagenesXProducto foreign key (IdProducto)
references Productos(IdProducto);

alter table Carrito
add constraint FK_Carrito_Producto foreign key (IdProducto)
references Productos(IdProducto);

alter table Carrito
add constraint FK_Carrito_Usuario foreign key (IdUsuario)
references Usuarios(IdUsuario);

alter table Facturas
add constraint FK_Factura foreign key (IdUsuario)
references Usuarios(IdUsuario);

alter table DetallesFacturas
add constraint FK_Detalle_Factura foreign key (IdFactura)
references Facturas(IdFactura);

alter table DetallesFacturas
add constraint FK_Detalle_Producto foreign key (IdProducto)
references Productos(IdProducto);

alter table Pedidos
add constraint FK_Pedidos_Usuario foreign key (IdUsuario)
references Usuarios(IdUsuario);

alter table Pedidos
add constraint FK_Pedidos_Tipo foreign key (IdTipoProducto)
references TipoProductos(IdTipoProducto);

alter table ChatXPedido
add constraint FK_Chat_Pedido foreign key (IdPedido)
references Pedidos(IdPedido);

alter table ChatXPedido
add constraint FK_Chat_Usuario foreign key (IdUsuario)
references Usuarios(IdUsuario);

alter table ImagenesXChat
add constraint FK_ImagenesXChat foreign key (IdChat)
references ChatXPedido(IdChat);

insert into tipousuarios(descripcion) select "Administrador";
insert into tipousuarios(descripcion) select "Cliente";

insert into tipoProductos(Nombre,Descripcion)
select "Cuaderno","Cuaderno" union
select "Agenda","Agenda" union
select "Calendario","Calendario" union
select "Tarjeta","Tajeta"