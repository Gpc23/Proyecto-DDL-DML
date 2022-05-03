# Proyecto-DDL-DML

## Tablas
Tablas en los sistemas de Oracle, MariaDB y PostgreSQL.

### TIENDAS
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| Cif_Tienda | cadena de caracteres (10) | Clave Primaria |
| Nombre | cadena de caracteres (20) | No Nulo |
| Dirección | cadena de caracteres (20) |  |
| Población | cadenade caracteres (20) | Mayuscula Inicial |

### ESCRITORES
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| Cod_Escritor | numérico hasta 3 | Clave Primaria |
| Nombre | cadena de caracteres (15) | No Nulo |
| Pais | cadena de caracteres (20) | Mayúsculas |
| Fecha_Nac | fecha | Entre 1900 y 2020 |

### COMICS
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| Comic | cadena de caracteres (20) | Clave Primaria |
| Cod_Escritor | numérico hasta 3 | Clave Ajena |
| Paginas | numérico hasta 99 | Ha de ser > 0 |
| Categoria | cadena de caracteres (10) | Ha de ser 'Acción', 'Aventura' o 'Terror' |
| Existencias | numérico hasta 10 |  |

### CLIENTES
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| Nif_Cliente | cadena de caracteres (10) | Clave Primaria y debe tener 8 números y una letra mayúsculas |
| Nombre | cadena de caracteres (10) | No Nulo |
| Socio | cadena de caracteres (10) |  |
| Direccion | cadena de caracteres (10) | Mayúsculas |
| Teléfono | numérico hasta 9 | Debe ser un móvil |

### VENTAS
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| ID_Venta | numérico hasta 3 | Clave Primaria |
| Comic | cadena de caracteres (20) | Clave Ajena |
| Nif_Cliente | cadena de caracteres (20) | Clave Ajena |
| Fecha_Venta | fecha | Entre las 10 y las 20 horas |

### TIENDA_COMICS
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| Cif_Tienda | cadena de caracteres (10) | Clave Primaria |
| Comic | cadena de caracteres (20) | Clave Primaria |
| Stock | numérico hasta 3 | Siempre > 1 |

## ENUNCIADOS

1. Añade la columna referencias en la tabla comics, que sea una cadena de 20 caracteres.
2. Eliminar la columna socio de la tabla clientes.
3. Modificar nombre en la tabla escritores aumentando a 20 los caracteres de la cadena.
4. Añadir una restricción a stock en la tabla tienda_comics para que el mínimo sea 2.
5. Eliminar la restricción sobre la columna Obra de la tabla Interpretación.
6. Desactivar la restricción que afecta a País_nacimiento de la tabla Compositores.

## CONSULTAS

1. Muestra los escritores que nacieron antes del año 1965.
2. Muestra el nombre de los cómics cuya categoria sea Aventura.
3. Muestra el nombre del escritor y el comic ordenados por su código.
4. Muestra el país del escritor que haya escrito el comic Wolverine.
5. Crea una tabla llamada IRONMAN con el mismo tipo y tamaño de las ya existentes. Insertar en la tabla el nombre del comic, el número de páginas y el stock mediante una consulta de datos anexados.
6. Actualizar en la tabla clientes que Laura ya no es socio.
7. Borrar el comic 'Daredevil Born Again' de la tabla comics.
8. Muestra el nombre del comic siendo el numero de paginas como mínimo 20 y como máximo 38.
9. Consulta el nombre de un comic con su categoria y los nombres de los comics con su stock.
10. Muestra el comic de Antonio cuyo id de venta pertenezca a la direccion C.Altraz


