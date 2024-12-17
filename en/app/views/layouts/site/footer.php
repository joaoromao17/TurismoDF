<!--INCIO DOBRA RODAPE-->

<div class="imagem_logo">
    <a href="index.php" class="logo">
        <img src="assets/img/logo.png" width="250" height="250" alt="Logo" title="logo"></a>
</div>

<section class="main_footer">
    <header>
        <h1>Want to know more?</h1>
    </header>
    <article class="main_footer_our_pages">
        <header>
            <h2>Nossas Páginas</h2>
        </header>
        <ul>
            <li class="icon-home"><a href="#">Home</a></li>
            <li class="icon-facebook"><a href="#">Facebook</a></li>
            <li class="icon-instagram"><a href="#">Instagram</a></li>
            <li class="icon-twitter"><a href="#">Twitter</a></li>
        </ul>
    </article>

    <article class="main_footer_links">
        <header>
            <h2>Useful links</h2>
        </header>
        <ul>
            <li><a href="#">Privacy Policy</a></li>
            <li><a href="#">Disclaimer</a></li>
            <li><a href="#">Terms of use</a></li>
        </ul>
    </article>

    <article class="main_footer_about">
        <header>
            <h2>About the project</h2>
        </header>
        <p>This site was created with the intention of helping all tourists and natives of the DF to get to know our beautiful
            capital and the other cities of the Federal District</p>
    </article>
</section>
<footer class="main_footer_rights">
    <p>ETC - All rights reserved.</p>
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