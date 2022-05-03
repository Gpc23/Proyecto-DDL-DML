/* TABLAS */

CREATE TABLE tiendas (
    cif_tienda VARCHAR (10),
    nombre VARCHAR (20),
    direccion VARCHAR (20),
    poblacion VARCHAR (20),
    CONSTRAINT PK_cif PRIMARY KEY (cif_tienda),
    CONSTRAINT CK_nom CHECK (nombre IS NOT NULL),
    CONSTRAINT CK_pob CHECK (poblacion=UCASE(poblacion))
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
    CONSTRAINT CK_nif_cliente CHECK (REGEXP_LIKE(nif_cliente,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')),
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
    CONSTRAINT CK_hora CHECK (date_format(fecha_venta, '%H:%i:%s') between '10:00:00' and '20:00:00')
);

CREATE TABLE tienda_comics (
    cif_tienda VARCHAR (10),
    comic VARCHAR (20),
    stock NUMBER (3),
    CONSTRAINT FK_cif FOREIGN KEY (cif_tienda2) REFERENCES tiendas (cif_tienda),
    CONSTRAINT FK_comic FOREIGN KEY (comic3) REFERENCES comics (comic),
    CONSTRAINT CK_stock CHECK (stock > 1)
);

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

/* ENUNCIADOS */

--- 1. Añade la columna referencias en la tabla comics, que sea una cadena de 20 caracteres. ---
ALTER TABLE comics ADD referencias VARCHAR2 (20);

--- 2. Eliminar la columna socio de la tabla clientes. ---
ALTER TABLE clientes DROP socio;

--- 3. Modificar nombre en la tabla escritores aumentando a 20 los caracteres de la cadena. ---
ALTER TABLE escritores MODIFY nombre VARCHAR2 (20);

--- 4. Añadir una restricción a stock en la tabla tienda_comics para que el mínimo sea 2. ---
ALTER TABLE tienda_comics ADD CONSTRAINT CK_stock CHECK (stock > 2);

--- 5. Eliminar la restricción sobre la columna nombre de la tabla Tiendas. ---
ALTER TABLE tiendas DROP CONSTRAINT CK_nom;

--- 6. Desactivar la restricción que afecta a nombre_escritor de la tabla Escritores. ---
ALTER TABLE escritores DISABLE CONSTRAINT CK_nom;

/* CONSULTAS */

--- 1. Muestra los escritores que nacieron antes del año 1965. ---
    SELECT *
    FROM escritores
    WHERE fecha_nacimiento <'01/01/1965';

--- 2. Muestra el nombre de los cómics cuya categoria sea Aventura. ---
    SELECT comic
    FROM comics
    WHERE categoria = 'AVENTURA'

--- 3. Muestra el nombre del escritor y el comic ordenados por su código. ---
    CREATE VIEW comics
        AS
        SELECT e.cod_escritor, c.comic
        FROM escritores e, comics c 
        WHERE e.nombre_escritor = c.comic;

    SELECT *
    FROM comics;

--- 4. Muestra el país del escritor que haya escrito el comic Wolverine. ---
    SELECT pais
    FROM escritores
    WHERE cod_escritor IN ( SELECT cod_escritor2
                            FROM comics
                            WHERE comic = 'Wolverine');

--- 5. Crea una tabla llamada IRONMAN con el mismo tipo y tamaño de las ya existentes. Insertar en la tabla el nombre del comic, el número de páginas y el stock mediante una consulta de datos anexados. ---
    CREATE TABLE ironman (
        comic VARCHAR2 (20),
        paginas NUMBER (99),
        stock NUMBER (3)
    );

    INSERT INTO ironman
    SELECT c.comic, c.paginas, t.stock
    FROM comic c, tienda_comics t
    WHERE c.comic = 'Iron-Man' and t.comic2 = 'Iron-Man';

--- 6. Actualizar en la tabla clientes que Laura ya no es socio. ---
    UPDATE clientes
    SET socio = 'no socio'
    Where nombre_cliente = 'Laura';

--- 7. Borrar el comic 'Daredevil Born Again' de la tabla comics. ---
    DELETE FROM comics
    WHERE comic = 'Daredevil Born Again';

--- 8. Muestra el nombre del comic siendo el numero de paginas como mínimo 20 y como máximo 38. ---
    SELECT comic, MAX(paginas) AS max_paginas, MIN(paginas) AS min_paginas
    FROM comics
    GROUP BY comic
    HAVING MAX(paginas) > 38 OR MIN(paginas) < 20;

---9. Consulta el nombre de un comic con su categoria y los nombres de los comics con su stock. ---
    SELECT comic, categoria
    FROM comics
    UNION 
    SELECT comic3, stock
    FROM tienda_comics;

--- 10. Muestra el comic de Antonio cuyo id de venta pertenezca a la direccion C.Altraz ---
    SELECT DISTINCT comic
    FROM comics
    WHERE comic IN (SELECT comic2
                    FROM ventas
                    WHERE id_venta = '1'
                    and nif_cliente2 IN (SELECT nif_cliente
                                            FROM clientes
                                            WHERE direccion = 'C.Altraz'));