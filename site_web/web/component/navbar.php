<?php 
require_once './web/session/session.php';
?>

<link rel="stylesheet" href="./web/assets/css/navbar.css">

<!-- ========== NAVBAR MOBILE ========== -->
<!-- Barre du haut pour les boutons sur mobile -->
<div class="w-full flex md:hidden justify-end p-4 z-30 fixed top-0 left-0" style="gap:10px; background: var(--glasmorphism-bg); border-bottom: 1px solid var(--glasmorphism-border-color); backdrop-filter: var(--glasmorphism-backdrop-filter); -webkit-backdrop-filter: var(--glasmorphism-backdrop-filter);">
  <?php if (!isLoggedIn()): ?>
    <button id="btn-signup" onclick="loadPage('signup.php', this)"
      style="background:var(--primary-text-color);color:var(--rapidc3-main-color);border:1px solid var(--glasmorphism-border-color);border-radius:8px;padding:8px 16px;font-weight:bold;text-decoration:none;">
      Inscription
    </button>
    <button id="btn-signin" onclick="loadPage('signin.php', this)"
      style="background:var(--glasmorphism-bg);border:1px solid var(--glasmorphism-border-color);border-radius:8px;color:var(--primary-text-color);padding:8px 16px;font-weight:bold;text-decoration:none;">
      Connexion
    </button>
  <?php else: ?>
    <span style="color:var(--primary-text-color);font-weight:bold;align-self:center;margin-right:10px;">
      <?php echo htmlspecialchars(getPrenom()); ?>
    </span>
    <?php require_once './php/connexion.php'; ?>
    <?php if (isLoggedInAdmin($conn)): ?>
      <button id="btn-gerer" onclick="loadPage('gerer.php', this)"
        style="background:var(--glasmorphism-bg);border:1px solid var(--glasmorphism-border-color);border-radius:8px;color:var(--primary-text-color);padding:8px 16px;font-weight:bold;text-decoration:none;">
        Gérer
      </button>
    <?php endif; ?>
    <button id="btn-compte" onclick="loadPage('compte.php', this)"
      style="background:var(--primary-text-color);color:var(--rapidc3-main-color);border:1px solid var(--glasmorphism-border-color);border-radius:8px;padding:8px 16px;font-weight:bold;text-decoration:none;">
      Mon compte
    </button>
    <button id="btn-deconnecter" onclick="loadPage('logout.php', this)"
      style="background:var(--glasmorphism-bg);border:1px solid var(--glasmorphism-border-color);border-radius:8px;color:var(--primary-text-color);padding:8px 16px;font-weight:bold;text-decoration:none;">
      Se déconnecter
    </button>
  <?php endif; ?>
</div>

<!-- Barre du bas pour la navigation principale sur mobile -->
<div class="navbar">
  <button id="btn-accueil" onclick="loadPage('accueil.php', this)">
    <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 24 24" fill="gray">
      <path d="M3 9.75L12 3l9 6.75v10.5A1.75 1.75 0 0 1 19.25 22h-3.5A1.75 1.75 0 0 1 14 20.25V15a1 1 0 0 0-2 0v5.25A1.75 1.75 0 0 1 10.25 22h-3.5A1.75 1.75 0 0 1 5 20.25V9.75z" />
    </svg>
    <small>Accueil</small>
  </button>
  <button id="btn-commander" onclick="loadPage('menu.php', this)">
    <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 24 24" fill="gray">
      <path d="M5.25 3A2.25 2.25 0 0 0 3 5.25v13.5c0 .621.504 1.125 1.125 1.125.248 0 .49-.082.683-.232L6 18.25l1.192 1.393c.193.15.435.232.683.232.248 0 .49-.082.683-.232L10 18.25l1.192 1.393c.193.15.435.232.683.232s.49-.082.683-.232L14 18.25l1.192 1.393a1.125 1.125 0 0 0 1.683 0L18 18.25l1.192 1.393c.193.15.435.232.683.232.621 0 1.125-.504 1.125-1.125V5.25A2.25 2.25 0 0 0 18.75 3H5.25z" />
    </svg>
    <small>Menus</small>
  </button>
  <button id="btn-plats" onclick="loadPage('plat.php', this)">
    <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 24 24" fill="gray">
      <path d="M12 2C6.477 2 2 6.477 2 12c0 5.523 4.477 10 10 10s10-4.477 10-10C22 6.477 17.523 2 12 2zm0 2c4.411 0 8 3.589 8 8s-3.589 8-8 8-8-3.589-8-8 3.589-8 8-8zm0 2a6 6 0 1 0 0 12A6 6 0 0 0 12 6z"/>
    </svg>
    <small>Plats</small>
  </button>
  <button id="btn-panier" onclick="loadPage('panier.php', this)">
    <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 24 24" fill="gray">
      <path d="M7 18c-1.104 0-1.99.896-1.99 2S5.896 22 7 22s2-.896 2-2-.896-2-2-2zm10 0c-1.104 0-1.99.896-1.99 2s.886 2 1.99 2 2-.896 2-2-.896-2-2-2zM7.16 16l.94-2h8.43c.75 0 1.41-.41 1.74-1.03l3.24-6.11A1 1 0 0 0 20.5 5H5.21l-.94-2H1V5h2l3.6 7.59-1.35 2.44C4.52 15.37 5.48 17 7 17h12v-2H7.42c-.14 0-.25-.11-.27-.25z"/>
    </svg>
    <small>Panier</small>
  </button>
</div>
<!-- ========== END NAVBAR MOBILE ========== -->

<!-- ========== NAVBAR DESKTOP ========== -->
<!-- bg-neutral-800/80 -->
<body class="bg-neutral-900 text-white">
<header id="top-navbar"
  class="sticky top-0 inset-x-0 z-50 w-full text-white">
  <nav class="w-full flex items-center justify-between px-0 py-2"> <!-- retire mx-auto et max-w-[85rem] -->
    <!-- logo centré sur mobile -->
    <div class="flex items-center ml-4">
      <button id="btn-title" class="text-white font-semibold focus:outline-hidden focus:opacity-80" onclick="loadPage('accueil.php', this)">
        <img src="./web/assets/img/logoC3.png" class="h-20 w-23">
      </button>
    </div>
    <!-- end logo -->

    <?php require_once './php/connexion.php'; ?>

    <!-- buttons -->
  <div id="hs-header-scrollspy" class="hs-collapse hidden overflow-hidden transition-all duration-300 basis-full grow md:block" aria-labelledby="hs-header-scrollspy-collapse">
   <div class="overflow-hidden overflow-y-auto max-h-[75vh] [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300 dark:[&::-webkit-scrollbar-track]:bg-neutral-700 dark:[&::-webkit-scrollbar-thumb]:bg-neutral-500">
    <div data-hs-scrollspy="#scrollspy" class="text-xl py-2 md:py-0 [--scrollspy-offset:220] md:[--scrollspy-offset:70] flex flex-col md:flex-row md:items-center md:justify-end gap-0.5 md:gap-1 mr-4">
        <?php if (!isLoggedIn()): ?>
            <button id="btn-signup" onclick="loadPage('signup.php', this)"
              class="py-2 px-6 flex items-center text-white hover:bg-orange-600 !bg-orange-400 !hover:bg-orange-600 rounded-full">
              Inscription
            </button>

            <button id="btn-signin" onclick="loadPage('signin.php', this)" class="py-2 px-6 flex items-center text-white hover:bg-orange-600 !bg-orange-400 !hover:bg-orange-600 rounded-full">

              Connexion
            </button>
          <?php endif; ?>
          <?php if (isLoggedIn()): ?>
            <p>Connecté en tant que <?php echo getPrenom(); ?></p>

            <?php if (isLoggedInAdmin($conn)): ?>
              <button id="btn-signup" onclick="loadPage('gerer.php', this)" class="py-2 px-6 flex items-center text-white hover:bg-orange-600 !bg-orange-400 !hover:bg-orange-600 rounded-full">
                Gerer
              </button>
            <?php endif; ?>

            <button id="btn-compte" onclick="loadPage('compte.php', this)" class="py-2 px-6 !bg-orange-400 !hover:bg-orange-600 flex items-center text-gray-800 hover:bg-gray-100 rounded-full focus:outline-hidden focus:bg-gray-100 dark:bg-neutral-800 dark:text-neutral-200 dark:hover:bg-neutral-700 dark:focus:bg-neutral-700 hs-scrollspy-active:bg-gray-100">
              Mon compte
            </button>

            <button id="btn-deconnecter" onclick="loadPage('logout.php', this)" class="py-2 px-6 !bg-orange-400 !hover:bg-orange-600 flex items-center text-gray-800 hover:bg-gray-100 rounded-full focus:outline-hidden focus:bg-gray-100 dark:bg-neutral-800 dark:text-neutral-200 dark:hover:bg-neutral-700 dark:focus:bg-neutral-700 hs-scrollspy-active:bg-gray-100">
              Se deconnecter
            </button>
          <?php endif; ?>
        </div>
      </div>
    </div>
    <!-- end buttons -->
  </nav>
</header>
<!-- ========== END NAVBAR DESKTOP ========== -->

<script src="./web/assets/js/navbar.js"></script>
