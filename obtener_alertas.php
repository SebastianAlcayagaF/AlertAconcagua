<?php
include 'conexion.php';

$sql = "SELECT latitud, longitud, ubicacion, tipo, prioridad, descripcion, nombre_usuario, telefono_usuario FROM alertas";
$result = $conexion->query($sql);

$alertas = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $alertas[] = $row;
    }
}

echo json_encode($alertas);

$conexion->close();
?>