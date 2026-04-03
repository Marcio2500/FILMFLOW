<?php

function calcularTendenciaRegional($conn, $localizacao_id) {
    // Busca visualizações da última semana vs média global
    $sql = "SELECT conteudo_id, total_views, crescimento_pct 
            FROM visualizacoes_regiao 
            WHERE localizacao_id = $localizacao_id";
    
    $result = $conn->query($sql);
    $tendencias = [];

    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            // Algoritmo Simples: Se views > 100 e crescimento > 5%, é tendência
            $score = ($row['total_views'] * 0.4) + ($row['crescimento_pct'] * 0.6);
            $tendencias[] = [
                "conteudo_id" => $row['conteudo_id'],
                "score" => $score
            ];
        }
    }
    
    // Ordena pelo score mais alto
    usort($tendencias, function($a, $b) {
        return $b['score'] <=> $a['score'];
    });

    return $tendencias;
}
?>