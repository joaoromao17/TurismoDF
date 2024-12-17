<?php
# para trabalhar com sessões sempre iniciamos com session_start.
session_start();

# inclui os arquivos header, menu e login.
require_once 'layouts/site/header.php';
require_once 'layouts/site/menu.php';
require_once 'login.php';
require_once "../database/conexao.php";

# cria a variavel $dbh que vai receber a conexão com o SGBD e banco de dados.
$dbh = Conexao::getInstance();

# cria uma consulta banco de dados buscando todos os dados da tabela  
# ordenando pelo campo data.
$query = "SELECT * FROM `categorias` 
                ORDER BY categorias.id";
# verifica se existe filtro para categoria.
# se sim adiciona condição ao select.
$stmt = $dbh->prepare($query);

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

// echo '<pre>';var_dump($rows);exit;
# destroi a conexao com o banco de dados.
$dbh = null;
?>
<!--DOBRA PALCO PRINCIPAL-->

<!--1ª DOBRA-->

<main>

    <?php
    # verifca se existe uma mensagem de erro enviada via GET.
    # se sim, exibe a mensagem enviada no cabeçalho.
    if (isset($_GET['error']) || isset($_GET['success'])) { ?>
        <script>
            Swal.fire({
                icon: '<?php echo (isset($_GET['error']) ? 'error' : 'success'); ?>',
                title: 'Turismo DF',
                text: '<?php echo (isset($_GET['error']) ? $_GET['error'] : $_GET['success']); ?>',
            })
        </script>
    <?php } ?>

    <a href="#" class="btn-top"></a>
    <div class="main_cta">
        <article class="main_cta_content">
            <div class="main_cta_content_spacer">
                <header>
                    <h1>DOAÇÃO</h1>
                </header>
                <h2>Qualquer valor é importante!</h2>
                <p><a href="#oquefazer" class="btn">Saiba Mais</a></p>
            </div>
        </article>
    </div>
    <!--FIM 1ª DOBRA-->

    <!--INICIO SESSÃO SESSÃO DE ARTIGOS-->
    <section class="main_blog">
        <header class="main_blog_header">
            <h1 class="icon-credit-card" id="oquefazer">Apenas ler o Qrcode</h1>
            <p>Agradecemos!!</p>
            <br>
            <img src="assets/img/pix.jpeg" alt="">
            
            <!-- cria o campo select com os dados da consulta 
                realizada na tabela de categorias -->
        </header>

    </section>

   
</main>


<!--FIM DOBRA PALCO PRINCIPAL-->

<?php require_once 'layouts/site/footer.php'; ?>