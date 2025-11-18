#!/bin/bash

# Clean fix script to add loading particle functionality to all pages

for page in about.html services.html portfolio.html contact.html; do
    echo "Fixing $page..."
    
    # Add loading-particle styles right after loading-particles closing brace
    if ! grep -q "loading-particle {" "$page"; then
        sed -i '/\.loading-particles {/,/}/a\\
           .loading-particle {\
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
    
    # Add missing animation keyframes if not present
    if ! grep -q "@keyframes twinkle" "$page"; then
        sed -i '/@keyframes float {/,/}/a\\
           @keyframes twinkle {\
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
    
    # Update floating particles count to match index.html
    sed -i 's/for (let i = 0; i < 50; i++) {/for (let i = 0; i < 200; i++) {/g' "$page"
    
    # For contact page only: fix loading particles to use loading-particle class
    if [[ "$page" == "contact.html" ]]; then
        # Replace only the first occurrence (in loading section)
        sed -i '0,/particle\.className = '\''particle'\'';/s//particle\.className = '\''loading-particle'\'';/' "$page"
    fi
    
    echo "Fixed $page"
done

echo "All pages fixed!"