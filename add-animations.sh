#!/bin/bash

# Add missing animation keyframes to each page
for page in about.html services.html portfolio.html contact.html; do
    echo "Adding animations to $page..."
    
    # Add twinkle and drift keyframes after the float keyframe
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
    
    echo "Added animations to $page"
done

echo "All animations added!"