CREATE DATABASE ArepasLaBrasita;
GO
USE ArepasLaBrasita;
GO

-- Tabla Usuarios 
CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    Cedula VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    PasswordHash VARCHAR(256) NOT NULL,
    Rol VARCHAR(20) NOT NULL DEFAULT 'repartidor',
    Autorizado BIT NOT NULL DEFAULT 0,
    FechaRegistro DATETIME NOT NULL DEFAULT GETDATE()
);

-- Tabla Productos 
CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto VARCHAR(100) NOT NULL UNIQUE,
    PrecioUnitario DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

-- Tabla Pedidos 
CREATE TABLE Pedidos (
    PedidoID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'pendiente',
    FechaPedido DATETIME NOT NULL DEFAULT GETDATE(),
    FechaCompletado DATETIME NULL,
    CONSTRAINT FK_Pedidos_Usuarios FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- Tabla DetallePedidos 
CREATE TABLE DetallePedidos (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    PedidoID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL DEFAULT 1,
    Color VARCHAR(20) NOT NULL DEFAULT 'blanca',
    CONSTRAINT FK_Detalle_Pedidos FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    CONSTRAINT FK_Detalle_Productos FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- Tabla Notificaciones 
CREATE TABLE Notificaciones (
    NotificacionID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    Mensaje VARCHAR(255) NOT NULL,
    Leida BIT NOT NULL DEFAULT 0,
    FechaNotificacion DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Notificaciones_Usuarios FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- ALTER TABLE Y UPDATE Modificación de la tabla Usuarios para añadir una columna de teléfono de contacto
ALTER TABLE Usuarios
ADD TelefonoContacto VARCHAR(15) NULL;

-- Update Actualizar estado de autorización inicial de la Jefa de producción
UPDATE Usuarios
SET Autorizado = 1
WHERE Rol = 'jefa';
GO

-- Población de Productos 
INSERT INTO Productos (NombreProducto, PrecioUnitario) VALUES
('Tela de 500g', 3500.00),
('Cemitela de 500g', 3800.00),
('Media tela de 500g', 2800.00),
('Max de 600g', 4200.00),
('Ranyer de 650g', 4800.00),
('Arepa Quesuda 400g', 5000.00),
('Arepa Choclo 500g', 4500.00),
('Arepa Delgada x5', 3000.00),
('Arepa Rellena 300g', 4000.00),
('Arepa Integral 500g', 3900.00),
('Arepa Mantequilla x4', 3200.00),
('Arepa Mini x10', 2500.00),
('Arepa Especial 700g', 5500.00),
('Arepa Tradicional 500g', 3000.00),
('Arepa Premium 800g', 6000.00),
('Arepa Queso Doble Cream', 5800.00),
('Arepa Light 400g', 3600.00),
('Arepa Parrillera 600g', 4300.00),
('Arepa Extra Queso x2', 4900.00),
('Arepa Familiar 1000g', 7500.00);

-- Población de Usuarios 
INSERT INTO Usuarios (Cedula, Nombre, PasswordHash, Rol, Autorizado, FechaRegistro, TelefonoContacto) VALUES
('1001001', 'Doña Gloria Jefa', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'jefa', 1, '2025-08-01 08:00:00', '3001234567'),
('1001002', 'Carlos Repartidor', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-01 08:30:00', '3001234568'),
('1001003', 'Andrés López', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-01 09:00:00', '3001234569'),
('1001004', 'Maria Rodriguez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-02 07:15:00', '3001234570'),
('1001005', 'Juan Perez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-02 07:45:00', '3001234571'),
('1001006', 'Luis Gomez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-03 08:00:00', '3001234572'),
('1001007', 'Diana Martinez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-03 08:30:00', '3001234573'),
('1001008', 'Pedro Sanchez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-04 09:10:00', '3001234574'),
('1001009', 'Laura Ramirez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 0, '2025-08-04 10:00:00', '3001234575'),
('1001010', 'Jorge Hernandez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-05 06:30:00', '3001234576'),
('1001011', 'Ana Morales', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-05 07:00:00', '3001234577'),
('1001012', 'Felipe Castro', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 0, '2025-08-05 11:20:00', '3001234578'),
('1001013', 'Claudia Torres', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-06 08:15:00', '3001234579'),
('1001014', 'Gabriel Vargas', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-06 08:45:00', '3001234580'),
('1001015', 'Sofia Diaz', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-07 09:30:00', '3001234581'),
('1001016', 'Mateo Salazar', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 0, '2025-08-07 10:15:00', '3001234582'),
('1001017', 'Valentina Rios', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-08 07:00:00', '3001234583'),
('1001018', 'Daniel Mendoza', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-08 08:20:00', '3001234584'),
('1001019', 'Camila Gutierrez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 0, '2025-08-09 09:00:00', '3001234585'),
('1001020', 'Santiago Ospina', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'repartidor', 1, '2025-08-10 06:45:00', '3001234586');

-- Población de Pedidos 
INSERT INTO Pedidos (UsuarioID, Estado, FechaPedido, FechaCompletado) VALUES
(2, 'listo', '2025-08-05 08:00:00', '2025-08-05 08:30:00'),
(3, 'listo', '2025-08-05 08:15:00', '2025-08-05 08:45:00'),
(4, 'listo', '2025-08-05 09:00:00', '2025-08-05 09:20:00'),
(5, 'listo', '2025-08-06 07:30:00', '2025-08-06 08:00:00'),
(6, 'listo', '2025-08-06 08:00:00', '2025-08-06 08:25:00'),
(7, 'listo', '2025-08-06 08:30:00', '2025-08-06 09:10:00'),
(8, 'listo', '2025-08-07 07:00:00', '2025-08-07 07:40:00'),
(10, 'listo', '2025-08-07 08:00:00', '2025-08-07 08:30:00'),
(11, 'listo', '2025-08-07 09:10:00', '2025-08-07 09:50:00'),
(13, 'listo', '2025-08-08 07:20:00', '2025-08-08 07:50:00'),
(14, 'pendiente', '2025-08-08 08:00:00', NULL),
(15, 'pendiente', '2025-08-08 08:30:00', NULL),
(17, 'pendiente', '2025-08-09 07:15:00', NULL),
(18, 'pendiente', '2025-08-09 08:00:00', NULL),
(20, 'pendiente', '2025-08-09 08:45:00', NULL),
(2, 'pendiente', '2025-08-10 07:00:00', NULL),
(3, 'pendiente', '2025-08-10 07:30:00', NULL),
(4, 'pendiente', '2025-08-10 08:00:00', NULL),
(5, 'pendiente', '2025-08-10 08:30:00', NULL),
(7, 'pendiente', '2025-08-10 09:00:00', NULL);

-- Población de DetallePedidos 
INSERT INTO DetallePedidos (PedidoID, ProductoID, Cantidad, Color) VALUES
(1, 1, 10, 'blanca'),
(1, 2, 5, 'amarilla'),
(2, 3, 12, 'blanca'),
(3, 4, 8, 'amarilla'),
(4, 5, 15, 'blanca'),
(5, 1, 20, 'amarilla'),
(6, 6, 6, 'blanca'),
(7, 7, 10, 'amarilla'),
(8, 8, 25, 'blanca'),
(9, 9, 14, 'amarilla'),
(10, 10, 18, 'blanca'),
(11, 2, 30, 'amarilla'),
(12, 4, 10, 'blanca'),
(13, 11, 8, 'amarilla'),
(14, 12, 16, 'blanca'),
(15, 13, 7, 'amarilla'),
(16, 14, 22, 'blanca'),
(17, 15, 9, 'amarilla'),
(18, 5, 11, 'blanca'),
(19, 3, 13, 'amarilla');

-- Población de Notificaciones 
INSERT INTO Notificaciones (UsuarioID, Mensaje, Leida, FechaNotificacion) VALUES
(2, 'Tu pedido está listo: 10x Tela de 500g', 1, '2025-08-05 08:30:00'),
(3, 'Tu pedido está listo: 12x Media tela de 500g', 1, '2025-08-05 08:45:00'),
(4, 'Tu pedido está listo: 8x Max de 600g', 0, '2025-08-05 09:20:00'),
(5, 'Tu pedido está listo: 15x Ranyer de 650g', 1, '2025-08-06 08:00:00'),
(6, 'Tu pedido está listo: 20x Tela de 500g', 0, '2025-08-06 08:25:00'),
(7, 'Tu pedido está listo: 6x Arepa Quesuda 400g', 1, '2025-08-06 09:10:00'),
(8, 'Tu pedido está listo: 10x Arepa Choclo 500g', 1, '2025-08-07 07:40:00'),
(10, 'Tu pedido está listo: 25x Arepa Delgada x5', 0, '2025-08-07 08:30:00'),
(11, 'Tu pedido está listo: 14x Arepa Rellena 300g', 1, '2025-08-07 09:50:00'),
(13, 'Tu pedido está listo: 18x Arepa Integral 500g', 0, '2025-08-08 07:50:00'),
(2, 'Su cuenta ha sido verificada correctamente', 1, '2025-08-01 08:35:00'),
(3, 'Su cuenta ha sido verificada correctamente', 1, '2025-08-01 09:05:00'),
(4, 'Su cuenta ha sido verificada correctamente', 1, '2025-08-02 07:20:00'),
(5, 'Su cuenta ha sido verificada correctamente', 1, '2025-08-02 07:50:00'),
(6, 'Su cuenta ha sido verificada correctamente', 1, '2025-08-03 08:05:00'),
(7, 'Su cuenta ha sido verificada correctamente', 1, '2025-08-03 08:35:00'),
(8, 'Su cuenta ha sido verificada correctamente', 1, '2025-08-04 09:15:00'),
(10, 'Su cuenta ha sido verificada correctamente', 1, '2025-08-05 06:35:00'),
(11, 'Su cuenta ha sido verificada correctamente', 1, '2025-08-05 07:05:00'),
(13, 'Su cuenta ha sido verificada correctamente', 1, '2025-08-06 08:20:00');
GO

/*
CONSULTA 1 Total recaudado y cantidad de arepas solicitadas por repartidor en pedidos 
completados 
*/
SELECT 
    U.Nombre AS Repartidor,
    U.Cedula,
    COUNT(DISTINCT P.PedidoID) AS TotalPedidosListos,
    SUM(DP.Cantidad) AS TotalArepasPedidas,
    SUM(DP.Cantidad * PR.PrecioUnitario) AS TotalMontoGenerado
FROM Usuarios U
INNER JOIN Pedidos P ON U.UsuarioID = P.UsuarioID
INNER JOIN DetallePedidos DP ON P.PedidoID = DP.PedidoID
INNER JOIN Productos PR ON DP.ProductoID = PR.ProductoID
WHERE P.Estado = 'listo'
GROUP BY U.Nombre, U.Cedula
HAVING SUM(DP.Cantidad * PR.PrecioUnitario) > 50000.00
ORDER BY TotalMontoGenerado DESC;


/*
CONSULTA 2 Promedio del tiempo de atención de pedidos completados por la Jefa
*/
SELECT 
    P.Estado,
    COUNT(P.PedidoID) AS TotalPedidosAtendidos,
    AVG(DATEDIFF(MINUTE, P.FechaPedido, P.FechaCompletado)) AS PromedioMinutosPreparacion
FROM Pedidos P
INNER JOIN Usuarios U ON P.UsuarioID = U.UsuarioID
WHERE P.Estado = 'listo' 
  AND MONTH(P.FechaPedido) = 8 
  AND YEAR(P.FechaPedido) = 2025
GROUP BY P.Estado;


/*
CONSULTA 3 Consolidado de productos preferidos agrupados por tipo y color de arepa
*/
SELECT 
    PR.NombreProducto,
    DP.Color,
    SUM(DP.Cantidad) AS TotalUnidadesVendidas,
    AVG(PR.PrecioUnitario) AS PrecioPromedio
FROM DetallePedidos DP
INNER JOIN Productos PR ON DP.ProductoID = PR.ProductoID
INNER JOIN Pedidos P ON DP.PedidoID = P.PedidoID
WHERE P.Estado = 'listo'
GROUP BY PR.NombreProducto, DP.Color
HAVING SUM(DP.Cantidad) >= 10
ORDER BY TotalUnidadesVendidas DESC;


/*
CONSULTA 4 Estado general de repartidores y 
el número total de notificaciones no leídas que poseen
*/
SELECT 
    U.Nombre AS Repartidor,
    U.Cedula,
    U.Autorizado,
    COUNT(N.NotificacionID) AS NotificacionesSinLeer
FROM Usuarios U
LEFT JOIN Notificaciones N ON U.UsuarioID = N.UsuarioID AND N.Leida = 0
WHERE U.Rol = 'repartidor'
GROUP BY U.Nombre, U.Cedula, U.Autorizado
HAVING COUNT(N.NotificacionID) >= 0
ORDER BY NotificacionesSinLeer DESC;


/*
CONSULTA 5 Reporte diario de pedidos recibidos versus 
valorización estimada en cola de espera 
*/
SELECT 
    CAST(P.FechaPedido AS DATE) AS Fecha,
    COUNT(DISTINCT P.PedidoID) AS TotalPedidosPendientes,
    SUM(DP.Cantidad) AS TotalArepasPorHacer,
    SUM(DP.Cantidad * PR.PrecioUnitario) AS ValorTotalPendiente
FROM Pedidos P
INNER JOIN DetallePedidos DP ON P.PedidoID = DP.PedidoID
INNER JOIN Productos PR ON DP.ProductoID = PR.ProductoID
WHERE P.Estado = 'pendiente'
  AND P.FechaPedido >= '2025-08-01' 
  AND P.FechaPedido <= '2025-08-31'
GROUP BY CAST(P.FechaPedido AS DATE)
HAVING SUM(DP.Cantidad) > 5
ORDER BY Fecha ASC;