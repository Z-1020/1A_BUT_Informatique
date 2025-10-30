function initPayerJS() {
    console.log('initPayerJS appelé');
    const input = document.getElementById('points_utilises');
    const maxPoints = document.getElementById('max_points');
    const messageErreur = document.getElementById('info_points');

    const reductionSpan = document.getElementById('reduction-montant');
    if (!input || !reductionSpan) {
        console.log('payer.js : éléments non trouvés');
        return;
    }

    function updateReduction() {
        messageErreur.classList.remove('active');

        let val = input.value;

        let reduction = 0;
        if (/^\d+$/.test(val)) {
            reduction = parseFloat(parseFloat(val) * 0.01).toFixed(2).replace('.', ',');
        } else {
            reduction = "0,00";
        }

        if (parseFloat(parseFloat(val) * 0.01) > parseFloat(maxPoints.value)) {
            input.value = "";
            reductionSpan.textContent = "0,00" + " €";
            messageErreur.classList.add('active');
        } else {
            reductionSpan.textContent = reduction + " €";
        }

        if (input.value > maxPoints.value) {
            input.value = "";
            reductionSpan.textContent = "0,00" + " €";
            messageErreur.classList.add('active');
        }
    }

    input.addEventListener('input', updateReduction);
    updateReduction();
}

initPayerJS();