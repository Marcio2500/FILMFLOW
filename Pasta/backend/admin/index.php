<?php
session_start();
if (!isset($_SESSION['admin_id'])) {
    header("Location: login.php");
    exit();
}
include_once '../config/db.php';
// ... resto do teu código que já tinhas ...
?>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>FilmFlow Admin - Gestão de Conteúdos</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #1a1a1a; color: white; padding: 40px; }
        .container { max-width: 900px; margin: auto; background: #2d2d2d; padding: 20px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.5); }
        h1 { border-bottom: 2px solid #e50914; padding-bottom: 10px; color: #e50914; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { text-align: left; padding: 12px; border-bottom: 1px solid #444; }
        th { background: #3d3d3d; }
        tr:hover { background: #383838; }
        .btn { background: #e50914; color: white; padding: 8px 12px; text-decoration: none; border-radius: 5px; font-size: 14px; }
        .stats-box { display: inline-block; background: #444; padding: 10px 20px; border-radius: 5px; margin-bottom: 20px; }
    </style>
</head>
<body>

<div class="container">
    <h1>FilmFlow | Backoffice</h1>
    
    <div class="stats-box">
        <strong>Total de Filmes:</strong> <?php echo $result->num_rows; ?>
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
            <?php
            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    echo "<tr>
                            <td>{$row['id']}</td>
                            <td>{$row['titulo']}</td>
                            <td>⭐ {$row['popularidade']}</td>
                            <td><a href='#' class='btn'>Editar</a></td>
                          </tr>";
                }
            } else {
                echo "<tr><td colspan='4'>Nenhum filme encontrado.</td></tr>";
            }
            ?>
        </tbody>
    </table>
</div>

</body>
</html>