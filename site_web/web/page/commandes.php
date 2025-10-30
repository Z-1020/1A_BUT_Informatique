<?php
require_once '../session/session.php';
require_once '../../php/connexion.php';

if (!isLoggedIn()) {
    header('Location: ../page/signin.php');
    exit;
}
?>

<script src="./web/assets/js/navbar.js"></script>


<?php
    try {
        $id = getId();
        $sql = "SELECT RES_NUM, COM_NUM, CLI_NUM, COM_DATE, to_char(COM_HEURE_RECUP, 'hh24:mi:ss') as COM_HEURE_RECUP, COM_PRIX_TOTAL, COM_REDUC_POINTS, COM_REDUC_PROMO, COM_DUREE_TOTALE_PREPA FROM RAP_COMMANDE WHERE CLI_NUM = ".getId();
        $stmt = preparerRequetePDO($conn,$sql);
        $donnees = array();
        LireDonneesPDOPreparee($stmt, $donnees);
    }
    catch (Exception $e) {
        var_dump($e);
    }

?>

<!-- Table Section -->
<div class="max-w-[85rem] px-4 py-10 sm:px-6 lg:px-8 lg:py-14 mx-auto">
  <!-- Card -->
  <div class="flex flex-col">
    <div class="-m-1.5 overflow-x-auto">
      <div class="p-1.5 min-w-full inline-block align-middle">
        <div class="bg-white border border-gray-200 rounded-xl shadow-2xs overflow-hidden dark:bg-neutral-800 dark:border-neutral-700">
          <!-- Header -->
          <div class="px-6 py-4 grid gap-3 md:flex md:justify-between md:items-center border-b border-gray-200 dark:border-neutral-700">
            <div>
              <h2 class="text-xl font-semibold text-gray-800 dark:text-neutral-200">
                Commandes en cours
              </h2>
              <p class="text-sm text-gray-600 dark:text-neutral-400">
                Visualisez vos commandes
              </p>
            </div>

            <div>
              <div class="inline-flex gap-x-2">
                <button onclick="loadPage('commander.php')" class="py-2 px-3 inline-flex items-center gap-x-2 text-sm font-medium rounded-lg border border-transparent bg-orange-400 text-white hover:bg-orange-500 focus:outline-hidden focus:bg-orange-500 disabled:opacity-50 disabled:pointer-events-none" href="#">
                  <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
                  Commander
                </button>
              </div>
            </div>
          </div>
          <!-- End Header -->

          <!-- Table -->
          <table class="min-w-full divide-y divide-gray-200 dark:divide-neutral-700">
          <thead class="bg-gray-50 dark:bg-neutral-800 px-4 text-center">
              <tr>
                <!--
                <th scope="col" class="ps-6 py-3 text-start">
                  <label for="hs-at-with-checkboxes-main" class="flex">
                    <input type="checkbox" class="shrink-0 border-gray-300 rounded-sm text-blue-600 focus:ring-blue-500 checked:border-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-800 dark:border-neutral-600 dark:checked:bg-blue-500 dark:checked:border-blue-500 dark:focus:ring-offset-gray-800" id="hs-at-with-checkboxes-main">
                    <span class="sr-only">Checkbox</span>
                  </label>
                </th>
-->

                <th scope="col" class="ps-6 lg:ps-3 xl:ps-0 pe-6 py-3 text-start">
                  <div class="flex items-center gap-x-2">
                    <span class="text-xs font-semibold uppercase text-gray-800 dark:text-neutral-200">
                      Nom restaurant
                    </span>
                  </div>
                </th>

                <th scope="col" class="px-6 py-3 text-start">
                  <div class="flex items-center gap-x-2">
                    <span class="text-xs font-semibold uppercase text-gray-800 dark:text-neutral-200">
                      Numéro commande
                    </span>
                  </div>
                </th>

                <th scope="col" class="px-6 py-3 text-start">
                  <div class="flex items-center gap-x-2">
                    <span class="text-xs font-semibold uppercase text-gray-800 dark:text-neutral-200">
                      Numéro client
                    </span>
                  </div>
                </th>

                <th scope="col" class="px-6 py-3 text-start">
                  <div class="flex items-center gap-x-2">
                    <span class="text-xs font-semibold uppercase text-gray-800 dark:text-neutral-200">
                      Créer le
                    </span>
                  </div>
                </th>

                <th scope="col" class="px-6 py-3 text-start">
                  <div class="flex items-center gap-x-2">
                    <span class="text-xs font-semibold uppercase text-gray-800 dark:text-neutral-200">
                      HEURE RECUPERATION COMMANDE
                    </span>
                  </div>
                </th>

                <th scope="col" class="px-6 py-3 text-start">
                  <div class="flex items-center gap-x-2">
                    <span class="text-xs font-semibold uppercase text-gray-800 dark:text-neutral-200">
                      PRIX TOTAL COMMANDE
                    </span>
                  </div>
                </th>

                <th scope="col" class="px-6 py-3 text-start">
                  <div class="flex items-center gap-x-2">
                    <span class="text-xs font-semibold uppercase text-gray-800 dark:text-neutral-200">
                      COM_REDUC_POINTS
                    </span>
                  </div>
                </th>

                <th scope="col" class="px-6 py-3 text-start">
                  <div class="flex items-center gap-x-2">
                    <span class="text-xs font-semibold uppercase text-gray-800 dark:text-neutral-200">
                      COM_REDUC_PROMO
                    </span>
                  </div>
                </th>

                <th scope="col" class="px-6 py-3 text-start">
                  <div class="flex items-center gap-x-2">
                    <span class="text-xs font-semibold uppercase text-gray-800 dark:text-neutral-200">
                      COM_DUREE_TOTALE_PREPA
                    </span>
                  </div>
                </th>

                <th scope="col" class="py-3 text-end"></th>
              </tr>
            </thead>

            <tbody class="divide-y divide-gray-200 dark:divide-neutral-700">
                <?php if (empty($donnees)): ?>
                    <tr>
                        <td colspan="11" class="px-6 py-6 text-center text-gray-500 dark:text-neutral-400">
                            Aucune commande en cours.
                        </td>
                    </tr>
                <?php else: ?>
                    <?php for ($i = 0; $i < count($donnees); $i++): ?>
                        <tr>
                            <!--
                        <td class="size-px whitespace-nowrap">
                            <div class="ps-6 py-3">
                            <label class="flex">
                                <input type="checkbox" class="shrink-0 border-gray-300 rounded-sm text-blue-600 focus:ring-blue-500 dark:bg-neutral-800 dark:border-neutral-600 dark:checked:bg-blue-500 dark:checked:border-blue-500 dark:focus:ring-offset-gray-800">
                                <span class="sr-only">Checkbox</span>
                            </label>
                            </div>
                        </td>
                        -->

                        <!-- RES_NUM -->
                        <td class="size-px whitespace-nowrap">
                            <div class="flex justify-center ps-6 lg:ps-3 xl:ps-0 pe-6 py-3">
                            <span class="text-sm text-gray-800 dark:text-neutral-200">
                                <?= htmlspecialchars($donnees[$i]['RES_NUM']) ?>
                            </span>
                            </div>
                        </td>

                        <!-- COM_NUM -->
                        <td class="h-px w-72 whitespace-nowrap">
                            <div class="flex justify-center px-6 py-3">
                            <span class="text-sm text-gray-800 dark:text-neutral-200">
                                <?= htmlspecialchars($donnees[$i]['COM_NUM']) ?>
                            </span>
                            </div>
                        </td>

                        <!-- CLI_NUM -->
                        <td class="size-px whitespace-nowrap">
                            <div class="flex justify-center px-6 py-3">
                            <span class="text-sm text-gray-800 dark:text-neutral-200">
                                <?= htmlspecialchars($donnees[$i]['CLI_NUM']) ?>
                            </span>
                            </div>
                        </td>

                        <!-- COM_DATE -->
                        <td class="size-px whitespace-nowrap">
                            <div class="flex justify-center px-6 py-3">
                            <span class="text-sm text-gray-500 dark:text-neutral-500">
                                <?= htmlspecialchars($donnees[$i]['COM_DATE']) ?>
                            </span>
                            </div>
                        </td>

                        <!-- COM_HEURE_RECUP -->
                        <td class="size-px whitespace-nowrap">
                            <div class="flex justify-center px-6 py-3">
                            <span class="text-sm text-gray-500 dark:text-neutral-500">
                                <?= htmlspecialchars($donnees[$i]['COM_HEURE_RECUP']) ?>
                            </span>
                            </div>
                        </td>

                        <!-- COM_PRIX_TOTAL -->
                        <td class="size-px whitespace-nowrap">
                            <div class="flex justify-center px-6 py-3">
                            <span class="text-sm text-gray-500 dark:text-neutral-500">
                                <?= htmlspecialchars($donnees[$i]['COM_PRIX_TOTAL'])." €" ?>
                            </span>
                            </div>
                        </td>

                        <!-- COM_REDUC_POINTS -->
                        <td class="size-px whitespace-nowrap">
                            <div class="flex justify-center px-6 py-3">
                            <span class="text-sm text-gray-500 dark:text-neutral-500">
                                <?= htmlspecialchars($donnees[$i]['COM_REDUC_POINTS']) ?>
                            </span>
                            </div>
                        </td>

                        <!-- COM_REDUC_PROMO -->
                        <td class="size-px whitespace-nowrap">
                            <div class="flex justify-center px-6 py-3">
                            <span class="text-sm text-gray-500 dark:text-neutral-500">
                                <?= htmlspecialchars($donnees[$i]['COM_REDUC_PROMO']) ?>
                            </span>
                            </div>
                        </td>

                        <!-- COM_DUREE_TOTALE_PREPA -->
                        <td class="size-px whitespace-nowrap">
                            <div class="flex justify-center px-6 py-3">
                            <span class="text-sm text-gray-500 dark:text-neutral-500">
                                <?= htmlspecialchars($donnees[$i]['COM_DUREE_TOTALE_PREPA']) ?>
                            </span>
                            </div>
                        </td>

                        </tr>
                    <?php endfor; ?>
                <?php endif; ?>
            </tbody>
          </table>
          <!-- End Table -->

          <?php if (!empty($donnees)): ?>
            <!-- Footer -->
            <div class="px-6 py-4 grid gap-3 md:flex md:justify-between md:items-center border-t border-gray-200 dark:border-neutral-700">
                <div>
                <p class="text-sm text-gray-600 dark:text-neutral-400">
                    <span class="font-semibold text-gray-800 dark:text-neutral-200">
                        <?= count($donnees); ?>
                    </span> resultats
                </p>
                </div>
            </div>
            <!-- End Footer -->
        <?php endif; ?>
        </div>
      </div>
    </div>
  </div>
  <!-- End Card -->
</div>
<!-- End Table Section -->