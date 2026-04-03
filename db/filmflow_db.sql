-- Criar a Base de Dados
CREATE DATABASE IF NOT EXISTS filmflow_db;
USE filmflow_db;

-- Tabela de Moods (Emoções)
CREATE TABLE IF NOT EXISTS moods (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Tabela de Conteúdos (Filmes ou Séries)
CREATE TABLE IF NOT EXISTS conteudos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT,
    ano INT,
    popularidade FLOAT DEFAULT 0,
    tendencia_pct FLOAT DEFAULT 0
);

-- Tabela de Géneros
CREATE TABLE IF NOT EXISTS generos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela de Junção (Classifica os Filmes por Género)
CREATE TABLE IF NOT EXISTS conteudo_genero (
    conteudo_id INT,
    genero_id INT,
    PRIMARY KEY (conteudo_id, genero_id),
    FOREIGN KEY (conteudo_id) REFERENCES conteudos(id) ON DELETE CASCADE,
    FOREIGN KEY (genero_id) REFERENCES generos(id) ON DELETE CASCADE
);

-- 
-- É pra inserir dados de teste para o teu Backend já ter o que ler
INSERT INTO moods (nome) VALUES ('Alegre'), ('Triste'), ('Tenso'), ('Épico');

INSERT INTO conteudos (titulo, descricao, ano, popularidade) 
VALUES ('Divertidamente 2', 'Uma viagem pelas emoções.', 2024, 9.5),
       ('Oppenheimer', 'O criador da bomba atómica.', 2023, 8.9);