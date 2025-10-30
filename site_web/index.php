<?php
require_once './web/session/session.php';

if (!isset($_SESSION['panier'])) {
    $_SESSION['panier'] = [
        'produits' => [],
        'menus' => []
    ];
}

if (!isset($_SESSION['panier']['produits'])) {
    $_SESSION['panier']['produits'] = [];
}

if (!isset($_SESSION['panier']['menus'])) {
    $_SESSION['panier']['menus'] = [];
}
?>

<!DOCTYPE html>
<?php require_once './web/component/meta.php'; ?>
<!-- style commun de l'application -->
<link rel="stylesheet" href="./web/assets/css/root.css">

<body>

    <?php require_once './web/component/navbar.php'; ?>

    <div id="content">
        <!-- Le contenu se charge ici -->
    </div>

    <?php require_once './web/component/dialog.php';?>
    <?php require_once './web/component/footer.php';?>

    <script src="./web/assets/js/payer.js"></script>

</body>
</html>