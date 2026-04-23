<?php
header('Content-Type: application/json');
include_once '../config/db.php';

$moods = isset($_GET['moods']) ? $_GET['moods'] : '';

if (!$moods) {
    echo json_encode(['filmes' => []]);
    exit;
}

$mood_list = explode(',', $moods);

$placeholders = str_repeat('?,', count($mood_list) - 1) . '?';

$sql = "SELECT c.id, c.titulo, c.descricao, c.ano, c.popularidade,
               GROUP_CONCAT(g.nome SEPARATOR ', ') AS generos
        FROM conteudos c
        JOIN conteudo_genero cg ON cg.conteudo_id = c.id
        JOIN generos g ON g.id = cg.genero_id
        WHERE g.nome IN ($placeholders)
        GROUP BY c.id
        ORDER BY c.popularidade DESC
        LIMIT 20";

$stmt = $conn->prepare($sql);
$stmt->bind_param(str_repeat('s', count($mood_list)), ...$mood_list);
$stmt->execute();
$result = $stmt->get_result();

$filmes = [];
while ($row = $result->fetch_assoc()) {
    $filmes[] = $row;
}

echo json_encode(['filmes' => $filmes]);
?>