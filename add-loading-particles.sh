#!/bin/bash

# Add loading-particle styles after loading-particles in each page
for page in about.html services.html portfolio.html contact.html; do
    echo "Adding loading-particle styles to $page..."
    
    # Add the loading-particle styles after the loading-particles closing brace
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
    
    echo "Added styles to $page"
done

echo "All loading-particle styles added!"