const TMDB_KEY = '684effb3e21a144fa6de7a31dfa2dae6';
const TMDB_IMG = 'https://image.tmdb.org/t/p/original';

async function getTMDBPoster(titulo) {
  try {
    const res = await fetch(
      `https://api.themoviedb.org/3/search/movie?api_key=${TMDB_KEY}&query=${encodeURIComponent(titulo)}&language=pt-PT`
    );
    const data = await res.json();
    if (data.results && data.results[0] && data.results[0].poster_path) {
      return TMDB_IMG + data.results[0].poster_path;
    }
    return null;
  } catch {
    return null;
  }
}

async function preencherPosters(seletor, campoTitulo) {
  const cards = document.querySelectorAll(seletor);
  for (const card of cards) {
    const titulo = card.querySelector(campoTitulo)?.textContent;
    if (!titulo) continue;
    const poster = await getTMDBPoster(titulo);
    const posterEl = card.querySelector('.film-card-poster, .rec-poster, .rec-card-poster');
    if (poster && posterEl) {
      posterEl.style.backgroundImage = `url(${poster})`;
      posterEl.style.backgroundSize = 'cover';
      posterEl.style.backgroundPosition = 'center';
    }
  }
}