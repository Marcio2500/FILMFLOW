<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$loc_id = isset($_GET['loc']) ? intval($_GET['loc']) : 1;

$sql = "SELECT c.id, c.titulo, c.ano, c.popularidade, c.tendencia_pct,
               l.cidade, l.regiao,
               v.total_views
        FROM conteudos c
        JOIN visualizacoes_regiao v ON v.conteudo_id = c.id
        JOIN localizacoes l ON v.localizacao_id = l.id
        WHERE v.localizacao_id = ?
        ORDER BY v.total_views DESC
        LIMIT 10";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $loc_id);
$stmt->execute();
$result = $stmt->get_result();

$tendencias = [];
while ($row = $result->fetch_assoc()) {
    $tendencias[] = $row;
}

echo json_encode(['tendencias' => $tendencias]);
?>