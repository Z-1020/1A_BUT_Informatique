<link rel="stylesheet" href="./web/assets/css/gerer.css">

<?php
require_once '../session/session.php';
require_once '../../php/connexion.php';

// Statistiques
$sql = "SELECT COUNT(*) AS NB FROM RAP_CLIENT";
$tab = [];
LireDonneesPDO1($conn, $sql, $tab);
$nb_clients = $tab[0]['NB'];

$sql = "SELECT COUNT(*) AS NB FROM RAP_COMMANDE";
$tab = [];
LireDonneesPDO1($conn, $sql, $tab);
$nb_commandes = $tab[0]['NB'];

$sql = "SELECT SUM(COM_PRIX_TOTAL) AS TOTAL FROM RAP_COMMANDE";
$tab = [];
LireDonneesPDO1($conn, $sql, $tab);
$chiffre_affaires = $tab[0]['TOTAL'] ?? 0;
$chiffre_affaires = floatval(str_replace(',', '.', $chiffre_affaires));

$sql = "SELECT AVG(COM_PRIX_TOTAL) AS MOY FROM RAP_COMMANDE";
$tab = [];
LireDonneesPDO1($conn, $sql, $tab);
$moyenne_commande = $tab[0]['MOY'] ?? 0;
$moyenne_commande = floatval(str_replace(',', '.', $moyenne_commande));

// Recherche clients avec filtre éventuel
$search = '';
if (isset($_GET['search']) && trim($_GET['search']) !== '') {
    $search = trim($_GET['search']);
}

// On récupère tous les clients avec leur dernière commande, en fonction du filtre
$sql = "
    SELECT 
        C.CLI_NUM,
        C.CLI_NOM,
        C.CLI_PRENOM,
        C.CLI_COURRIEL,
        MAX(COM.COM_DATE) AS DERNIERE_COMMANDE
    FROM RAP_CLIENT C
    LEFT JOIN RAP_COMMANDE COM ON C.CLI_NUM = COM.CLI_NUM
    " . ($search !== '' ? "WHERE C.CLI_NOM LIKE :search OR C.CLI_PRENOM LIKE :search OR C.CLI_COURRIEL LIKE :search" : "") . "
    GROUP BY C.CLI_NUM, C.CLI_NOM, C.CLI_PRENOM, C.CLI_COURRIEL
    ORDER BY C.CLI_NOM, C.CLI_PRENOM
";

$params = [];
if ($search !== '') {
    $params = ['search' => '%' . $search . '%'];
}

$clients = [];
LireDonneesPDO1($conn, $sql, $clients, $params);

// Marquer les clients inactifs (plus de 2 ans depuis dernière commande)
$date_limite = new DateTime('-2 years');

foreach ($clients as &$client) {
    if (!empty($client['DERNIERE_COMMANDE'])) {
        try {
            $date_commande = new DateTime($client['DERNIERE_COMMANDE']);
            $client['inactif'] = ($date_commande < $date_limite);
        } catch (Exception $e) {
            $client['inactif'] = true;
        }
    } else {
        $client['inactif'] = true;
    }
}
unset($client);

// Meilleurs clients
$sql = "
    SELECT C.CLI_NOM, C.CLI_PRENOM, SUM(COM.COM_PRIX_TOTAL) AS TOTAL
    FROM RAP_CLIENT C
    JOIN RAP_COMMANDE COM ON C.CLI_NUM = COM.CLI_NUM
    WHERE C.CLI_NOM NOT LIKE 'NON CLIENT'
    GROUP BY C.CLI_NOM, C.CLI_PRENOM
    ORDER BY TOTAL DESC
    FETCH FIRST 3 ROWS ONLY
";
$meilleurs_clients = [];
LireDonneesPDO1($conn, $sql, $meilleurs_clients);

// Meilleures périodes
$sql = "
    SELECT TO_CHAR(COM_DATE, 'YYYY-MM') AS PERIODE, COUNT(*) AS NB
    FROM RAP_COMMANDE
    GROUP BY TO_CHAR(COM_DATE, 'YYYY-MM')
    ORDER BY NB DESC
    FETCH FIRST 3 ROWS ONLY
";
$meilleures_periodes = [];
LireDonneesPDO1($conn, $sql, $meilleures_periodes);

?>

<div class="fixed inset-0 w-full h-full bg-neutral-900 bg-[url('./web/assets/img/rapidc3.png')] bg-cover bg-center bg-no-repeat z-0 ">
    <div class="absolute inset-0 bg-black opacity-55"></div>
</div>
<div class="z-10 flex">
    <div class="flex-1 flex flex-col px-10 py-6 items-center justify-start z-30 text-white overflow-y-auto">
        <div class="bg-neutral-800 bg-opacity-95 rounded-2xl shadow-lg p-10 max-w-5xl w-full mt-10 mb-8 flex flex-col items-center">
            <h1 class="text-4xl font-extrabold text-orange-400 mb-8 text-center">Statistiques</h1>
            <div class="flex flex-wrap gap-6 justify-between w-full">
                <div class="flex-1 min-w-[180px] bg-neutral-900 border border-neutral-700 rounded-lg p-6 flex flex-col items-center">
                    <div class="text-3xl font-bold text-orange-400"><?= htmlspecialchars($nb_clients) ?></div>
                    <div class="text-neutral-300 mt-2">Clients inscrits</div>
                </div>
                <div class="flex-1 min-w-[180px] bg-neutral-900 border border-neutral-700 rounded-lg p-6 flex flex-col items-center">
                    <div class="text-3xl font-bold text-orange-400"><?= htmlspecialchars($nb_commandes) ?></div>
                    <div class="text-neutral-300 mt-2">Commandes passées</div>
                </div>
                <div class="flex-1 min-w-[180px] bg-neutral-900 border border-neutral-700 rounded-lg p-6 flex flex-col items-center">
                    <div class="text-3xl font-bold text-orange-400"><?= number_format($moyenne_commande, 2, ',', ' ') ?> €</div>
                    <div class="text-neutral-300 mt-2">Montant moyen commande</div>
                </div>
                <div class="flex-1 min-w-[180px] bg-neutral-900 border border-neutral-700 rounded-lg p-6 flex flex-col items-center">
                    <div class="text-3xl font-bold text-orange-400"><?= number_format($chiffre_affaires, 2, ',', ' ') ?> €</div>
                    <div class="text-neutral-300 mt-2">Chiffre d'affaires</div>
                </div>
            </div>
            <div class="flex flex-wrap gap-6 justify-between w-full mt-6">
                <div class="flex-1 min-w-[250px] bg-neutral-900 border border-neutral-700 rounded-lg p-6 flex flex-col items-center">
                    <div class="text-xl font-bold text-orange-400 mb-2">Meilleurs clients</div>
                    <?php foreach ($meilleurs_clients as $cli): ?>
                        <div class="text-neutral-200">
                            <?= htmlspecialchars($cli['CLI_NOM'].' '.$cli['CLI_PRENOM']) ?> :
                            <?= number_format(floatval(str_replace(',', '.', $cli['TOTAL'])), 2, ',', ' ') ?> €
                        </div>
                    <?php endforeach; ?>
                </div>
                <div class="flex-1 min-w-[250px] bg-neutral-900 border border-neutral-700 rounded-lg p-6 flex flex-col items-center">
                    <div class="text-xl font-bold text-orange-400 mb-2">Meilleures périodes de ventes</div>
                    <?php foreach ($meilleures_periodes as $periode): ?>
                        <div class="text-neutral-200">
                            <?= htmlspecialchars($periode['PERIODE']) ?> : <?= $periode['NB'] ?> commandes
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </div>

        <!-- Bloc Gestion clients -->
        <div class="bg-neutral-800 bg-opacity-95 rounded-2xl shadow-lg p-10 w-full mb-8 flex flex-col items-center">
            <h1 class="text-4xl font-extrabold text-orange-400 mb-8 text-center">Gestion des clients</h1>
            <p class="text-sm text-orange-700 mb-4 font-bold">
                    " Les noms et prénoms en rouge indiquent des clients inactifs depuis plus de 2 ans. !"
            </p>
            <div class="w-full overflow-x-auto">
                <table class="min-w-full text-white text-center">
                    <thead class="text-2xl">
                        <tr>
                            <th class="py-2">ID</th>
                            <th class="py-2">Nom</th>
                            <th class="py-2">Prénom</th>
                            <th class="py-2">Courriel</th>
                            <th class="py-2">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($clients as $client): ?>
                        <tr>
                            <td class="py-2"><?= htmlspecialchars($client['CLI_NUM'] ?? '') ?></td>
                            <td class="py-2 <?= !empty($client['inactif']) && $client['inactif'] ? 'text-red-600 font-bold' : '' ?>">
                                    <?= htmlspecialchars($client['CLI_NOM'] ?? '') ?>
                                </td>
                                <td class="py-2 <?= !empty($client['inactif']) && $client['inactif'] ? 'text-red-600 font-bold' : '' ?>">
                                    <?= htmlspecialchars($client['CLI_PRENOM'] ?? '') ?>
                                </td>
                            <td class="py-2">
                                <?= !empty($client['CLI_COURRIEL']) ? htmlspecialchars($client['CLI_COURRIEL']) : 'Pas d\'adresse mail renseignée' ?>
                                <td class="py-2 text-center">
                            <div class="inline-flex gap-2 justify-center items-center">
                                <button type="button" class="btn-modifier bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded">Modifier</button>
                                <form method="post" action="/sae2-456-grp2/web/component/supp.php" onsubmit="return confirm('Supprimer ce client ?');">
                                <input type="hidden" name="delete_id" value="<?= htmlspecialchars($client['CLI_NUM'] ?? '') ?>">
                                <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">Supprimer</button>
                                </form>
                            </div>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                        <?php if (count($clients) === 0): ?>
                        <tr>
                            <td colspan="5" class="text-center py-4 text-white">Aucun client trouvé.</td>
                        </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Bloc Mail -->
        <div class="bg-neutral-800 bg-opacity-95 rounded-2xl shadow-lg p-10 w-full mb-8 flex flex-col items-center">
            <h1 class="text-4xl font-extrabold text-orange-400 mb-8 text-center">Envoyer un mail</h1>
            <form id="emailForm" action="../component/sendMail.php" method="POST" class="w-full max-w-4xl">
                <div class="mb-4">
                    <label for="email" class="block text-sm font-medium text-white mb-2">Adresse mail du destinataire</label>
                    <input type="email" id="email" name="email" value="nathanelie.06@gmail.com" class="py-3 px-5 block w-4/5 border-gray-200 rounded-lg text-white focus:border-blue-500 focus:ring-blue-500 mx-auto" required readonly>
                </div>
                <div class="mb-4">
                    <label for="subject" class="block text-sm font-medium text-white mb-2">Sujet</label>
                    <input type="text" id="subject" name="subject" class="py-3 px-5 block w-4/5 border-gray-200 rounded-lg text-white focus:border-blue-500 focus:ring-blue-500 mx-auto" required>
                </div>
                <div class="mb-4">
                    <label for="message" class="block text-sm font-medium text-white mb-2">Message</label>
                    <textarea id="message" name="message" rows="7" class="py-3 px-5 block w-4/5 border-gray-200 rounded-lg text-white focus:border-blue-500 focus:ring-blue-500 mx-auto" required></textarea>
                </div>
                <button type="submit" class="w-4/5 bg-orange-400 hover:bg-orange-500 text-white font-bold py-4 rounded-lg text-xl transition mx-auto">Envoyer</button>
            </form>
            <div id="emailStatus" class="mt-4 text-white"></div>
        </div>
    </div>
</div>
