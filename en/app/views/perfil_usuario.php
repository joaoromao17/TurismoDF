<?php
    # para trabalhar com sessões sempre iniciamos com session_start.
    session_start();
    
    # inclui o arquivo header e a classe de conexão com o banco de dados.
    require_once "../database/conexao.php";

    $query = "SELECT * FROM `turismodf`.`usuarios`";

?>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500&display=swap" rel="stylesheet">
    <link href="assets/css/boot.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/fonticon.css" rel="stylesheet">
    <link href="assets/css/login.css" rel="stylesheet">
    <link href="assets/css/lista.css" rel="stylesheet">
    <link href="assets/css/conta_cli/altera_dado.css" rel="stylesheet">
    <link href="assets/css/conta_cli/index.css" rel="stylesheet">
    <link href="assets/css/conta_cli/reativa.css" rel="stylesheet">

    <link href="assets/css/modal.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/novoform.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Turismo DF</title>
</head>

<body>
    <?php require_once 'layouts/admin/menu.php'; ?>

    <!-- MAIN============================================ -->
    <main>
        <section class="main_content_dados">
            <header class="main_titulo_dados">
                <h1>Personal data</h1>
            </header>

            <div class='dados_cadastro_content'>
                <div class="dados_cadastro_input_box">
                    <label for="#">Name:</label>
                    <span class="dado_php"><?php echo $_SESSION['usuario']['nome']?></span><br>
                </div>
                <div class="dados_cadastro_input_box">
                    <label for="#">Email:</label>
                    <span class="dado_php"><?php echo $_SESSION['usuario']['email'] ?></span>
                </div>
            </div>



                </div>
            </div>
        </section>
    </main>

    <?php require_once 'layouts/site/footer.php'; ?>
</body>


</html>