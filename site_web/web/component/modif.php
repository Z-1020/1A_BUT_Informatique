<?php
require_once '../../php/connexion.php';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['cli_id'];
    $nom = $_POST['cli_nom'];
    $prenom = $_POST['cli_prenom'];
    $email = $_POST['cli_email'];
    $sql = "UPDATE RAP_CLIENT SET CLI_NOM = :nom, CLI_PRENOM = :prenom, CLI_COURRIEL = :email WHERE CLI_NUM = :id";
    $stmt = preparerRequetePDO($conn, $sql);
    ajouterParamPDO($stmt, ":nom", $nom, 'texte', strlen($nom));
    ajouterParamPDO($stmt, ":prenom", $prenom, 'texte', strlen($prenom));
    ajouterParamPDO($stmt, ":email", $email, 'texte', strlen($email));
    ajouterParamPDO($stmt, ":id", $id, 'nombre');
    $stmt->execute();
    header("Location: /sae2-456-grp2/index.php?page=gerer.php");
    exit;
}
?>