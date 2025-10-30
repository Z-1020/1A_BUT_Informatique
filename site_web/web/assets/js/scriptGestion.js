document.addEventListener('DOMContentLoaded', function () {
    // Fonction pour ouvrir la pop-up et afficher les informations du client
    function openEditPopup(cliId, cliNom, cliPrenom, cliEmail) {
        // Crée dynamiquement la pop-up
        const popup = document.createElement('div');
        popup.id = 'popup';
        popup.className = 'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50';
        popup.innerHTML = `
            <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md relative">
                <button 
                    onclick="closePopup()" 
                    class="absolute top-2 right-2 text-gray-600 hover:text-red-600 font-bold text-xl">
                    ×
                </button>
                <h2 class="text-2xl font-bold mb-4 text-gray-800">Modifier le client</h2>
                <form id="edit-form">
                    <input type="hidden" name="cli_id" id="edit_cli_id" value="${cliId}">
                    <div class="mb-4">
                        <label for="cli_nom" class="block text-gray-700 font-bold mb-2">Nom :</label>
                        <input type="text" name="cli_nom" id="edit_cli_nom" class="w-full text-black border rounded-lg px-3 py-2" value="${cliNom}">
                    </div>
                    <div class="mb-4">
                        <label for="cli_prenom" class="block text-gray-700 font-bold mb-2">Prénom :</label>
                        <input type="text" name="cli_prenom" id="edit_cli_prenom" class="w-full text-black border rounded-lg px-3 py-2" value="${cliPrenom}">
                    </div>
                    <div class="mb-4">
                        <label for="cli_email" class="block text-gray-700 font-bold mb-2">Email :</label>
                        <input type="email" name="cli_email" id="edit_cli_email" class="w-full text-black border rounded-lg px-3 py-2" value="${cliEmail}">
                    </div>
                    <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-black px-4 py-2 rounded">Enregistrer</button>
                </form>
            </div>
        `;
        document.body.appendChild(popup);

        // Ajoute un événement au formulaire pour gérer la modification
        document.getElementById('edit-form').addEventListener('submit', function (e) {
            e.preventDefault();
            const updatedData = {
                cli_id: document.getElementById('edit_cli_id').value,
                cli_nom: document.getElementById('edit_cli_nom').value,
                cli_prenom: document.getElementById('edit_cli_prenom').value,
                cli_email: document.getElementById('edit_cli_email').value,
            };

            // Envoie les données au serveur via fetch
            fetch('/sae2-456-grp2/web/component/modif.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(updatedData),
            })
                .then(response => {
                    if (response.ok) {
                        alert('Modification réussie !');
                        closePopup();
                        location.reload(); // Recharge la page pour refléter les modifications
                    } else {
                        alert('Erreur lors de la modification.');
                    }
                })
                .catch(error => {
                    console.error('Erreur :', error);
                    alert('Erreur lors de la modification.');
                });
        });
    }

    // Fonction pour fermer la pop-up
    function closePopup() {
        const popup = document.getElementById('popup');
        if (popup) {
            popup.remove();
        }
    }

    // Ajoute un événement au bouton "Modifier"
    document.querySelectorAll('.btn-modifier').forEach(button => {
        button.addEventListener('click', function () {
            const row = this.closest('tr'); // Récupère la ligne correspondante
            const cliId = row.querySelector('[data-cli-id]').textContent.trim();
            const cliNom = row.querySelector('[data-cli-nom]').textContent.trim();
            const cliPrenom = row.querySelector('[data-cli-prenom]').textContent.trim();
            const cliEmail = row.querySelector('[data-cli-email]').textContent.trim();

            openEditPopup(cliId, cliNom, cliPrenom, cliEmail);
        });
    });
});