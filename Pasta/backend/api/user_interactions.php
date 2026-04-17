<?php
header('Content-Type: application/json');
include_once '../config/db.php';

// Pra receber dados do Frontend
$data = json_decode(file_get_contents("php://input"), true);

if (!$data) {
    echo json_encode(["erro" => "Dados inválidos"]);
    exit;
}

$user_id = $data['user_id'];
$conteudo_id = $data['conteudo_id'];
$tipo = $data['tipo']; // 'favorito', 'watchlist', 'historico'
$progresso = $data['progresso'] ?? 0; // Tempo ou % do filme


$sql = "INSERT INTO interacoes (utilizador_id, conteudo_id, tipo, progresso, data_interacao) 
        VALUES ('$user_id', '$conteudo_id', '$tipo', '$progresso', NOW())
        ON DUPLICATE KEY UPDATE progresso = '$progresso', data_interacao = NOW()";

if ($conn->query($sql)) {
    echo json_encode(["status" => "sucesso", "mensagem" => "Interação de $tipo registada"]);
} else {
    echo json_encode(["status" => "erro", "mensagem" => $conn->error]);
}
?>