#!/bin/bash

echo "Applying clean fixes to all pages..."

# Fix 1: Add loading-particle styles to each page (only once)
for page in about.html services.html portfolio.html contact.html; do
    if ! grep -q "loading-particle {" "$page"; then
        echo "Adding loading-particle styles to $page..."
        
        # Add after loading-particles section
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
done

# Fix 2: Add missing animations to each page (only once)
for page in about.html services.html portfolio.html contact.html; do
    if ! grep -q "@keyframes twinkle" "$page"; then
        echo "Adding animations to $page..."
        
        # Add after float keyframe
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
done

# Fix 3: Update floating particles count to 200
for page in about.html services.html portfolio.html contact.html; do
    sed -i 's/for (let i = 0; i < 50; i++) {/for (let i = 0; i < 200; i++) {/g' "$page"
done

# Fix 4: Update contact page to use loading-particle class
if grep -q "particleCount = 30" contact.html; then
    sed -i '/particleCount = 30/,/particlesContainer\.appendChild(particle);/ s/particle\.className = '\''particle'\'';/particle\.className = '\''loading-particle'\'';/' contact.html
fi

echo "All clean fixes applied!"