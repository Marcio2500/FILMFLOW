<?php
session_start();
if (!isset($_SESSION['admin_id'])) {
    header("Location: login.php");
    exit();
}
include_once '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $titulo = trim($_POST['titulo']);
    $desc   = trim($_POST['descricao']);
    $pop    = floatval($_POST['popularidade']);

    $stmt = $conn->prepare("INSERT INTO conteudos (titulo, descricao, popularidade) VALUES (?, ?, ?)");
    $stmt->bind_param("ssd", $titulo, $desc, $pop);

    if ($stmt->execute()) {
        $stmt->close();
        header("Location: index.php");
        exit();
    } else {
        $erro = $stmt->error;
        $stmt->close();
    }
}
?>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>FilmFlow - Adicionar Filme</title>
    <style>
        body { font-family: sans-serif; background: #1a1a1a; color: white; padding: 40px; }
        form { background: #2d2d2d; padding: 20px; border-radius: 8px; max-width: 400px; }
        input, textarea { width: 100%; margin-bottom: 10px; padding: 8px; border-radius: 4px; border: none; box-sizing: border-box; }
        button { background: #e50914; color: white; border: none; padding: 10px; cursor: pointer; width: 100%; border-radius: 4px; }
        .erro { color: #ff6b6b; }
    </style>
</head>
<body>
    <h1>Adicionar Novo Conteúdo</h1>
    <?php if (isset($erro)) echo "<p class='erro'>Erro: $erro</p>"; ?>
    <form method="POST">
        <input type="text"   name="titulo"       placeholder="Título do Filme" required>
        <textarea            name="descricao"    placeholder="Sinopse"></textarea>
        <input type="number" name="popularidade" placeholder="Popularidade (0-10)" step="0.1" min="0" max="10">
        <button type="submit">Guardar no FilmFlow</button>
    </form>
    <br>
    <a href="index.php" style="color: #ccc;">Voltar ao Painel</a>
</body>
</html>
