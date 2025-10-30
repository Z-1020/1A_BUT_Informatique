<?php 
require_once('../session/session.php');
require_once("../../php/functions.php"); 
?>

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<div class="relative min-h-screen w-full">

  <!-- Image de fond -->
  <div class="fixed inset-0 w-full h-full bg-[url('./web/assets/img/fast-food.jpeg')] bg-cover bg-center bg-no-repeat z-0">
    <div class="absolute inset-0 bg-black opacity-55"></div>
  </div>
  
  <!-- NAV BAR GAUCHE -->
  <div class="relative z-10 flex">
    <aside class="fixed top-1/2 left-0 transform -translate-y-1/2 flex flex-col items-center py-6 px-4 backdrop-blur dark:bg-neutral-800 h-auto w-64 z-20 rounded-r-3xl shadow-lg">
      <!-- Liens inchangés -->
      <div class="flex items-center mb-10 w-full justify-start">
        <a href="?page=accueil.php" class="material-icons text-orange-400 text-[4.5rem] mr-4 flex items-center justify-center">home</a>
        <a href="?page=accueil.php"
           class="w-full text-left text-xl font-bold text-white transition-all duration-300 whitespace-nowrap focus:outline-none hover:bg-orange-100 hover:text-orange-500 active:scale-95 transition-transform rounded-md py-2 px-3">
          Accueil
        </a>
      </div>
      <div class="flex items-center mb-10 w-full justify-start">
        <a href="?page=menu.php" class="material-icons text-orange-400 text-[4.5rem] mr-4 flex items-center justify-center">menu_book</a>
        <a href="?page=menu.php"
           class="w-full text-left text-xl font-bold text-white transition-all duration-300 whitespace-nowrap focus:outline-none hover:bg-orange-100 hover:text-orange-500 active:scale-95 transition-transform rounded-md py-2 px-3">
          Nos Menus
        </a>
      </div>
      <div class="flex items-center mb-10 w-full justify-start">
        <a href="?page=plat.php" class="material-icons text-orange-400 text-[4.5rem] mr-4 flex items-center justify-center">restaurant</a>
        <a href="?page=plat.php"
           class="w-full text-left text-xl font-bold text-white transition-all duration-300 whitespace-nowrap focus:outline-none hover:bg-orange-100 hover:text-orange-500 active:scale-95 transition-transform rounded-md py-2 px-3">
          Nos Plats
        </a>
      </div>
      <div class="flex items-center mb-10 w-full justify-start">
        <a href="?page=panier.php" class="material-icons text-orange-400 text-[4.5rem] mr-4 flex items-center justify-center">shopping_cart</a>
        <a href="?page=panier.php"
           class="w-full text-left text-xl font-bold text-white transition-all duration-300 whitespace-nowrap focus:outline-none hover:bg-orange-100 hover:text-orange-500 active:scale-95 transition-transform rounded-md py-2 px-3">
          Panier
          <?php 
            if (isset($_SESSION['panier']['produits']) && isset($_SESSION['panier']['menus'])) {
                echo getNbProduits() + count($_SESSION['panier']['menus']);
            } else {
                echo 0;
                var_dump($_SESSION['panier']['produits']);
            }
          ?>
        </a>
      </div>
    </aside>

    <!-- Main Content -->
    <div class="flex-1 flex flex-col ml-72 pr-10 py-6 overflow-y-auto">
      <h1 class="text-5xl font-extrabold text-orange-400 mb-8 tracking-wide">NOS MENUS</h1>
      <?php
        $categories = getNamePlat($conn);
        $allMenus = getAllMenusName($conn);
      ?>
      <?php foreach ($categories as $cat): ?>
        <?php
          $menusDeCategorie = array_filter($allMenus, function($nomMenu) use ($cat) {
            return (stripos($nomMenu, $cat) !== false);
          });
          if (empty($menusDeCategorie)) continue;
        ?>
        <h2 class="text-4xl font-extrabold text-white mb-6"><?= strtoupper(htmlspecialchars($cat)) ?></h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-3 gap-6 justify-items-center">
        <?php foreach ($menusDeCategorie as $menuNom): ?>
          <?php
            $plat = getOneInfoPerMenuByName($conn, $menuNom);
            $platInfo = getImgInfoPerPlats($conn, getOnePlaNumPerMenuByName($conn, $menuNom));
          ?>
          <div class="relative group w-80 h-[420px]">
            <!-- Image + overlay description -->
            <div class="absolute top-0 left-0 w-full flex flex-col items-center">
              <div class="relative rounded-2xl overflow-hidden h-40 w-full border-4 border-orange-300 shadow-lg">
                <img src="<?= $platInfo["CHEMIN_IMG"] ?? 'web/assets/img/image_non_trouve.jpg' ?>"
                  alt="<?= $platInfo["ALT_DESC_IMG"] ?? '' ?>"
                  class="h-full w-full object-cover transition-all duration-500 group-hover:scale-105">
                <div class="absolute left-0 top-0 w-full transition-all duration-500 ease-out -translate-y-full group-hover:translate-y-0 opacity-0 group-hover:opacity-100 bg-gradient-to-b from-black/90 to-transparent text-white rounded-t-2xl p-4 text-center flex flex-col items-center justify-start pointer-events-auto overflow-y-auto max-h-36 scrollbar-thin scrollbar-thumb-orange-400 scrollbar-track-black/40 desc-overlay-scroll"
                     style="will-change: transform, opacity;">
                  <div class="font-bold text-lg mb-1 break-words">
                    <?= $plat["PLA_DESCRIPTION"] ?? '' ?>
                  </div>
                </div>
              </div>
            </div>
            <!-- Formulaire unique PAR CARTE -->
            <div class="absolute bottom-0 left-0 w-full flex flex-col items-center">
              <div class="bg-white rounded-full px-8 py-2 font-bold text-lg mb-4 shadow text-black mt-1 text-center">
                <?= $menuNom ?? '' ?><br>
                <span class="font-normal"><?= $plat["PLA_PRIX_VENTE_UNIT_HT"] ?? '' ?>€</span>
              </div>
              <form action="./web/commande/ajout_panier_menus.php" method="POST" class="flex flex-col items-center w-full">
                <input type="hidden" name="menu_prix" value="<?= $plat["PLA_PRIX_VENTE_UNIT_HT"] ?>">
                <input type="hidden" name="menu_nom" value="<?= $menuNom ?>">
                <input type="hidden" name="menu_num" value="<?= getOnePlaNumPerMenuByName($conn, $menuNom); ?>">
                <div class="flex justify-center w-full mb-2">
                  <div class="grid grid-cols-2 gap-2 w-56 mx-auto">
                    <select name="plat" class="rounded-xl border border-orange-300 py-1 px-2 bg-white text-gray-700 focus:outline-none focus:ring-2 focus:ring-orange-400 text-sm" aria-label="Plat" required>
                      <?php foreach(getAllPlatByMenuName($conn, $menuNom) as $numPlat): ?>
                        <option value="<?= $numPlat ?>"><?= getPlatByPlaNum($conn, $numPlat)["PLA_NOM"] ?></option>
                      <?php endforeach; ?>
                    </select>
                    <select name="dessert" class="rounded-xl border border-orange-300 py-1 px-2 bg-white text-gray-700 focus:outline-none focus:ring-2 focus:ring-orange-400 text-sm" aria-label="Dessert" required>
                      <?php foreach(getAllDessertsByMenuName($conn, $menuNom) as $numPlat): ?>
                        <option value="<?= $numPlat ?>"><?=getPlatByPlaNum($conn, $numPlat)["PLA_NOM"] ?></option>
                      <?php endforeach; ?>
                    </select>
                    <select name="legume" class="rounded-xl border border-orange-300 py-1 px-2 bg-white text-gray-700 focus:outline-none focus:ring-2 focus:ring-orange-400 text-sm" aria-label="Légume" required>
                      <?php foreach(getAllLegumesByMenuName($conn, $menuNom) as $numPlat): ?>
                        <option value="<?= $numPlat ?>"><?=getPlatByPlaNum($conn, $numPlat)["PLA_NOM"] ?></option>
                      <?php endforeach; ?>
                    </select>
                    <select name="boisson" class="rounded-xl border border-orange-300 py-1 px-2 bg-white text-gray-700 focus:outline-none focus:ring-2 focus:ring-orange-400 text-sm" aria-label="Boissons" required>
                      <?php foreach(getAllBoissonsByMenuName($conn, $menuNom) as $numPlat): ?>
                        <option value="<?= $numPlat ?>"><?=getPlatByPlaNum($conn, $numPlat)["PLA_NOM"] ?></option>
                      <?php endforeach; ?>
                    </select>
                  </div>
                </div>
                <div class="flex flex-row w-full gap-4">
                  <button type="submit" name="ajouter" value="1" class="border-2 border-orange-400 text-orange-400 font-semibold px-6 py-2 rounded-full hover:bg-orange-50 transition w-1/2">Ajouter au panier</button>
                  <button type="submit" name="commander" value="1" class="border-2 border-orange-400 text-orange-400 font-semibold px-6 py-2 rounded-full bg-orange-400 text-white transition w-1/2">Commander</button>
                </div>
              </form>
            </div>
          </div>
        <?php endforeach; ?>
        </div>
      <?php endforeach; ?>
    </div>
  </div>
</div>

<script>
  // Empêche la propagation du scroll à la page quand la souris est sur la description
  document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.desc-overlay-scroll').forEach(function(el) {
      el.addEventListener('wheel', function(e) {
        const atTop = el.scrollTop === 0;
        const atBottom = el.scrollHeight - el.scrollTop === el.clientHeight;
        if ((e.deltaY < 0 && atTop) || (e.deltaY > 0 && atBottom)) {
          return;
        }
        e.stopPropagation();
        e.preventDefault();
      }, {
        passive: false
      });
    });
  });
  
</script>
