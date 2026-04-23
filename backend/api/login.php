<?php
header('Content-Type: application/json');
session_start();
include_once '../config/db.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data) {
    echo json_encode(['erro' => 'Dados inválidos']);
    exit;
}

$email = $conn->real_escape_string($data['email']);
$password = $data['password'];

$stmt = $conn->prepare("SELECT id, ut_nome, ut_password FROM utilizador WHERE ut_email = ?");
if ($stmt) {
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();
    $stmt->close();

    if ($user && password_verify($password, $user['ut_password'])) {
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['user_nome'] = $user['ut_nome'];
        echo json_encode(['mensagem' => 'Login bem-sucedido']);
    } else {
        echo json_encode(['erro' => 'Email ou palavra-passe incorretos.']);
    }
} else {
    echo json_encode(['erro' => 'Erro na preparação da consulta']);
}
?>