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
                    <h1>Bienvenidos a TurismoDF</h1>
                </header>
                <h2>Un sitio web para ayudarte a encontrar tu mejor horario</h2>
                <p><a href="#oquefazer" class="btn">Sepa mas</a></p>
            </div>
        </article>
    </div>
    <!--FIM 1ª DOBRA-->

    <!--INICIO SESSÃO SESSÃO DE ARTIGOS-->
    <section class="main_blog">
        <header class="main_blog_header">
            <h1 class="icon-location" id="oquefazer">¿Qué hacer en Brasília?</h1>
            <p class="icon-info">Aquí encontrarás las mejores sugerencias sobre qué hacer en nuestra capital.</p>
            <!-- cria o campo select com os dados da consulta 
                realizada na tabela de categorias -->
        </header>
        <?php if ($rows) {
            foreach ($rows as $row) { ?>
                <article>
                    <a href="artigo_list.php?id=<?= $row['id']; ?>">
                        <?php
                        $imagem = $row['imagem'] == '' ? "assets/img/post.jpg" : $row['imagem'];
                        ?>
                        <img src="<?= $imagem ?>" width="200px" height="200px" alt="<?= $row['nome'] ?>"
                            title="<?= $row['nome'] ?>">
                    </a>
                    <p><a href="#" class="category">
                            <?= $row['nome'] ?>
                        </a></p>
                </article>
            <?php }
        } else {
            echo "<p>No hay categorías registradas</p>";
        } ?>
    </section>

    <section class="main_blog">
        <header class="main_blog_header">
            <hr><br>
            <h1 class="icon-map" id="mapa">Mapas</h1>
            <p class="icon-warning">Para una mejor experiencia, haga clic en "Ver mapa más grande".</p>
        </header>

        <article>
            <h2 class="icon-map">Mapa de Brasília</h2>
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d103308.13421287884!2d-47.91567415075026!3d-15.792797648139683!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x935a3d18df9ae275%3A0x738470e469754a24!2zQnJhc8OtbGlhLCBERiwgQnJhc2ls!5e0!3m2!1spt-BR!2sus!4v1685762996791!5m2!1spt-BR!2sus"
                width="370" height="270" style="border:0;" allowfullscreen="" loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"></iframe>
        </article>

        <article>
            <h2 class='bx bx-restaurant'>Mapa de Restaurantes</h2>
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d61429.20663932099!2d-47.929306887425504!3d-15.786786206461178!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1sRestaurantes!5e0!3m2!1spt-BR!2sbr!4v1682683260541!5m2!1spt-BR!2sbr"
                width="370" height="270" style="border:0;" allowfullscreen="" loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"></iframe>
        </article>

        <article>
            <h2 class='bx bxs-hotel'>Mapa de Hoteles</h2>
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d61430.72425482212!2d-47.926912064703856!3d-15.781778759148956!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1zSG90w6lpcw!5e0!3m2!1spt-BR!2sbr!4v1682683731098!5m2!1spt-BR!2sbr"
                width="370" height="270" style="border:0;" allowfullscreen="" loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"></iframe>
        </article>

        <article>
            <h2 class='bx bx-plus-medical'>Mapa de Farmacias</h2>
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d61428.98775191294!2d-47.93463121955171!3d-15.78750830855134!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1sFarm%C3%A1cias!5e0!3m2!1spt-BR!2sbr!4v1682684059953!5m2!1spt-BR!2sbr"
                width="370" height="270" style="border:0;" allowfullscreen="" loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"></iframe>
        </article>

        <article>
            <h2 class="icon-credit-card">Mapa de cajero automático</h2>
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d86860.90376733258!2d-48.02056250593406!3d-15.817347936836581!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1sCaixas%20eletr%C3%B4nicos!5e0!3m2!1spt-BR!2sbr!4v1682684383531!5m2!1spt-BR!2sbr"
                width="370" height="270" style="border:0;" allowfullscreen="" loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"></iframe>
        </article>

        <article>
            <h2 class='bx bxs-bus'>Mapa de transporte público</h2>
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d146073.75345262777!2d-48.05072446560145!3d-15.828823511121788!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1sesta%C3%A7%C3%B5es%20de%20metro%20de%20brasilia!5e0!3m2!1spt-BR!2sus!4v1685763205381!5m2!1spt-BR!2sus"
                width="370" height="270" style="border:0;" allowfullscreen="" loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"></iframe>
        </article>
    </section>
    <!--FIM SESSÃO SESSÃO DE ARTIGOS-->

    <!--SOLZINHO-->
    <div class="container-sun">
        <div class="cloud front">
            <span class="left-front"></span>
            <span class="right-front"></span>
        </div>
        <span class="sun sunshine"></span>
        <span class="sun"></span>
        <div class="cloud back">
            <span class="left-back"></span>
            <span class="right-back"></span>
        </div>
    </div>
    <!--FIM SOLZINHO-->

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


<!--FIM DOBRA PALCO PRINCIPAL-->

<?php require_once 'layouts/site/footer.php'; ?>