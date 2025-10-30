<?php
require_once '../session/session.php';
require_once './verif_panier.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    for ($i = 0; $i < count($_SESSION['panier']['produits']); $i = $i + 1) {
        if ($_SESSION['panier']['produits'][$i]['id'] == $_POST["pla_num"]) {
            $_SESSION['panier']['produits'][$i]['quantite'] = $_SESSION['panier']['produits'][$i]['quantite'] + 1;
        }
      }

    header('Location: ../../index.php?page=panier.php');
    exit;
}

?>