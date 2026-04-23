<?php
include("conexao.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nome = $conn->real_escape_string($_POST["nome"]);
    $email = $conn->real_escape_string($_POST["email"]);
    $senha = password_hash($_POST["senha"], PASSWORD_DEFAULT);

    $sql = "INSERT INTO utilizador (ut_nome, ut_email, ut_password) VALUES ('$nome', '$email', '$senha')";
    if ($conn->query($sql)) {
        echo "Usuário cadastrado com sucesso!";
    } else {
        echo "Erro: " . $conn->error;
    }
} else {
    echo "Método de requisição inválido. Use POST.";
}
?>