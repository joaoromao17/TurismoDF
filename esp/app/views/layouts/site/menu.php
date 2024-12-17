<header class="main_header">
    <div class="main_header_content">
    <a href="index.php" class="logo">
        <img src="assets/img/logo.png" width="80" height="80" alt="Logo" title="logo"></a>

        <nav class="main_header_content_menu">
            <ul>
                <li><a href="../../../br/app/views/index.php"><img src="assets/img/brasil.jfif" width="30 px" height="20 px"></a></li>
                <li><a href="../../../en/app/views/index.php"><img src="assets/img/USA.jfif" width="30 px" height="20 px"></a></li>
                <li><a href="../views/index.php"><img src="assets/img/espanhol.jfif" width="30 px" height="20 px"></a></li>
                <li><a href="#oquefazer">¿Que hacer?</a></li>
                <li><a href="#mapa">Mapa</a></li>
                <?php 
                    # verifica se existe sessão de usuario e se ele é administrador.
                    # se não for o primeiro caso, verifica se a sessao existe.
                    # por ultimo adiciona somente o link para o login se a sessão não existir. 
                    if (isset($_SESSION['usuario']) && $_SESSION['usuario']['perfil'] == 'ADM')  {
                        echo "<li><a href='usuario_admin.php'>Admin</a></li>";
                        echo "<li><a href='logout.php'>Sair</a></li>";
                    } else if(isset($_SESSION['usuario']) && ($_SESSION['usuario']['perfil'] == 'ADM' || $_SESSION['usuario']['perfil'] == 'GER' )) {
                        echo "<li><a href='categoria_index.php'>Categorías</a></li>";
                        echo "<li><a href='logout.php'>Salir</a></li>";
                        echo "<li>¡Bienvenido Usuario!</li>";
                    } else if(isset($_SESSION['usuario'])) {
                        echo "<li><a href='logout.php'>Salir</a></li>";
                        echo "<li>¡Bienvenido Usuario!</li>";
                    } else {
                        echo "<li><a href='login.php' class='modal-link'>Login</a>";               
                    }
                ?>
            </ul>
        </nav>
        <!--<p style="text-align: right;color:#fff;margin: 0 20px 15px 0;font-weight:500;width:100vw">Bem vindo: <?=$_SESSION['usuario']['nome'];?></p>-->
    </div>
</header>

    <!--DOBRA CABEÇALHO-->