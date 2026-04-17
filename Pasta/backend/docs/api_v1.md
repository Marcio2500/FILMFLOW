# Documentação REST da API FilmFlow - V1

## 1. Listar Filmes para o Mapa
**Endpoint:** `GET /api/get_filmes.php`  
**Descrição:** Extrai da base de dados todos os filmes e os seus detalhes para exibição no mapa interativo.


## 2. Registar Clique
**Endpoint:** `POST /api/track_click.php`  
**Descrição:** Incrementa o contador de visualizações de um filme numa região específica.

### Parâmetros (POST):
- `conteudo_id`: ID do filme clicado.
- `localizacao_id`: ID da região onde o filme foi visto.


## 3. Obter Tendências Regionais
**Endpoint:** `GET /api/get_trends.php?loc={id}`  
**Descrição:** Retorna os filmes ordenados pelo algoritmo de tendência (popularidade + crescimento) para uma região específica.

### Parâmetros (URL):
- `loc`: ID da localização para o filtro.


## 4. Gestão de Interações do Utilizador
**Endpoint:** `POST /api/user_interactions.php`  
**Descrição:** Regista favoritos, filmes na lista de espera (watchlist), histórico de visualização e o progresso de conteúdos não terminados.

### Parâmetros (JSON Body):
- `user_id`: (int) ID do utilizador logado.
- `conteudo_id`: (int) ID do filme ou série.
- `tipo`: (string) Valores aceites: `'favorito'`, `'watchlist'`, `'historico'`.
- `progresso`: (int) Tempo ou percentagem (ex: 45) para filmes interrompidos.