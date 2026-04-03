<?php
header('Content-Type: application/json');
include_once '../config/db.php';
include_once '../includes/algoritmo_tendencias.php';

$loc_id = isset($_GET['loc']) ? intval($_GET['loc']) : 1;

$dados = calcularTendencias($conn, $loc_id);

echo json_encode([
    "regiao_id" => $loc_id,
    "tendencias" => $dados
]);
?>