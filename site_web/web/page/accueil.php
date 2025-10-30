<?php require_once('../session/session.php'); ?>

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<div class="relative min-h-screen w-full">
    <!-- Image de fond + filtre opaque -->
    <div class="fixed inset-0 w-full h-full bg-[url('./web/assets/img/rapidc3.png')] bg-cover bg-center bg-no-repeat z-0 ">
        <div class="absolute inset-0 bg-black opacity-55"></div>
    </div>
    <!-- Contenu principal en relatif -->
    <div class="z-10 flex h-screen">
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



        <div class="absolute inset-0 flex flex-col items-center justify-center z-10">
            <h1 class="md:text-9xl text-6xl font-extrabold tracking-tight mb-4 drop-shadow-lg">
                <span class="text-white drop-shadow-[0_4px_4px_rgba(0,0,0,1)]">RAPID</span>
                <span class="text-orange-400 drop-shadow-[0_4px_4px_rgba(0,0,0,1)]">C3</span>
            </h1>
            <p class="md:text-3xl text-xl font-semibold text-white text-center max-w-2xl drop-shadow-lg">
                IUT DE CAEN CAMPUS 3<br> </p>
            <p class="md:text-2xl text-lg font-semibold text-white text-center max-w-2xl drop-shadow-lg">
                <br><i>" Commandez en ligne rapidement et simplement " </i></p>
            </p>
        </div>
    </div>