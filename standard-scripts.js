// Standard Loading Screen and Particle Functionality

document.addEventListener('DOMContentLoaded', function() {
    
    // Loading Screen Functionality
    const loadingScreen = document.getElementById('loadingScreen');
    const loadingBar = document.getElementById('loadingBar');
    const loadingPercentage = document.getElementById('loadingPercentage');
    
    if (loadingScreen && loadingBar && loadingPercentage) {
        let progress = 0;
        
        const loadingInterval = setInterval(() => {
            progress += Math.random() * 15;
            if (progress > 100) progress = 100;
            
            loadingBar.style.width = progress + '%';
            loadingPercentage.textContent = Math.floor(progress) + '%';
            
            if (progress >= 100) {
                clearInterval(loadingInterval);
                setTimeout(() => {
                    loadingScreen.classList.add('hidden');
                }, 500);
            }
        }, 100);
    }
    
    // Create Loading Particles
    const loadingParticlesContainer = document.getElementById('loadingParticles');
    if (loadingParticlesContainer) {
        for (let i = 0; i < 30; i++) {
            const particle = document.createElement('div');
            particle.className = 'loading-particle';
            
            // Random size between 1px and 3px
            const size = Math.random() * 2 + 1;
            particle.style.width = size + 'px';
            particle.style.height = size + 'px';
            
            // Random starting position
            particle.style.left = Math.random() * 100 + '%';
            particle.style.top = Math.random() * 100 + '%';
            
            // Varied animation properties for natural movement
            particle.style.animationDelay = Math.random() * 8 + 's';
            particle.style.animationDuration = (Math.random() * 10 + 15) + 's';
            
            loadingParticlesContainer.appendChild(particle);
        }
    }
    
    // Create Floating Particles - Dense Starlight Effect
    const particlesContainer = document.getElementById('particles');
    if (particlesContainer) {
        for (let i = 0; i < 200; i++) {
            const particle = document.createElement('div');
            particle.className = 'particle';
            
            // Smaller particles (1px to 3px)
            const size = Math.random() * 2 + 1;
            particle.style.width = size + 'px';
            particle.style.height = size + 'px';
            
            particle.style.left = Math.random() * 100 + '%';
            particle.style.top = Math.random() * 100 + '%';
            particle.style.animationDelay = Math.random() * 25 + 's';
            particle.style.animationDuration = (Math.random() * 15 + 20) + 's';
            particlesContainer.appendChild(particle);
        }
    }
    
    // Header Scroll Effect
    const header = document.getElementById('header');
    if (header) {
        window.addEventListener('scroll', () => {
            if (window.scrollY > 100) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });
    }
    
    // Mobile Menu Toggle
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    const navLinks = document.querySelector('.nav-links');
    
    if (mobileMenuToggle && navLinks) {
        mobileMenuToggle.addEventListener('click', () => {
            navLinks.classList.toggle('active');
            mobileMenuToggle.textContent = navLinks.classList.contains('active') ? '✕' : '☰';
        });
    }
    
    // Reveal Animation on Scroll
    const reveals = document.querySelectorAll('.reveal');
    const revealOnScroll = () => {
        reveals.forEach(element => {
            const elementTop = element.getBoundingClientRect().top;
            const windowHeight = window.innerHeight;
            if (elementTop < windowHeight - 100) {
                element.classList.add('active');
            }
        });
    };
    window.addEventListener('scroll', revealOnScroll);
    revealOnScroll();
    
    // FAQ Accordion
    const faqItems = document.querySelectorAll('.faq-item');
    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');
        const answer = item.querySelector('.faq-answer');
        
        if (question && answer) {
            question.addEventListener('click', () => {
                const isOpen = answer.style.maxHeight;
                
                // Close all other FAQ items
                faqItems.forEach(otherItem => {
                    const otherAnswer = otherItem.querySelector('.faq-answer');
                    const otherQuestion = otherItem.querySelector('.faq-question');
                    if (otherAnswer && otherQuestion !== question) {
                        otherAnswer.style.maxHeight = null;
                        otherQuestion.classList.remove('active');
                    }
                });
                
                // Toggle current item
                if (isOpen) {
                    answer.style.maxHeight = null;
                    question.classList.remove('active');
                } else {
                    answer.style.maxHeight = answer.scrollHeight + 'px';
                    question.classList.add('active');
                }
            });
        }
    });
});

// Cookie Consent
function acceptCookies() {
    localStorage.setItem('cookieConsent', 'accepted');
    document.getElementById('cookieBanner').style.display = 'none';
}

function declineCookies() {
    localStorage.setItem('cookieConsent', 'declined');
    document.getElementById('cookieBanner').style.display = 'none';
}

// Check cookie consent on load
window.addEventListener('load', () => {
    const consent = localStorage.getItem('cookieConsent');
    const cookieBanner = document.getElementById('cookieBanner');
    if (cookieBanner && (consent === 'accepted' || consent === 'declined')) {
        cookieBanner.style.display = 'none';
    }
});