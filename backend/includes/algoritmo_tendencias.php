<?php

function calcularTendenciaRegional($conn, $localizacao_id) {
    $sql = "SELECT v.conteudo_id, v.total_views, v.crescimento_pct, c.titulo
            FROM visualizacoes_regiao v
            JOIN conteudos c ON c.id = v.conteudo_id
            WHERE v.localizacao_id = ?";

    $stmt = $conn->prepare($sql);
    $stmt->execute([$localizacao_id]);
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $tendencias = [];

    foreach ($result as $row) {
        $score = ($row['total_views'] * 0.4) + ($row['crescimento_pct'] * 0.6);
        $tendencias[] = [
            "conteudo_id"    => $row['conteudo_id'],
            "titulo"         => $row['titulo'],
            "total_views"    => $row['total_views'],
            "crescimento_pct"=> $row['crescimento_pct'],
            "score"          => round($score, 2)
        ];
    }


    usort($tendencias, function ($a, $b) {
        return $b['score'] <=> $a['score'];
    });

    return $tendencias;
}
?>
