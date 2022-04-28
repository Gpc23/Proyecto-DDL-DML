CREATE TABLE tiendas (
    cif_tienda VARCHAR (10),
    nombre VARCHAR (20),
    direccion VARCHAR (20),
    poblacion VARCHAR (20),
    CONSTRAINT PK_cif PRIMARY KEY (cif_tienda),
    CONSTRAINT CK_nom CHECK (nombre IS NOT NULL),
    CONSTRAINT CK_pob CHECK (poblacion=INITCAP(poblacion))
);

CREATE TABLE escritores (
    cod_escritor NUMBER (3),
    nombre VARCHAR (15),
    pais VARCHAR (15),
    fecha_nacimiento DATE,
    CONSTRAINT PK_cod PRIMARY KEY (cod_escritor),
    CONSTRAINT CK_nom CHECK (nombre IS NOT NULL),
    CONSTRAINT CK_pais CHECK (upper(pais)),
    CONSTRAINT CK_fnac CHECK (fecha_nacimiento BETWEEN '1900-01-01' AND '2020-12-31'),
);

CREATE TABLE comics (
    comic VARCHAR (20),
    cod_escritor NUMBER (3),
    paginas NUMBER (99),
    categoria VARCHAR (10),
    existencias NUMBER (10),
    CONSTRAINT PK_comic PRIMARY KEY (comic),
    CONSTRAINT FK_cod FOREIGN KEY (cod_escritor) REFERENCES escritores (cod_escritor),
    CONSTRAINT CK_paginas CHECK (paginas > 1),
    CONSTRAINT CK_categoria CHECK (upper(categoria) IN ('Accion','Aventura','Terror'))
);

CREATE TABLE clientes (
    nif_cliente VARCHAR (10),
    nombre VARCHAR (10),
    socio VARCHAR (10),
    direccion VARCHAR (10),
    telefono NUMBER (9),
    CONSTRAINT PK_nif PRIMARY KEY (nif_cliente),
    CONSTRAINT CK_nif_cliente CHECK (REGEXP_LIKE(nif_cliente,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'));
    CONSTRAINT CK_nom CHECK (nombre IS NOT NULL),
    CONSTRAINT CK_dir CHECK (upper(direccion)),
    CONSTRAINT CK_movil_ok CHECK (telefono Between 600000000 AND 799999999)
);

CREATE TABLE ventas (
    id_venta NUMBER (3),
    comic VARCHAR (20),
    nif_cliente VARCHAR (20),
    fecha_venta DATE,
    CONSTRAINT PK_id PRIMARY KEY (id_venta),
    CONSTRAINT FK_comic FOREIGN KEY (comic) REFERENCES comics (comic),
    CONSTRAINT FK_nif FOREIGN KEY (nif_cliente) REFERENCES clientes (nif_cliente),
    CONSTRAINT CK_fecha_venta CHECK ((TIME_FORMAT(fecha_venta, '%H') >= '10') AND (TIME_FORMAT(fecha_venta, '%H') <= '20'))
);

CREATE TABLE tienda_comics (
    cif_tienda VARCHAR (10),
    comic VARCHAR (20),
    stock NUMBER (3),
    CONSTRAINT PK_cif PRIMARY KEY (cif_tienda),
    CONSTRAINT PK_comic PRIMARY KEY (comic),
    CONSTRAINT CK_stock CHECK (stock > 1)
);

/* ENUNCIADOS */

/* 1. Añade la columna referencias en la tabla comics, que sea una cadena de 20 caracteres.*/
ALTER TABLE comics ADD referencias VARCHAR2 (20);

/* 2. Eliminar la columna socio de la tabla clientes.*/ 
ALTER TABLE clientes DROP socio;

/* 3. Modificar nombre en la tabla escritores aumentando a 20 los caracteres de la cadena.*/
ALTER TABLE escritores MODIFY nombre VARCHAR2 (20);

/* 4. Añadir una restricción a stock en la tabla tienda_comics para que el mínimo sea 2. */
ALTER TABLE tienda_comics ADD CONSTRAINT CK_stock CHECK (stock > 2);

/* 5. Eliminar la restricción sobre la columna Obra de la tabla Interpretación.*/
ALTER TABLE tiendas DROP CONSTRAINT CK_nom;

/* 6. Desactivar la restricción que afecta a País_nacimiento de la tabla Compositores.*/
ALTER TABLE escritores DISABLE CONSTRAINT CK_pais;

/* INSERTS */

--- Tabla tiendas ---
INSERT INTO tiendas (cif_tienda, nombre, direccion, poblacion) values ('1', 'Nostromo', 'C. Zaragoza', 'Sevilla')
INSERT INTO tiendas (cif_tienda, nombre, direccion, poblacion) values ('2', 'Raccoon Games', 'C. Luis Montoto', 'Sevilla')
INSERT INTO tiendas (cif_tienda, nombre, direccion, poblacion) values ('3', 'Arkham Games', 'C. Silos', 'Alcala')

--- Tabla escritores ---
INSERT INTO escritores (cod_escritor, nombre, pais, fecha_nacimiento) values ('1', 'Frank Miller', 'Estados Unidos', '1957-01-27')
INSERT INTO escritores (cod_escritor, nombre, pais, fecha_nacimiento) values ('2', 'Jason Aaron', 'Estados Unidos', '1973-01-28')
INSERT INTO escritores (cod_escritor, nombre, pais, fecha_nacimiento) values ('3', 'Carlos Pacheco', 'España', '1962-11-14')

--- Tabla comics ---
INSERT INTO comics (comic, cod_escritor, paginas, categoria, existencias) values ('Daredevil Born Again', '1', '50', 'Accion', '7')
INSERT INTO comics (comic, cod_escritor, paginas, categoria, existencias) values ('Wolverine', '1', '54', 'Terror', '6')
INSERT INTO comics (comic, cod_escritor, paginas, categoria, existencias) values ('Elektra', '1', '34', 'Aventura', '4')
INSERT INTO comics (comic, cod_escritor, paginas, categoria, existencias) values ('Thor', '2', '78', 'Aventura', '4')
INSERT INTO comics (comic, cod_escritor, paginas, categoria, existencias) values ('Avengers Forever', '2', '98', 'Terror', '8')
INSERT INTO comics (comic, cod_escritor, paginas, categoria, existencias) values ('Punisher', '2', '56', 'Accion', '7')
INSERT INTO comics (comic, cod_escritor, paginas, categoria, existencias) values ('Ultimate Avengers', '3', '60', 'Accion', '9')
INSERT INTO comics (comic, cod_escritor, paginas, categoria, existencias) values ('X-Men Apocalypse', '3', '54', 'Terror', '6')
INSERT INTO comics (comic, cod_escritor, paginas, categoria, existencias) values ('Bishop', '3', '76', 'Aventura', '7')

--- Tabla clientes ---
INSERT INTO clientes (nif_cliente, nombre, socio, direccion, telefono) values ('678954756A', 'Antonio', 'socio', 'C.Altraz', '678954678')
INSERT INTO clientes(nif_cliente, nombre, socio, direccion, telefono) values ('786954673G', 'Jorje', 'socio', 'C.Libertad', '685674523')
INSERT INTO clientes (nif_cliente, nombre, socio, direccion, telefono) values ('786954674H', 'Claudia', 'socio', 'C.Libertad', '693546273')
INSERT INTO clientes (nif_cliente, nombre, socio, direccion, telefono) values ('894374856L', 'Laura', 'socio', 'C.Pluma', '692354671')

--- Tabla ventas ---
INSERT INTO ventas (id_venta, comic, nif_cliente, fecha_venta) values ('1', 'Punisher', '786954673G', '13:34:00')
INSERT INTO ventas (id_venta, comic, nif_cliente, fecha_venta) values ('2', 'Elektra', '894374856L', '17:56:00')
INSERT INTO ventas (id_venta, comic, nif_cliente, fecha_venta) values ('3', 'Wolverine', '786954674H', '19:24:00')
INSERT INTO ventas (id_venta, comic, nif_cliente, fecha_venta) values ('4', 'Bishop', '678954756A', '12:12:00')

--- Tabla tienda_comics ---
INSERT INTO tienda_comics (cif_tienda, comic, stock) values ('1', 'Daredevil Born Again', '12')
INSERT INTO tienda_comics (cif_tienda, comic, stock) values ('3', 'Wolverine', '3')
INSERT INTO tienda_comics (cif_tienda, comic, stock) values ('2', 'Elektra', '2')
INSERT INTO tienda_comics (cif_tienda, comic, stock) values ('2', 'Thor', '2')
INSERT INTO tienda_comics (cif_tienda, comic, stock) values ('3', 'Avengers Forever', '3')
INSERT INTO tienda_comics (cif_tienda, comic, stock) values ('1', 'Punisher', '2', '56', 'Accion', '4')
INSERT INTO tienda_comics (cif_tienda, comic, stock) values ('3', 'Ultimate Avengers', '5')
INSERT INTO tienda_comics (cif_tienda, comic, stock) values ('1', 'X-Men Apocalypse', '3')
INSERT INTO tienda_comics (cif_tienda, comic, stock) values ('2', 'Bishop', '4')

/* Consultas */