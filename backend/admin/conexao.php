<?php

$host = "localhost";
$user = "root";
$pass = "";
$dbname = "filmflow_db";

$conn = new mysqli($host, $user, $pass, $dbname);

if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

$conn->set_charset("utf8mb4");
?>