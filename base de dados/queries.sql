-- -------------------------------------------------------
-- Queries FilmFlow
-- -------------------------------------------------------

-- 1. Listar todos os conteúdos com os seus géneros
SELECT c.titulo, c.tipo, c.ano, GROUP_CONCAT(g.nome ORDER BY g.nome SEPARATOR ', ') AS generos
FROM conteudos c
JOIN conteudo_genero cg ON c.id = cg.conteudo_id
JOIN generos g ON g.id = cg.genero_id
GROUP BY c.id, c.titulo, c.tipo, c.ano
ORDER BY c.popularidade DESC;

-- 2. Top 5 conteúdos mais populares
SELECT titulo, tipo, ano, popularidade, tendencia_pct
FROM conteudos
ORDER BY popularidade DESC
LIMIT 5;

-- 3. Conteúdos em tendência (tendencia_pct > 15%)
SELECT titulo, tipo, ano, tendencia_pct
FROM conteudos
WHERE tendencia_pct > 15
ORDER BY tendencia_pct DESC;

-- 4. Recomendações de um utilizador específico (ex: id = 1)
SELECT u.nome, c.titulo, r.origem, r.score, r.gerado_em
FROM recomendacoes r
JOIN utilizadores u ON u.id = r.utilizador_id
JOIN conteudos c ON c.id = r.conteudo_id
WHERE r.utilizador_id = 1
ORDER BY r.score DESC;

-- 5. Visualizações por região numa semana específica
SELECT l.pais, l.regiao, l.cidade, c.titulo, v.total_views, v.crescimento_pct
FROM visualizacoes_regiao v
JOIN localizacoes l ON l.id = v.localizacao_id
JOIN conteudos c ON c.id = v.conteudo_id
WHERE v.semana = '2024-10-07'
ORDER BY v.total_views DESC;

-- 6. Conteúdos mais vistos por cidade
SELECT l.cidade, c.titulo, SUM(v.total_views) AS total_views
FROM visualizacoes_regiao v
JOIN localizacoes l ON l.id = v.localizacao_id
JOIN conteudos c ON c.id = v.conteudo_id
GROUP BY l.cidade, c.titulo
ORDER BY l.cidade, total_views DESC;

-- 7. Géneros recomendados para um mood específico (ex: Épico)
SELECT m.nome AS mood, g.nome AS genero, mg.peso
FROM mood_genero mg
JOIN moods m ON m.id = mg.mood_id
JOIN generos g ON g.id = mg.genero_id
WHERE m.nome = 'Épico'
ORDER BY mg.peso DESC;

-- 8. Utilizadores e as suas preferências
SELECT u.nome, p.tipo, p.valor
FROM preferencias_utilizador p
JOIN utilizadores u ON u.id = p.utilizador_id
ORDER BY u.nome, p.tipo;

-- 9. Interações por utilizador (total por tipo)
SELECT u.nome, i.tipo, COUNT(*) AS total
FROM interacoes_utilizador i
JOIN utilizadores u ON u.id = i.utilizador_id
GROUP BY u.nome, i.tipo
ORDER BY u.nome, i.tipo;

-- 10. Média de avaliação por conteúdo
SELECT c.titulo, ROUND(AVG(i.avaliacao), 2) AS media_avaliacao, COUNT(i.avaliacao) AS total_avaliacoes
FROM interacoes_utilizador i
JOIN conteudos c ON c.id = i.conteudo_id
WHERE i.avaliacao IS NOT NULL
GROUP BY c.titulo
ORDER BY media_avaliacao DESC;

-- 11. Conteúdos que um utilizador ainda não viu (ex: id = 1)
SELECT c.titulo, c.tipo, c.popularidade
FROM conteudos c
WHERE c.id NOT IN (
    SELECT conteudo_id
    FROM interacoes_utilizador
    WHERE utilizador_id = 1
)
ORDER BY c.popularidade DESC;

-- 12. Comparação de visualizações entre duas regiões (ex: Lisboa vs Porto)
SELECT c.titulo,
       SUM(CASE WHEN l.cidade = 'Lisboa' THEN v.total_views ELSE 0 END) AS views_lisboa,
       SUM(CASE WHEN l.cidade = 'Porto'  THEN v.total_views ELSE 0 END) AS views_porto
FROM visualizacoes_regiao v
JOIN localizacoes l ON l.id = v.localizacao_id
JOIN conteudos c ON c.id = v.conteudo_id
WHERE l.cidade IN ('Lisboa', 'Porto')
GROUP BY c.titulo
ORDER BY views_lisboa DESC;

-- 13. Recomendações por origem (algoritmo / trending / mood)
SELECT origem, COUNT(*) AS total, ROUND(AVG(score), 2) AS media_score
FROM recomendacoes
GROUP BY origem
ORDER BY media_score DESC;

-- 14. Utilizadores mais ativos (mais interações)
SELECT u.nome, COUNT(*) AS total_interacoes
FROM interacoes_utilizador i
JOIN utilizadores u ON u.id = i.utilizador_id
GROUP BY u.nome
ORDER BY total_interacoes DESC;

-- 15. Conteúdos recomendados por mood com géneros compatíveis
SELECT m.nome AS mood, c.titulo, g.nome AS genero, mg.peso, r.score
FROM recomendacoes r
JOIN conteudos c ON c.id = r.conteudo_id
JOIN conteudo_genero cg ON cg.conteudo_id = c.id
JOIN generos g ON g.id = cg.genero_id
JOIN mood_genero mg ON mg.genero_id = g.id
JOIN moods m ON m.id = mg.mood_id
WHERE r.origem = 'mood'
ORDER BY m.nome, r.score DESC;
