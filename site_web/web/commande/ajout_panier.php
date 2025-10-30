<?php
require_once '../session/session.php';
require_once './verif_panier.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    if (isset($_POST['pla_num']) && isset($_POST['pla_prix_ht']) && isset($_POST['pla_nom'])) {
        $exist = false;
        $item = [
            'id' => $_POST['pla_num'],
            'quantite' => 1,
            'prix' => $_POST['pla_prix_ht'],
            'nom' => $_POST['pla_nom'],
        ];
        for ($i = 0; $i < count($_SESSION['panier']['produits']); $i = $i + 1) {
            if ($_SESSION['panier']['produits'][$i]['id'] == $item['id']) {
                $exist = true;
                $_SESSION['panier']['produits'][$i]['quantite'] = $_SESSION['panier']['produits'][$i]['quantite'] + 1;
            }
        }
        if (!$exist) {
            array_push($_SESSION['panier']['produits'], $item);
        }

        header('Location: ../../index.php?page=plat.php');
        exit;
    } else {
        echo 'erreur article non ajouté au panier';
    }
}

?>