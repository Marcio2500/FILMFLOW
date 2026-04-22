-- Base de Dados FilmFlow
CREATE DATABASE IF NOT EXISTS filmflow_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE filmflow_db;

-- Tabela de Localizações
CREATE TABLE IF NOT EXISTS localizacoes (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    pais    VARCHAR(100),
    regiao  VARCHAR(100),
    cidade  VARCHAR(100)
) ENGINE=InnoDB;

-- Tabela de Utilizadores
CREATE TABLE IF NOT EXISTS utilizadores (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(255),
    email         VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255),
    criado_em     DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_login  DATETIME
) ENGINE=InnoDB;

-- Tabela de Conteúdos (Filmes / Séries)
CREATE TABLE IF NOT EXISTS conteudos (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    titulo        VARCHAR(255) NOT NULL,
    tipo          ENUM('filme', 'serie') DEFAULT 'filme',
    descricao     TEXT,
    ano           INT,
    popularidade  FLOAT DEFAULT 0,
    tendencia_pct FLOAT DEFAULT 0
) ENGINE=InnoDB;

-- Tabela de Géneros
CREATE TABLE IF NOT EXISTS generos (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Tabela de Moods
CREATE TABLE IF NOT EXISTS moods (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Junção Conteúdo <-> Género
CREATE TABLE IF NOT EXISTS conteudo_genero (
    conteudo_id INT,
    genero_id   INT,
    PRIMARY KEY (conteudo_id, genero_id),
    FOREIGN KEY (conteudo_id) REFERENCES conteudos(id) ON DELETE CASCADE,
    FOREIGN KEY (genero_id)   REFERENCES generos(id)   ON DELETE CASCADE
) ENGINE=InnoDB;

-- Junção Mood <-> Género (peso de afinidade)
CREATE TABLE IF NOT EXISTS mood_genero (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    mood_id   INT,
    genero_id INT,
    peso      FLOAT,
    FOREIGN KEY (mood_id)   REFERENCES moods(id)   ON DELETE CASCADE,
    FOREIGN KEY (genero_id) REFERENCES generos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Preferências do Utilizador
CREATE TABLE IF NOT EXISTS preferencias_utilizador (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    utilizador_id INT,
    tipo          VARCHAR(50),
    valor         VARCHAR(100),
    FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Visualizações por Região
CREATE TABLE IF NOT EXISTS visualizacoes_regiao (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    conteudo_id    INT,
    localizacao_id INT,
    total_views    INT DEFAULT 0,
    semana         DATE,
    crescimento_pct FLOAT DEFAULT 0,
    UNIQUE KEY unico_conteudo_local_semana (conteudo_id, localizacao_id, semana),
    FOREIGN KEY (conteudo_id)    REFERENCES conteudos(id)    ON DELETE CASCADE,
    FOREIGN KEY (localizacao_id) REFERENCES localizacoes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Recomendações
CREATE TABLE IF NOT EXISTS recomendacoes (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    utilizador_id INT,
    conteudo_id   INT,
    origem        ENUM('algoritmo', 'trending', 'mood'),
    score         FLOAT,
    gerado_em     DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id) ON DELETE CASCADE,
    FOREIGN KEY (conteudo_id)   REFERENCES conteudos(id)    ON DELETE CASCADE
) ENGINE=InnoDB;

-- Comparações entre Regiões
CREATE TABLE IF NOT EXISTS comparacoes (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    utilizador_id    INT,
    localizacao_a_id INT,
    localizacao_b_id INT,
    criado_em        DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (utilizador_id)    REFERENCES utilizadores(id)  ON DELETE CASCADE,
    FOREIGN KEY (localizacao_a_id) REFERENCES localizacoes(id),
    FOREIGN KEY (localizacao_b_id) REFERENCES localizacoes(id)
) ENGINE=InnoDB;

-- Interações do Utilizador
CREATE TABLE IF NOT EXISTS interacoes_utilizador (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    utilizador_id INT,
    conteudo_id   INT,
    tipo          ENUM('clique', 'view', 'like'),
    avaliacao     TINYINT,
    criado_em     DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id) ON DELETE CASCADE,
    FOREIGN KEY (conteudo_id)   REFERENCES conteudos(id)    ON DELETE CASCADE
) ENGINE=InnoDB;
