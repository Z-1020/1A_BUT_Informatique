<?php
require_once '../session/session.php';
require_once '../../php/connexion.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $email = trim($_POST['email'] ?? '');
    $password = trim($_POST['password'] ?? '');

    if (empty($email) || empty($password)) {
        header('Location: ../page/signin.php?error=missing');
        exit;
    }

    try {
        $sql = "SELECT * FROM RAP_CLIENT WHERE CLI_COURRIEL = :email";
        $stmt = preparerRequetePDO($conn, $sql);
        ajouterParamPDO($stmt, ":email", $email, 'texte', strlen($email));
        $stmt->execute();
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        // afficherObj($user);

        if (!$user) {
            header('Location: ../page/signin.php?error=invalid');
            exit;
        }

        if (!password_verify($password, $user['CLI_OAUTH_KEY'])) {
            header('Location: ../page/signin.php?error=invalid');
            exit;
        }

        $_SESSION['client'] = [
            'id' => $user['CLI_NUM'],
            'nom' => $user['CLI_NOM'],
            'prenom' => $user['CLI_PRENOM'],
            'tel' => $user['CLI_TEL'],
            'email' => $user['CLI_COURRIEL'],
        ];

        header('Location: ../../index.php?page=accueil.php');
        exit;

    } catch (PDOException $e) {
        header('Location: ../page/signin.php?error=server');
        exit;
    }
} else {
    header('Location: ../page/signin.php');
    exit;
}
