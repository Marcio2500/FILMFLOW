const fmStyle = document.createElement('style');
fmStyle.textContent = `
  @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Outfit:wght@400;500;600;700&display=swap');

  .fm-overlay {
    position: fixed;
    inset: 0;
    z-index: 10000;
    display: none;
    background: rgba(0,0,0,0.6);
    backdrop-filter: blur(8px);
    font-family: 'Outfit', sans-serif;
  }

  .fm-overlay.open { display: block; }

  .fm-modal {
    position: absolute;
    inset: 0;
    overflow-y: auto;
    animation: fmfadein 0.3s forwards;
  }

  .fm-modal::-webkit-scrollbar { width: 4px; }
  .fm-modal::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.1); border-radius: 2px; }

  @keyframes fmfadein { from{opacity:0} to{opacity:1} }

  /* HERO SECTION */
  .fm-hero {
    position: relative;
    min-height: 100vh;
    display: flex;
    align-items: flex-end;
    padding: 3rem 4rem;
    overflow: hidden;
  }

  .fm-backdrop {
    position: absolute;
    inset: 0;
    background-size: cover;
    background-position: center top;
    filter: brightness(0.25);
  }

  .fm-gradient {
    position: absolute;
    inset: 0;
    background: linear-gradient(
      90deg,
      rgba(0,0,0,0.9) 0%,
      rgba(0,0,0,0.5) 50%,
      rgba(0,0,0,0.2) 100%
    ),
    linear-gradient(
      180deg,
      rgba(0,0,0,0.3) 0%,
      transparent 30%,
      rgba(0,0,0,0.8) 80%,
      rgba(0,0,0,1) 100%
    );
  }

  /* CLOSE BTN */
  .fm-topbar {
    position: absolute;
    top: 1.5rem;
    left: 1.5rem;
    z-index: 10;
    display: flex;
    align-items: center;
    gap: 1rem;
  }

  .fm-back {
    display: flex;
    align-items: center;
    gap: 0.4rem;
    background: rgba(0,0,0,0.5);
    border: 1px solid rgba(255,255,255,0.15);
    color: #fff;
    font-family: 'Outfit', sans-serif;
    font-size: 0.82rem;
    font-weight: 600;
    padding: 0.45rem 1rem;
    border-radius: 6px;
    cursor: pointer;
    backdrop-filter: blur(6px);
    transition: all 0.2s;
  }

  .fm-back:hover { background: rgba(0,0,0,0.8); }

  .fm-page-title {
    font-size: 0.82rem;
    color: rgba(255,255,255,0.4);
    font-weight: 500;
  }

  /* CONTENT */
  .fm-content {
    position: relative;
    z-index: 2;
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    gap: 2rem;
    width: 100%;
  }

  .fm-left { flex: 1; max-width: 560px; }

  .fm-mood-badge {
    display: inline-block;
    font-size: 0.72rem;
    font-weight: 700;
    padding: 0.25rem 0.7rem;
    border-radius: 4px;
    background: #e5181b;
    color: #fff;
    letter-spacing: 1px;
    margin-bottom: 0.75rem;
    text-transform: uppercase;
  }

  .fm-titulo {
    font-family: 'Bebas Neue', sans-serif;
    font-size: clamp(3rem, 7vw, 5.5rem);
    letter-spacing: 2px;
    color: #fff;
    line-height: 1;
    margin-bottom: 0.75rem;
    text-shadow: 0 2px 20px rgba(0,0,0,0.5);
  }

  .fm-meta {
    font-size: 0.85rem;
    color: rgba(255,255,255,0.6);
    margin-bottom: 0.6rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    flex-wrap: wrap;
  }

  .fm-dot {
    width: 3px;
    height: 3px;
    border-radius: 50%;
    background: rgba(255,255,255,0.4);
  }

  .fm-rating {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 1rem;
  }

  .fm-stars { color: #facc15; font-size: 1rem; letter-spacing: 2px; }
  .fm-nota { font-size: 1rem; font-weight: 700; color: #facc15; }
  .fm-votos { font-size: 0.8rem; color: rgba(255,255,255,0.4); }

  .fm-sinopse {
    font-size: 0.9rem;
    color: rgba(255,255,255,0.75);
    line-height: 1.7;
    margin-bottom: 1rem;
    max-width: 500px;
  }

  .fm-creditos {
    font-size: 0.8rem;
    color: rgba(255,255,255,0.4);
    margin-bottom: 1.75rem;
    line-height: 1.7;
  }

  .fm-creditos strong { color: rgba(255,255,255,0.6); }

  .fm-btns {
    display: flex;
    gap: 0.75rem;
    flex-wrap: wrap;
  }

  .fm-btn-assistir {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    background: #e5181b;
    color: #fff;
    font-family: 'Outfit', sans-serif;
    font-size: 0.9rem;
    font-weight: 700;
    padding: 0.8rem 2rem;
    border-radius: 6px;
    border: none;
    cursor: pointer;
    transition: all 0.2s;
    letter-spacing: 0.5px;
  }

  .fm-btn-assistir:hover {
    opacity: 0.88;
    box-shadow: 0 0 20px rgba(229,24,27,0.5);
  }

  .fm-btn-lista {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    background: rgba(255,255,255,0.12);
    color: #fff;
    font-family: 'Outfit', sans-serif;
    font-size: 0.9rem;
    font-weight: 600;
    padding: 0.8rem 1.6rem;
    border-radius: 6px;
    border: 1px solid rgba(255,255,255,0.25);
    cursor: pointer;
    transition: all 0.2s;
  }

  .fm-btn-lista:hover { background: rgba(255,255,255,0.2); }

  /* RELACIONADOS */
  .fm-right {
    width: 220px;
    flex-shrink: 0;
    align-self: center;
  }

  .fm-related-title {
    font-size: 0.72rem;
    color: rgba(255,255,255,0.35);
    text-transform: uppercase;
    letter-spacing: 1.5px;
    margin-bottom: 0.75rem;
  }

  .fm-related-card {
    display: flex;
    gap: 0.6rem;
    margin-bottom: 0.6rem;
    cursor: pointer;
    transition: opacity 0.2s;
    align-items: center;
  }

  .fm-related-card:hover { opacity: 0.75; }

  .fm-related-poster {
    width: 48px;
    height: 68px;
    border-radius: 4px;
    object-fit: cover;
    background: #1a1a22;
    flex-shrink: 0;
  }

  .fm-related-info { flex: 1; min-width: 0; }
  .fm-related-name { font-size: 0.8rem; font-weight: 600; color: #fff; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
  .fm-related-year { font-size: 0.72rem; color: rgba(255,255,255,0.35); margin-top: 2px; }

  /* TRAILER */
  .fm-trailer-section {
    background: #000;
    padding: 0;
  }

  .fm-trailer-wrap {
    position: relative;
    padding-bottom: 56.25%;
    height: 0;
  }

  .fm-trailer-wrap iframe {
    position: absolute;
    top: 0; left: 0;
    width: 100%; height: 100%;
  }

  /* LOADING */
  .fm-loading {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
    color: rgba(255,255,255,0.3);
    font-size: 0.9rem;
    flex-direction: column;
    gap: 1rem;
    background: #0d0d0f;
  }

  .fm-spinner {
    width: 36px;
    height: 36px;
    border: 3px solid rgba(255,255,255,0.1);
    border-top-color: #e5181b;
    border-radius: 50%;
    animation: fmspin 0.8s linear infinite;
  }

  @keyframes fmspin { to { transform: rotate(360deg); } }
`;
document.head.appendChild(fmStyle);

// HTML
const fmDiv = document.createElement('div');
fmDiv.innerHTML = `
  <div class="fm-overlay" id="fm-overlay">
    <div class="fm-modal" id="fm-modal"></div>
  </div>
`;
document.body.appendChild(fmDiv);

// FUNÇÕES
window.abrirFilme = async function(titulo, moodLabel) {
  const overlay = document.getElementById('fm-overlay');
  const modal   = document.getElementById('fm-modal');

  overlay.classList.add('open');
  document.body.style.overflow = 'hidden';

  modal.innerHTML = `
    <div class="fm-loading">
      <div class="fm-spinner"></div>
      <span>A carregar...</span>
    </div>
  `;

  const filme = await getFilmeDetalhes(titulo);

  if (!filme) {
    modal.innerHTML = `
      <div class="fm-loading">
        <p>Filme não encontrado 😕</p>
        <button class="fm-back" onclick="fmFechar()">← Voltar</button>
      </div>
    `;
    return;
  }

  const estrelas = filme.nota
    ? '★'.repeat(Math.round(filme.nota / 2)) + '☆'.repeat(5 - Math.round(filme.nota / 2))
    : '';

  const relatedHTML = filme.similar?.length ? `
    <div class="fm-right">
      <div class="fm-related-title">Relacionados</div>
      ${filme.similar.map(s => `
        <div class="fm-related-card" onclick="abrirFilme('${s.titulo.replace(/'/g, "\\'")}')">
          ${s.poster
            ? `<img src="${s.poster}" class="fm-related-poster" alt="${s.titulo}">`
            : `<div class="fm-related-poster"></div>`}
          <div class="fm-related-info">
            <div class="fm-related-name">${s.titulo}</div>
            <div class="fm-related-year">${s.ano || ''}</div>
          </div>
        </div>`).join('')}
    </div>` : '';

  modal.innerHTML = `
    <div class="fm-hero" style="background:#0d0d0f">
      <div class="fm-backdrop" style="background-image:url('${filme.backdrop || filme.poster}')"></div>
      <div class="fm-gradient"></div>

      <div class="fm-topbar">
        <button class="fm-back" onclick="fmFechar()">← Voltar</button>
        <span class="fm-page-title">${moodLabel || 'PARA TI'}</span>
      </div>

      <div class="fm-content">
        <div class="fm-left">
          ${moodLabel ? `<span class="fm-mood-badge">${moodLabel}</span>` : ''}
          <h2 class="fm-titulo">${filme.titulo}</h2>
          <div class="fm-meta">
            <span>${filme.ano || ''}</span>
            ${filme.duracao ? `<span class="fm-dot"></span><span>${filme.duracao}</span>` : ''}
            ${filme.generos ? `<span class="fm-dot"></span><span>${filme.generos}</span>` : ''}
          </div>
          ${filme.nota ? `
            <div class="fm-rating">
              <span class="fm-stars">${estrelas}</span>
              <span class="fm-nota">${filme.nota} (${filme.votos} avaliações)</span>
            </div>` : ''}
          <p class="fm-sinopse">${filme.sinopse || 'Sem sinopse disponível.'}</p>
          <div class="fm-creditos">
            ${filme.diretor ? `<div><strong>Direção:</strong> ${filme.diretor}</div>` : ''}
            ${filme.elenco  ? `<div><strong>Elenco:</strong> ${filme.elenco}</div>`  : ''}
          </div>
          <div class="fm-btns">
            <button class="fm-btn-assistir" onclick="fmAssistir('${filme.trailer}')">
              ▶ ASSISTIR
            </button>
            <button class="fm-btn-lista">+ Minha Lista</button>
          </div>
        </div>
        ${relatedHTML}
      </div>
    </div>

    <div id="fm-trailer-container"></div>
  `;
};

window.fmAssistir = function(trailerKey) {
  if (!trailerKey || trailerKey === 'null') {
    alert('Trailer não disponível.');
    return;
  }
  const container = document.getElementById('fm-trailer-container');
  container.innerHTML = `
    <div class="fm-trailer-section">
      <div class="fm-trailer-wrap">
        <iframe src="https://www.youtube.com/embed/${trailerKey}?autoplay=1"
          frameborder="0" allowfullscreen
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture">
        </iframe>
      </div>
    </div>`;
  container.scrollIntoView({ behavior: 'smooth' });
};

window.fmFechar = function() {
  document.getElementById('fm-overlay').classList.remove('open');
  document.getElementById('fm-modal').innerHTML = '';
  document.body.style.overflow = '';
};

// Fechar com ESC
document.addEventListener('keydown', e => {
  if (e.key === 'Escape') fmFechar();
});