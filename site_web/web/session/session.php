<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

function isLoggedIn() {
    return isset($_SESSION['client']);
}


function isLoggedInAdmin($conn) {
    if (!isLoggedIn()) {
        return false;
    }

    try {
        $sql = "select cli_num from rap_client
                where cli_num in (
                    select cli_num from rap_administrateur
                )";
        $res = LireDonneesPDO1($conn,$sql,$donnees);

        if (isset($donnees[0]["CLI_NUM"])) {
            return $donnees[0]["CLI_NUM"] == getId();
        }
        return false;
    }
    catch (PDOException $e) {
        var_dump($e);
        return false;
    }
    return false;
}


function getClient() {
    return $_SESSION['client'] ?? null;
}

function getId() {
    return $_SESSION['client']['id'] ?? null;
}

function getNom() {
    return $_SESSION['client']['nom'] ?? null;
}

function getPrenom() {
    return $_SESSION['client']['prenom'] ?? null;
}

function getTel() {
    return $_SESSION['client']['tel'] ?? null;
}

function getEmail() {
    return $_SESSION['client']['email'] ?? null;
}

function getNbProduits() {
    $result = 0;
    foreach ($_SESSION['panier']['produits'] as $items) {
        $result = $result + $items['quantite'];
    }
    return $result;
}

function getNbMenus() {
    $result = 0;
    
    foreach ($_SESSION['panier']['menus'] as $items) {
        $result = $result + $items['quantite'];
    }

    return $result;
}

function getPrixTotal() {
    $_SESSION['panier']['somme'] = 0.0;
    
    foreach ($_SESSION['panier']['produits'] as $items) {
        $quantite = (float) str_replace(',', '.', $items['quantite']);
        $prix = (float) str_replace(',', '.', $items['prix']);
        $_SESSION['panier']['somme'] += $quantite * $prix;
    }

    foreach ($_SESSION['panier']['menus'] as $items) {
        $quantite = (float) str_replace(',', '.', $items['quantite']);
        $prix = (float) str_replace(',', '.', $items['prix']);
        $_SESSION['panier']['somme'] += $quantite * $prix;
    }

    return $_SESSION['panier']['somme'];
}
?>
