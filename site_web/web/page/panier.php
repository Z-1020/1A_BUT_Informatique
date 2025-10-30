<?php
require_once('../session/session.php');
require_once('../../php/connexion.php');
require_once('../../php/functions.php');
?>

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<div class="relative min-h-screen w-full">
  <div class="fixed inset-0 w-full h-full bg-[url('./web/assets/img/fast-food.jpeg')] bg-cover bg-center bg-no-repeat z-0">
    <div class="absolute inset-0 bg-black opacity-55"></div>
  </div>

  <div class="relative z-10 flex h-screen">
    <!-- Sidebar Navigation -->
    <aside class="fixed top-1/2 left-0 transform -translate-y-1/2 flex flex-col items-center py-6 px-4 backdrop-blur dark:bg-neutral-800 h-auto w-64 z-20 rounded-r-3xl shadow-lg">
      <!-- Lien 1 -->
      <div class="flex items-center mb-10 w-full justify-start">
        <a href="?page=accueil.php" class="material-icons text-orange-400 text-[4.5rem] mr-4 flex items-center justify-center">home</a>
        <a href="?page=accueil.php"
           class="w-full text-left text-xl font-bold text-white transition-all duration-300 whitespace-nowrap focus:outline-none hover:bg-orange-100 hover:text-orange-500 active:scale-95 transition-transform rounded-md py-2 px-3">
          Accueil
        </a>
      </div>
      <!-- Lien 2 -->
      <div class="flex items-center mb-10 w-full justify-start">
        <a href="?page=menu.php" class="material-icons text-orange-400 text-[4.5rem] mr-4 flex items-center justify-center">menu_book</a>
        <a href="?page=menu.php"
           class="w-full text-left text-xl font-bold text-white transition-all duration-300 whitespace-nowrap focus:outline-none hover:bg-orange-100 hover:text-orange-500 active:scale-95 transition-transform rounded-md py-2 px-3">
          Nos Menus
        </a>
      </div>
      <!-- Lien 3 -->
      <div class="flex items-center mb-10 w-full justify-start">
        <a href="?page=plat.php" class="material-icons text-orange-400 text-[4.5rem] mr-4 flex items-center justify-center">restaurant</a>
        <a href="?page=plat.php"
           class="w-full text-left text-xl font-bold text-white transition-all duration-300 whitespace-nowrap focus:outline-none hover:bg-orange-100 hover:text-orange-500 active:scale-95 transition-transform rounded-md py-2 px-3">
          Nos Plats
        </a>
      </div>
      <!-- Lien 4 -->
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

    <div class="flex-1 flex flex-col px-10 py-6">
      <h1 class="text-5xl font-extrabold text-orange-400 mb-8 text-center">VOTRE PANIER</h1>
      <div class="bg-white bg-opacity-90 rounded-2xl shadow-lg p-8 max-w-2xl mx-auto" id="panier-content">
        <ul class="divide-y divide-gray-200 mb-6">
          <?php if ((getNbProduits() + getNbMenus()) < 1): ?>
            <p class="text-black">Votre panier est vide.</p>
            <br/>
            <p class="text-black">Remplissez-le pour pouvoir effectuer une commande.</p>
          <?php else: ?>
            <?php foreach (['produits', 'menus'] as $type): ?>
              <?php foreach ($_SESSION['panier'][$type] as $item): ?>
                <?php if (((int) $item['quantite']) > 0): ?>
                  <li class="flex items-center justify-between py-4">
                      <div class="flex items-center gap-4">
                        <?php
                          $imgInfos = [];
                          $imgInfos = getImgInfoPerPlats($conn, $item['id']);
                        ?>
                          <img src="<?= $imgInfos["CHEMIN_IMG"] ?>" alt="<?= $item['nom'] ?>" class="w-20 h-20 rounded-xl object-cover border-2 border-orange-200">
                          <div>
                              <div class="font-bold text-black text-lg"><?= $item['nom']; ?></div>
                              <div class="text-gray-500 flex items-center gap-2">
                                  <form action="./web/commande/moinsPlat.php" method="POST">
                                    <input type="hidden" name="pla_num" value="<?= $item['id'] ?>">
                                    <button type="submit" class="btn-moins text-3xl px-4 py-1 bg-orange-100 rounded hover:bg-orange-200">-</button>
                                  </form>
                                  <span><?= $item['quantite']; ?> x <?= $item['prix'] ?>€</span>
                                  <form action="./web/commande/plusPlat.php" method="POST">
                                    <input type="hidden" name="pla_num" value="<?= $item['id'] ?>">
                                    <button type="submit" class="btn-plus text-3xl px-4 py-1 bg-orange-100 rounded hover:bg-orange-200">+</button>
                                  </form>
                                  <form action="./web/commande/suppPlat.php" method="POST">
                                    <input type="hidden" name="pla_num" value="<?= $item['id'] ?>">
                                    <button type="submit" class="btn-plus text-3xl px-4 py-1 bg-red-100 rounded hover:bg-red-200">X</button>
                                  </form>
                              </div>
                          </div>
                      </div>
                  </li>
                <?php endif; ?>
              <?php endforeach; ?>
            <?php endforeach; ?>
            <div class="flex justify-between items-center mb-6">
              <span class="text-xl font-bold text-black">Total :</span>
              <span class="text-xl font-bold text-orange-500"><?= getPrixTotal(); ?> €</span>
            </div>
            <a href="?page=payer.php">
              <button class="w-full bg-orange-400 hover:bg-orange-500 text-white font-bold py-3 rounded-full text-xl transition">Payer</button>
            </a>
          <?php endif; ?>
        </ul>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
  function bindPanierButtons() {
    document.querySelectorAll('.btn-plus, .btn-moins').forEach(btn => {
      btn.onclick = function () {
        const nom = this.getAttribute('data-nom');
        const type = this.getAttribute('data-type');
        const action = this.classList.contains('btn-plus') ? 'plus' : 'moins';
        fetch(`?page=panier.php&ajax=1&action=${action}&nom=${encodeURIComponent(nom)}&type=${type}`)
          .then(r => r.json())
          .then(data => {
            if (data.success) {
              document.getElementById('panier-content').innerHTML = data.html;
              bindPanierButtons(); // Re-bind les boutons après mise à jour
            }
          });
      };
    });
  }
  bindPanierButtons();
});
</script>
