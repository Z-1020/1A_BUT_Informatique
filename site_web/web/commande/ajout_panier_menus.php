<?php
require_once '../session/session.php';
require_once './verif_panier.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    if (isset($_POST['ajouter'])) {
        $exist = false;
        $item = [
            'id' => $_POST['menu_num'],
            'quantite' => 1,
            'prix' => $_POST['menu_prix'],
            'nom' => $_POST['menu_nom'],
        ];
        for ($i = 0; $i < count($_SESSION['panier']['menus']); $i = $i + 1) {
            if ($_SESSION['panier']['menus'][$i]['id'] == $item['id']) {
                $exist = true;
                $_SESSION['panier']['menus'][$i]['quantite'] = $_SESSION['panier']['menus'][$i]['quantite'] + 1;
            }
        }
        if (!$exist) {
            array_push($_SESSION['panier']['menus'], $item);
        }

        header('Location: ../../index.php?page=menu.php');
        exit;
    } 
    elseif (isset($_POST['commander'])) {
       //
    }
    else {
        echo 'erreur article non ajouté au panier';
    }
}

?>
