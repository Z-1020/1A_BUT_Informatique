<?php
ob_start();
require_once '../../php/connexion.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_id'])) {
    $id = $_POST['delete_id'];
    try {
        // 1. Supprimer dans RAP_APPARTENIR
        $sql = "
            DELETE FROM RAP_APPARTENIR 
            WHERE COM_NUM IN (SELECT COM_NUM FROM RAP_COMMANDE WHERE CLI_NUM = :id)
        ";
        $stmt = preparerRequetePDO($conn, $sql);
        ajouterParamPDO($stmt, ":id", $id, 'nombre');
        $stmt->execute();

        // 2. Supprimer dans RAP_COMMANDE
        $sql = "DELETE FROM RAP_COMMANDE WHERE CLI_NUM = :id";
        $stmt = preparerRequetePDO($conn, $sql);
        ajouterParamPDO($stmt, ":id", $id, 'nombre');
        $stmt->execute();

        // 3. Supprimer dans RAP_FIDELISATION
        $sql = "DELETE FROM RAP_FIDELISATION WHERE CLI_NUM = :id";
        $stmt = preparerRequetePDO($conn, $sql);
        ajouterParamPDO($stmt, ":id", $id, 'nombre');
        $stmt->execute();

        // 4. Supprimer dans RAP_CLIENT
        $sql = "DELETE FROM RAP_CLIENT WHERE CLI_NUM = :id";
        $stmt = preparerRequetePDO($conn, $sql);
        ajouterParamPDO($stmt, ":id", $id, 'nombre');
        $stmt->execute();

        header("Location: /sae2-456-grp2/index.php?page=gerer.php");
        exit;
        
    } catch (PDOException $e) {
        echo "Erreur lors de la suppression : " . $e->getMessage();
    }
}
?>
