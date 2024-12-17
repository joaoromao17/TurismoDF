<!--INCIO DOBRA RODAPE-->

<div class="imagem_logo">
    <a href="index.php" class="logo">
        <img src="assets/img/logo.png" width="250" height="250" alt="Logo" title="logo"></a>
</div>

<section class="main_footer">
    <header>
        <h1>¿Quiere saber más?</h1>
    </header>
    <article class="main_footer_our_pages">
        <header>
            <h2>Nuestras páginas</h2>
        </header>
        <ul>
            <li class="icon-home"><a href="#">Casa</a></li>
            <li class="icon-facebook"><a href="#">Facebook</a></li>
            <li class="icon-instagram"><a href="#">Instagram</a></li>
            <li class="icon-twitter"><a href="#">Twitter</a></li>
        </ul>
    </article>

    <article class="main_footer_links">
        <header>
            <h2>Enlaces útiles</h2>
        </header>
        <ul>
            <li><a href="#">Política de privacidad</a></li>
            <li><a href="#">Descargo de responsabilidad</a></li>
            <li><a href="#">Terminos de uso</a></li>
        </ul>
    </article>

    <article class="main_footer_about">
        <header>
            <h2>Sobre el proyecto</h2>
        </header>
        <p>Este sitio fue creado con la intención de ayudar a todos los turistas y nativos del DF a conocer nuestra hermosa capital y las demás ciudades del Distrito Federal</p>
    </article>
</section>
<footer class="main_footer_rights">
    <p>ETC - Todos los derechos reservados.</p>
</footer>
</body>

<script>
    // Seleciona o link e a janela modal
    var link = document.querySelector('.modal-link');
    var modal = document.querySelector('.modal');
    var overlay = document.querySelector('.overlay');

    // Adiciona um listener de evento para o link
    link.addEventListener('click', function (event) {
        event.preventDefault(); // previne o comportamento padrão do link (navegar para outra página)

        overlay.style.display = 'block'; // exibe a camada escura
        modal.style.display = 'block'; // exibe a janela modal
    });

    // Adiciona um listener de evento para a camada escura
    overlay.addEventListener('click', function () {
        overlay.style.display = 'none'; // oculta a camada escura
        modal.style.display = 'none'; // oculta a janela modal
    });
</script>

</html>