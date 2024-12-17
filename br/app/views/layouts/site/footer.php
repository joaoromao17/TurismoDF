<!--INCIO DOBRA RODAPE-->

<div class="imagem_logo">
    <a href="index.php" class="logo">
        <img src="assets/img/logo.png" width="250" height="250" alt="Logo" title="logo"></a>
</div>

<section class="main_footer">
    <header>
        <h1>Quer saber mais?</h1>
    </header>
    <article class="main_footer_our_pages">
        <header>
            <h2>Nossas Páginas</h2>
        </header>
        <ul>
            <li class="icon-home"><a href="#">Home</a></li>
            <li class="icon-facebook"><a href="https://www.facebook.com/profile.php?id=100093545959335" target="_blank">Facebook</a></li>
            <li class="icon-instagram"><a href="https://www.instagram.com/turismo__df/" target="_blank">Instagram</a></li>
            <li class="icon-twitter"><a href="https://twitter.com/turismo__DF" target="_blank">Twitter</a></li>
        </ul>
    </article>

    <article class="main_footer_links">
        <header>
            <h2>Links Úteis</h2>
        </header>
        <ul>
            <li><a href="layouts/site/politicadepriv.html">Política de Privacidade</a></li>
            <li><a href="#">Aviso Legal</a></li>
            <li><a href="#">Termos de Uso</a></li>
        </ul>
    </article>

    <article class="main_footer_about">
        <header>
            <h2>Sobre o Projeto</h2>
        </header>
        <p>Esse site foi criado com a intuição de ajudar todos os turistas e os nativos do DF a conhecer nossa linda
            capital e as demais cidades do Distrito Federal</p>
    </article>
</section>
<footer class="main_footer_rights">
    <p>ETC - Todos os direitos reservados.</p>
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