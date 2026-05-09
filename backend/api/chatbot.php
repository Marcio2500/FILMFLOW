<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);
$messages = $data['messages'] ?? [];

$payload = [
    'model' => 'claude-sonnet-4-20250514',
    'max_tokens' => 1000,
    'system' => 'És o Flow Bot, um assistente de descoberta de filmes da plataforma Filmflow — uma app que mostra tendências de filmes em Portugal por cidade e mood. O teu objetivo é perceber o mood do utilizador e sugerir filmes/séries populares em Portugal. Regras: Responde sempre em português de Portugal. Sê informal, simpático e conciso. Sugere sempre 2-3 filmes/séries concretos com o nome, género e ano. Usa emojis com moderação. Mantém respostas curtas (máximo 3-4 linhas).',
    'messages' => $messages
];

$ch = curl_init('https://api.anthropic.com/v1/messages');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Content-Type: application/json',
    'x-api-key: SUA_CHAVE_API_CLAUDE_AQUI',
    'anthropic-version: 2023-06-01'
]);

$response = curl_exec($ch);
curl_close($ch);

echo $response;
?>