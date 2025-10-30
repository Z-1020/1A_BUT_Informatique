<?php
    require_once '../session/session.php';
    require_once '../../php/connexion.php';
    if (!isLoggedIn()) {
        header("Location: ../page/signin.php");
        exit;
    }

    try {
        $comNumSql = "SELECT (max(COM_NUM) + 1) as max FROM RAP_COMMANDE";
        $stmt2 = preparerRequetePDO($conn, $comNumSql);
        $stmt2->execute();
        $comNum = $stmt2->fetchColumn();
    }
    catch (PDOException $e) {
        echo 'erreur pour récupérer le numéro de commande';
        var_dump($e);
    }

    try {
        $comDate = date("d/m/Y");
    }
    catch (Exception $e) {
        echo 'problème pour recuperer la date actuelle';
        var_dump($e);
    }

    try {
        $date = new DateTime();
        $date->modify('+1 hour');
        $comHeureRecup = $date->format('H:i:s');
    }
    catch (Exception $e) {
        echo 'problème pour recuperer l heure de recuperation de la commande';
        var_dump($e);
    }

    $resNum = "1";
    $cliNum = getId();
    $comPrixTotal = (string) str_replace('.', ',', getPrixTotal());
    $comReducPoints = "0";
    $comReducPromo = "0";
    $comDureeTotalePrepa = "0";


    $successfullySaved = false;

    if (isset($resNum) && isset($comNum) && isset($cliNum) && isset($comDate) && isset($comHeureRecup) && isset($comPrixTotal) && isset($comReducPoints) && isset($comReducPromo) && isset($comDureeTotalePrepa)) {
        try {
            $sql = "INSERT INTO RAP_COMMANDE VALUES ('".$resNum."','".$comNum."','".$cliNum."','".$comDate."',to_date('".$comHeureRecup."','hh24:mi:ss'),'".$comPrixTotal."','".$comReducPoints."','".$comReducPromo."','".$comDureeTotalePrepa."','0')";
            $stmt = preparerRequetePDO($conn, $sql);
            $stmt->execute();
        }
        catch (PDOException $e) {
            echo "problème lors de l'enregistrement de la commande dans RAP_COMMANDE";
        }

        try {
            foreach ($_SESSION['panier']['produits'] as $plat) {
                $plaNum = $plat['id'];
                $appQuantite = $plat['quantite'];

                $sql = "INSERT INTO RAP_APPARTENIR VALUES ('".$resNum."','".$comNum."','".$plaNum."','".$appQuantite."')";
                $stmt = preparerRequetePDO($conn, $sql);
                $stmt->execute();
            }
        }
            catch (PDOException $e) {
            echo "problème lors de l'enregistrement de la commande dans RAP_APPPARTENIR";
        }


        try {
            $totsql = "
            SELECT p.PLA_NB_POINTS * a.APP_QUANTITE AS total_points
            FROM RAP_APPARTENIR a
            JOIN RAP_PLAT p ON a.PLA_NUM = p.PLA_NUM
            WHERE a.RES_NUM = ".$resNum;
    
            $stmt = preparerRequetePDO($conn, $totsql);
            $stmt->execute();
            $totalPoints = $stmt->fetchColumn();

            $suiDatePoints = date('d/m/Y');

            $sql = "INSERT INTO RAP_FIDELISATION VALUES ('".$cliNum."','".$suiDatePoints."','".$totalPoints."')";
            $stmt = preparerRequetePDO($conn, $sql);
            $stmt->execute();
        }
        catch (PDOException $e) {
            echo "problème lors de l'enregistrement de la commande dans RAP_FIDELISATION";
            var_dump($e);
        }

        $successfullySaved = true;

        if ($successfullySaved) {
            $_SESSION['panier']['produits'] = [];
            $_SESSION['panier']['menus'] = [];
            $_SESSION['panier']['somme'] = 0;

            // echo "<script>
            //     let secondes = 10;
            //     const timer = document.getElementById('timer');
        
            //     const interval = setInterval(() => {
            //     secondes--;
            //     timer.textContent = secondes;
            //     if (secondes <= 0) {
            //         clearInterval(interval);
            //     }
            //     }, 1000);
            // </script>";
    
        }
    }
?>

<!-- Image de fond + filtre opaque -->
<!-- bg-[url('./web/assets/img/rapidc3.png')] -->
<div class="fixed inset-0 w-full h-full  bg-cover bg-center bg-no-repeat z-0 ">
    <div class="absolute inset-0 bg-black opacity-55"></div>
</div>
<!-- Contenu au-dessus du fond -->
<div class="relative z-10 flex items-center justify-center h-screen w-full">
    <div class="text-center bg-white/90 backdrop-blur-md p-8 rounded-xl shadow-xl max-w-md w-full">
        <h1 class="text-3xl font-bold text-green-600 mb-4">Commande terminée ✅</h1>
        <p class="text-gray-800 mb-2">Merci pour votre commande.</p>
        <p class="text-gray-700">Vous pouvez désormais retourner à <span id="timer" class="font-semibold text-black">l'accueil</span></p>
    </div>
</div>

</body>
</html>
