function loadPage(page, button = null, updateURL = true) {
    const fullRedirectPages = ['signin.php', 'signup.php'];

    if (fullRedirectPages.includes(page)) {
        window.location.href = './web/page/' + page;
        return;
    }

    const content = document.getElementById('content');

    document.querySelectorAll('.navbar button').forEach(btn => btn.classList.remove('active'));
    if (button) button.classList.add('active');

    // roue de chargement
    content.innerHTML = '<div class="centered"><div class="loader"></div></div>';

    if (updateURL) history.pushState({}, '', '?page=' + page);

    setTimeout(() => {
        console.log('ok');
    }, 5000);

    // verification de la présence de l'etension .php
    if (!page.endsWith('.php')) {
        content.innerHTML = "<p>Une erreur est survenue car vous avez oublié d'ajouter l'extension .php à la chaîne de caractère.</p>";
        return;
    }

    fetch('./web/page/' + page)
        .then(res => {
            if (!res.ok) throw new Error('Erreur lors du chargement');
            if (res.redirected) {
                window.location.href = res.url;
                return;
            }
            return res.text()
        })
        .then(html => {
            content.style.opacity = 0;
            setTimeout(() => {
                content.innerHTML = html;
                if (window.initPayerJS) window.initPayerJS();
                window.scrollTo({ top: 0, behavior: 'smooth' });
                content.style.opacity = 1;
            }, 100);
        })
        .catch(error => {
            content.innerHTML = "<p>Une erreur est survenue.</p>";
            console.error(error);
        });
}

// revenir à la page précédente
function backPage() {
    history.back();
}

// recharger la page
function reloadPage() {
    let page = new URLSearchParams(location.search).get('page') || 'accueil.php';
    let btn = document.getElementById('btn-' + page.split(".")[0]);
    loadPage(page, btn, false);
}

// charger la page accueil par defaut
window.onload = () => {
    reloadPage();
};

// revenir à la page précédente avec le bouton retour du navigateur
window.onpopstate = () => {
    reloadPage();
};