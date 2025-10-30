<?php
require_once '../session/session.php';
require_once '../../php/connexion.php';


if (!isLoggedIn()) {
    header('Location: ../page/signin.php');
    exit;
}
?>

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<div class="fixed inset-0 w-full h-full bg-[url('./web/assets/img/rapidc3.png')] bg-cover bg-center bg-no-repeat z-0 ">
        <div class="absolute inset-0 bg-black opacity-55"></div>
    </div>

<div class="fixed inset-0 flex flex-col items-center justify-center gap-10 z-30">
    
    <!-- Boîte 1 : Infos utilisateur -->
    <div class="bg-white rounded-2xl shadow-xl p-8 w-[650px] max-w-full text-center">
        <div class="text-orange-400 text-4xl font-bold mb-6">
            <?php echo 'Bienvenue ' . getPrenom(); ?>
        </div>
        
        <div class="text-gray-800 text-2xl font-semibold mb-4 flex gap-5 justify-center">
            <?php echo 'Votre adresse mail : ' . getEmail(); ?>
            <form action="">
                <button><small class="text-orange-400">modifier</small></button>
            </form>
        </div>
        
        <div class="text-gray-800 text-2xl font-semibold mb-4 flex gap-5 justify-center">
            <?php echo 'Votre mot de passe : *********'; ?>
            <form action="">
                <button><small class="text-orange-400">modifier</small></button>
            </form>
        </div>
        
        <div class="text-gray-800 text-2xl font-semibold flex gap-4 justify-center">
            <?php echo 'Votre numéro de téléphone : ' . getTel(); ?>
            <form action="">
                <button><small class="text-orange-400">modifier</small></button>
            </form>
        </div>
    </div>

    <!-- Boîte 2 : Fidélité -->
    <div class="bg-white rounded-2xl shadow-xl p-8 w-[650px] max-w-full text-center">
        <div class="text-orange-400 text-4xl font-bold mb-6">
            Vos points de fidélité
        </div>
        
        <div class="flex justify-center items-baseline gap-3 tex-gray-800">
            <div class="text-gray-800 text-6xl font-semibold">
                <?php
                    $sql = "select sum(total_points) as somme from rap_client
                            join rap_commande using(cli_num)
                            join rap_fidelisation using(cli_num)
                            join rap_restaurant using(res_num)
                            where cli_num = ".getId();
                    $res = LireDonneesPDO1($conn,$sql,$donnees);

                    if($donnees != null){
                        //echo "<script>console.log(".$donnees.")</script>";
                        //echo ($donnees[0]);
                        // print_r($donnees);
                        if (isset($donnees[0]["SOMME"])) {
                            echo $donnees[0]["SOMME"];
                        }
                        else {
                            echo 0;
                        }
                    }
                    else{
                        echo (0);
                    }
                    
                    // echo $donnees[0];
                    // echo 'Vous avez ' . $points . ' point' . ($points > 1 ? 's' : '') . ' de fidélité.'; 

                    $result = isLoggedInAdmin($conn);
                ?>
            </div>
            <div class="text-gray-800 text-2xl font-semibold">
            points
            </div>
        </div>
        <div class="flex justify-center mt-5 items-baseline gap-3 tex-gray-800">
        <button id="btn-commandes" onclick="loadPage('commandes.php', this)" class="py-2 px-6 !bg-orange-400 !hover:bg-orange-600 flex items-center text-gray-800 hover:bg-gray-100 rounded-full focus:outline-hidden focus:bg-gray-100 dark:bg-neutral-800 dark:text-neutral-200 dark:hover:bg-neutral-700 dark:focus:bg-neutral-700 hs-scrollspy-active:bg-gray-100">
                Mes commandes
        </button>
        </div>
    </div>
</div>
