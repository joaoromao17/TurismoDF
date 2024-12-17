<?php 
    # para trabalhar com sessões sempre iniciamos com session_start.
    session_start();
    
    # inclui o arquivo header e a classe de conexão com o banco de dados.
    require_once 'layouts/admin/header.php';
    require_once "../database/conexao.php";

    # verifica se existe sessão de usuario e se ele é administrador.
    # se não existir redireciona o usuario para a pagina principal com uma mensagem de erro.
    # sai da pagina.
    if(!isset($_SESSION['usuario']) || ($_SESSION['usuario']['perfil'] != 'ADM' )) {
        header("Location: index.php?error=Usuário não tem permissão para acessar esse recurso");
        exit;
    }

    # verifica se uma variavel id foi passada via GET 
    $id = isset($_GET['id']) ? $_GET['id'] : 0;

    # cria a variavel $dbh que vai receber a conexão com o SGBD e banco de dados.
    $dbh = Conexao::getInstance();
    
    # verifica se os dados do formulario foram enviados via POST 
    if($_SERVER['REQUEST_METHOD'] == 'POST') {
        # cria variaveis (nome, status, tipo) para armazenar os dados passados via método POST.
        $nome = isset($_POST['nome']) ? $_POST['nome'] : '';
        $status = isset($_POST['status']) ? $_POST['status'] : 0;
        $imagem_externa = ($_POST['tipoImagem'] == '1'? true: false);
        $imagemName  = isset($_POST['imagem_externa']) ? $_POST['imagem_externa'] : '';

           # verifica se a imagem a ser cadastrada é interna? Se sim, entra no if.
           if($imagem_externa == false) {
            # definie o caminho onde sera gravado o arquivo.
            $uploaddir = __DIR__ . '/assets/img/categorias/';
            $imagemName = basename($_FILES['imagem_interna']['name']);
            $uploadfile = $uploaddir . $imagemName;
            
            # verifica se o diretorio existe? Se não existir cria um novo.
            if(!file_exists($uploaddir)) {
                mkdir($uploaddir, 0777);
            }
            # recebe o arquivo a ser gravado e inserido no diretorio criado. 
            # Se sim, gravano diretorio. Se não, limpa o nome da variavel que
            # sera usada no banco de dados.
            if(!move_uploaded_file($_FILES['imagem_interna']['tmp_name'], $uploadfile)){
                $imagemName  = '';
            }
        }
    
        # cria um comando SQL para alterar ou modificar valores na tabela  
        $query = "UPDATE `turismodf`.`categorias` SET 
                    `nome` = :nome,
                    `status` = :status, 
                    `imagem` = :imagem, 
                    `imagem_externa` = :imagem_externa
                    WHERE id = :id";
        $stmt = $dbh->prepare($query);
        $stmt->bindParam(':nome', $nome);
        $stmt->bindParam(':status', $status);
        $stmt->bindParam(':imagem', $imagemName);
        $stmt->bindParam(':imagem_externa', $imagem_externa);
        $stmt->bindParam(':id', $id);

        # executa o comando SQL.
        $stmt->execute();

        # verifica se a quantiade de registros inseridos é maior que zero.
        # se sim, redireciona para a pagina de admin com mensagem de sucesso.
        # se não, redireciona para a pagina de cadastro com mensagem de erro.
        if($stmt->rowCount()) {
            header('location: categoria_index.php?success=Categoria inserido com sucesso!');
        } else {
            header('location: categoria_add.php?error=Erro ao inserir categoria!');
        }
    }

    # cria uma consulta banco de dados buscando todos os dados  
    # filtrando pelo id do usuário.
    $query = "SELECT * FROM `turismodf`.`categorias` WHERE id=:id LIMIT 1";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':id', $id);

    # executa a consulta banco de dados e aguarda o resultado.
    $stmt->execute();
    
    # Faz um fetch para trazer os dados existentes, se existirem, em um array na variavel $row.
    # se não existir retorna null
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    
    # se o resultado retornado for igual a NULL, redireciona para a pagina de listar usuario.
    # se não, cria a variavel row com dados do usuario selecionado.
    if(!$row){
        header('location: categoria_index.php?error=Categoria inválida.');
    }
    
    # destroi a conexao com o banco de dados.
    $dbh = null;
?>
<body>
    <?php require_once 'layouts/admin/menu.php';?>
    <main>
        <div class="main_opc">
            <?php
                # verifca se existe uma mensagem de erro enviada via GET.
                # se sim, exibe a mensagem enviada no cabeçalho.
                if(isset($_GET['error'])) { ?>
                    <script>
                        Swal.fire({
                        icon: 'error',
                        title: 'Categorias',
                        text: '<?=$_GET['error'] ?>',
                        })
                    </script>
            <?php } ?>
            <section class="novo__form__section">
                <div class="novo__form__titulo">
                    <h2>Atualizar Categorias</h2>
                </div>
                <form action="" method="post" class="novo__form">
                    <input type="hidden" name="id" value="<?=isset($row)? $row['id'] : ''?>">
                    <div>
                        <label for="nome">Nome</label><br>
                        <input type="text" name="nome" 
                                value="<?=isset($row)? $row['nome'] : ''?>"
                                placeholder="Informe seu nome."  
                                required><br><br>
                    </div>
                    <label for="status">Status</label><br>
                    <select name="status"><br><br>
                        <option value="1" <?=isset($row) && $row['status'] == '1'? 'selected' : ''?>>Ativo</option>
                        <option value="0" <?=isset($row) && $row['status'] == '0'? 'selected' : ''?>>Inativo</option>
                    </select><br><br>
                    <div>
                        <label for="tipoImagem">Tipo de Imagem</label><br>
                        <select name="tipoImagem" onchange="changeImagem(this);">
                            <option value="0" <?=($row['imagem_externa'] == '0') ? 'selected': ''?>>Intena</option>
                            <option value="1" <?=($row['imagem_externa'] == '1') ? 'selected': ''?>>Externa</option>
                        </select>
                    </div>
                    <br><br>
                    <div>
                        <label for="imagem">Imagem</label><br>
                        <input 
                            type="text" 
                            name="imagem_externa"
                            value="<?=isset($row['imagem']) ? $row['imagem'] : ''?>" 
                            id="imagem_externa"
                            <?=($row['imagem_externa'] == '0') ? 'style="display:none;"': ''?>
                        >
                        <input 
                            type="file" 
                            name="imagem_interna"
                            value="<?=isset($row['imagem']) ? $row['imagem'] : ''?>"
                            id="imagem_interna"
                            <?=($row['imagem_externa'] == '1') ? 'style="display:none;"': ''?>
                        > 
                    </div>
                    <br><br>

                    <input type="submit" value="Salvar" name="salvar">
               </form>
            </section>
            </div>
    </main>   
    <script>        
        function changeImagem(e) {
            const listaValue = e.value;
            const imagemExterna = document.getElementById('imagem_externa');
            const imagemInterna = document.getElementById('imagem_interna');
            
            imagemExterna.style.display = "none";
            imagemInterna.style.display = "";
            if(listaValue == 1) {
                imagemExterna.style.display = "";
                imagemInterna.style.display = "none";
                imagemInterna.value = "";
            }
        }
    </script> 
</body>
</html>
