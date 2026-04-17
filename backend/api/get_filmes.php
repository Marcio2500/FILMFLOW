<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$sql = "SELECT c.id, c.titulo, c.descricao, c.ano, c.popularidade, c.tendencia_pct,
               l.cidade, l.regiao, l.pais,
               v.localizacao_id,
               GROUP_CONCAT(g.nome SEPARATOR ', ') AS generos
        FROM conteudos c
        LEFT JOIN visualizacoes_regiao v ON v.conteudo_id = c.id
        LEFT JOIN localizacoes l ON v.localizacao_id = l.id
        LEFT JOIN conteudo_genero cg ON cg.conteudo_id = c.id
        LEFT JOIN generos g ON g.id = cg.genero_id
        GROUP BY c.id, v.localizacao_id
        ORDER BY c.popularidade DESC";

$result = $conn->query($sql);

$filmes = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $filmes[] = $row;
    }
}

echo json_encode($filmes);
?>
