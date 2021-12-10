DROP DATABASE blog;
--  Creando y accesando a la base de datos blog
CREATE DATABASE blog;
\c blog

-- Crear las tablas indicadas de acuerdo al modelo de datos
CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE posts (
    id INT PRIMARY KEY,
    usuario_id INT,
    titulo VARCHAR(255),
    fecha DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE comentarios (
    id INT PRIMARY KEY,
    post_id INT,
    usuario_id INT,
    texto VARCHAR(255),
    fecha DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- Agregar datos de tabla usuarios
INSERT INTO usuarios (id, email) VALUES (1, 'usuario01@hotmail.com');
INSERT INTO usuarios (id, email) VALUES (2, 'usuario02@gmail.com');
INSERT INTO usuarios (id, email) VALUES (3, 'usuario03@gmail.com');
INSERT INTO usuarios (id, email) VALUES (4, 'usuario04@hotmail.com');
INSERT INTO usuarios (id, email) VALUES (5, 'usuario05@yahoo.com');
INSERT INTO usuarios (id, email) VALUES (6, 'usuario06@hotmail.com');
INSERT INTO usuarios (id, email) VALUES (7, 'usuario07@yahoo.com');
INSERT INTO usuarios (id, email) VALUES (8, 'usuario08@yahoo.com');
INSERT INTO usuarios (id, email) VALUES (9, 'usuario09@yahoo.com');

-- Agregando datos a la tabla posts

INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (1, 1, 'Post 1: Esto es malo', '2020-06-29');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (2, 5, 'Post 2: Esto es malo', '2020-06-20');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (3, 1, 'Post 3: Esto es excelente', '2020-05-30');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (4, 9, 'Post 4: Esto es bueno', '2020-05-09');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (5, 7, 'Post 5: Esto es bueno', '2020-07-10');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (6, 5, 'Post 6: Esto es excelente', '2020-07-18');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (7, 8, 'Post 7: Esto es excelente', '2020-07-07');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (8, 5, 'Post 8: Esto es excelente', '2020-05-14');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (9, 2, 'Post 9: Esto es bueno', '2020-05-08');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (10,6, 'Post 10: Esto es bueno', '2020-06-02');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (11,4, 'Post 11: Esto es bueno', '2020-05-05');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (12,9, 'Post 12: Esto es malo', '2020-07-23');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (13,5, 'Post 13: Esto es excelente', '2020-05-30');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (14,8, 'Post 14: Esto es excelente', '2020-05-01');
INSERT INTO posts (id, usuario_id,titulo, fecha) VALUES (15,7, 'Post 15: Esto es malo', '2020-06-17');

-- Agregando datos a la tabla comentarios

INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (1, 3, 6, 'Este es el comentario 1', '2020-07-08');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (2, 4, 2, 'Este es el comentario 2', '2020-06-07');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (3, 6, 4, 'Este es el comentario 3', '2020-06-16');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (4, 2, 13, 'Este es el comentario 4', '2020-06-15');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (5, 6, 6, 'Este es el comentario 5', '2020-05-14');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (6, 3, 3, 'Este es el comentario 6', '2020-07-08');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (7, 6, 1, 'Este es el comentario 7', '2020-05-22');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (8, 6, 7, 'Este es el comentario 8', '2020-07-09');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (9, 8, 13, 'Este es el comentario 9', '2020-06-30');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (10, 8, 6, 'Este es el comentario 10', '2020-06-19');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (11, 5, 1, 'Este es el comentario 11', '2020-05-09');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (12, 8, 15, 'Este es el comentario 12', '2020-06-17');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (13, 1, 9, 'Este es el comentario 13', '2020-05-01');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (14, 2, 5, 'Este es el comentario 14', '2020-05-31');
INSERT INTO comentarios (id, usuario_id, post_id, texto, fecha) VALUES (15, 4, 3, 'Este es el comentario 15', '2020-06-28');

-- Seleccionar el correo, id y título de todos los posts publicados por el usuario 5.
\echo 'TODOS LOS POSTS PUBLICADOS POR EL USUARIO 5'
SELECT posts.id, usuarios.email, posts.titulo
FROM posts INNER JOIN usuarios ON usuarios.id = posts.usuario_id
WHERE usuarios.id = 5;

-- Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.
\echo 'TODOS LOS COMENTARIOS, EXCEPTO LOS DEL USUARIO06'
SELECT usuarios.id, usuarios.email, comentarios.texto
FROM comentarios LEFT JOIN usuarios ON usuarios.id = comentarios.usuario_id
WHERE usuarios.id != 6
ORDER BY usuarios.id;

-- Listar los usuarios que no han publicado ningún post.
\echo 'USUARIOS QUE NO HAN PUBLICADO POSTS'
SELECT usuarios.* FROM usuarios
LEFT JOIN posts ON posts.usuario_id = usuarios.id
WHERE posts.usuario_id IS NULL;


-- Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios)
\echo 'TODOS LOS POSTS PUBLICADOS POR LOS USUARIOS, INCLUYENDO A QUIENES NO TIENEN COMENTARIOS'
SELECT * FROM posts FULL OUTER JOIN comentarios ON comentarios.post_id = posts.id
ORDER BY posts.id;

-- Listar todos los usuarios que hayan publicado un post en Junio.
\echo 'TODOS LOS USUARIOS QUE PUBLICARON EN EL MES DE JUNIO'
SELECT * FROM usuarios
INNER JOIN posts ON posts.usuario_id = usuarios.id
WHERE posts.fecha BETWEEN '2020-06-01' AND '2020-06-30'
ORDER BY posts.fecha;