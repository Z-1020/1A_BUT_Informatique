<?php
require_once __DIR__ . '/../session/session.php';
require_once __DIR__ . '/../../php/connexion.php';
?>

<head>
  <meta charset="UTF-8">
  <title>Paiement - RapidC3</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link rel="stylesheet" href="../assets/css/root.css">
</head>
<body>
<div class="relative min-h-screen w-full">
  <!-- Image de fond + filtre opaque -->
  <div class="fixed inset-0 w-full h-full bg-[url('./web/assets/img/rapidc3.png')] bg-cover bg-center bg-no-repeat z-0 ">
        <div class="absolute inset-0 bg-black opacity-55"></div>
    </div>
    
 <!-- NAV BAR GAUCHE -->
    <!-- Contenu principal en relatif -->
    <div class="z-10 flex h-screen">
       
    <!-- Main Content -->
    <div class="flex-1 flex flex-col px-10 py-6 items-center justify-center z-30 text-black">
      <div class="bg-white bg-opacity-95 rounded-2xl shadow-lg p-10 max-w-xl w-full">

<?php
// Ajoute ce bloc PHP tout en haut du fichier payer.php
// Exemple : on suppose que le total du panier est stocké dans $_SESSION['panier_total']
// Sinon, adapte ce calcul selon ta logique panier
$prix_total = isset($_SESSION['panier_total']) ? number_format($_SESSION['panier_total'], 2, ',', ' ') : '0,00';
?>
<h1 class="text-4xl font-extrabold text-orange-400 mb-6 text-center">Paiement</h1>
<p class="text-center text-2xl font-bold mb-6">
    Total à payer : <span class="text-orange-500"><?= getPrixTotal(); ?> €</span>
</p>
<?php

$points_fidelite = 0;
if (isLoggedIn()) {
    if ($conn) {
        $sql = "SELECT SUM(TOTAL_POINTS) AS POINTS
                FROM RAP_CLIENT
                JOIN RAP_COMMANDE USING(CLI_NUM)
                JOIN RAP_FIDELISATION USING(CLI_NUM)
                JOIN RAP_RESTAURANT USING(RES_NUM)
                WHERE CLI_NUM = :cli_num";
        $cur = preparerRequetePDO($conn, $sql);
        $cli_num = getId();
        $cur->bindParam(':cli_num', $cli_num, PDO::PARAM_INT);
        $cur->execute();
        $row = $cur->fetch(PDO::FETCH_ASSOC);
        if ($row && isset($row['POINTS'])) {
            $points_fidelite = $row['POINTS'];
        }
    }
}
?>
<p class="text-center text-xl mb-6 flex items-center justify-center gap-2">
    Vos points fidélités :
    <span class="text-orange-500" id="points-fidelite"><?= htmlspecialchars($points_fidelite) ?></span>
    <input id="max_points" type="text" class="hidden" value="<?= $points_fidelite ?>">
    <input
        type="number"
        name="points_utilises"
        id="points_utilises"
        min="0"
        max="<?= htmlspecialchars($points_fidelite) ?>"
        class="border rounded px-2 py-1 w-35 text-center"
        placeholder="0"
        style="margin-left: 10px;"
    >
</p>
<style>
#info_points.active {
  display: flex !important;
}
</style>
<p id="info_points" class="hidden flex justify-center text-red-500 align-center">Votre max de points ne peut être dépassés.</p>
<p class="text-center text-lg mb-6" id="reduction-fidelite">
    Réduction appliquée : <span class="text-green-600" id="reduction-montant">0,00 €</span>
</p>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const input = document.getElementById('points_utilises');
    const maxPoints = parseInt(document.getElementById('points-fidelite').textContent, 10);
    const reductionSpan = document.getElementById('reduction-montant');

    function updateReduction() {
        let val = input.value;
        let reduction = 0;
        if (/^\d+$/.test(val) && parseInt(val, 10) <= maxPoints) {
            reduction = (parseInt(val, 10) * 0.01).toFixed(2).replace('.', ',');
        } else {
            reduction = "0,00";
        }
        reductionSpan.textContent = reduction + " €";
    }

    input.addEventListener('input', function() {
        let val = input.value;
        if (val === "") {
            input.setCustomValidity("");
            updateReduction();
            return;
        }
        if (!/^\d+$/.test(val) || parseInt(val, 10) > maxPoints) {
            input.setCustomValidity("Veuillez entrer un nombre entier inférieur ou égal à vos points fidélité.");
            input.reportValidity();
        } else {
            input.setCustomValidity("");
        }
        updateReduction();
    });

    // Initialisation
    updateReduction();
});
</script>
        <form action="./web/commande/verif_payer.php" method="POST" class="space-y-6">
              <div>
                <label class="block font-semibold mb-2 text-gray-700 text-2xl p-8">Méthode de paiement</label>
                <div class="flex flex-col gap-4  ">
                  <label class="flex items-center gap-3 cursor-pointer">
                    <input type="radio" name="payment_method" value="cb" class="accent-orange-400" checked>
                    <span class="material-icons text-orange-400">credit_card</span>
                    <span>Carte bancaire</span>
                </div>
              </div>
              <!-- Zone CB -->
              <div id="cb-fields" class="text-black space-y-4">
                <div>
                  <label class="block text-sm mb-1">Numéro de carte</label>
                  <input type="text" name="cb_num" maxlength="19" class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-orange-400" placeholder="1234 5678 9012 3456" required>
                </div>
                <div class="flex gap-4">
                  <div class="flex-1">
                    <label class="block text-sm mb-1">Expiration</label>
                    <input type="text" name="cb_exp" maxlength="5" class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-orange-400" placeholder="MM/AA" required>
                  </div>
                  <div class="flex-1">
                    <label class="block text-sm mb-1">CVC</label>
                    <input type="text" name="cb_cvc" maxlength="4" class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-orange-400" placeholder="123" required>
                  </div>
                </div>
              </div>
            
              <!-- Bouton payer -->
              <button type="submit" id="btn-payer" class="w-full bg-orange-400 hover:bg-orange-500 text-white font-bold py-3 rounded-full text-xl transition">Payer</button>
              <!-- Bouton retour au panier -->
            <a href="?page=panier.php"
                        class="w-full inline-block text-center bg-white border-2 border-orange-400 text-orange-500 font-bold py-3 rounded-full text-xl transition hover:bg-orange-100 hover:text-orange-600">
                Retour au panier
            </a>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>
