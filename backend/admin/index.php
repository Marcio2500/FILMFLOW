<?php
session_start();
if (!isset($_SESSION['admin_id'])) {
    header("Location: login.php");
    exit();
}
include("conexao.php");

$sql    = "SELECT id, titulo, popularidade FROM conteudos ORDER BY id DESC";
$result = $mysqli->query($sql);
?>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FilmFlow Admin - Gestão de Conteúdos</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #1a1a1a; color: white; padding: 40px; }
        .container { max-width: 900px; margin: auto; background: #2d2d2d; padding: 20px; border-radius: 10px; }
        h1 { border-bottom: 2px solid #e50914; padding-bottom: 10px; color: #e50914; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { text-align: left; padding: 12px; border-bottom: 1px solid #444; }
        th { background: #3d3d3d; }
        tr:hover { background: #383838; }
        .btn { background: #e50914; color: white; padding: 8px 12px; text-decoration: none; border-radius: 5px; font-size: 14px; }
        .stats-box { display: inline-block; background: #444; padding: 10px 20px; border-radius: 5px; margin-bottom: 20px; }
        .nav-links a { color: #ccc; margin-right: 20px; text-decoration: none; }
    </style>
</head>

<body>
<div class="container">
    <h1>FilmFlow | Backoffice</h1>

    <div class="nav-links" style="margin-bottom: 20px;">
        <a href="adicionar_filme.php">+ Adicionar Filme</a>
        <a href="estatisticas.php">📊 Estatísticas</a>
        <a href="logout.php" style="color:#e50914;">Sair</a>
    </div>

    <div class="stats-box">
        <strong>Total de Filmes:</strong> <?php echo $result ? $result->num_rows : 0; ?>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Título</th>
                <th>Popularidade</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($result && $result->num_rows > 0): ?>
                <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?php echo htmlspecialchars($row['id']); ?></td>
                    <td><?php echo htmlspecialchars($row['titulo']); ?></td>
                    <td>⭐ <?php echo htmlspecialchars($row['popularidade']); ?></td>
                    <td><a href="adicionar_filme.php" class="btn">Editar</a></td>
                </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr><td colspan="4">Nenhum filme encontrado.</td></tr>
            <?php endif; ?>
        </tbody>
    </table>
</div>
</body>
</html>
