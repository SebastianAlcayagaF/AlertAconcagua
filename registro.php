<?php
require_once 'conexion.php';
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $email = $_POST['email'];
    $telefono = $_POST['telefono'];
    

    // Verificar si el usuario ya existe
    $sql_check = "SELECT * FROM usuarios WHERE username = ? OR email = ?";
    $stmt_check = $conexion->prepare($sql_check);
    $stmt_check->bind_param("ss", $username, $email);
    $stmt_check->execute();
    $resultado_check = $stmt_check->get_result();

    if ($resultado_check->num_rows > 0) {
        echo "<script>alert('El usuario o correo ya está registrado. Por favor, inicia sesión.'); window.location.href='index.html';</script>";
    } else {
        $sql = "INSERT INTO usuarios (username, email, password, telefono) VALUES (?, ?, ?, ?)";
        $stmt = $conexion->prepare($sql);
        if ($stmt) {
            $stmt->bind_param("ssss", $username, $email, $password, $telefono);

            if ($stmt->execute()) {
                session_start();
                $_SESSION['username'] = $username;
                echo "<script>alert('Registro exitoso. Redirigiendo al sistema de alarma geográfica.'); window.location.href='sistema_alarma_geografica.html';</script>";
            } else {
                echo "Error al ejecutar la consulta de inserción: " . $stmt->error;
            }

            $stmt->close();
        } else {
            echo "Error en la preparación de la consulta: " . $conexion->error;
        }
    }

    $stmt_check->close();
}
$conexion->close();
?>
