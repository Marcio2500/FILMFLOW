<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['erro' => 'Método não permitido']);
    exit;
}

require_once __DIR__ . '/../config/db.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!is_array($data) || !isset($data['email'], $data['password'])) {
    http_response_code(400);
    echo json_encode(['erro' => 'Email e password obrigatórios']);
    exit;
}

$email = trim((string) ($data['email'] ?? ''));
$password = (string) ($data['password'] ?? '');

if ($email === '' || $password === '') {
    http_response_code(400);
    echo json_encode(['erro' => 'Email e password obrigatórios']);
    exit;
}

try {
    $stmt = $conn->prepare('SELECT id, nome, password_hash FROM utilizadores WHERE email = ?');
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user || !password_verify($password, $user['password_hash'])) {
        http_response_code(401);
        echo json_encode(['erro' => 'Email ou password incorretos']);
        exit;
    }

    $stmt_login = $conn->prepare('UPDATE utilizadores SET ultimo_login = CURRENT_TIMESTAMP WHERE id = ?');
    $stmt_login->execute([$user['id']]);

    echo json_encode(['mensagem' => 'Login bem-sucedido', 'id' => $user['id'], 'nome' => $user['nome']]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['erro' => 'Erro de base de dados: ' . $e->getMessage()]);
    exit;
}
?>
