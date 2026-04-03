<?php
// Define que o navegador deve ler isto como um ficheiro de dados (JSON)
header('Content-Type: application/json');

$filmes_por_regiao = [
    [
        "id" => 1,
        "titulo" => "Divertidamente 2",
        "cidade" => "Lisboa",
        "lat" => 38.7071, 
        "lng" => -9.1354,
        "mood" => "Alegre",
        "votos" => 150
    ],
    [
        "id" => 2,
        "titulo" => "Oppenheimer",
        "cidade" => "Porto",
        "lat" => 41.1579, 
        "lng" => -8.6291,
        "mood" => "Sério",
        "votos" => 85
    ],
    [
        "id" => 3,
        "titulo" => "Pobres Criaturas",
        "cidade" => "Coimbra",
        "lat" => 40.2033, 
        "lng" => -8.4103,
        "mood" => "Estranho",
        "votos" => 42
    ]
];

// Transforma o array de PHP num formato que o JS do mapa entende :)
echo json_encode($filmes_por_regiao);
?>