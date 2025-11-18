#!/bin/bash

# Fix JavaScript timing issues by wrapping code in DOMContentLoaded event listeners

echo "Fixing JavaScript timing issues in all pages..."

for page in about.html services.html portfolio.html contact.html; do
    echo "Fixing $page..."
    
    # Add DOMContentLoaded wrapper at the beginning of the main script
    sed -i '/<script>/a\\n            document.addEventListener('\''DOMContentLoaded'\'', function() {' "$page"
    
    # Add closing brace before the closing script tag
    sed -i '/<\/script>/i\\n            });' "$page"
    
    echo "Fixed $page"
done

echo "JavaScript timing fixes applied!"