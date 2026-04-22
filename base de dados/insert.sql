-- -------------------------------------------------------
-- Dados de teste
-- -------------------------------------------------------

INSERT INTO localizacoes (pais, regiao, cidade) VALUES
    ('Portugal', 'Lisboa',  'Lisboa'),
    ('Portugal', 'Norte',   'Porto'),
    ('Portugal', 'Centro',  'Coimbra'),
    ('Portugal', 'Algarve', 'Faro');

INSERT INTO utilizadores (nome, email, password_hash, ultimo_login) VALUES
    ('Ana Silva',     'ana.silva@email.com',     'hash_ana123',   '2024-11-01 10:00:00'),
    ('Bruno Costa',   'bruno.costa@email.com',   'hash_bruno456', '2024-11-02 14:30:00'),
    ('Carla Mendes',  'carla.mendes@email.com',  'hash_carla789', '2024-11-03 09:15:00'),
    ('Diogo Ferreira','diogo.f@email.com',        'hash_diogo321', '2024-11-04 18:45:00');

INSERT INTO generos (nome) VALUES
    ('Comédia'),           -- id 1
    ('Drama'),             -- id 2
    ('Thriller'),          -- id 3
    ('Ação'),              -- id 4
    ('Romance'),           -- id 5
    ('Ficção Científica'), -- id 6
    ('Animação'),          -- id 7
    ('Terror'),            -- id 8
    ('Documentário'),      -- id 9
    ('Aventura');          -- id 10

INSERT INTO moods (nome) VALUES
    ('Alegre'),      -- id 1
    ('Triste'),      -- id 2
    ('Tenso'),       -- id 3
    ('Épico'),       -- id 4
    ('Relaxado'),    -- id 5
    ('Curioso'),     -- id 6
    ('Nostálgico'),  -- id 7
    ('Assustado');   -- id 8

INSERT INTO conteudos (titulo, tipo, descricao, ano, popularidade, tendencia_pct) VALUES
    ('Divertidamente 2',     'filme', 'Uma viagem pelas emoções de uma adolescente.',        2024, 9.5, 34.0),
    ('Oppenheimer',          'filme', 'O criador da bomba atómica e as suas consequências.', 2023, 8.9, 21.0),
    ('Pobres Criaturas',     'filme', 'Uma história surreal e criativa sobre liberdade.',    2023, 8.2, 17.0),
    ('Dune: Parte 2',        'filme', 'A continuação da épica saga no deserto de Arrakis.', 2024, 9.1, 28.0),
    ('The Bear',             'serie', 'Um chef tenta salvar o restaurante da família.',      2023, 8.7, 19.0),
    ('Succession',           'serie', 'A luta pelo controlo de um império mediático.',       2023, 9.3, 25.0),
    ('Anatomia de um Crime', 'filme', 'Um julgamento que questiona a verdade e a memória.',  2023, 8.0, 14.0),
    ('Planet Earth III',     'serie', 'Uma exploração deslumbrante da vida selvagem.',       2023, 8.5, 11.0),
    ('O Hobbit',             'filme', 'A aventura de Bilbo Bolseiro pela Terra Média.',      2012, 7.8, 8.0),
    ('Midsommar',            'filme', 'Um casal enfrenta um festival perturbador na Suécia.',2019, 7.5, 6.0);

INSERT INTO conteudo_genero (conteudo_id, genero_id) VALUES
    (1,  7), -- Divertidamente 2     -> Animação
    (1,  1), -- Divertidamente 2     -> Comédia
    (2,  2), -- Oppenheimer          -> Drama
    (2,  4), -- Oppenheimer          -> Ação
    (3,  2), -- Pobres Criaturas     -> Drama
    (3,  1), -- Pobres Criaturas     -> Comédia
    (4,  4), -- Dune: Parte 2        -> Ação
    (4,  6), -- Dune: Parte 2        -> Ficção Científica
    (4, 10), -- Dune: Parte 2        -> Aventura
    (5,  2), -- The Bear             -> Drama
    (6,  2), -- Succession           -> Drama
    (6,  3), -- Succession           -> Thriller
    (7,  3), -- Anatomia de um Crime -> Thriller
    (7,  2), -- Anatomia de um Crime -> Drama
    (8,  9), -- Planet Earth III     -> Documentário
    (9, 10), -- O Hobbit             -> Aventura
    (9,  4), -- O Hobbit             -> Ação
    (10, 8), -- Midsommar            -> Terror
    (10, 3); -- Midsommar            -> Thriller

INSERT INTO mood_genero (mood_id, genero_id, peso) VALUES
    -- Alegre (1)
    (1, 1, 0.9),  -- Comédia
    (1, 7, 0.8),  -- Animação
    (1, 5, 0.6),  -- Romance
    -- Triste (2)
    (2, 2, 0.9),  -- Drama
    (2, 5, 0.7),  -- Romance
    (2, 9, 0.5),  -- Documentário
    -- Tenso (3)
    (3, 3, 0.95), -- Thriller
    (3, 8, 0.8),  -- Terror
    (3, 4, 0.6),  -- Ação
    -- Épico (4)
    (4, 4, 0.95), -- Ação
    (4,10, 0.8),  -- Aventura
    (4, 6, 0.7),  -- Ficção Científica
    -- Relaxado (5)
    (5, 1, 0.7),  -- Comédia
    (5, 9, 0.8),  -- Documentário
    (5, 7, 0.6),  -- Animação
    -- Curioso (6)
    (6, 9, 0.9),  -- Documentário
    (6, 6, 0.8),  -- Ficção Científica
    (6, 2, 0.5),  -- Drama
    -- Nostálgico (7)
    (7, 2, 0.8),  -- Drama
    (7, 5, 0.7),  -- Romance
    (7, 1, 0.6),  -- Comédia
    -- Assustado (8)
    (8, 8, 0.95), -- Terror
    (8, 3, 0.7),  -- Thriller
    (8, 6, 0.4);  -- Ficção Científica

INSERT INTO preferencias_utilizador (utilizador_id, tipo, valor) VALUES
    (1, 'genero', 'Animação'),
    (1, 'genero', 'Comédia'),
    (1, 'mood',   'Alegre'),
    (2, 'genero', 'Thriller'),
    (2, 'mood',   'Tenso'),
    (3, 'genero', 'Drama'),
    (3, 'mood',   'Triste'),
    (4, 'genero', 'Ficção Científica'),
    (4, 'mood',   'Épico');

INSERT INTO visualizacoes_regiao (conteudo_id, localizacao_id, total_views, semana, crescimento_pct) VALUES
    (1,  1, 15000, '2024-10-07', 12.0),
    (1,  2,  9800, '2024-10-07',  8.5),
    (2,  1, 12000, '2024-10-07', 10.0),
    (2,  3,  7500, '2024-10-07',  6.0),
    (3,  1,  8000, '2024-10-07',  5.5),
    (4,  1, 13500, '2024-10-07', 15.0),
    (4,  2, 11000, '2024-10-07', 13.0),
    (5,  1,  9000, '2024-10-07',  7.0),
    (6,  1, 14000, '2024-10-07', 11.0),
    (7,  4,  6000, '2024-10-07',  4.5),
    (8,  3,  5000, '2024-10-07',  3.0),
    (9,  2,  4500, '2024-10-07',  2.5),
    (10, 4,  3800, '2024-10-07',  2.0);

INSERT INTO interacoes_utilizador (utilizador_id, conteudo_id, tipo, avaliacao) VALUES
    (1,  1, 'like',   9),
    (1,  3, 'view',   7),
    (1,  8, 'clique', NULL),
    (2,  2, 'like',   8),
    (2,  6, 'view',   9),
    (2, 10, 'like',   7),
    (3,  5, 'like',   8),
    (3,  7, 'clique', NULL),
    (3,  2, 'view',   8),
    (4,  4, 'like',   10),
    (4,  2, 'view',   8),
    (4,  9, 'like',   7);

INSERT INTO recomendacoes (utilizador_id, conteudo_id, origem, score) VALUES
    (1, 1, 'mood',      0.95),
    (1, 3, 'algoritmo', 0.82),
    (1, 8, 'trending',  0.71),
    (2, 6, 'trending',  0.88),
    (2, 2, 'algoritmo', 0.79),
    (2, 7, 'mood',      0.83),
    (3, 5, 'mood',      0.91),
    (3, 7, 'trending',  0.74),
    (3, 2, 'algoritmo', 0.80),
    (4, 4, 'algoritmo', 0.97),
    (4, 6, 'trending',  0.85),
    (4, 9, 'mood',      0.76);

INSERT INTO comparacoes (utilizador_id, localizacao_a_id, localizacao_b_id) VALUES
    (1, 1, 2),
    (2, 1, 3),
    (3, 2, 4),
    (4, 1, 4);
