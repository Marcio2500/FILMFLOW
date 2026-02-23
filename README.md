RELATÓRIO TÉCNICO – FASE 1 

Projeto: FilmFlow
1. Proposta Inicial do Projeto
O FilmFlow é uma aplicação web que permite aos utilizadores pesquisar, descobrir e organizar filmes e séries num ambiente centralizado. A plataforma integra uma API pública para obtenção de dados
cinematográficos e disponibiliza funcionalidades de gestão de listas pessoais (“Para Ver”, “Favoritos” e “Vistos”), com persistência em base de dados própria.
O projeto diferencia-se ao introduzir um mecanismo alternativo de descoberta baseado no estado emocional do utilizador (Mood-Based Discovery), bem como uma funcionalidade de recomendação
aleatória (“Surpreende-me”).

2. Enquadramento
O consumo de conteúdos audiovisuais encontra-se fragmentado por múltiplas plataformas. Os utilizadores guardam recomendações em diferentes locais, o que gera desorganização. O FilmFlow
propõe uma solução centralizada com descoberta personalizada.

3. Objetivos
- Integrar pesquisa por título via API pública.
- Implementar autenticação de utilizadores.
- Permitir gestão de listas pessoais.
- Desenvolver descoberta baseada em estado de espírito.
- Implementar funcionalidade “Surpreende-me”.
- Garantir persistência de dados em base relacional.

4.Público-Alvo
Estudantes e jovens adultos (16–35 anos) que consomem filmes e séries e procuram organização e personalização.

5.Funcionalidade Diferenciadora
Mood-Based Discovery:
Permite selecionar um estado emocional (Relaxar, Rir, Emocionar, Suspense, Romântico,Aventura) e receber sugestões associadas a géneros específicos.
Surpreende-me: Geração de recomendação aleatória global ou baseada no mood selecionado.

6.User Journey
• Login ou registo.
• Pesquisa por título ou seleção de mood.
• Visualização de resultados.
• Consulta de detalhes.
• Adição à lista pessoal.
• Marcação como visto.
7.Arquitetura
• Frontend – Interface web responsiva.
• Backend – API REST própria com lógica de autenticação e gestão de listas.
• Base de Dados – Armazenamento de utilizadores e conteúdos.
• API Externa – Fornecimento de dados cinematográficos.

8.Requisitos Funcionais
RF1 – Registo e autenticação.
RF2 – Pesquisa por título.
RF3 – Visualização em grelha.
RF4 – Visualização de detalhes.
RF5 – Gestão de listas pessoais.
RF6 – Alteração/remoção de conteúdos.
RF7 – Descoberta por mood.
RF8 – Recomendação aleatória.

9.Requisitos Não Funcionais
RNF1 – Interface responsiva.
RNF2 – Persistência de dados.
RNF3 – Segurança de passwords.
RNF4 – Tempo de resposta adequado.
RNF5 – Código modular.

Conclusão
O FilmFlow combina organização pessoal e descoberta emocional, oferecendo uma solução diferenciada e tecnicamente viável para gestão de conteúdos audiovisuais.
