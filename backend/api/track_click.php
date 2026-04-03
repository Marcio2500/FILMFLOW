<?php
header('Content-Type: application/json');
include_once '../config/db.php';

// Aqui recebe o ID do filme e a localização (enviados pelo Frontend)
$conteudo_id = $_POST['conteudo_id'] ?? null;
$localizacao_id = $_POST['localizacao_id'] ?? null;

if ($conteudo_id && $localizacao_id) {
    // Insere o registo na tabela de estatísticas (visualizacoes_regiao) 
    $sql = "INSERT INTO visualizacoes_regiao (conteudo_id, localizacao_id, total_views, semana) 
            VALUES ('$conteudo_id', '$localizacao_id', 1, NOW())
            ON DUPLICATE KEY UPDATE total_views = total_views + 1";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(["status" => "sucesso", "mensagem" => "Estatística registada"]);
    } else {
        echo json_encode(["status" => "erro", "mensagem" => $conn->error]);
    }
} else {
    echo json_encode(["status" => "erro", "mensagem" => "Dados incompletos"]);
}
?>