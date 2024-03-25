-- Creación de base de datos: modelo de películas.

CREATE DATABASE prueba_peliculas;

-- Conexión a base de datos.

\c prueba_peliculas;

-- Creación de entidades.

CREATE TABLE
    peliculas (
        id SERIAL PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL,
        anno INT NOT NULL
    );

CREATE TABLE
    tags (
        id SERIAL PRIMARY KEY,
        tag VARCHAR(50) NOT NULL
    );

CREATE TABLE
    conectora (
        id SERIAL PRIMARY KEY,
        peliculas_id INT REFERENCES peliculas(id),
        tags_id INT REFERENCES tags(id)
    );

-- Agregar contenido a entidades. 

-- Entidad películas.

INSERT INTO peliculas (nombre, anno) VALUES
    ('peli1', 2011),
    ('peli2', 2012),
    ('peli3', 2013),
    ('peli4', 2014),
    ('peli5', 2015);

-- Entidad tags.

INSERT INTO tags (tag) VALUES
    ('Misterio'),
    ('Ciencia ficción'),
    ('Cine chileno'),
    ('Comedia'),
    ('Drama');

-- Entidad conectora.

INSERT INTO conectora (peliculas_id, tags_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 4),
    (2, 5),
    (3, NULL),
    (4, NULL),
    (5, NULL);

-- Chequeo tags por peliculas 1 y 2 (punto 2).

    select * from conectora;

  -- Comando para mostrar buscar primera películas con 3 tags y segunda con 2, pero mostrando tags(género), (punto 2). 

SELECT p.nombre AS nombre_pelicula, t.tag AS nombre_tag FROM peliculas p
INNER JOIN conectora c ON p.id = c.peliculas_id
INNER JOIN tags t ON c.tags_id = t.id
ORDER BY p.id;

-- Mostrar cantidad de tags por película (punto 3).

SELECT p.nombre AS nombre_pelicula, COUNT(t.id) AS cantidad_tags FROM peliculas p
LEFT JOIN conectora c ON p.id = c.peliculas_id
LEFT JOIN tags t ON c.tags_id = t.id
GROUP BY p.id, p.nombre
ORDER BY p.id;






