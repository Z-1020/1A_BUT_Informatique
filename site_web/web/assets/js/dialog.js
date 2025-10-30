function showMenu(page) {
    const dialog = document.getElementById('dialog');
    const overlay = dialog.querySelector('.overlay');
    const content = dialog.querySelector('.content');

    fetch('./page/' + page)
        .then(res => res.text())
        .then(html => {
            setTimeout(() => {
                content.innerHTML = html;
            }, 100);
        })
        .catch(error => {
            content.innerHTML = "<p>Une erreur est survenue.</p>";
            console.error(error);
        });


    dialog.classList.add('active');
    setTimeout(() => {
        overlay.classList.add('active');
        content.classList.add('active');
    }, 350);
}

function hideMenu() {
    const dialog = document.getElementById('dialog');
    const overlay = dialog.querySelector('.overlay');
    const content = dialog.querySelector('.content');

    content.classList.remove('active');
    overlay.classList.remove('active');
    setTimeout(() => {
        dialog.classList.remove('active');
    }, 350);
}


addEventListener('DOMContentLoaded', () => {
    const overlay = document.getElementById('dialog').querySelector('.overlay');

    overlay.addEventListener('click', () => {
        hideMenu();
    });
});