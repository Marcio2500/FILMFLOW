-- =====================================================
-- FilmFlow — Dados de Teste Completos
-- =====================================================
USE filmflow_db;

-- -------------------------------------------------------
-- 1. LOCALIZAÇÕES (estende as 4 existentes)
-- -------------------------------------------------------
INSERT INTO localizacoes (pais, regiao, cidade) VALUES
    ('Portugal', 'Alentejo',  'Évora'),
    ('Portugal', 'Açores',    'Ponta Delgada'),
    ('Brasil',   'Sudeste',   'São Paulo'),
    ('Brasil',   'Nordeste',  'Salvador'),
    ('Espanha',  'Catalunha', 'Barcelona'),
    ('França',   'Île-de-France', 'Paris');

-- -------------------------------------------------------
-- 2. GÉNEROS (estende os 5 existentes)
-- -------------------------------------------------------
INSERT INTO generos (nome) VALUES
    ('Ficção Científica'),  -- id 6
    ('Terror'),             -- id 7
    ('Animação'),           -- id 8
    ('Documentário'),       -- id 9
    ('Aventura');           -- id 10

-- -------------------------------------------------------
-- 3. MOODS (estende os 4 existentes)
-- -------------------------------------------------------
INSERT INTO moods (nome) VALUES
    ('Relaxado'),    -- id 5
    ('Curioso'),     -- id 6
    ('Nostálgico'),  -- id 7
    ('Assustado');   -- id 8

-- -------------------------------------------------------
-- 4. MOOD <-> GÉNERO (pesos de afinidade)
-- -------------------------------------------------------
INSERT INTO mood_genero (mood_id, genero_id, peso) VALUES
    -- Alegre (1)
    (1, 1, 0.9),  -- Comédia
    (1, 8, 0.8),  -- Animação
    (1, 5, 0.6),  -- Romance
    -- Triste (2)
    (2, 2, 0.9),  -- Drama
    (2, 5, 0.7),  -- Romance
    (2, 9, 0.5),  -- Documentário
    -- Tenso (3)
    (3, 3, 0.95), -- Thriller
    (3, 7, 0.8),  -- Terror
    (3, 4, 0.6),  -- Ação
    -- Épico (4)
    (4, 4, 0.95), -- Ação
    (4, 10, 0.8), -- Aventura
    (4, 6, 0.7),  -- Ficção Científica
    -- Relaxado (5)
    (5, 1, 0.7),  -- Comédia
    (5, 9, 0.8),  -- Documentário
    (5, 8, 0.6),  -- Animação
    -- Curioso (6)
    (6, 9, 0.9),  -- Documentário
    (6, 6, 0.8),  -- Ficção Científica
    (6, 2, 0.5),  -- Drama
    -- Nostálgico (7)
    (7, 2, 0.8),  -- Drama
    (7, 5, 0.7),  -- Romance
    (7, 1, 0.6),  -- Comédia
    -- Assustado (8)
    (8, 7, 0.95), -- Terror
    (8, 3, 0.7),  -- Thriller
    (8, 6, 0.4);  -- Ficção Científica

-- -------------------------------------------------------
-- 5. CONTEÚDOS (estende os 3 existentes)
-- -------------------------------------------------------
INSERT INTO conteudos (titulo, tipo, descricao, ano, popularidade, tendencia_pct) VALUES
    ('Dune: Parte II',           'filme', 'A jornada épica de Paul Atreides continua no deserto de Arrakis.', 2024, 9.1, 29.0),
    ('Alien: Romulus',           'filme', 'Um grupo de jovens colonizadores enfrenta a forma mais aterradora da galáxia.', 2024, 7.8, 18.5),
    ('Deadpool & Wolverine',     'filme', 'Dois anti-heróis improváveis unem forças no multiverso Marvel.', 2024, 9.3, 38.0),
    ('A Substância',             'filme', 'Um thriller de corpo-horror sobre obsessão com a juventude eterna.', 2024, 8.0, 22.0),
    ('Conclave',                 'filme', 'Drama político e espiritual em torno da eleição de um novo papa.', 2024, 8.4, 19.0),
    ('Anora',                    'filme', 'Uma dançarina de Nova Iorque casa com o filho de um oligarca russo.', 2024, 8.5, 16.0),
    ('Beetlejuice Beetlejuice',  'filme', 'O fantasma mais irreverente regressa décadas depois.', 2024, 7.6, 15.0),
    ('Wicked',                   'filme', 'A história das bruxas de Oz antes de Dorothy chegar.', 2024, 8.7, 31.0),
    ('The Bear',                 'serie', 'Um chef de alto nível tenta salvar o restaurante da sua família em Chicago.', 2022, 9.4, 41.0),
    ('Silo',                     'serie', 'Num futuro distópico, a humanidade vive num silo subterrâneo.', 2023, 8.6, 25.0),
    ('Shogun',                   'serie', 'Um navegador inglês preso no Japão feudal torna-se aprendiz de samurai.', 2024, 9.2, 37.0),
    ('The Last of Us S2',        'serie', 'Joel e Ellie navegam um mundo pós-apocalíptico repleto de perigos.', 2025, 9.5, 45.0),
    ('Severance S2',             'serie', 'Os funcionários da Lumon Industries investigam os segredos da empresa.', 2025, 9.3, 43.0),
    ('Adolescence',              'serie', 'Drama britânico sobre um adolescente acusado de um crime brutal.', 2025, 9.6, 50.0),
    ('Black Mirror S7',          'serie', 'Antologia de tecnologia e consequências imprevistas.', 2025, 8.5, 20.0);

-- -------------------------------------------------------
-- 6. CONTEÚDO <-> GÉNERO
-- -------------------------------------------------------
INSERT INTO conteudo_genero (conteudo_id, genero_id) VALUES
    -- Divertidamente 2 (1)
    (1, 8), (1, 1),
    -- Oppenheimer (2)
    (2, 2), (2, 9),
    -- Pobres Criaturas (3)
    (3, 2), (3, 1),
    -- Dune: Parte II (4)
    (4, 6), (4, 4), (4, 10),
    -- Alien: Romulus (5)
    (5, 7), (5, 6),
    -- Deadpool & Wolverine (6)
    (6, 4), (6, 1),
    -- A Substância (7)
    (7, 7), (7, 3),
    -- Conclave (8)
    (8, 2), (8, 3),
    -- Anora (9)
    (9, 2), (9, 5),
    -- Beetlejuice Beetlejuice (10)
    (10, 1), (10, 7),
    -- Wicked (11)
    (11, 8), (11, 5),
    -- The Bear (12)
    (12, 2),
    -- Silo (13)
    (13, 6), (13, 3),
    -- Shogun (14)
    (14, 2), (14, 10), (14, 4),
    -- The Last of Us S2 (15)
    (15, 4), (15, 6), (15, 3),
    -- Severance S2 (16)
    (16, 3), (16, 6),
    -- Adolescence (17)
    (17, 2), (17, 3),
    -- Black Mirror S7 (18)
    (18, 6), (18, 3);

-- -------------------------------------------------------
-- 7. UTILIZADORES
-- -------------------------------------------------------
INSERT INTO utilizadores (nome, email, password_hash, criado_em, ultimo_login) VALUES
    ('Ana Silva',       'ana.silva@email.pt',      '$2b$12$Hx1LjnI5EzKp8sGt7mVwOe', '2024-01-15 09:23:00', '2025-04-20 18:30:00'),
    ('Pedro Ferreira',  'pedro.f@gmail.com',        '$2b$12$Kn2MqpR7Tz9lWdXv3nYbQf', '2024-02-03 14:10:00', '2025-04-21 22:10:00'),
    ('Maria Costa',     'maria.costa@hotmail.com',  '$2b$12$Lm4NsrS8Ua0mXeYw4oZcRg', '2024-03-22 11:05:00', '2025-04-19 20:45:00'),
    ('João Rodrigues',  'joao.rodrigues@work.pt',   '$2b$12$Mp5OtqT9Vb1nYfZx5pAdSh', '2024-04-10 16:40:00', '2025-04-18 12:00:00'),
    ('Sofia Martins',   'sofia.m@outlook.pt',       '$2b$12$Nq6PurU0Wc2oZgAy6qBeSi', '2024-05-18 08:55:00', '2025-04-21 09:15:00'),
    ('Carlos Lopes',    'carlos.lopes@sapo.pt',     '$2b$12$Or7QvsV1Xd3pAhBz7rCfTj', '2024-06-07 13:20:00', '2025-04-17 15:30:00'),
    ('Inês Pereira',    'ines.pereira@email.com',   '$2b$12$Ps8RwtW2Ye4qBiCa8sDgUk', '2024-07-25 10:00:00', '2025-04-22 07:45:00'),
    ('Miguel Santos',   'miguel.santos@gmail.com',  '$2b$12$Qt9SxuX3Zf5rCjDb9tEhVl', '2024-08-14 17:30:00', '2025-04-20 21:00:00'),
    ('Beatriz Nunes',   'beatriz.n@gmail.com',      '$2b$12$Ru0TyvY4Ag6sDkEc0uFiWm', '2024-09-01 09:10:00', '2025-04-21 19:20:00'),
    ('Rui Oliveira',    'rui.oliveira@empresa.pt',  '$2b$12$Sv1UzwZ5Bh7tElFd1vGjXn', '2024-10-12 12:00:00', '2025-04-16 11:55:00');

-- -------------------------------------------------------
-- 8. PREFERÊNCIAS DOS UTILIZADORES
-- -------------------------------------------------------
INSERT INTO preferencias_utilizador (utilizador_id, tipo, valor) VALUES
    (1, 'genero',    'Drama'),
    (1, 'genero',    'Romance'),
    (1, 'mood',      'Triste'),
    (2, 'genero',    'Ação'),
    (2, 'genero',    'Ficção Científica'),
    (2, 'mood',      'Épico'),
    (3, 'genero',    'Comédia'),
    (3, 'mood',      'Alegre'),
    (4, 'genero',    'Thriller'),
    (4, 'genero',    'Drama'),
    (4, 'mood',      'Tenso'),
    (5, 'genero',    'Animação'),
    (5, 'genero',    'Comédia'),
    (5, 'mood',      'Alegre'),
    (6, 'genero',    'Documentário'),
    (6, 'mood',      'Curioso'),
    (7, 'genero',    'Terror'),
    (7, 'mood',      'Assustado'),
    (8, 'genero',    'Ficção Científica'),
    (8, 'mood',      'Curioso'),
    (9, 'genero',    'Drama'),
    (9, 'genero',    'Romance'),
    (9, 'mood',      'Nostálgico'),
    (10,'genero',    'Ação'),
    (10,'mood',      'Épico');

-- -------------------------------------------------------
-- 9. VISUALIZAÇÕES POR REGIÃO
-- -------------------------------------------------------
INSERT INTO visualizacoes_regiao (conteudo_id, localizacao_id, total_views, semana, crescimento_pct) VALUES
    -- Lisboa
    (1,  1, 12400, '2025-04-14', 8.2),
    (6,  1, 18900, '2025-04-14', 15.4),
    (14, 1, 22100, '2025-04-14', 30.0),
    (17, 1, 31500, '2025-04-14', 50.0),
    (16, 1, 27000, '2025-04-14', 43.0),
    -- Porto
    (6,  2, 14700, '2025-04-14', 17.0),
    (14, 2, 19300, '2025-04-14', 28.5),
    (17, 2, 27800, '2025-04-14', 48.0),
    (12, 2, 16500, '2025-04-14', 41.0),
    -- Coimbra
    (11, 3,  8200, '2025-04-14', 22.0),
    (17, 3, 11900, '2025-04-14', 46.0),
    (15, 3, 10100, '2025-04-14', 37.0),
    -- São Paulo
    (6,  7, 95000, '2025-04-14', 40.0),
    (14, 7, 88000, '2025-04-14', 35.0),
    (17, 7, 120000,'2025-04-14', 55.0),
    -- Barcelona
    (4,  9, 41000, '2025-04-14', 18.0),
    (6,  9, 55000, '2025-04-14', 22.0),
    -- Semana anterior — Lisboa
    (17, 1, 21000, '2025-04-07', 30.0),
    (16, 1, 18500, '2025-04-07', 25.0),
    (14, 1, 15000, '2025-04-07', 20.0);

-- -------------------------------------------------------
-- 10. INTERAÇÕES DOS UTILIZADORES
-- -------------------------------------------------------
INSERT INTO interacoes_utilizador (utilizador_id, conteudo_id, tipo, avaliacao, criado_em) VALUES
    (1,  17, 'view',   NULL, '2025-04-20 20:05:00'),
    (1,  17, 'like',   NULL, '2025-04-20 20:15:00'),
    (1,   9, 'view',   NULL, '2025-04-19 21:30:00'),
    (1,   9, 'like',   NULL, '2025-04-19 21:45:00'),
    (2,  14, 'view',   NULL, '2025-04-21 19:00:00'),
    (2,  14, 'like',   NULL, '2025-04-21 19:10:00'),
    (2,   6, 'view',   NULL, '2025-04-20 18:00:00'),
    (2,   6, 'clique', NULL, '2025-04-20 17:58:00'),
    (3,   1, 'view',   NULL, '2025-04-18 15:30:00'),
    (3,   1, 'like',   NULL, '2025-04-18 15:50:00'),
    (4,  16, 'view',   NULL, '2025-04-22 08:00:00'),
    (4,  13, 'view',   NULL, '2025-04-21 22:00:00'),
    (4,  13, 'like',   NULL, '2025-04-21 22:30:00'),
    (5,  11, 'view',   NULL, '2025-04-17 14:00:00'),
    (5,  11, 'like',   NULL, '2025-04-17 14:20:00'),
    (6,   2, 'view',   NULL, '2025-04-16 20:00:00'),
    (7,   5, 'view',   NULL, '2025-04-15 21:00:00'),
    (7,   5, 'like',   NULL, '2025-04-15 21:20:00'),
    (7,   7, 'clique', NULL, '2025-04-14 22:00:00'),
    (8,   4, 'view',   NULL, '2025-04-13 18:30:00'),
    (9,   3, 'view',   NULL, '2025-04-12 20:00:00'),
    (9,   9, 'view',   NULL, '2025-04-11 21:00:00'),
    (10,  6, 'view',   NULL, '2025-04-10 19:00:00'),
    (10, 14, 'like',   NULL, '2025-04-10 19:30:00');

-- -------------------------------------------------------
-- 11. RECOMENDAÇÕES
-- -------------------------------------------------------
INSERT INTO recomendacoes (utilizador_id, conteudo_id, origem, score, gerado_em) VALUES
    (1,  9,  'algoritmo', 0.94, '2025-04-22 06:00:00'),
    (1,  17, 'trending',  0.97, '2025-04-22 06:00:00'),
    (1,  3,  'algoritmo', 0.88, '2025-04-22 06:00:00'),
    (2,  4,  'algoritmo', 0.92, '2025-04-22 06:00:00'),
    (2,  15, 'trending',  0.95, '2025-04-22 06:00:00'),
    (2,  6,  'mood',      0.89, '2025-04-22 06:00:00'),
    (3,  11, 'mood',      0.91, '2025-04-22 06:00:00'),
    (3,   1, 'algoritmo', 0.86, '2025-04-22 06:00:00'),
    (4,  13, 'algoritmo', 0.93, '2025-04-22 06:00:00'),
    (4,  16, 'trending',  0.96, '2025-04-22 06:00:00'),
    (5,  11, 'mood',      0.90, '2025-04-22 06:00:00'),
    (5,   1, 'algoritmo', 0.85, '2025-04-22 06:00:00'),
    (6,   2, 'algoritmo', 0.88, '2025-04-22 06:00:00'),
    (6,  18, 'mood',      0.82, '2025-04-22 06:00:00'),
    (7,   5, 'mood',      0.94, '2025-04-22 06:00:00'),
    (7,   7, 'algoritmo', 0.87, '2025-04-22 06:00:00'),
    (8,   4, 'algoritmo', 0.91, '2025-04-22 06:00:00'),
    (8,  15, 'trending',  0.93, '2025-04-22 06:00:00'),
    (9,   3, 'mood',      0.89, '2025-04-22 06:00:00'),
    (9,  17, 'trending',  0.97, '2025-04-22 06:00:00'),
    (10,  6, 'mood',      0.92, '2025-04-22 06:00:00'),
    (10, 14, 'algoritmo', 0.90, '2025-04-22 06:00:00');

-- -------------------------------------------------------
-- 12. COMPARAÇÕES ENTRE REGIÕES
-- -------------------------------------------------------
INSERT INTO comparacoes (utilizador_id, localizacao_a_id, localizacao_b_id, criado_em) VALUES
    (1,  1, 2, '2025-04-20 10:00:00'),  -- Lisboa vs Porto
    (2,  1, 7, '2025-04-21 11:30:00'),  -- Lisboa vs São Paulo
    (4,  2, 3, '2025-04-19 09:00:00'),  -- Porto vs Coimbra
    (6,  1, 9, '2025-04-18 14:00:00'),  -- Lisboa vs Barcelona
    (8,  7, 8, '2025-04-17 16:00:00'),  -- São Paulo vs Salvador
    (10, 1, 3, '2025-04-16 13:00:00');  -- Lisboa vs Coimbra
