<?php
require_once '../session/session.php';
require_once '../../php/connexion.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // On récupère les valeurs du formulaire
    $email = trim($_POST['email'] ?? '');
    $password = trim($_POST['password'] ?? '');

    // Vérifie que les champs ne sont pas vides
    if (empty($email) || empty($password)) {
        header('Location: ../page/signin.php?error=missing');
        exit;
    }

    try {
        $sql = "select * from RAP_CLIENT where CLI_COURRIEL like '".$email."' and CLI_MDP like '".$password."'";
        $res = LireDonneesPDO1($conn, $sql, $user);

        afficherObj($user);

        if (empty($user)) {
            header('Location: ../page/signin.php?error=invalid');
            exit;
        } else {
            $_SESSION['client'] = [
                'id' => $user[0]['CLI_NUM'],
                'nom' => $user[0]['CLI_NOM'],
                'prenom' => $user[0]['CLI_PRENOM'],
                'tel' => $user[0]['CLI_TEL'],
                'email' => $user[0]['CLI_COURRIEL'],
            ];
        }
        header('Location: ../index.php?page=accueil.php');
        exit;

    } catch (PDOException $e) {
        // Gestion d'erreur base de données
        header('Location: ../page/signin.php?error=server');
        exit;
    }
} else {
    header('Location: ../page/signin.php');
    exit;
}
