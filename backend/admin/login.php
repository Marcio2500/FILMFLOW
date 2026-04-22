<?php
session_start();
include("conexao.php");

$erro = "";
$email = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email    = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($email === '' || $password === '') {
        $erro = "Preencha o email e a palavra-passe.";
    } else {
        $stmt = $mysqli->prepare("SELECT id, nome, ut_password FROM utilizador WHERE ut_email = ?");
        if ($stmt) {
            $stmt->bind_param("s", $email);
            $stmt->execute();
            $result = $stmt->get_result();
            $user   = $result->fetch_assoc();
            $stmt->close();

            if ($user && password_verify($password, $user['ut_password'])) {
                $_SESSION['admin_id']   = $user['id'];
                $_SESSION['admin_nome'] = $user['nome'];
                header("Location: index.php");
                exit();
            }
        }

        if (empty($erro)) {
            $erro = "Email ou palavra-passe incorretos.";
        }
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
        input { width: 100%; margin: 10px 0; padding: 10px; border-radius: 5px; border: none; box-sizing: border-box; }
        button { background: #e50914; color: white; width: 100%; padding: 10px; border: none; cursor: pointer; border-radius: 5px; }
        .erro { color: #ff6b6b; font-size: 14px; }
    </style>
</head>
<body>
    <div class="login-card">
        <h2>FilmFlow Admin</h2>
        <?php if (!empty($erro)) echo "<p class='erro'>" . htmlspecialchars($erro) . "</p>"; ?>
        <form method="POST">
            <input type="email" name="email" placeholder="Email" required value="<?= htmlspecialchars($email) ?>">
            <input type="password" name="password" placeholder="Palavra-passe" required>
            <button type="submit">Entrar</button>
        </form>
    </div>
</body>
</html>
