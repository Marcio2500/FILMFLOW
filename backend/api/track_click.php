<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$conteudo_id    = isset($_POST['conteudo_id'])    ? intval($_POST['conteudo_id'])    : null;
$localizacao_id = isset($_POST['localizacao_id']) ? intval($_POST['localizacao_id']) : null;

if ($conteudo_id && $localizacao_id) {
    $sql = "INSERT INTO visualizacoes_regiao (conteudo_id, localizacao_id, total_views, semana)
            VALUES (?, ?, 1, CURDATE())
            ON DUPLICATE KEY UPDATE total_views = total_views + 1";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $conteudo_id, $localizacao_id);

    if ($stmt->execute()) {
        echo json_encode(["status" => "sucesso", "mensagem" => "Estatística registada"]);
    } else {
        echo json_encode(["status" => "erro", "mensagem" => $stmt->error]);
    }
    $stmt->close();
} else {
    http_response_code(400);
    echo json_encode(["status" => "erro", "mensagem" => "Dados incompletos"]);
}
?>
