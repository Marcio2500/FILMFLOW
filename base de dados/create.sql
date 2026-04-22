CREATE TABLE localizacoes (
    id     INT AUTO_INCREMENT PRIMARY KEY,
    pais   VARCHAR(100),
    regiao VARCHAR(100),
    cidade VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE utilizadores (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(255),
    email         VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255),
    criado_em     DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_login  DATETIME
) ENGINE=InnoDB;

CREATE TABLE conteudos (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    titulo        VARCHAR(255) NOT NULL,
    tipo          ENUM('filme', 'serie') DEFAULT 'filme',
    descricao     TEXT,
    ano           INT,
    popularidade  FLOAT DEFAULT 0,
    tendencia_pct FLOAT DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE generos (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE moods (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE conteudo_genero (
    conteudo_id INT,
    genero_id   INT,
    PRIMARY KEY (conteudo_id, genero_id)
) ENGINE=InnoDB;

CREATE TABLE mood_genero (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    mood_id   INT,
    genero_id INT,
    peso      FLOAT
) ENGINE=InnoDB;

CREATE TABLE preferencias_utilizador (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    utilizador_id INT,
    tipo          VARCHAR(50),
    valor         VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE visualizacoes_regiao (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    conteudo_id     INT,
    localizacao_id  INT,
    total_views     INT DEFAULT 0,
    semana          DATE,
    crescimento_pct FLOAT DEFAULT 0,
    UNIQUE KEY unico_conteudo_local_semana (conteudo_id, localizacao_id, semana)
) ENGINE=InnoDB;

CREATE TABLE recomendacoes (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    utilizador_id INT,
    conteudo_id   INT,
    origem        ENUM('algoritmo', 'trending', 'mood'),
    score         FLOAT,
    gerado_em     DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE comparacoes (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    utilizador_id    INT,
    localizacao_a_id INT,
    localizacao_b_id INT,
    criado_em        DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE interacoes_utilizador (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    utilizador_id INT,
    conteudo_id   INT,
    tipo          ENUM('clique', 'view', 'like'),
    avaliacao     TINYINT,
    criado_em     DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
