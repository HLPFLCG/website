#!/bin/bash

# Apply the correct loading screen and particle background fixes to all pages

# Function to fix a page
fix_page() {
    local page=$1
    
    echo "Fixing $page..."
    
    # Add missing loading-particle styles
    if ! grep -q "loading-particle {" "$page"; then
        # Add loading-particle styles after loading-particles
        sed -i '/\.loading-particles {/,/}/a\\n           .loading-particle {\
               position: absolute;\
               background: radial-gradient(circle, rgba(200, 121, 65, 0.9) 0%, rgba(200, 121, 65, 0.3) 50%, transparent 70%);\
               box-shadow: \
                   0 0 4px rgba(200, 121, 65, 0.8),\
                   0 0 8px rgba(200, 121, 65, 0.4),\
                   0 0 12px rgba(200, 121, 65, 0.2);\
               border-radius: 50%;\
               animation: float 15s infinite ease-in-out, twinkle 2s infinite ease-in-out, drift 6s infinite ease-in-out;\
           }' "$page"
    fi
    
    # Add missing animation keyframes
    if ! grep -q "@keyframes twinkle" "$page"; then
        # Add after the float keyframe
        sed -i '/@keyframes float {/,/}/a\\n           @keyframes twinkle {\
               0%, 100% { opacity: 0.3; }\
               50% { opacity: 1; }\
           }\
           \
           @keyframes drift {\
               0%, 100% { transform: translateX(0); }\
               25% { transform: translateX(30px); }\
               75% { transform: translateX(-30px); }\
           }' "$page"
    fi
    
    # Fix loading particles JavaScript
    if grep -q "particleCount = 30" "$page"; then
        # Replace the old loading particles code with the correct one
        sed -i '/const particlesContainer = document.querySelector('\''\.loading-particles'\'');/,/particlesContainer.appendChild(particle);/c\
           // Create Loading Particles - Dense Starlight Effect\
           const loadingParticlesContainer = document.getElementById('\''loadingParticles'\'');\
           for (let i = 0; i < 30; i++) {\
               const particle = document.createElement('\''div'\'');\
               particle.className = '\''loading-particle'\'';\
               \
               // Smaller particles for more elegant effect (1px to 3px)\
               const size = Math.random() * 2 + 1;\
               particle.style.width = size + '\''px'\'';\
               particle.style.height = size + '\''px'\'';\
               \
               // Random starting position\
               particle.style.left = Math.random() * 100 + '\''%'\'';\
               particle.style.top = Math.random() * 100 + '\''%'\'';\
               \
               // Varied animation properties for natural movement\
               particle.style.animationDelay = Math.random() * 8 + '\''s'\'';\
               particle.style.animationDuration = (Math.random() * 15 + 20) + '\''s'\'';\
               \
               loadingParticlesContainer.appendChild(particle);\
           }' "$page"
    fi
    
    # Fix floating particles count
    if grep -q "Create Floating Particles" "$page"; then
        sed -i 's/for (let i = 0; i < 50; i++) {/for (let i = 0; i < 200; i++) {/g' "$page"
        sed -i 's/const size = Math.random() \* 2 + 1;/const size = Math.random() * 2 + 1;/g' "$page"
    fi
    
    echo "Fixed $page"
}

# Fix each page
for page in about.html services.html portfolio.html contact.html; do
    fix_page "$page"
done

echo "All pages fixed!"