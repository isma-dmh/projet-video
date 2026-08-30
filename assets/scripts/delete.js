document.addEventListener('submit', function (e) {
    if (e.target.matches('.js-confirm-form')) {
        if (!confirm(e.target.dataset.confirm)) {
            e.preventDefault();
        }
    }
});