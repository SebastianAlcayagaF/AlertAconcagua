<?php
$conexion = new mysqli("localhost", "root", "", "alertaconcagua_db");
if ($conexion->connect_error) {
    die("Conexión fallida: " . $conexion->connect_error);
}

// Creación de la tabla 'alertas' si no existe

$sql_create_table = "CREATE TABLE IF NOT EXISTS alertas (
    id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    latitud FLOAT NOT NULL,
    longitud FLOAT NOT NULL,
    latitud_original FLOAT,
    longitud_original FLOAT,
    ubicacion VARCHAR(255) NOT NULL,
    tipo ENUM('fire', 'rescue', 'hazmat') NOT NULL,
    prioridad ENUM('high', 'medium', 'low') NOT NULL,
    descripcion VARCHAR(255),
    nombre_usuario VARCHAR(255) NOT NULL,
    telefono_usuario VARCHAR(20) NOT NULL,
    ruta_a_incendio TEXT,
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP
)";


if (!$conexion->query($sql_create_table)) {
    die("Error al crear la tabla 'alertas': " . $conexion->error);
}
?>

