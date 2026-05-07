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
async function getTrailer(titulo) {
  try {
    // Primeiro busca o ID do filme
    const search = await fetch(
      `https://api.themoviedb.org/3/search/movie?api_key=${TMDB_KEY}&query=${encodeURIComponent(titulo)}&language=pt-PT`
    );
    const searchData = await search.json();
    if (!searchData.results[0]) return null;
    
    const movieId = searchData.results[0].id;

    // Depois busca os vídeos
    const videos = await fetch(
      `https://api.themoviedb.org/3/movie/${movieId}/videos?api_key=${TMDB_KEY}`
    );
    const videosData = await videos.json();
    
    const trailer = videosData.results.find(v => v.type === 'Trailer' && v.site === 'YouTube');
    return trailer ? trailer.key : null;

  } catch {
    return null;
  }
}
async function getFilmeDetalhes(titulo) {
  try {
    // Buscar ID do filme
    const search = await fetch(
      `https://api.themoviedb.org/3/search/movie?api_key=${TMDB_KEY}&query=${encodeURIComponent(titulo)}&language=pt-PT`
    );
    const searchData = await search.json();
    if (!searchData.results[0]) return null;
    
    const id = searchData.results[0].id;

    // Buscar detalhes completos
    const [detalhes, credits, videos, similar] = await Promise.all([
      fetch(`https://api.themoviedb.org/3/movie/${id}?api_key=${TMDB_KEY}&language=pt-PT`).then(r => r.json()),
      fetch(`https://api.themoviedb.org/3/movie/${id}/credits?api_key=${TMDB_KEY}&language=pt-PT`).then(r => r.json()),
      fetch(`https://api.themoviedb.org/3/movie/${id}/videos?api_key=${TMDB_KEY}`).then(r => r.json()),
      fetch(`https://api.themoviedb.org/3/movie/${id}/similar?api_key=${TMDB_KEY}&language=pt-PT`).then(r => r.json()),
    ]);

    const trailer = videos.results.find(v => v.type === 'Trailer' && v.site === 'YouTube');
    const diretor = credits.crew?.find(p => p.job === 'Director');
    const elenco  = credits.cast?.slice(0, 5).map(p => p.name).join(', ');

    return {
      id,
      titulo:    detalhes.title,
      ano:       detalhes.release_date?.split('-')[0],
      duracao:   detalhes.runtime ? `${Math.floor(detalhes.runtime/60)}h ${detalhes.runtime%60}min` : '',
      generos:   detalhes.genres?.map(g => g.name).join(', '),
      sinopse:   detalhes.overview,
      nota:      detalhes.vote_average?.toFixed(1),
      votos:     detalhes.vote_count > 1000 ? (detalhes.vote_count/1000).toFixed(0) + 'k' : detalhes.vote_count,
      poster:    detalhes.poster_path ? 'https://image.tmdb.org/t/p/original' + detalhes.poster_path : null,
      backdrop:  detalhes.backdrop_path ? 'https://image.tmdb.org/t/p/original' + detalhes.backdrop_path : null,
      trailer:   trailer ? trailer.key : null,
      diretor:   diretor?.name,
      elenco,
      similar:   similar.results?.slice(0, 5).map(f => ({
        titulo: f.title,
        poster: f.poster_path ? 'https://image.tmdb.org/t/p/w300' + f.poster_path : null,
        ano:    f.release_date?.split('-')[0],
      }))
    };
  } catch {
    return null;
  }
}