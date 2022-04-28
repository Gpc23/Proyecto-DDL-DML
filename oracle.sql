CREATE TABLE tiendas (
    cif_tienda VARCHAR2 (10),
    nombre VARCHAR2 (20),
    direccion VARCHAR2 (20),
    poblacion VARCHAR2 (20),
    CONSTRAINT PK_cif PRIMARY KEY (cif_tienda),
    CONSTRAINT CK_nom CHECK (nombre IS NOT NULL),
    CONSTRAINT CK_pob CHECK (poblacion=INITCAP(poblacion))
);

CREATE TABLE escritores (
    cod_escritor NUMBER (3),
    nombre VARCHAR2 (15),
    pais VARCHAR2 (15),
    fecha_nacimiento DATE,
    CONSTRAINT PK_cod PRIMARY KEY (cod_escritor),
    CONSTRAINT CK_nom CHECK (nombre IS NOT NULL),
    CONSTRAINT CK_pais CHECK (upper(pais)),
    CONSTRAINT CK_fechnac CHECK (TO_NUMBER(substr(fecha_nacimiento, -4, 4)) BETWEEN 1900 AND 2020)
);

CREATE TABLE comics (
    comic VARCHAR2 (20),
    cod_escritor NUMBER (3),
    paginas NUMBER (99),
    categoria VARCHAR2 (10),
    existencias NUMBER (10),
    CONSTRAINT PK_comic PRIMARY KEY (comic),
    CONSTRAINT FK_cod FOREIGN KEY (cod_escritor) REFERENCES escritores (cod_escritor),
    CONSTRAINT CK_paginas CHECK (paginas > 1),
    CONSTRAINT CK_categoria CHECK (upper(categoria) IN ('Accion','Aventura','Terror'))
);

CREATE TABLE clientes (
    nif_cliente VARCHAR2 (10),
    nombre VARCHAR2 (10),
    socio VARCHAR2 (10),
    direccion VARCHAR2 (10),
    telefono NUMBER (9),
    CONSTRAINT PK_nif PRIMARY KEY (nif_cliente),
    CONSTRAINT CK_nif_cliente CHECK (REGEXP_LIKE(nif_cliente,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'));
    CONSTRAINT CK_nom CHECK (nombre IS NOT NULL),
    CONSTRAINT CK_dir CHECK (upper(direccion)),
    CONSTRAINT CK_movil_ok CHECK (telefono Between 600000000 AND 799999999)
);

CREATE TABLE ventas (
    id_venta NUMBER (3),
    comic VARCHAR2 (20),
    nif_cliente VARCHAR2 (20),
    fecha_venta DATE,
    CONSTRAINT PK_id PRIMARY KEY (id_venta),
    CONSTRAINT FK_comic FOREIGN KEY (comic) REFERENCES comics (comic),
    CONSTRAINT FK_nif FOREIGN KEY (nif_cliente) REFERENCES clientes (nif_cliente),
    CONSTRAINT CK_fecha_venta CHECK (fecha_venta > TO_DATE(TO_CHAR(TRUNC)(fecha_venta), 'DD/MM/YYYY' || '10:00:00', 'DD/MM/YYYY HH24:MI:SS')) BETWEEN (fecha_venta < TO_DATE(TO_CHAR(TRUNC)(fecha_venta), 'DD/MM/YYYY' || '20:00:00', 'DD/MM/YYYY HH24:MI:SS'))
);

CREATE TABLE tienda_comics (
    cif_tienda VARCHAR2 (10),
    comic VARCHAR2 (20),
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
INSERT INTO tiendas values ('1', 'Nostromo', 'C. Zaragoza', 'Sevilla')
INSERT INTO tiendas values ('2', 'Raccoon Games', 'C. Luis Montoto', 'Sevilla')
INSERT INTO tiendas values ('3', 'Arkham Games', 'C. Silos', 'Alcala')

--- Tabla escritores ---
INSERT INTO escritores values ('1', 'Frank Miller', 'Estados Unidos', '1957-01-27')
INSERT INTO escritores values ('2', 'Jason Aaron', 'Estados Unidos', '1973-01-28')
INSERT INTO escritores values ('3', 'Carlos Pacheco', 'España', '1962-11-14')

--- Tabla comics ---
INSERT INTO comics values ('Daredevil Born Again', '1', '50', 'Accion', '7')
INSERT INTO comics values ('Wolverine', '1', '54', 'Terror', '6')
INSERT INTO comics values ('Elektra', '1', '34', 'Aventura', '4')
INSERT INTO comics values ('Thor', '2', '78', 'Aventura', '4')
INSERT INTO comics values ('Avengers Forever', '2', '98', 'Terror', '8')
INSERT INTO comics values ('Punisher', '2', '56', 'Accion', '7')
INSERT INTO comics values ('Ultimate Avengers', '3', '60', 'Accion', '9')
INSERT INTO comics values ('X-Men Apocalypse', '3', '54', 'Terror', '6')
INSERT INTO comics values ('Bishop', '3', '76', 'Aventura', '7')

--- Tabla clientes ---
INSERT INTO clientes values ('678954756A', 'Antonio', 'socio', 'C.Altraz', '678954678')
INSERT INTO clientes values ('786954673G', 'Jorje', 'socio', 'C.Libertad', '685674523')
INSERT INTO clientes values ('786954674H', 'Claudia', 'socio', 'C.Libertad', '693546273')
INSERT INTO clientes values ('894374856L', 'Laura', 'socio', 'C.Pluma', '692354671')

--- Tabla ventas ---
INSERT INTO ventas values ('1', 'Punisher', '786954673G', '13:34:00')
INSERT INTO ventas values ('2', 'Elektra', '894374856L', '17:56:00')
INSERT INTO ventas values ('3', 'Wolverine', '786954674H', '19:24:00')
INSERT INTO ventas values ('4', 'Bishop', '678954756A', '12:12:00')

--- Tabla tienda_comics ---
INSERT INTO tienda_comics values ('1', 'Daredevil Born Again', '12')
INSERT INTO tienda_comics values ('3', 'Wolverine', '3')
INSERT INTO tienda_comics values ('2', 'Elektra', '2')
INSERT INTO tienda_comics values ('2', 'Thor', '2')
INSERT INTO tienda_comics values ('3', 'Avengers Forever', '3')
INSERT INTO tienda_comics values ('1', 'Punisher', '2', '56', 'Accion', '4')
INSERT INTO tienda_comics values ('3', 'Ultimate Avengers', '5')
INSERT INTO tienda_comics values ('1', 'X-Men Apocalypse', '3')
INSERT INTO tienda_comics values ('2', 'Bishop', '4')

/* Consultas */

--- 1: Muestra los escritores que nacieron antes del año 1965. ---
    SELECT *
    FROM escritores
    WHERE fecha_nacimiento <'01/01/1965';