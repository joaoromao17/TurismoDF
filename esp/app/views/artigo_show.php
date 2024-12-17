<?php
    # para trabalhar com sessões sempre iniciamos com session_start.
    session_start();

    # inclui os arquivos header, menu e login.
    require_once 'layouts/site/header.php';
    require_once 'login.php';
    require_once "../database/conexao.php";

    # cria a variavel $dbh que vai receber a conexão com o SGBD e banco de dados.
    $dbh = Conexao::getInstance();
    
    # cria variavel que recebe parametro da categoria
    # se foi passado via get quando o campo select do
    # formulario é modificado.    
    $idArtigo = isset($_GET['id']) ? $_GET['id'] : 0;
    
    
    # cria uma consulta banco de dados buscando todos os dados da tabela  
    # ordenando pelo campo data e limita o resultado a 10 registros.
    $query = "SELECT art.*, cat.nome as categoria 
                FROM `turismodf`.`artigos` AS art 
                INNER JOIN `turismodf`.`categorias` AS cat ON cat.id = art.categoria_id
                WHERE art.id = " .$idArtigo;    
    $stmt = $dbh->prepare($query);
    
    # executa a consulta banco de dados e aguarda o resultado.
    $stmt->execute();
    
    # Faz um fetch para trazer os dados existentes, se existirem, em um array na variavel $row.
    # se não existir retorna null
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    # destroi a conexao com o banco de dados.
    $dbh = null;
    // echo '<pre>';var_dump($row);
?>

<!--DOBRA PALCO PRINCIPAL-->

<!--1ª DOBRA-->
<header class="main_header">
    <div class="main_header_content">
    <a href="index.php" class="logo">
        <img src="assets/img/logo.png" width="80" height="80" alt="Logo" title="logo"></a>

        <nav class="main_header_content_menu">
            <ul>
                <li><a href="../views/index.php">Casa</a></li>
                <?php 
                    # verifica se existe sessão de usuario e se ele é administrador.
                    # se não for o primeiro caso, verifica se a sessao existe.
                    # por ultimo adiciona somente o link para o login se a sessão não existir. 
                    if (isset($_SESSION['usuario']) && $_SESSION['usuario']['perfil'] == 'ADM')  {
                        echo "<li><a href='usuario_admin.php'>Admin</a></li>";
                        echo "<li><a href='logout.php'>Salir</a></li>";
                    } else if(isset($_SESSION['usuario']) && ($_SESSION['usuario']['perfil'] == 'ADM' || $_SESSION['usuario']['perfil'] == 'GER' )) {
                        echo "<li><a href='categoria_index.php'>Categorías</a></li>";
                        echo "<li><a href='logout.php'>Salir</a></li>";
                    } else if(isset($_SESSION['usuario'])) {
                        echo "<li><a href='logout.php'>Salir</a></li>";
                    } else {
                        echo "<li><a href='login.php' class='modal-link'>Login</a>";               
                    }
                ?>
            </ul>
        </nav>
        <p style="text-align: right;color:#fff;margin: 0 20px 15px 0;font-weight:500;width:100vw">Usuario: <?=$_SESSION['usuario']['nome'];?></p>
    </div>
</header>

    <!--DOBRA CABEÇALHO-->
<main>
    
    <?php
        # verifca se existe uma mensagem de erro enviada via GET.
        # se sim, exibe a mensagem enviada no cabeçalho.
        if(isset($_GET['error']) || isset($_GET['success']) ) { ?>
            <script>
                Swal.fire({
                icon: '<?php echo (isset($_GET['error']) ? 'error' : 'success');?>',
                title: 'Turismo DF',
                text: '<?php echo (isset($_GET['error']) ? $_GET['error']: $_GET['success']); ?>',
                })
            </script>
    <?php } ?>

    <!--FIM 1ª DOBRA-->
    <section class="main_blog">
        <header class="main_blog_header">
            <?php 
                if(!$row) {
                    header('location: index.php?error=Artigo não encontrado!');
                    exit;
                }    
            ?>
            <h1 class="icon-blog">
                <?=$row['titulo'];?>
            </h1>
            <p>
                <strong>Categoría: </strong><span><?=$row['categoria'];?></span>
            </p>
        </header>
        <section class="artigo_show">
            <div>
                <?php 
                    $path =  'assets/img/artigos/';
                    if($row['imagem_externa'] && trim($row['imagem']) != '') {
                        echo "<img alt='" . $row['titulo'] . "' src='" . $row['imagem'] . "'>";
                    } elseif($row['imagem_externa'] == false && trim($row['imagem']) != '') {
                        $imagem = $path . $row['imagem'];
                        echo "<img alt='" . $row['titulo'] . "' src='" . $imagem . "'>";        
                    } else {
                        echo "<img alt='" . $row['titulo'] . "' src='assets/img/artigos/semimagem.jpg'>";
                    }               
                ?>

<div class="rating">
  <input value="star-1" name="star-radio" id="star-1" type="radio">
  <label for="star-1">
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12,17.27L18.18,21L16.54,13.97L22,9.24L14.81,8.62L12,2L9.19,8.62L2,9.24L7.45,13.97L5.82,21L12,17.27Z" pathLength="360"></path></svg>
  </label>
  <input value="star-1" name="star-radio" id="star-2" type="radio">
  <label for="star-2">
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12,17.27L18.18,21L16.54,13.97L22,9.24L14.81,8.62L12,2L9.19,8.62L2,9.24L7.45,13.97L5.82,21L12,17.27Z" pathLength="360"></path></svg>
  </label>
  <input value="star-1" name="star-radio" id="star-3" type="radio">
  <label for="star-3">
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12,17.27L18.18,21L16.54,13.97L22,9.24L14.81,8.62L12,2L9.19,8.62L2,9.24L7.45,13.97L5.82,21L12,17.27Z" pathLength="360"></path></svg>
  </label>
  <input value="star-1" name="star-radio" id="star-4" type="radio">
  <label for="star-4">
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12,17.27L18.18,21L16.54,13.97L22,9.24L14.81,8.62L12,2L9.19,8.62L2,9.24L7.45,13.97L5.82,21L12,17.27Z" pathLength="360"></path></svg>
  </label>
  <input value="star-1" name="star-radio" id="star-5" type="radio">
  <label for="star-5">
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12,17.27L18.18,21L16.54,13.97L22,9.24L14.81,8.62L12,2L9.19,8.62L2,9.24L7.45,13.97L5.82,21L12,17.27Z" pathLength="360"></path></svg>
  </label>
</div>

<br><br>
                
            </div>
            <p class="artigo_show__data">
                <strong>Fecha de publicación: </strong>
                <?=date_format(date_create($row['data_publicacao']),'d/m/Y H:i');?>
            </p>
            <br>
            <p class="artigo_show__texto">
               <?=$row['texto'];?>
            </p>
            <p class="artigo_show__texto">
                <a href="<?=$row['link'];?>" target="_blank">
             <?=$row['link'];?>
             </a>
            </p>
        </section>
        <br>
        <br>
    </section>

                <!--INICIO SESSÃO OPTIN-->
                <article class="opt_in">
        <div class="opt_in_content">
            <header>
                <h1>¿Quieres recibir todas las novedades en tu email?</h1>
                <p>Ingrese su nombre y correo electrónico en el campo al lado y haga clic en ¡Aceptar!</p>
            </header>
            <form>
                <input type="text" placeholder="Su nombre">
                <input type="email" placeholder="Su e-mail">
                <button type="submit">Ok</button>
            </form>
        </div>
    </article>
    <!--FIM SESSÃO OPTIN-->
    
</main>

<!-- inclui o arquivo de rodape do site -->
<?php require_once 'layouts/site/footer.php'; ?>