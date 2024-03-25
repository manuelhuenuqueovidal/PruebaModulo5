-- Creación base de datos preguntas y respuestas.

CREATE DATABASE prueba_preguntas_respuestas;

-- Conexión a base de datos.

\c prueba_preguntas_respuestas;

-- Creación de entidades.

CREATE TABLE
    preguntas (
        id serial PRIMARY KEY,
        pregunta VARCHAR(255),
        respuesta_correcta VARCHAR
    );

CREATE TABLE
    usuarios (
        id serial PRIMARY KEY,
        nombre VARCHAR(255),
        edad INTEGER
    );

CREATE TABLE
    respuestas (
        id serial PRIMARY KEY,
        respuesta VARCHAR(255),
        usuario_id INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
        pregunta_id INTEGER REFERENCES preguntas(id)
    );

-- Agregar contenido a entidades. 

-- Entidad preguntas.

INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES
    ('pregunta1', 'respuesta_correcta_pregunta1'),
    ('pregunta2','respuesta_correcta_pregunta2'),
    ('pregunta3','respuesta_correcta_pregunta3'),
    ('pregunta4','respuesta_correcta_pregunta4'),
    ('pregunta5','respuesta_correcta_pregunta5');

-- Entidad usuarios.

INSERT INTO usuarios (nombre, edad) VALUES
    ('usuario1', 15),
    ('usuario2', 30),
    ('usuario3', 40),
    ('usuario4', 50),
    ('usuario5', 25);

--Entidad respuestas.

INSERT INTO
    respuestas (respuesta, usuario_id, pregunta_id) VALUES
    ('respuesta_incorrecta_pregunta1', 1, 1),
    ('respuesta_correcta_pregunta1', 2, 1),
    ('respuesta_correcta_pregunta1', 3, 1),
    ('respuesta_incorrecta_pregunta1', 4, 1),
    ('respuesta_incorrecta_pregunta1', 5, 1),
    ('respuesta_correcta_pregunta2', 1, 2),
    ('respuesta_incorrecta_pregunta2', 2, 2),
    ('respuesta_incorrecta_pregunta2', 3, 2),
    ('respuesta_incorrecta_pregunta2', 4, 2),
    ('respuesta_incorrecta_pregunta2', 5, 2 ),
    ('respuesta_correcta_pregunta3', 1, 3),
    ('respuesta_correcta_pregunta3', 2, 3),
    ('respuesta_correcta_pregunta3', 3, 3),
    ('respuesta_incorrecta_pregunta3', 4, 3),
    ('respuesta_incorrecta_pregunta3', 5, 3),
    ('respuesta_correcta_pregunta4', 1, 4),
    ('respuesta_correcta_pregunta4', 2, 4),
    ('respuesta_incorrecta_pregunta4', 3, 4),
    ('respuesta_correcta_pregunta4', 4, 4),
    ('respuesta_correcta_pregunta4', 5, 4),
    ('respuesta_correcta_pregunta5', 1, 5),
    ('respuesta_incorrecta_pregunta5', 2, 5),
    ('respuesta_correcta_pregunta5', 3, 5),
    ('respuesta_correcta_pregunta5', 4, 5),
    ('respuesta_correcta_pregunta5', 5, 5);

-- Comando para saber cantidad de respuestas correctas por usuario (punto 6).

SELECT u.nombre AS nombre_usuario,
 COUNT(CASE WHEN r.respuesta = p.respuesta_correcta THEN 1 END) AS respuestas_correctas
FROM respuestas r
JOIN preguntas p ON r.pregunta_id = p.id
JOIN usuarios u ON r.usuario_id = u.id
GROUP BY u.nombre;

-- Comando para saber cuántos usuarios tuvieron la respuesta correcta en la tabla preguntas (punto 7).

SELECT 
    p.pregunta AS pregunta,
    COUNT(CASE WHEN r.respuesta = p.respuesta_correcta THEN 1 END) AS usuarios_respuesta_correcta
FROM 
    preguntas p
JOIN 
    respuestas r ON p.id = r.pregunta_id
GROUP BY 
    p.pregunta;

-- Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementación (punto 8).
-- Al crear la tabla, ya implementé en borrado en cascada.

DELETE FROM usuarios WHERE id = 1;

-- Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos (punto 9).

 ALTER TABLE usuarios ADD CONSTRAINT ck_edad CHECK (edad >= 18);

    -- Chequeo.
    INSERT INTO usuarios (nombre, edad) VALUES
    ('usuario20', 12);

-- Comando para agregar columna email a usuarios con restricción único (punto 10).

ALTER TABLE usuarios ADD COLUMN email VARCHAR(255) UNIQUE;

    -- Chequeo.
    INSERT INTO usuarios (email) VALUES
    ('ejemplo@prueba.com'),
    ('ejemplo@prueba.com');