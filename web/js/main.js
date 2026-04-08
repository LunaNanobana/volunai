// VolunAI – Main JavaScript

/* ── Scroll animations ── */
const fadeEls = document.querySelectorAll('.fade-up');
const observer = new IntersectionObserver(entries => {
  entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
}, { threshold: 0.15 });
fadeEls.forEach(el => observer.observe(el));

/* ── Active nav link ── */
function setActiveNav() {
  const links = document.querySelectorAll('.nav-links a');
  links.forEach(l => {
    l.classList.toggle('active', l.href === window.location.href ||
      l.getAttribute('href') === window.location.pathname.split('/').pop());
  });
}
setActiveNav();

/* ── Modal helpers ── */
window.openModal = id => {
  document.getElementById(id)?.classList.add('show');
  document.body.style.overflow = 'hidden';
};
window.closeModal = id => {
  document.getElementById(id)?.classList.remove('show');
  document.body.style.overflow = '';
};
document.querySelectorAll('.overlay').forEach(o => {
  o.addEventListener('click', e => { if (e.target === o) closeModal(o.id); });
});

/* ── Category filter ── */
document.querySelectorAll('.cat-card').forEach(card => {
  card.addEventListener('click', () => {
    document.querySelectorAll('.cat-card').forEach(c => c.classList.remove('active'));
    card.classList.add('active');
    const cat = card.dataset.cat;
    filterEvents(cat);
  });
});

function filterEvents(cat) {
  document.querySelectorAll('.event-card').forEach(card => {
    const cardCat = card.dataset.category || '';
    card.style.display = (!cat || cat === 'all' || cardCat === cat) ? '' : 'none';
  });
}

/* ── Rating tabs ── */
document.querySelectorAll('.r-tab').forEach(tab => {
  tab.addEventListener('click', () => {
    tab.closest('.rating-card').querySelectorAll('.r-tab').forEach(t => t.classList.remove('active'));
    tab.classList.add('active');
  });
});

/* ── AI Chat demo ── */
const chatForm = document.getElementById('chatDemoForm');
if (chatForm) {
  chatForm.addEventListener('submit', e => {
    e.preventDefault();
    const input = chatForm.querySelector('input');
    const msgs = document.getElementById('chatMessages');
    if (!input.value.trim()) return;

    // user bubble
    const userMsg = document.createElement('div');
    userMsg.className = 'msg user';
    userMsg.textContent = input.value;
    msgs.appendChild(userMsg);
    input.value = '';
    msgs.scrollTop = msgs.scrollHeight;

    // AI typing
    setTimeout(() => {
      const aiMsg = document.createElement('div');
      aiMsg.className = 'msg ai';
      aiMsg.textContent = 'Понял! Ищу подходящие мероприятия волонтёров для вас...';
      msgs.appendChild(aiMsg);
      msgs.scrollTop = msgs.scrollHeight;
    }, 700);
  });
}

/* ── Counter animation ── */
function animateCounters() {
  document.querySelectorAll('.stat-num[data-target]').forEach(el => {
    const target = +el.dataset.target;
    const suffix = el.dataset.suffix || '';
    let current = 0;
    const step = Math.ceil(target / 60);
    const timer = setInterval(() => {
      current = Math.min(current + step, target);
      el.textContent = current.toLocaleString() + suffix;
      if (current >= target) clearInterval(timer);
    }, 24);
  });
}

const statsSection = document.querySelector('.stats');
if (statsSection) {
  const statsObs = new IntersectionObserver(entries => {
    if (entries[0].isIntersecting) { animateCounters(); statsObs.disconnect(); }
  }, { threshold: 0.4 });
  statsObs.observe(statsSection);
}

/* ── Smooth scroll ── */
document.querySelectorAll('a[href^="#"]').forEach(a => {
  a.addEventListener('click', e => {
    const target = document.querySelector(a.getAttribute('href'));
    if (target) { e.preventDefault(); target.scrollIntoView({ behavior: 'smooth' }); }
  });
});
