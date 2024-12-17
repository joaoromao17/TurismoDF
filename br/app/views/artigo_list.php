<?php
# para trabalhar com sessões sempre iniciamos com session_start.
session_start();

# inclui o arquivo header e a classe de conexão com o banco de dados.
require_once 'layouts/site/header.php';
require_once 'login.php';
require_once "../database/conexao.php";

# verifica se existe sessão de usuario e se ele é administrador.
# se não existir redireciona o usuario para a pagina principal com uma mensagem de erro.
# sai da pagina.
if (
    !isset($_SESSION['usuario']) ||
    ($_SESSION['usuario']['perfil'] != 'ADM'
        && $_SESSION['usuario']['perfil'] != 'USU'
    )
) {
    header("Location: index.php?error=Faça o login para visualizar");
    exit;
}

# verifica se uma variavel id foi passada via GET 
$id = isset($_GET['id']) ? $_GET['id'] : 0;

# cria a variavel $dbh que vai receber a conexão com o SGBD e banco de dados.
$dbh = Conexao::getInstance();

# cria variavel que recebe parametro da categoria
# se foi passado via get quando o campo select do
# formulario é modificado.    
$filtroCategoria = isset($_GET['categoria']) ? $_GET['categoria'] : null;
$filtroTitulo = isset($_GET['filtro']) ? $_GET['filtro'] : null;


# cria uma consulta banco de dados buscando todos os dados da tabela usuarios 
# ordenando pelo campo perfil e nome.
$query = "SELECT art.*, cat.nome as categoria 
                FROM `turismodf`.`artigos` AS art
                INNER JOIN `turismodf`.`categorias` AS cat ON cat.id = art.categoria_id
                WHERE  cat.id = :catid";
if ($filtroCategoria != null && $filtroCategoria != "0") {
    $query .= " AND cat.id = '" . $filtroCategoria . "' ";
}
if ($filtroTitulo != null && $filtroTitulo != "0") {
    $query .= " AND art.titulo LIKE '%" . $filtroTitulo . "%' ";
}
$query .= " ORDER BY art.data_publicacao DESC";

$stmt = $dbh->prepare($query);
$stmt->bindParam(':catid', $id);

# executa a consulta banco de dados e aguarda o resultado.
$stmt->execute();

# Faz um fetch para trazer os dados existentes, se existirem, em um array na variavel $row.
# se não existir retorna null
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

   # cria uma consulta banco de dados buscando todos os dados da tabela  
    # ordenando pelo campo nome da categoria.
    $query = "SELECT * 
                FROM `turismodf`.`categorias` 
                ORDER BY nome";
    $stmt = $dbh->prepare($query);
    
    # executa a consulta banco de dados e aguarda o resultado.
    $stmt->execute();
    
    # Faz um fetch para trazer os dados existentes, se existirem, em um array na variavel $row.
    # se não existir retorna null
    $categorias = $stmt->fetchAll(PDO::FETCH_ASSOC);

# destroi a conexao com o banco de dados.
$dbh = null;
// echo '<pre>'; var_dump($rows); exit;
?>

<body>

    <!--DOBRA PALCO PRINCIPAL-->
    <header class="main_header">
        <div class="main_header_content">
            <a href="index.php" class="logo">
                <img src="assets/img/logo.png" width="80" height="80" alt="Logo" title="logo"></a>

            <nav class="main_header_content_menu">
                <ul>
                    <li><a href="../views/index.php">HOME</a></li>
                    <?php
                    # verifica se existe sessão de usuario e se ele é administrador.
                    # se não for o primeiro caso, verifica se a sessao existe.
                    # por ultimo adiciona somente o link para o login se a sessão não existir. 
                    if (isset($_SESSION['usuario']) && $_SESSION['usuario']['perfil'] == 'ADM') {
                        echo "<li><a href='usuario_admin.php'>Admin</a></li>";
                        echo "<li><a href='logout.php'>SAIR</a></li>";
                    } else if (isset($_SESSION['usuario']) && ($_SESSION['usuario']['perfil'] == 'ADM' || $_SESSION['usuario']['perfil'] == 'GER')) {
                        echo "<li><a href='categoria_index.php'>Categorias</a></li>";
                        echo "<li><a href='logout.php'>SAIR</a></li>";
                    } else if (isset($_SESSION['usuario'])) {
                        echo "<li><a href='logout.php'>SAIR</a></li>";
                    } else {
                        echo "<li><a href='login.php' class='modal-link'>Login</a>";
                    }
                    ?>
                </ul>
            </nav>
            <p style="text-align: right;color:#fff;margin: 0 20px 15px 0;font-weight:500;width:100vw">Usuário:
                <?= $_SESSION['usuario']['nome']; ?>
            </p>
        </div>
    </header>

    <!--DOBRA CABEÇALHO-->
    <!--1ª DOBRA-->
    <main>
        <?php
        # verifca se existe uma mensagem de erro enviada via GET.
        # se sim, exibe a mensagem enviada no cabeçalho.
        if (isset($_GET['error']) || isset($_GET['success'])) { ?>
            <script>
                Swal.fire({
                    icon: '<?php echo (isset($_GET['error']) ? 'error' : 'success'); ?>',
                    title: 'Artigos',
                    text: '<?php echo (isset($_GET['error']) ? $_GET['error'] : $_GET['success']); ?>',
                })
            </script>
        <?php } ?>

        <?php if ($rows) { ?>
            <div class="main_cta_list">
                <article class="main_cta_content">
                    <div class="main_cta_content_spacer">
                        <header>
                            <h1>
                                <?= $rows[0]['categoria'] ?>
                            </h1>
                        </header>
                    </div>
                </article>
            </div>
        <?php } else {
            echo "<p>Não existem artigos cadastrados</p>";
        } ?>

        <!--FIM 1ª DOBRA-->
        <a href="#" class="btn-top"></a>
        <!--INICIO SESSÃO SESSÃO DE ARTIGOS-->
        <section class="main_blog">
            <header class="main_blog_header">
                <h1 class="icon-camera" id="oquefazer">Sugestões</h1>
                <p class="icon-point-down">Para a vizualização do artigo, basta clicar!</p>

            </header>
            <!-- cria o campo select com os dados da consulta 
                realizada na tabela de categorias -->

            <?php if ($rows) {
                foreach ($rows as $row) { ?>
                    <article>
                        <a href="artigo_show.php?id=<?= $row['id']; ?>">
                            <?php
                            $imagem = $row['imagem'] == '' ? "assets/img/post.jpg" : $row['imagem'];
                            if ($row['imagem_externa'] == '0') {
                                $imagem = "assets/img/artigos/" . $imagem;
                            }
                            ?>
                            <img src="<?= $imagem ?>" width="200px" height="200px" alt="<?= $row['titulo'] ?>"
                                title="<?= $row['titulo'] ?>">
                        </a>
                        <p><a href="#" class="category">
                                <?= $row['titulo'] ?>
                            </a></p>
                    </article>
                <?php }
            } else {
                echo "<p>Não existem artigos cadastrados</p>";
            } ?>
        </section>

    <!--INICIO SESSÃO OPTIN-->
    <article class="opt_in">
        <div class="opt_in_content">
            <header>
                <h1>Quer nos ajudar?</h1>
                <p>Nosso site é gratuito, porém se quiser fazer uma doação e nos ajudar a ficar no ar, agradecemos!!!</p>
            </header>
            <form action="doacao.php">
                <button type="submit">Doar</button>
            </form>
        </div>
    </article>
    <!--FIM SESSÃO OPTIN-->
    </main>
    <!--FIM DOBRA PALCO PRINCIPAL-->

</body>


</html>

<?php require_once 'layouts/site/footer.php'; ?>