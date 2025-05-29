const themeToggle = document.getElementById('themeToggle');
const prefersDarkScheme = window.matchMedia('(prefers-color-scheme: dark)');

function initTheme() {
    const savedTheme = localStorage.getItem('theme');
    if (savedTheme === 'dark' || (!savedTheme && prefersDarkScheme.matches)) {
        document.documentElement.setAttribute('data-theme', 'dark');
    } else {
        document.documentElement.setAttribute('data-theme', 'light');
    }
}

function toggleTheme() {
    const currentTheme = document.documentElement.getAttribute('data-theme') || 'light';
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    
    document.documentElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
}

initTheme();
themeToggle.addEventListener('click', toggleTheme);

document.addEventListener('DOMContentLoaded', () => {
    const statValues = document.querySelectorAll('.stat-value');
    
    const animateCounter = (element, target, suffix) => {
        const duration = 2000;
        const startTime = performance.now();
        const startValue = 0;
        
        function updateCounter(currentTime) {
            const elapsedTime = currentTime - startTime;
            const progress = Math.min(elapsedTime / duration, 1);
            
            const easing = t => t < 0.5 ? 4 * t * t * t : (t - 1) * (2 * t - 2) * (2 * t - 2) + 1;
            
            const easedProgress = easing(progress);
            
            if (target % 1 !== 0) {
                const value = (easedProgress * target).toFixed(1);
                element.textContent = value + suffix;
            } else {
                const value = Math.floor(easedProgress * target);
                element.textContent = value + suffix;
            }
            
            if (progress < 1) {
                requestAnimationFrame(updateCounter);
            }
        }
        
        requestAnimationFrame(updateCounter);
    };
    
    const animatedElements = document.querySelectorAll('.animate-fade-in-up, .animate-zoom-in');
    
    const isElementInViewport = el => {
        const rect = el.getBoundingClientRect();
        const windowHeight = window.innerHeight || document.documentElement.clientHeight;
        
        return (
            rect.top <= windowHeight * 0.7 &&
            rect.bottom >= 0 &&
            rect.left >= 0 &&
            rect.right <= (window.innerWidth || document.documentElement.clientWidth)
        );
    };
    
    animatedElements.forEach(el => {
        el.style.opacity = '0';
        el.style.animation = 'none';
    });
    
    const checkVisibility = () => {
        statValues.forEach(el => {
            if (isElementInViewport(el) && !el.classList.contains('animated')) {
                el.classList.add('animated');
                const target = parseFloat(el.getAttribute('data-target'));
                const suffix = el.getAttribute('data-suffix');
                animateCounter(el, target, suffix);
            }
        });
        
        animatedElements.forEach(el => {
            if (isElementInViewport(el) && !el.classList.contains('animated-scroll')) {
                el.classList.add('animated-scroll');
                el.style.opacity = '';
                el.style.animation = '';
                
                void el.offsetWidth;
                
                if (el.classList.contains('animate-fade-in-up')) {
                    el.style.animation = 'fadeInUp 0.8s ease-out forwards';
                } else if (el.classList.contains('animate-zoom-in')) {
                    el.style.animation = 'zoomIn 0.8s ease-out forwards';
                }
            }
        });
    };
    
    setTimeout(checkVisibility, 100);
    window.addEventListener('scroll', checkVisibility);
    window.addEventListener('resize', checkVisibility);
});