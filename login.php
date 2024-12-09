<?php
require_once 'conexion.php';
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $password = $_POST['password'];

    if (empty($username) || empty($password)) {
        echo "<script>alert('Por favor, completa todos los campos.'); window.location.href='index.html';</script>";
        exit();
    }

    $sql = "SELECT * FROM usuarios WHERE username = ?";
    $stmt = $conexion->prepare($sql);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $resultado = $stmt->get_result();

    if ($resultado->num_rows > 0) {
        $usuario = $resultado->fetch_assoc();
        if (password_verify($password, $usuario['password'])) {
            session_start();
            $_SESSION['username'] = $username;
            // Redirigir al sistema de alarma geográfica
            header("Location: sistema_alarma_geografica.html");
            exit();
        } else {
            echo "<script>alert('Contraseña incorrecta.'); window.location.href='index.html';</script>";
        }
    } else {
        echo "<script>alert('Usuario no encontrado. Por favor, regístrate.'); window.location.href='registro.html';</script>";
    }

    $stmt->close();
}
$conexion->close();
?>
