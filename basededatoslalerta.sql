-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-12-2024 a las 02:38:13
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `alertaconcagua_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alertas`
--

CREATE TABLE `alertas` (
  `id_alerta` int(11) NOT NULL,
  `latitud` float NOT NULL,
  `longitud` float NOT NULL,
  `latitud_original` float DEFAULT NULL,
  `longitud_original` float DEFAULT NULL,
  `ubicacion` varchar(255) NOT NULL,
  `tipo` enum('fire','rescue','hazmat') NOT NULL,
  `prioridad` enum('high','medium','low') NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `nombre_usuario` varchar(255) NOT NULL,
  `telefono_usuario` varchar(20) NOT NULL,
  `ruta_a_incendio` text DEFAULT NULL,
  `fecha_hora` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alertas`
--

INSERT INTO `alertas` (`id_alerta`, `latitud`, `longitud`, `latitud_original`, `longitud_original`, `ubicacion`, `tipo`, `prioridad`, `descripcion`, `nombre_usuario`, `telefono_usuario`, `ruta_a_incendio`, `fecha_hora`) VALUES
(1, -32.7549, -70.7264, NULL, NULL, 'Chile', 'fire', 'high', 'Ayuda', 'Sebastian', '9304776633', NULL, '2024-11-12 02:06:31'),
(2, -32.7549, -70.7264, NULL, NULL, 'Chile', 'fire', 'high', 'Incendio', 'Carlos', '343455566', NULL, '2024-11-12 02:17:16'),
(3, -32.7516, -70.7264, NULL, NULL, 'Chile', 'rescue', 'high', 'Accidente', 'Marlen', '987877673', NULL, '2024-11-12 14:15:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sesiones`
--

CREATE TABLE `sesiones` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `inicio_sesion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sesiones`
--

INSERT INTO `sesiones` (`id`, `user_id`, `inicio_sesion`) VALUES
(1, 18, '2024-11-12 09:25:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `rol` varchar(20) DEFAULT 'usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `email`, `password`, `telefono`, `rol`) VALUES
(17, 'german', 'german@email.com', '$2y$10$XMmpUBzn9f6J0MSJRv1RPuMT7WskoB6OVNxInPZtZGkF7ephVPPca', '8938273622', 'usuario'),
(18, 'arbolito16', 'arbolito16@email.com', '$2y$10$Qsqd5XC0KeDPN2bw/l90QOgaFE860aXDhnQEQgbXKNF0KwAVEv7BC', '9998887776', 'usuario'),
(19, 'marlen', 'marlen16@emial.com', '$2y$10$1ntcECHfjUgPGIdRIaQYD.AoAVWyciLFi8/CvMAWtjO7mbavrlnGu', '8987778726', 'usuario'),
(20, 'arbolito11', 'arbolito11@gmail.com', '$2y$10$TlbcQF..a3m14a2/0V36Y.aZ36/TTJV2uKz.qS5i06yUmkbiRUub6', '2223334456', 'usuario');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alertas`
--
ALTER TABLE `alertas`
  ADD PRIMARY KEY (`id_alerta`);

--
-- Indices de la tabla `sesiones`
--
ALTER TABLE `sesiones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alertas`
--
ALTER TABLE `alertas`
  MODIFY `id_alerta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `sesiones`
--
ALTER TABLE `sesiones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `sesiones`
--
ALTER TABLE `sesiones`
  ADD CONSTRAINT `sesiones_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
