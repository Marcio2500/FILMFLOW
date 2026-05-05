<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=utf-8');

function responder(int $status, array $payload): void
{
    http_response_code($status);
    echo json_encode($payload, JSON_UNESCAPED_UNICODE);
    exit;
}

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'OPTIONS') {
    http_response_code(204);
    exit;
}

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    responder(405, ['erro' => 'Método não permitido']);
}

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

try {
    require_once __DIR__ . '/../config/db.php';

    $rawBody = file_get_contents('php://input');
    $data = json_decode($rawBody, true);

    if (!is_array($data) || !isset($data['nome'], $data['email'], $data['senha'])) {
        responder(400, ['erro' => 'Dados inválidos']);
    }

    $nome = trim((string) $data['nome']);
    $email = trim((string) $data['email']);
    $senha = (string) $data['senha'];

    if ($nome === '' || $email === '' || $senha === '') {
        responder(400, ['erro' => 'Todos os campos são obrigatórios']);
    }

    if (strlen($senha) < 6) {
        responder(400, ['erro' => 'Password deve ter pelo menos 6 caracteres']);
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        responder(400, ['erro' => 'Email inválido']);
    }

    $senha_hash = password_hash($senha, PASSWORD_DEFAULT);

    try {
        $stmt = $conn->prepare('INSERT INTO utilizadores (nome, email, password_hash) VALUES (?, ?, ?)');
        $stmt->execute([$nome, $email, $senha_hash]);
        $utilizador_id = $conn->lastInsertId();

        if (isset($data['preferencias']) && is_array($data['preferencias']) && count($data['preferencias']) > 0) {
            $stmt_pref = $conn->prepare('INSERT INTO preferencias_utilizador (utilizador_id, tipo, valor) VALUES (?, ?, ?)');
            $tipo = 'mood';

            foreach ($data['preferencias'] as $pref) {
                $valor = trim((string) $pref);
                if ($valor === '') {
                    continue;
                }
                $stmt_pref->execute([$utilizador_id, $tipo, $valor]);
            }
        }

        responder(201, ['mensagem' => 'Usuário cadastrado com sucesso!']);
    } catch (PDOException $e) {
        if ($e->getCode() == 23000) { // Duplicate entry
            responder(409, ['erro' => 'Este email já está registado']);
        }
        responder(500, ['erro' => 'Erro de base de dados: ' . $e->getMessage()]);
    }