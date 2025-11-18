#!/bin/bash

# Clean up duplicate loading-particle styles
for page in about.html services.html portfolio.html contact.html; do
    echo "Cleaning up $page..."
    
    # Remove all duplicate loading-particle definitions, keep only the first one
    awk '
    BEGIN { found = 0 }
    /\.loading-particle {/ {
        if (found == 0) {
            print
            found = 1
            in_block = 1
            next
        } else {
            in_block = 1
            next
        }
    }
    in_block && /}/ {
        if (found == 1) {
            print
            in_block = 0
        }
        next
    }
    in_block { next }
    { print }
    ' "$page" > "${page}.tmp" && mv "${page}.tmp" "$page"
    
    echo "Cleaned up $page"
done

echo "All duplicates cleaned!"