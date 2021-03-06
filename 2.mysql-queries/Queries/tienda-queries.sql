USE tienda;
/*1*/SELECT nombre FROM tienda.producto;
/*2*/SELECT nombre, precio FROM tienda.producto;
/*3*/SELECT * FROM tienda.producto;
/*4*/SELECT nombre, precio, precio * 1.21 FROM tienda.producto;
/*5*/SELECT nombre as "nom de producto", precio as euros, precio * 1.21 AS dolars FROM tienda.producto;
/*6*/SELECT UPPER(nombre), precio FROM tienda.producto;
/*7*/SELECT LOWER(nombre), precio FROM tienda.producto;
/*8*/SELECT nombre, LEFT(nombre, 2) FROM tienda.fabricante;
/*9*/SELECT nombre, ROUND(precio) FROM tienda.producto;
/*10*/SELECT nombre, TRUNCATE(precio, 0) FROM tienda.producto;
/*11*/SELECT codigo_fabricante FROM tienda.producto;
/*12*/SELECT DISTINCT codigo_fabricante FROM tienda.producto;
/*13*/SELECT nombre FROM tienda.fabricante ORDER BY nombre;
/*14*/SELECT nombre FROM tienda.fabricante ORDER BY nombre DESC;
/*15*/SELECT nombre FROM tienda.producto ORDER BY nombre, precio DESC;
/*16*/SELECT * FROM tienda.fabricante LIMIT 5;
/*17*/SELECT * FROM tienda.fabricante LIMIT 3, 2;
/*18*/SELECT nombre, precio FROM tienda.producto ORDER BY precio LIMIT 1;
/*19*/SELECT nombre, precio FROM tienda.producto ORDER BY precio DESC LIMIT 1; 
/*20*/SELECT nombre FROM tienda.producto WHERE codigo_fabricante = 2;
/*21*/SELECT p.nombre, p.precio, f.nombre as nombre_fabricante FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo;
/*22*/SELECT p.nombre, p.precio, f.nombre as nombre_fabricante FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;
/*23*/SELECT p.codigo, p.nombre, p.codigo_fabricante, f.nombre as nombre_fabricante FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;
/*24*/SELECT p.nombre, p.precio, f.nombre as nombre_fabricante FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo ORDER BY p.precio LIMIT 1;
/*25*/SELECT p.nombre, p.precio, f.nombre as nombre_fabricante FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo ORDER BY p.precio DESC LIMIT 1;
/*26*/SELECT p.nombre FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Lenovo";
/*27*/SELECT p.nombre FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Crucial" AND p.precio > 200;
/*28*/SELECT p.nombre FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Asus" OR f.nombre = "Hewlett-Packard" OR f.nombre = "Seagate";
/*29*/SELECT p.nombre FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ("Asus", "Hewlett-Packard", "Seagate");
/*30*/SELECT p.nombre, p.precio FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE RIGHT(f.nombre, 1) = "e";
/*31*/SELECT p.nombre, p.precio FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE LOWER(f.nombre) LIKE "%w%";
/*32*/SELECT p.nombre, p.precio, f.nombre as nombre_fabricante FROM tienda.producto as p JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio DESC, p.nombre;
/*33*/SELECT DISTINCT f.codigo, f.nombre as nombre_fabricante FROM tienda.fabricante as f JOIN tienda.producto as p ON p.codigo_fabricante = f.codigo;
/*34*/SELECT f.codigo, f.nombre as nombre_fabricante, p.nombre as nombre_producto FROM tienda.fabricante as f LEFT JOIN tienda.producto as p ON p.codigo_fabricante = f.codigo;
/*35*/SELECT f.codigo, f.nombre as nombre_fabricante, p.nombre as nombre_producto FROM tienda.fabricante as f LEFT JOIN tienda.producto as p ON p.codigo_fabricante = f.codigo WHERE p.nombre IS NULL;
/*36*/SELECT p.nombre FROM tienda.producto as p, tienda.fabricante as f WHERE p.codigo_fabricante = f.codigo AND f.nombre = "Lenovo";
/*37*/SELECT * FROM tienda.producto WHERE precio = (SELECT MAX(precio) FROM tienda.producto p, tienda.fabricante f WHERE p.codigo_fabricante = f.codigo AND f.nombre = "Lenovo");
/*38*/SELECT p.nombre FROM tienda.producto as p JOIN tienda.fabricante as f ON f.codigo = p.codigo_fabricante WHERE f.nombre = "Lenovo" ORDER BY p.precio DESC LIMIT 1;
/*39*/SELECT p.nombre FROM tienda.producto as p JOIN tienda.fabricante as f ON f.codigo = p.codigo_fabricante WHERE f.nombre = "Hewlett-Packard" ORDER BY p.precio LIMIT 1;
/*40*/SELECT nombre FROM tienda.producto WHERE precio >= (SELECT MAX(precio) FROM tienda.producto p, tienda.fabricante f WHERE p.codigo_fabricante = f.codigo AND f.nombre = "Lenovo");
/*41*/SELECT p.nombre FROM tienda.producto as p JOIN tienda.fabricante as f ON f.codigo = p.codigo_fabricante WHERE f.nombre = "Asus" AND p.precio >= (SELECT AVG(p.precio) FROM tienda.producto as p JOIN tienda.fabricante as f ON f.codigo = p.codigo_fabricante WHERE f.nombre = "Asus");