<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data) {
    echo json_encode(['erro' => 'Dados inválidos']);
    exit;
}

$nome = $conn->real_escape_string($data['nome']);
$email = $conn->real_escape_string($data['email']);
$senha = password_hash($data['senha'], PASSWORD_DEFAULT);

$sql = "INSERT INTO utilizadores (nome, email, password_hash) VALUES ('$nome', '$email', '$senha')";
if ($conn->query($sql)) {
    echo json_encode(['mensagem' => 'Usuário cadastrado com sucesso!']);
} else {
    echo json_encode(['erro' => 'Erro: ' . $conn->error]);
}
?>