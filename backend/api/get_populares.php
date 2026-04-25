<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$sql = "SELECT c.id, c.titulo, c.descricao, c.ano, c.popularidade,
               GROUP_CONCAT(g.nome SEPARATOR ', ') AS generos
        FROM conteudos c
        LEFT JOIN conteudo_genero cg ON cg.conteudo_id = c.id
        LEFT JOIN generos g ON g.id = cg.genero_id
        GROUP BY c.id
        ORDER BY c.popularidade DESC
        LIMIT 20";

$stmt = $conn->query($sql);
$filmes = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(['filmes' => $filmes], JSON_UNESCAPED_UNICODE);
?>