USE libreria_cf;
-- Obtener a todos los usuarios que han realizado un préstamo en los últimos diez días

SELECT CONCAT(us.nombre, ' ', us.apellidos) AS usuarios_prestamos, COUNT(us.usuario_id) AS total_prestamos FROM usuarios AS us
INNER JOIN libros_usuarios AS l_u
  ON us.usuario_id = l_u.usuario_id
  AND l_u.fecha_creacion >= CURDATE() - INTERVAL 10 DAY
GROUP BY us.usuario_id;


-- Obtener a todos los usuarios que no ha realizado ningún préstamo.
SELECT CONCAT(us.nombre, ' ', us.apellidos) AS usuarios_sin_prestamos
FROM usuarios AS us
LEFT JOIN libros_usuarios AS l_u
  ON us.usuario_id = l_u.usuario_id
  WHERE l_u.libro_id IS NULL;


  -- Listar de forma descendente a los cinco usuarios con más préstamos.
SELECT COUNT(l_u.usuario_id) AS prestamos, us.nombre FROM usuarios AS us
INNER JOIN libros_usuarios AS l_u  ON us.usuario_id = l_u.usuario_id
GROUP BY us.usuario_id ORDER BY prestamos DESC LIMIT 5;


-- Listar 5 títulos con más préstamos en los últimos 30 días.
SELECT COUNT(l_u.libro_id) AS prestamos, li.titulo FROM libros AS li
INNER JOIN libros_usuarios AS l_u ON li.libro_id = l_u.libro_id
      AND l_u.fecha_creacion >= CURDATE() - INTERVAL 30 DAY
GROUP BY li.titulo
ORDER BY prestamos DESC LIMIT 5;


-- Obtener el título de todos los libros que no han sido prestados.
SELECT li.titulo FROM libros AS li
LEFT JOIN libros_usuarios AS l_u ON li.libro_id = l_u.libro_id
WHERE l_u.libro_id IS NULL;


-- Obtener la cantidad de libros prestados el día de hoy. 
SELECT COUNT(libro_id) AS prestamos FROM libros_usuarios
WHERE DATE(fecha_creacion) = CURDATE();


-- Obtener la cantidad de libros prestados por el autor con id 1.
SELECT COUNT(l_u.libro_id) AS prestamos FROM libros_usuarios AS l_u
INNER JOIN autores AS au ON au.autor_id = l_u.usuario_id
WHERE DATE(l_u.fecha_creacion) = CURDATE() 
AND au.autor_id = 1;


-- Obtener el nombre completo de los cinco autores con más préstamos

SELECT CONCAT(au.nombre, ' ', au.apellido) AS nombre, COUNT(l_u.libro_id) AS prestamos FROM autores AS au 
INNER JOIN libros AS li ON li.libro_id = au.autor_id
INNER JOIN libros_usuarios AS l_u ON l_u.libro_id = li.libro_id
GROUP BY l_u.libro_id
ORDER BY prestamos DESC LIMIT 5;


-- Obtener el título del libro con más préstamos esta semana
SELECT li.titulo, COUNT(l_u.libro_id) AS prestamos FROM libros AS li
INNER JOIN libros_usuarios AS l_u ON l_u.libro_id = li.libro_id
                          AND DATE(l_u.fecha_creacion) >= CURDATE() - INTERVAL 7 DAY
GROUP BY li.titulo
ORDER BY prestamos DESC LIMIT 1;
