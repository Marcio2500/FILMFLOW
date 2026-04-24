<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include_once '../config/db.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['email']) || !isset($data['password'])) {
    echo json_encode(['erro' => 'Email e password obrigatórios']);
    exit;
}

$email = trim($data['email']);
$password = $data['password'];

if (empty($email) || empty($password)) {
    echo json_encode(['erro' => 'Email e password obrigatórios']);
    exit;
}

// Usar prepared statements
$stmt = $conn->prepare('SELECT id, nome, password_hash FROM utilizadores WHERE email = ?');
if (!$stmt) {
    echo json_encode(['erro' => 'Erro de preparação: ' . $conn->error]);
    exit;
}

$stmt->bind_param('s', $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo json_encode(['erro' => 'Email ou password incorretos']);
    exit;
}

$user = $result->fetch_assoc();
$stmt->close();

if (password_verify($password, $user['password_hash'])) {
    // Atualizar último login
    $stmt_login = $conn->prepare('UPDATE utilizadores SET ultimo_login = CURRENT_TIMESTAMP WHERE id = ?');
    $stmt_login->bind_param('i', $user['id']);
    $stmt_login->execute();
    $stmt_login->close();
    
    echo json_encode(['mensagem' => 'Login realizado com sucesso', 'id' => $user['id'], 'nome' => $user['nome']]);
} else {
    echo json_encode(['erro' => 'Email ou password incorretos']);
}
?>