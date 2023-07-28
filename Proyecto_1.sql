-- Creacion de tablas --

CREATE TABLE `clientes` (
  `ID_Cliente` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Cliente` varchar(255) CHARACTER SET latin1 NOT NULL,
  `Email` varchar(255) CHARACTER SET latin1 NOT NULL,
  `Telefono` varchar(15) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`ID_Cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

CREATE TABLE `detalle_venta` (
  `ID_Detalle` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Venta` int(11) NOT NULL,
  `ID_Producto` int(11) NOT NULL,
  `Cantidad` varchar(45) NOT NULL,
  `Precio_Unitario` decimal(18,0) NOT NULL,
  PRIMARY KEY (`ID_Detalle`),
  KEY `ID_Venta_idx` (`ID_Venta`),
  KEY `ID_Producto_idx` (`ID_Producto`),
  CONSTRAINT `ID_Producto` FOREIGN KEY (`ID_Producto`) REFERENCES `productos` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ID_Venta` FOREIGN KEY (`ID_Venta`) REFERENCES `ventas` (`ID_Ventas`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

CREATE TABLE `empleados` (
  `ID_Empleado` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Empleado` varchar(255) NOT NULL,
  `Empresa` varchar(255) DEFAULT NULL,
  `Fecha_Contratación` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_Empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=902 DEFAULT CHARSET=latin1;

CREATE TABLE `productos` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Producto` varchar(255) NOT NULL,
  `Precio_Unitario` int(11) NOT NULL,
  `Stock` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9117 DEFAULT CHARSET=latin1;

CREATE TABLE `ventas_2` (
  `ID_Ventas` int(11) NOT NULL,
  `Fecha_Venta` date NOT NULL,
  `ID_Cliente` int(11) NOT NULL,
  `ID_Empleado` int(11) NOT NULL,
  PRIMARY KEY (`ID_Ventas`),
  KEY `ID_Cliente_idx` (`ID_Cliente`),
  KEY `ID_Empleado_idx` (`ID_Empleado`),
  CONSTRAINT `ID_Cliente` FOREIGN KEY (`ID_Cliente`) REFERENCES `clientes` (`ID_Cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ID_Empleado` FOREIGN KEY (`ID_Empleado`) REFERENCES `empleados` (`ID_Empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Funcion LEFT JOIN para analizar el primer ejercicio--

SELECT *
	FROM detalle_venta
	LEFT JOIN ventas_2 ON detalle_venta.ID_Venta = ventas_2.ID_Ventas;
    
    -- Ventas Totales--
    SELECT SUM(Precio_Unitario) AS Total_Precio
	FROM detalle_venta
	INNER JOIN ventas_2 ON detalle_venta.ID_Venta = ventas_2.ID_Ventas;
    
    -- Ventas por Mes --
    SELECT MONTH(Fecha_Venta) AS MES, SUM(Precio_Unitario) AS Total_Precio
	FROM detalle_venta
	INNER JOIN ventas_2 ON detalle_venta.ID_Venta = ventas_2.ID_Ventas
	WHERE MONTH(Fecha_Venta) = 12
	GROUP BY MONTH(Fecha_Venta);
    
    -- Función LEFT y RIGHT para analizar el tercer ejercicio--
    SELECT *
	FROM detalle_venta
   	LEFT JOIN ventas_2 ON detalle_venta.ID_Venta = ventas_2.ID_Ventas
    RIGHT JOIN productos ON detalle_venta.ID_Producto = productos.ID;
    
    -- Productos más vendidos --
    
    SELECT Nombre_Producto, COUNT(Nombre_Producto) AS repeticiones
FROM productos
GROUP BY Nombre_Producto
ORDER BY repeticiones DESC
LIMIT 1;

    -- El menos vendedido --
SELECT Nombre_Producto, COUNT(Nombre_Producto) AS repeticiones
FROM productos
GROUP BY Nombre_Producto
ORDER BY repeticiones ASC
LIMIT 1;    
     
    -- Clientes que mas compran --
   
SELECT *
	FROM ventas_2
	LEFT JOIN clientes ON ventas_2.ID_Cliente = clientes.ID_Cliente;

-- Cantidad de compras --
	SELECT ID_Cliente, COUNT(ID_Cliente) AS repeticiones
FROM ventas_2
GROUP BY ID_Cliente
ORDER BY repeticiones DESC
LIMIT 1;

-- Nombre de cliente que mas compra --
	SELECT ID_Cliente, Nombre_Cliente
FROM clientes
WHERE ID_Cliente = 98
GROUP BY Nombre_Cliente
ORDER BY ID_Cliente DESC
LIMIT 1;

-- Empleado que más vende --
SELECT *
	FROM ventas_2
	LEFT JOIN empleados ON ventas_2.ID_Empleado = empleados.ID_Empleado;

-- Cantidad de ventas --
	SELECT ID_Empleado, COUNT(ID_Empleado) AS repeticiones
FROM ventas_2
GROUP BY ID_Empleado
ORDER BY repeticiones DESC
LIMIT 1;

-- Nombre y ID del empleado
	SELECT ID_Empleado, Nombre_Empleado
FROM empleados
WHERE ID_Empleado = 94
GROUP BY Nombre_Empleado
ORDER BY ID_Empleado DESC
LIMIT 1;