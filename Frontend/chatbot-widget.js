// ── ESTILOS ────────────────────────────────────
const style = document.createElement('style');
style.textContent = `
  .flow-btn {
    position: fixed;
    bottom: 1.5rem;
    right: 1.5rem;
    z-index: 9999;
    width: 52px;
    height: 52px;
    background: #e5181b;
    border-radius: 50%;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 20px rgba(229,24,27,0.45);
    transition: all 0.2s;
    font-size: 1.3rem;
  }

  .flow-btn:hover { transform: scale(1.1); box-shadow: 0 4px 28px rgba(229,24,27,0.65); }

  .flow-btn.open { background: #333; }

  .flow-popup {
    position: fixed;
    bottom: 5.5rem;
    right: 1.5rem;
    z-index: 9998;
    width: 360px;
    background: #111116;
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 14px;
    overflow: hidden;
    display: none;
    flex-direction: column;
    box-shadow: 0 12px 40px rgba(0,0,0,0.6);
    max-height: 520px;
    font-family: 'Outfit', sans-serif;
  }

  .flow-popup.open { display: flex; }

  .flow-popup-head {
    padding: 1rem 1.2rem;
    border-bottom: 1px solid rgba(255,255,255,0.07);
    background: #0f0f14;
    flex-shrink: 0;
  }

  .flow-popup-title {
    font-size: 1rem;
    font-weight: 700;
    color: #fff;
    margin-bottom: 0.1rem;
  }

  .flow-popup-sub {
    font-size: 0.75rem;
    color: rgba(255,255,255,0.35);
  }

  .flow-msgs {
    flex: 1;
    overflow-y: auto;
    padding: 1rem;
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
    min-height: 200px;
  }

  .flow-msgs::-webkit-scrollbar { width: 3px; }
  .flow-msgs::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.1); border-radius: 2px; }

  .flow-msg-bot { display: flex; gap: 0.5rem; align-items: flex-start; }

  .flow-msg-avatar {
    width: 26px;
    height: 26px;
    border-radius: 50%;
    background: rgba(229,24,27,0.15);
    border: 1px solid rgba(229,24,27,0.25);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.75rem;
    flex-shrink: 0;
  }

  .flow-bubble-bot {
    background: #1a1a22;
    border: 1px solid rgba(255,255,255,0.07);
    border-radius: 4px 10px 10px 10px;
    padding: 0.65rem 0.85rem;
    max-width: 80%;
    font-size: 0.84rem;
    color: #fff;
    line-height: 1.55;
  }

  .flow-msg-user { display: flex; justify-content: flex-end; }

  .flow-bubble-user {
    background: #e5181b;
    border-radius: 10px 4px 10px 10px;
    padding: 0.65rem 0.85rem;
    max-width: 80%;
    font-size: 0.84rem;
    color: #fff;
    line-height: 1.55;
  }

  .flow-chips {
    display: flex;
    flex-wrap: wrap;
    gap: 0.35rem;
    margin-top: 0.6rem;
  }

  .flow-chip {
    font-size: 0.75rem;
    color: rgba(255,255,255,0.6);
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 20px;
    padding: 0.25rem 0.7rem;
    cursor: pointer;
    transition: all 0.2s;
    font-family: 'Outfit', sans-serif;
  }

  .flow-chip:hover {
    border-color: rgba(229,24,27,0.4);
    color: #fff;
    background: rgba(229,24,27,0.08);
  }

  .flow-typing {
    display: flex;
    align-items: center;
    gap: 3px;
    padding: 0.3rem 0;
  }

  .flow-typing span {
    width: 5px;
    height: 5px;
    border-radius: 50%;
    background: rgba(255,255,255,0.3);
    animation: flowblink 1.2s infinite;
  }

  .flow-typing span:nth-child(2) { animation-delay: 0.2s; }
  .flow-typing span:nth-child(3) { animation-delay: 0.4s; }

  @keyframes flowblink { 0%,80%,100%{opacity:0.3} 40%{opacity:1} }

  .flow-input-wrap {
    padding: 0.85rem 1rem;
    border-top: 1px solid rgba(255,255,255,0.07);
    display: flex;
    gap: 0.5rem;
    background: #0f0f14;
    flex-shrink: 0;
  }

  .flow-input {
    flex: 1;
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 8px;
    color: #fff;
    font-family: 'Outfit', sans-serif;
    font-size: 0.85rem;
    padding: 0.55rem 0.85rem;
    outline: none;
    transition: border-color 0.2s;
  }

  .flow-input:focus { border-color: rgba(229,24,27,0.4); }
  .flow-input::placeholder { color: rgba(255,255,255,0.2); }

  .flow-send {
    width: 36px;
    height: 36px;
    background: #e5181b;
    border-radius: 8px;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    transition: all 0.2s;
  }

  .flow-send:hover { opacity: 0.85; }

  .flow-msg-bot, .flow-msg-user {
    animation: flowfade 0.3s forwards;
  }

  @keyframes flowfade { from{opacity:0;transform:translateY(6px)} to{opacity:1;transform:translateY(0)} }
`;
document.head.appendChild(style);

// ── HTML ────────────────────────────────────────
const widget = document.createElement('div');
widget.innerHTML = `
  <div class="flow-popup" id="flow-popup">
    <div class="flow-popup-head">
      <div class="flow-popup-title">Flow Bot</div>
      <div class="flow-popup-sub">Assistente de descoberta de filmes</div>
    </div>
    <div class="flow-msgs" id="flow-msgs"></div>
    <div class="flow-input-wrap">
      <input class="flow-input" id="flow-input" placeholder="Escreve a tua mensagem..." autocomplete="off">
      <button class="flow-send" id="flow-send">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2">
          <line x1="22" y1="2" x2="11" y2="13"/>
          <polygon points="22 2 15 22 11 13 2 9 22 2" fill="#fff"/>
        </svg>
      </button>
    </div>
  </div>
  <button class="flow-btn" id="flow-btn">
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2">
      <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
    </svg>
  </button>
`;
document.body.appendChild(widget);

// ── LÓGICA ──────────────────────────────────────
const popup   = document.getElementById('flow-popup');
const btn     = document.getElementById('flow-btn');
const msgs    = document.getElementById('flow-msgs');
const input   = document.getElementById('flow-input');
const sendBtn = document.getElementById('flow-send');

let isOpen    = false;
let iniciado  = false;
let isLoading = false;
const history = [];

btn.addEventListener('click', () => {
  isOpen = !isOpen;
  popup.classList.toggle('open', isOpen);
  btn.classList.toggle('open', isOpen);
  if (isOpen && !iniciado) {
    iniciado = true;
    addBotMsg('Olá! Sou o Flow Bot. Como posso ajudar-te a descobrir filmes hoje?', true);
  }
});

input.addEventListener('keydown', e => { if (e.key === 'Enter') sendMsg(); });
sendBtn.addEventListener('click', sendMsg);

function addBotMsg(text, withChips = false) {
  const div = document.createElement('div');
  div.className = 'flow-msg-bot';
  div.innerHTML = `
    <div class="flow-msg-avatar">🎬</div>
    <div class="flow-bubble-bot">
      ${text}
      ${withChips ? `
        <div class="flow-chips">
          <span class="flow-chip" onclick="flowChip(this)">Quero adrenalina 🔥</span>
          <span class="flow-chip" onclick="flowChip(this)">Preciso relaxar 😌</span>
          <span class="flow-chip" onclick="flowChip(this)">Algo romântico 💕</span>
          <span class="flow-chip" onclick="flowChip(this)">Surpreende-me ✨</span>
        </div>` : ''}
    </div>
  `;
  msgs.appendChild(div);
  msgs.scrollTop = msgs.scrollHeight;
}

function addUserMsg(text) {
  const div = document.createElement('div');
  div.className = 'flow-msg-user';
  div.innerHTML = `<div class="flow-bubble-user">${text}</div>`;
  msgs.appendChild(div);
  msgs.scrollTop = msgs.scrollHeight;
}

function showTyping() {
  const div = document.createElement('div');
  div.className = 'flow-msg-bot';
  div.id = 'flow-typing';
  div.innerHTML = `
    <div class="flow-msg-avatar">🎬</div>
    <div class="flow-bubble-bot">
      <div class="flow-typing"><span></span><span></span><span></span></div>
    </div>
  `;
  msgs.appendChild(div);
  msgs.scrollTop = msgs.scrollHeight;
}

function hideTyping() {
  const el = document.getElementById('flow-typing');
  if (el) el.remove();
}

async function sendMsg() {
  const text = input.value.trim();
  if (!text || isLoading) return;
  input.value = '';
  addUserMsg(text);
  await getAIResponse(text);
}

window.flowChip = function(el) {
  const text = el.textContent.trim();
  addUserMsg(text);
  getAIResponse(text);
};

async function getAIResponse(userMsg) {
  isLoading = true;
  showTyping();

  history.push({ role: 'user', content: userMsg });

  try {
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        model: 'claude-sonnet-4-20250514',
        max_tokens: 1000,
        system: `És o Flow Bot, um assistente de descoberta de filmes e séries da plataforma Filmflow — uma app que mostra tendências de filmes em Portugal por cidade e mood.

O teu objetivo é perceber o mood do utilizador e sugerir filmes/séries populares em Portugal.

Regras:
- Responde sempre em português de Portugal
- Sê informal, simpático e conciso
- Sugere sempre 2-3 filmes/séries concretos com o nome, género e ano
- Usa emojis com moderação
- Mantém respostas curtas (máximo 3-4 linhas)
- Se o utilizador quiser mais recomendações, diz-lhe para ir à secção "Para Ti" da app`,
        messages: history
      })
    });

    const data = await response.json();
    const reply = data.content[0].text;
    history.push({ role: 'assistant', content: reply });

    hideTyping();
    addBotMsg(reply);

  } catch (err) {
    hideTyping();
    addBotMsg('Ups, tive um problema técnico 😅 Tenta outra vez!');
  }

  isLoading = false;
}