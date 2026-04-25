<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include_once '../config/db.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || empty($data['nome']) || empty($data['email']) || empty($data['senha'])) {
    http_response_code(400);
    echo json_encode(['erro' => 'Dados inválidos ou incompletos'], JSON_UNESCAPED_UNICODE);
    exit;
}

$nome = trim($data['nome']);
$email = trim($data['email']);
$senha = $data['senha'];

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['erro' => 'Email inválido'], JSON_UNESCAPED_UNICODE);
    exit;
}

$checkStmt = $conn->prepare('SELECT id FROM utilizadores WHERE email = ?');
$checkStmt->execute([$email]);

if ($checkStmt->fetch()) {
    http_response_code(409);
    echo json_encode(['erro' => 'Email já registado'], JSON_UNESCAPED_UNICODE);
    exit;
}

$senhaHash = password_hash($senha, PASSWORD_DEFAULT);
$stmt = $conn->prepare('INSERT INTO utilizadores (nome, email, password_hash) VALUES (?, ?, ?)');

if ($stmt->execute([$nome, $email, $senhaHash])) {
    http_response_code(201);
    echo json_encode(['mensagem' => 'Usuário cadastrado com sucesso!'], JSON_UNESCAPED_UNICODE);
} else {
    http_response_code(500);
    echo json_encode(['erro' => 'Erro ao criar conta'], JSON_UNESCAPED_UNICODE);
}

?>