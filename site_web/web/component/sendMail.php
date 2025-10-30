<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require __DIR__ . '/../../vendor/autoload.php'; // Vérifie que le chemin vers autoload.php est correct

header('Content-Type: text/plain');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Validation des données
    $to = filter_var(trim($_POST['email']), FILTER_VALIDATE_EMAIL);
    $subject = trim($_POST['subject'] ?? '');
    $message = trim($_POST['message'] ?? '');

    if (!$to || empty($subject) || empty($message)) {
        echo 'invalid_input';
        exit;
    }

    $mail = new PHPMailer(true);

    try {
        // Configuration SMTP
        $mail->isSMTP();
        $mail->Host = 'smtp.gmail.com';
        $mail->SMTPAuth = true;
        $mail->Username = ''; // <-- Remplacez par votre email
        $mail->Password = ''; // <-- Remplacez par votre mot de passe ou mot de passe d'application
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = 587;

        // Informations sur l'expéditeur et le destinataire
        $mail->setFrom('', ''); // <-- Remplacez par votre email et nom
        $mail->addAddress($to);

        // Contenu du message
        $mail->isHTML(false); // Change à true si tu veux envoyer en HTML
        $mail->Subject = $subject;
        $mail->Body = $message;

        // Envoi
        $mail->send();
        echo 'success';
    } catch (Exception $e) {
        echo 'error: ' . $mail->ErrorInfo;
    }
    exit;
} else {
    echo 'invalid_request';
}
?>
