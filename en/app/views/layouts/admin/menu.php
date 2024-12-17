<!--DOBRA CABEÇALHO-->

<header class="main_header">
    <div class="main_header_content">
        <a href="index.php" class="logo">
                <img src="assets/img/logo.png" width="80" height="80" alt="Logo" title="logo"></a>

        <nav class="main_header_content_menu">
            <ul>
                <li><a href="index.php">Home</a></li>
                <?php 
                    # verifica se existe sessão de usuario e se ele é administrador.
                    # se não for o primeiro caso, verifica se a sessao existe.
                    # por ultimo adiciona somente o link para o login se a sessão não existir. 
                    if (isset($_SESSION['usuario']) && $_SESSION['usuario']['perfil'] == 'ADM')  {
                        echo "<li><a href='usuario_admin.php'>Admin</a></li>";
                    }
                    if(isset($_SESSION['usuario']) && ($_SESSION['usuario']['perfil'] != 'USU' )) {
                        echo "<li><a href='artigo_index.php'>Artigos</a></li>";
                    } 
                    if(isset($_SESSION['usuario']) && ($_SESSION['usuario']['perfil'] == 'ADM' )) {
                        echo "<li><a href='categoria_index.php'>Categorias</a></li>";
                    } 
                    echo "<li><a href='logout.php'>Sair</a></li>";
                ?>
            </ul>
        </nav>
        <!--<p style="text-align: right;color:#fff;margin: 0 20px 15px 0;font-weight:500;width:100vw">Bem vindo: <?=$_SESSION['usuario']['nome'];?></p>-->
    </div>
</header>

<style>
    .main_cta{
        width:100%;
        background-image: url('../img/bg_main_home.png');
        background-color: #2d3142;
        background-repeat: no-repeat;
        background-position: center center;
        background-size: cover;
    }
</style>