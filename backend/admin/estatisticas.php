<?php
session_start();
if (!isset($_SESSION['admin_id'])) {
    header("Location: login.php");
    exit();
}
include_once '../config/db.php';

$sql = "SELECT c.titulo, l.cidade, l.regiao, SUM(v.total_views) AS total_cliques
        FROM visualizacoes_regiao v
        JOIN conteudos c    ON v.conteudo_id    = c.id
        JOIN localizacoes l ON v.localizacao_id = l.id
        GROUP BY v.conteudo_id, v.localizacao_id
        ORDER BY total_cliques DESC";

$result      = $conn->query($sql);
$total_geral = 0;
?>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>FilmFlow Admin - Estatísticas</title>
    <style>
        body { font-family: sans-serif; background: #1a1a1a; color: white; padding: 30px; }
        .stats-container { max-width: 1000px; margin: auto; background: #2d2d2d; padding: 20px; border-radius: 8px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #444; }
        th { background: #e50914; color: white; }
        .highlight { color: #e50914; font-weight: bold; }
        .back-link { display: inline-block; margin-top: 20px; color: #ccc; text-decoration: none; }
    </style>
</head>
<body>
<div class="stats-container">
    <h1>📊 Análise de Acessos por Região</h1>
    <p>Dados gerados dinamicamente com base nas interações registadas.</p>

    <table>
        <thead>
            <tr>
                <th>Filme (Conteúdo)</th>
                <th>Cidade</th>
                <th>Região</th>
                <th>Total de Visualizações</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($result && $result->num_rows > 0): ?>
                <?php while ($row = $result->fetch_assoc()): $total_geral += $row['total_cliques']; ?>
                <tr>
                    <td><?php echo htmlspecialchars($row['titulo']); ?></td>
                    <td><?php echo htmlspecialchars($row['cidade']); ?></td>
                    <td><?php echo htmlspecialchars($row['regiao']); ?></td>
                    <td class="highlight"><?php echo $row['total_cliques']; ?></td>
                </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr><td colspan="4">Ainda não existem dados de cliques registados.</td></tr>
            <?php endif; ?>
        </tbody>
    </table>

    <div style="margin-top: 20px; padding: 15px; background: #3d3d3d; border-radius: 5px;">
        <strong>Total Global de Interações:</strong> <?php echo $total_geral; ?> cliques.
    </div>

    <a href="index.php" class="back-link">← Voltar ao Painel Principal</a>
</div>
</body>
</html>
