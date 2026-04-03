<?php
$host = "localhost";
$user = "root";       // Utilizador padrão do XAMPP
$pass = "";           // Senha padrão do XAMPP (vazio)
$dbname = "filmflow_db"; 

// Cria a conexão
$conn = new mysqli($host, $user, $pass, $dbname);

// Verifica se houve erro na conexão
if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

// Configurei para aceitar caracteres especiais (como acentos)
$conn->set_charset("utf8mb4á");
?>