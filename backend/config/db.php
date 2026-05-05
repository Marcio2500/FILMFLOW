<?php
$host   = "localhost";
$user   = "root";
$pass   = "root";
$dbname = "filmflow_db";

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $user, $pass);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conn->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
} catch (PDOException $e) {
    die(json_encode(["erro" => "Erro de conexão: " . $e->message]));
}
?>
