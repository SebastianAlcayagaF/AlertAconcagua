<?php
header("Access-Control-Allow-Origin: *"); // Permitir el acceso desde cualquier origen si se necesita usar desde otro puerto o dominio

// Configuración de la conexión a la base de datos
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "alertaconcagua_db";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Verificar si se recibieron todos los datos requeridos
if (empty($_POST['latitud']) || empty($_POST['longitud']) || empty($_POST['ubicacion']) ||
    empty($_POST['tipo']) || empty($_POST['prioridad']) || empty($_POST['nombre_usuario']) ||
    empty($_POST['telefono_usuario'])) {
    die("Error: Todos los campos obligatorios deben ser completados.");
}

// Validar que la latitud y longitud sean valores numéricos válidos
$latitud = $_POST['latitud'];
$longitud = $_POST['longitud'];
if (!is_numeric($latitud) || !is_numeric($longitud)) {
    die("Error: Latitud y longitud deben ser valores numéricos.");
}

// Recibir y sanitizar los datos del formulario
$ubicacion = htmlspecialchars($_POST['ubicacion']);
$tipo = htmlspecialchars($_POST['tipo']);
$prioridad = htmlspecialchars($_POST['prioridad']);
$descripcion = htmlspecialchars($_POST['descripcion']);
$nombre_usuario = htmlspecialchars($_POST['nombre_usuario']);
$telefono_usuario = htmlspecialchars($_POST['telefono_usuario']);

// Usar una sentencia preparada para insertar los datos en la tabla `alertas`
$stmt = $conn->prepare("INSERT INTO alertas (latitud, longitud, ubicacion, tipo, prioridad, descripcion, nombre_usuario, telefono_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
$stmt->bind_param("ddssssss", $latitud, $longitud, $ubicacion, $tipo, $prioridad, $descripcion, $nombre_usuario, $telefono_usuario);

if ($stmt->execute() === TRUE) {
    echo "Alerta registrada exitosamente.";
} else {
    echo "Error al insertar datos: " . $stmt->error;
}

// Cerrar la sentencia y la conexión
$stmt->close();
$conn->close();
?>
