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
try {
    $stmt = $conn->prepare('SELECT id, nome, password_hash FROM utilizadores WHERE email = ?');
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user) {
        echo json_encode(['erro' => 'Email ou password incorretos']);
        exit;
    }

    if (password_verify($password, $user['password_hash'])) {
        // Atualizar último login
        $stmt_login = $conn->prepare('UPDATE utilizadores SET ultimo_login = CURRENT_TIMESTAMP WHERE id = ?');
        $stmt_login->execute([$user['id']]);

        echo json_encode(['mensagem' => 'Login bem-sucedido', 'nome' => $user['nome']]);
    } else {
        echo json_encode(['erro' => 'Email ou password incorretos']);
    }
} catch (PDOException $e) {
    echo json_encode(['erro' => 'Erro de base de dados: ' . $e->getMessage()]);
}
    $stmt_login->execute();
    $stmt_login->close();
    
    echo json_encode(['mensagem' => 'Login realizado com sucesso', 'id' => $user['id'], 'nome' => $user['nome']]);
} else {
    echo json_encode(['erro' => 'Email ou password incorretos']);
}
?>
