document.addEventListener('DOMContentLoaded', () => {
    const currentPage = document.body.dataset.page;

    document.querySelectorAll('[data-nav]').forEach((link) => {
        const linkPage = link.dataset.nav;

        if (linkPage === currentPage) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });

    const yearNode = document.querySelector('[data-current-year]');

    if (yearNode) {
        yearNode.textContent = new Date().getFullYear();
    }
});
