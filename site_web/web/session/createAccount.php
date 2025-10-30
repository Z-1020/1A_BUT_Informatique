<?php
require_once '../session/session.php';
require_once '../../php/connexion.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $nom = trim($_POST['nom'] ?? '');
    $prenom = trim($_POST['prenom'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $tel = trim($_POST['tel'] ?? null);
    $password = trim($_POST['password'] ?? '');
    $confirm_password = trim($_POST['confirm-password'] ?? '');

    if (empty($nom) || empty($prenom) || empty($email) || empty($password) || empty($confirm_password)) {
        header('Location: ../page/signup.php?error=missing');
        exit;
    }

    if ($password !== $confirm_password) {
        header('Location: ../page/signup.php?error=mismatch');
        exit;
    }

    try {
        $sql = "SELECT COUNT(*) FROM RAP_CLIENT WHERE CLI_COURRIEL = :email";
        $verif = preparerRequetePDO($conn, $sql);
        ajouterParamPDO($verif, ":email", $email, 'texte', strlen($email));
        $verif->execute();
        $count = $verif->fetchColumn();

        if ($count > 0) {
            header('Location: ../page/signup.php?error=exists');
            exit;
        }

        $sql = "SELECT COALESCE(MAX(CLI_NUM), 0) + 1 AS next_id FROM RAP_CLIENT";
        $max = $conn->query($sql);
        $id = $max->fetchColumn();

        $hash = password_hash($password, PASSWORD_DEFAULT);

        $sql = "INSERT INTO RAP_CLIENT (CLI_NUM, CLI_NOM, CLI_PRENOM, CLI_OAUTH_KEY, CLI_TEL, CLI_COURRIEL)
                      VALUES (:id, :nom, :prenom, :oauth_key, :tel, :email)";
        $stmt = preparerRequetePDO($conn, $sql);
        ajouterParamPDO($stmt, ":id", $id, 'nombre');
        ajouterParamPDO($stmt, ":nom", $nom, 'texte', strlen($nom));
        ajouterParamPDO($stmt, ":prenom", $prenom, 'texte', strlen($prenom));
        ajouterParamPDO($stmt, ":oauth_key", $hash, 'texte', strlen($hash));
        if (isset($tel)) {
            ajouterParamPDO($stmt, ":tel", $tel, 'texte', strlen($tel));
        }
        ajouterParamPDO($stmt, ":email", $email, 'texte', strlen($email));
        $stmt->execute();

        // $sql = "insert into rap_client values ((select max(cli_num) as num_max from rap_client) + 1, '".$nom."', '".$prenom."', '".$hash."', '".$tel."', '".$email."')";
        // $res = majDonneesPDO($conn, $sql);

        header('Location: ../page/signin.php');
        exit;

    } catch (PDOException $e) {
        header('Location: ../page/signup.php?error=server');
        exit;
    }
} else {
    header('Location: ../page/signup.php');
    exit;
}
