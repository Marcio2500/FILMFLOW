<?php
session_start();
include_once '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password']; // No futuro usaremos password_hash

    $sql = "SELECT id, nome FROM utilizadores WHERE email = '$email' AND password_hash = '$password'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        $_SESSION['admin_id'] = $user['id'];
        $_SESSION['admin_nome'] = $user['nome'];
        header("Location: index.php");
    } else {
        $erro = "Credenciais inválidas!";
    }
}
?>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>FilmFlow - Login Admin</title>
    <style>
        body { font-family: sans-serif; background: #1a1a1a; color: white; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-card { background: #2d2d2d; padding: 30px; border-radius: 10px; width: 300px; text-align: center; }
        input { width: 100%; margin: 10px 0; padding: 10px; border-radius: 5px; border: none; }
        button { background: #e50914; color: white; width: 100%; padding: 10px; border: none; cursor: pointer; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="login-card">
        <h2>FilmFlow Admin</h2>
        <?php if(isset($erro)) echo "<p style='color:red'>$erro</p>"; ?>
        <form method="POST">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Palavra-passe" required>
            <button type="submit">Entrar</button>
        </form>
    </div>
</body>
</html>