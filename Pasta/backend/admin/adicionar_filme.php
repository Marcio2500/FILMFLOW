<?php
include_once '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $titulo = $_POST['titulo'];
    $desc = $_POST['descricao'];
    $pop = $_POST['popularidade'];

    $sql = "INSERT INTO conteudos (titulo, descricao, popularidade) VALUES ('$titulo', '$desc', '$pop')";
    
    if ($conn->query($sql) === TRUE) {
        header("Location: index.php"); // Volta para a lista após inserir
    } else {
        echo "Erro: " . $conn->error;
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
        input, textarea { width: 100%; margin-bottom: 10px; padding: 8px; border-radius: 4px; border: none; }
        button { background: #e50914; color: white; border: none; padding: 10px; cursor: pointer; width: 100%; }
    </style>
</head>
<body>
    <h1>Adicionar Novo Conteúdo</h1>
    <form method="POST">
        <input type="text" name="titulo" placeholder="Título do Filme" required>
        <textarea name="descricao" placeholder="Sinopse"></textarea>
        <input type="number" step="0.1" name="popularidade" placeholder="Popularidade (0-10)">
        <button type="submit">Guardar no FilmFlow</button>
    </form>
    <br>
    <a href="index.php" style="color: #ccc;">Voltar ao Painel</a>
</body>
</html>