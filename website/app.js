const themeToggle = document.getElementById('themeToggle');
const body = document.body;

const currentTheme = localStorage.getItem('theme') || 'light';
body.setAttribute('data-theme', currentTheme);

themeToggle.addEventListener('click', () => {
    const currentTheme = body.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    
    body.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
});

function animateCounter(element, target, suffix = '', duration = 2000) {
    const start = 0;
    const startTime = performance.now();
    
    function updateCounter(currentTime) {
        const elapsed = currentTime - startTime;
        const progress = Math.min(elapsed / duration, 1);
        
        const easeOutQuart = 1 - Math.pow(1 - progress, 4);
        const current = start + (target - start) * easeOutQuart;
        
        if (target % 1 !== 0) {
            element.textContent = current.toFixed(1) + suffix;
        } else {
            element.textContent = Math.floor(current).toLocaleString() + suffix;
        }
        
        if (progress < 1) {
            requestAnimationFrame(updateCounter);
        }
    }
    
    requestAnimationFrame(updateCounter);
}

const observerOptions = {
    threshold: 0.01, 
    rootMargin: '0px 0px -10px 0px' 
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.animationPlayState = 'running';
            
            if (entry.target.classList.contains('stat-item')) {
                const valueElement = entry.target.querySelector('.stat-value');
                const target = parseFloat(valueElement.getAttribute('data-target'));
                const suffix = valueElement.getAttribute('data-suffix') || '';
                
                animateCounter(valueElement, target, suffix);
            }
            
            observer.unobserve(entry.target);
        }
    });
}, observerOptions);

function updateLanguage(lang) {
    if (!translations[lang]) return;
    
    document.documentElement.lang = lang;
    localStorage.setItem('language', lang);
    
    const elements = document.querySelectorAll('[data-i18n]');
    elements.forEach(el => {
        const key = el.getAttribute('data-i18n');
        if (translations[lang][key]) {
            if (translations[lang][key].includes('<')) {
                el.innerHTML = translations[lang][key];
            } else {
                el.textContent = translations[lang][key];
            }
        }
    });
}

async function fetchAppStoreRating() {
    try {
        const appId = '6746582572';
        
        const ratingElement = document.querySelector('.stat-item:nth-child(3) .stat-value');
        if (ratingElement) {
            ratingElement.textContent = "Loading...";
        }
        
        fetch(`https://api.allorigins.win/get?url=${encodeURIComponent(`https://itunes.apple.com/lookup?id=${appId}&country=fr`)}`)
            .then(response => response.json())
            .then(data => {
                const text = data.contents;
                const match = text.match(/"averageUserRating":(\d+(\.\d+)?)/);
                if (match && match[1]) {
                    const rating = parseFloat(match[1]);
                    
                    if (ratingElement) {
                        ratingElement.setAttribute('data-target', rating);
                        animateCounter(ratingElement, rating, '/5');
                    }
                }
            })
            .catch(error => {
                console.error('Error while getting data:', error);
                if (ratingElement) {
                    ratingElement.textContent = "5/5";
                }
            });
    } catch (error) {
        console.error('Errror while getting review data:', error);
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const animatedElements = document.querySelectorAll('.animate-fade-in-up, .animate-zoom-in, .stat-item');
    
    animatedElements.forEach(el => {
        el.style.animationPlayState = 'paused';
        observer.observe(el);
    });
    
    const savedLanguage = localStorage.getItem('language') || 'fr';
    const langSelector = document.getElementById('langSelector');
    if (langSelector) {
        langSelector.value = savedLanguage;
        updateLanguage(savedLanguage);
        
        langSelector.addEventListener('change', () => {
            updateLanguage(langSelector.value);
        });
    }
    
    fetchAppStoreRating();
});

document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

document.querySelectorAll('.btn').forEach(button => {
    button.addEventListener('mouseenter', function() {
        this.style.transform = 'scale(1.05)';
    });
    
    button.addEventListener('mouseleave', function() {
        this.style.transform = 'scale(1)';
    });
});

window.addEventListener('scroll', () => {
    const scrolled = window.pageYOffset;
    const parallax = document.querySelector('.app-mockup');
    const speed = 0.5;
    
    if (parallax) {
        parallax.style.transform = `translateY(${scrolled * speed}px)`;
    }
});

window.addEventListener('load', () => {
    document.body.classList.add('loaded');
});

function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

const optimizedScrollHandler = debounce(() => {
    const scrolled = window.pageYOffset;
    const parallax = document.querySelector('.app-mockup');
    const speed = 0.5;
    
    if (parallax) {
        parallax.style.transform = `translateY(${scrolled * speed}px)`;
    }
}, 10);

window.addEventListener('scroll', optimizedScrollHandler);

document.addEventListener('click', (e) => {
    if (e.target.classList.contains('btn')) {
        e.target.style.transform = 'scale(0.95)';
        setTimeout(() => {
            e.target.style.transform = '';
        }, 150);
    }
});

document.addEventListener('keydown', (e) => {
    if (e.key === 'Tab') {
        document.body.classList.add('keyboard-navigation');
    }
});

document.addEventListener('mousedown', () => {
    document.body.classList.remove('keyboard-navigation');
});

const style = document.createElement('style');
style.textContent = `
    .keyboard-navigation *:focus {
        outline: 2px solid var(--text-color);
        outline-offset: 2px;
    }
`;
document.head.appendChild(style);