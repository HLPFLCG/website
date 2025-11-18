const fs = require('fs');
const path = require('path');

// Read the working index.html as template
const indexPath = 'index.html';
const indexContent = fs.readFileSync(indexPath, 'utf8');

// Pages to fix
const pages = ['about.html', 'services.html', 'portfolio.html', 'contact.html'];

pages.forEach(page => {
    const pageContent = fs.readFileSync(page, 'utf8');
    
    // Extract page-specific content (title and main content)
    const titleMatch = pageContent.match(/<title>(.*?)<\/title>/);
    const pageTitle = titleMatch ? titleMatch[1] : '';
    
    // Find the main content section (between header and footer)
    const headerMatch = pageContent.match(/<header[\s\S]*?<\/header>/);
    const headerEnd = pageContent.indexOf('</header>');
    
    const footerMatch = pageContent.match(/<!-- Footer[\s\S]*?<\/footer>/);
    const footerStart = footerMatch ? pageContent.indexOf(footerMatch[0]) : -1;
    
    let pageMainContent = '';
    if (headerEnd !== -1 && footerStart !== -1) {
        pageMainContent = pageContent.substring(headerEnd, footerStart);
    }
    
    // Create new page content using index.html structure
    let newContent = indexContent;
    
    // Update title
    newContent = newContent.replace(/<title>.*?<\/title>/, `<title>${pageTitle}</title>`);
    
    // Update active nav item
    const pageName = page.replace('.html', '');
    const navMap = {
        'about': { home: '', services: '', portfolio: '', about: 'active', contact: '' },
        'services': { home: '', services: 'active', portfolio: '', about: '', contact: '' },
        'portfolio': { home: '', services: '', portfolio: 'active', about: '', contact: '' },
        'contact': { home: '', services: '', portfolio: '', about: '', contact: 'active' }
    };
    
    if (navMap[pageName]) {
        Object.entries(navMap[pageName]).forEach(([pageClass, active]) => {
            const navPattern = new RegExp(`(<li><a href="${pageClass === 'home' ? 'index' : pageClass}\\.html")[^>]*)(class="[^"]*)?"([^>]*>.*?</a></li>)`, 'g');
            newContent = newContent.replace(navPattern, (match, href, classAttr, rest) => {
                if (active) {
                    return `${href} class="active"${rest}`;
                } else {
                    return `${href}${rest}`;
                }
            });
        });
    }
    
    // Replace main content (keep hero section structure but update content)
    if (pageMainContent) {
        // Extract the hero content specific to each page
        const heroMatch = pageMainContent.match(/<section class="hero"[\s\S]*?<\/section>/);
        const heroSection = heroMatch ? heroMatch[0] : '';
        
        if (heroSection) {
            // Replace the index.html hero section with the page-specific one
            const indexHeroMatch = newContent.match(/<section class="hero" id="home">[\s\S]*?<\/section>/);
            if (indexHeroMatch) {
                newContent = newContent.replace(indexHeroMatch[0], heroSection);
            }
        }
        
        // Find the rest of the content sections
        const contentSections = pageMainContent.replace(/<section class="hero"[\s\S]*?<\/section>/, '');
        
        // Replace content after hero in index.html
        const afterHeroMatch = newContent.match(/<section class="hero" id="home">[\s\S]*?(?=<section class="value-props"|<div class="trust-badges">)/);
        if (afterHeroMatch && contentSections) {
            newContent = newContent.replace(
                afterHeroMatch[0],
                afterHeroMatch[0] + contentSections
            );
        }
    }
    
    // Write the fixed page
    fs.writeFileSync(page, newContent);
    console.log(`Fixed ${page}`);
});

console.log('All pages fixed!');