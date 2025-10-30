<?php

require_once("connexion.php");


function getAllPlats($conn): array{
    $tab = [];
    
    $req_sql = "SELECT * FROM RAP_PLAT";
    $cur = preparerRequetePDO($conn, $req_sql);
    LireDonneesPDOPreparee($cur, $tab);
    return $tab;
}

function getPlatByPlaNum($conn, $pla_num){
    $tab = [];
    
    $req_sql = "SELECT * FROM RAP_PLAT WHERE PLA_NUM = ?";
    $cur = preparerRequetePDO($conn, $req_sql);
    majDonneesPrepareesTabPDO($cur, [$pla_num]);
    LireDonneesPDOPreparee($cur, $tab);
    return $tab[0];
}

function getPlatByType($conn, $type){
    $tab = [];
    
    $req_sql = "SELECT * FROM RAP_$type JOIN RAP_PLAT using(PLA_NUM) WHERE ROWNUM <=3";
    $cur = preparerRequetePDO($conn, $req_sql);
    LireDonneesPDOPreparee($cur, $tab);
    return $tab ?? [];
}

function getNamePlat($conn){
    return ["PIZZA", "KEBAB", "LEGUME", "DESSERT", "BOISSON"];
}


function getImgInfoPerPlats($conn, $pla_num): array{
    $plat = [];
    $req_sql = "SELECT * FROM RAP_PLAT_IMAGE WHERE PLA_NUM=?";
    $cur = preparerRequetePDO($conn, $req_sql);
    majDonneesPrepareesTabPDO($cur, [$pla_num]);
    LireDonneesPDOPreparee($cur, $plat);
    
    return $plat[0] ?? [];
}

function getOnePlaNumPerMenuByName($conn, $pla_nom){
    $plat = [];
    $req_sql = "SELECT PLA_NUM FROM RAP_PLAT WHERE PLA_MENU=1 AND PLA_NOM=? AND ROWNUM<=1";
    $cur = preparerRequetePDO($conn, $req_sql);
    majDonneesPrepareesTabPDO($cur, [$pla_nom]);
    LireDonneesPDOPreparee($cur, $plat);
    
    return $plat[0]["PLA_NUM"] ?? [];
}
function getOneInfoPerMenuByName($conn, $pla_nom){
    $plat = [];
    $req_sql = "SELECT * FROM RAP_PLAT WHERE PLA_MENU=1 AND PLA_NOM=? AND ROWNUM<=1";
    $cur = preparerRequetePDO($conn, $req_sql);
    majDonneesPrepareesTabPDO($cur, [$pla_nom]);
    LireDonneesPDOPreparee($cur, $plat);
    
    return $plat[0] ?? [];
}

function isPlatExist($conn, $pla_num): bool{
    $tab = [];
    $req_sql = "SELECT * FROM RAP_PLAT WHERE PLA_NUM=?";
    $cur = preparerRequetePDO($conn, $req_sql);
    majDonneesPrepareesTabPDO($cur, [$pla_num]);
    LireDonneesPDOPreparee($cur, $tab);
    return !empty($tab);
}

function isClientExist($conn, $cli_num): bool{
    $tab = [];
    $req_sql = "SELECT * FROM RAP_CLIENT WHERE CLI_NUM=?";
    $cur = preparerRequetePDO($conn, $req_sql);
    majDonneesPrepareesTabPDO($cur, [$cli_num]);
    LireDonneesPDOPreparee($cur, $tab);
    return !empty($tab);
}

function getAllMenus($conn){
    $tab = [];
    
    $req_sql = "SELECT * FROM RAP_PLAT WHERE PLA_MENU = 1 AND ROWNUM<=10";
    $cur = preparerRequetePDO($conn, $req_sql);
    LireDonneesPDOPreparee($cur, $tab);
    return $tab;
}




function getAllMenusName($conn){
    $tab = [];
    $noms = [];
    $req_sql = "SELECT PLA_NOM FROM RAP_PLAT WHERE PLA_MENU=1";
    $cur = preparerRequetePDO($conn, $req_sql);
    LireDonneesPDOPreparee($cur, $tab);
    foreach($tab as $nom){
        array_push($noms, $nom["PLA_NOM"]);
    }
    
    return array_unique($noms);
}
function getAllPlatByMenuName($conn, $pla_nom){
    $tab = [];
    $plats = [];
    $req_sql = "SELECT SUBSTR(PLA_NUM, 1,1) || '000' AS PLAT FROM RAP_PLAT WHERE TRIM(UPPER(PLA_NOM)) LIKE TRIM(UPPER(?))";
    $cur = preparerRequetePDO($conn, $req_sql);
    majDonneesPrepareesTabPDO($cur, [$pla_nom]);
    LireDonneesPDOPreparee($cur, $tab);
    foreach($tab as $plat){
        array_push($plats, $plat["PLAT"]);
    }
    return array_unique($plats);
}

function getAllLegumesByMenuName($conn, $pla_nom){
    $tab = [];
    $legumes = [];
    $req_sql = "SELECT SUBSTR(PLA_NUM, 2,1) || '00' AS PLAT FROM RAP_PLAT WHERE TRIM(UPPER(PLA_NOM)) LIKE TRIM(UPPER(?))";
    $cur = preparerRequetePDO($conn, $req_sql);
    majDonneesPrepareesTabPDO($cur, [$pla_nom]);
    LireDonneesPDOPreparee($cur, $tab);
    foreach($tab as $plat){
        array_push($legumes, $plat["PLAT"]);
    }
    return array_unique($legumes);
}

function getAllBoissonsByMenuName($conn, $pla_nom){
    $tab = [];
    $boissons = [];
    $req_sql = "SELECT SUBSTR(PLA_NUM, 3,1) || '0' AS PLAT FROM RAP_PLAT WHERE TRIM(UPPER(PLA_NOM)) LIKE TRIM(UPPER(?))";
    $cur = preparerRequetePDO($conn, $req_sql);
    majDonneesPrepareesTabPDO($cur, [$pla_nom]);
    LireDonneesPDOPreparee($cur, $tab);
    foreach($tab as $plat){
        array_push($boissons, $plat["PLAT"]);
    }
    return array_unique($boissons);
}

function getAllDessertsByMenuName($conn, $pla_nom){
    $tab = [];
    $desserts = [];
    $req_sql = "SELECT SUBSTR(PLA_NUM, 4,1) AS PLAT FROM RAP_PLAT WHERE TRIM(UPPER(PLA_NOM)) LIKE TRIM(UPPER(?))";
    $cur = preparerRequetePDO($conn, $req_sql);
    majDonneesPrepareesTabPDO($cur, [$pla_nom]);
    LireDonneesPDOPreparee($cur, $tab);
    foreach($tab as $plat){
        array_push($desserts, $plat["PLAT"]);
    }
    return array_unique($desserts);
}

/*
function payerPlat($conn, $plat_num, $cli_num){
    try{
        if(!isPlatExist($conn, $plat_num)){
            http_response_code(400);
            echo json_encode([
                "error" => "Plat inexistant !",
            ]);
            exit;
        }

        if(!isClientExist($conn, $cli_num) || !isset($_SESSION["CLI_NUM"])){
            http_response_code(400);
            echo json_encode([
                "error" => "Vous devez être connecté pour payer un plat !",
                "redirect" => "login.php"
            ]);
            exit;
        }


    } catch(Exception $e) {
        echo json_encode(["error"=>"Erreur lors du paiement"]);
    }
    
}*/
