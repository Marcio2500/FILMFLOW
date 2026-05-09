<?php
ini_set('display_errors', '1');
error_reporting(E_ALL);
header('Content-Type: application/json; charset=utf-8');
$info = [
    'pdo_class' => class_exists('PDO'),
    'pdo_mysql' => extension_loaded('pdo_mysql'),
    'mysqli' => extension_loaded('mysqli'),
    'php_version' => phpversion(),
    'loaded_extensions' => get_loaded_extensions(),
];
echo json_encode($info, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
