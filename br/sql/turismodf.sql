-- SCRIPT DE DDL - DATA DEFINITION LANGUAGE
-- apaga o banco de dados escolabd, se ele existir.
DROP SCHEMA IF EXISTS turismodf;

-- cria um banco de dados chamado escolabd.
CREATE SCHEMA turismodf;

-- cria uma tabela chamada usuarios com os campos: 
-- id, email, password, nome, status, perfil e data_cadastro.
CREATE TABLE turismodf.usuarios (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(60) NOT NULL,
  nome VARCHAR(40) NOT NULL,
  perfil CHAR(3) NOT NULL DEFAULT 'USU' COMMENT 'ADM=Administrador\nUSU=Usuario',
  status BOOLEAN NOT NULL DEFAULT TRUE,
  data_cadastro DATETIME NOT NULL DEFAULT NOW()
);

-- cria uma tabela chamada categorias com os campos: 
-- id, nome e status.
CREATE TABLE turismodf.categorias (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(40) NOT NULL,
  status BOOLEAN NOT NULL DEFAULT TRUE,
  imagem varchar(255) DEFAULT NULL,
  imagem_externa tinyint(1) NOT NULL DEFAULT 1
);

-- cria uma tabela chamada artigos com os campos: 
-- id, titulo, texto, status, data_publicacao, categoria e usuario.
CREATE TABLE turismodf.artigos (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  titulo VARCHAR(100) NOT NULL,
  texto TEXT,
  link varchar(500) NOT NULL,
  status BOOLEAN NOT NULL DEFAULT FALSE,
  data_publicacao DATETIME DEFAULT NOW(),
  imagem VARCHAR(255) NULL,
  imagem_externa BOOLEAN NOT NULL DEFAULT TRUE,
  categoria_id INTEGER NOT NULL,
  usuario_id INTEGER NOT NULL,
  FOREIGN KEY (categoria_id) REFERENCES turismodf.categorias(id),
  FOREIGN KEY (usuario_id) REFERENCES turismodf.usuarios(id)
);

--
-- Estrutura para tabela `avaliacao`
--
CREATE TABLE turismodf.avaliacao (
  id int(11) NOT NULL,
  comentario text DEFAULT NULL,
  classificacao tinyint(1) NOT NULL DEFAULT 0,
  data_publicacao datetime DEFAULT current_timestamp(),
  artigo_id int(11) NOT NULL,
  usuario_id int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- SCRIPT DE DML - DATA MANIPULATION LANGUAGE
-- inserir dados na tabela de usuario. 
INSERT INTO
  turismodf.usuarios (id, email, password, nome, perfil, status)
VALUES
  (
    1,
    'admin@email.com',
    md5('123'),
    'Admin',
    'ADM',
    1
  ),
  (
    2,
    'usuario@email.com',
    md5('123456'),
    'Usuário',
    'USU',
    1
  );

-- inserir dados na tabela de usuario. 
INSERT INTO
  turismodf.categorias (id, nome, status, imagem, imagem_externa)
VALUES
  (
    1,
    'EVENTOS',
    1,
    'https://sagresonline.com.br/wp-content/uploads/2022/06/SHOW.jpeg',
    1
  ),
  (
    2,
    'PONTOS TURÍSTICOS',
    1,
    'https://brazilian.report/wp-content/uploads/2022/04/shutterstock_557983765.jpg',
    1
  ),
  (
    3,
    'CINEMAS',
    1,
    'https://p2.trrsf.com/image/fget/cf/774/0/images.terra.com/2022/05/21/919007046-filmes-para-assistir-cinema.jpg',
    1
  ),
  (
    4,
    'SHOPPINGS',
    1,
    'https://media.istockphoto.com/id/867341470/photo/window-shopping.jpg?s=612x612&w=0&k=20&c=2AdLIydxyTGmePMSNu5z5RQexib39GQDF-xUsoqJBkg=',
    1
  ),
  (
    5,
    'PARQUES',
    1,
    'https://jundiai.sp.gov.br/noticias/wp-content/uploads/sites/32/2019/10/parque-da-cidade-1280x853.jpg',
    1
  ),
  (
    6,
    'TEATROS',
    1,
    'https://teatrocolon.org.ar/sites/default/files/styles/d8/public/teatro-colon-argentina-image_1366_768.jpg?itok=bpxe64GH',
    1
  ),
  (
    7,
    'MUSEUS',
    1,
    'https://imgmd.net/images/v1/guia/1703461/museu-d-orsay.jpg',
    1
  ),
  (
    8,
    'ECOTURISMO',
    1,
    'https://www.papeiseparede.com.br/7365-thickbox_default/papel-de-parede-cachoeira-azul.jpg.webp',
    1
  );

--
-- Despejando dados para a tabela `avaliacao`
--
INSERT INTO
  turismodf.avaliacao (
    `id`,
    `comentario`,
    `classificacao`,
    `data_publicacao`,
    `artigo_id`,
    `usuario_id`
  )
VALUES
  (
    1,
    'Esse cine Brasília, é muito bom!!!',
    5,
    '2023-06-11 00:35:23',
    1,
    8
  );

-- inserir dados na tabela de artigos.
INSERT INTO
  turismodf.artigos (
    `titulo`,
    `texto`,
    `link`,
    `status`,
    `data_publicacao`,
    `imagem`,
    `imagem_externa`,
    `categoria_id`,
    `usuario_id`
  )
VALUES
  (
    'Cine Brasília',
    'SHCS EQS 106/107 - Brasília - DF',
    'https://cinebrasilia.com/',
    1,
    '2023-05-22 11:00:00',
    'https://cinebrasilia.com/wp-content/uploads/2022/09/img-home.jpg',
    1,
    3,
    1
  ),
  (
    'Cine Cultura Liberty Mall',
    'Shopping Center Liberty Mall SCN Quadra 2 . Bloco D Asa Norte - Brasília/DF',
    'http://www.cinecultura.com.br/',
    1,
    '2023-05-22 11:00:00',
    'https://uploads.metropoles.com/wp-content/uploads/2017/04/12172813/cine-cultura.jpg',
    1,
    3,
    1
  ),
  (
    'Cine Drive-In',
    'Área Especial do Autódromo • Asa Norte - Brasília - DF',
    'https://cinedrivein.com/',
    1,
    '2023-05-22 11:00:00',
    'https://portalradar.com.br/wp-content/uploads/2020/07/cinedrivein.jpg',
    1,
    3,
    1
  ),
  (
    'Cineflix - JK Shopping',
    'AV. Hélio Prates - QNM 34 Area especial 01 M Norte.',
    'https://jkshoppingdf.com.br/cinema/',
    1,
    '2023-05-22 11:00:00',
    'https://jkshoppingdf.com.br/pycmokse/bfi_thumb/Untitled-1-74h54dm9nx3qzlkeilrscznm9eo2swi2rtn3si5xv8y.jpg',
    1,
    3,
    1
  ),
  (
    'Cinemark Iguatemi Shopping',
    'SHIN CA 4 - Lago Norte - Brasília - DF',
    'https://iguatemi.com.br/brasilia/cinema',
    1,
    '2023-05-22 11:00:00',
    'https://cdn.jornaldebrasilia.com.br/wp-content/uploads/2022/01/06162322/885ed6f3-23cb-4f8a-b9d7-ec77af2f3917-1024x682.jpg',
    1,
    3,
    1
  ),
  (
    'Cinemark Shopping Pier 21',
    'Setor de clubes esportivos sul (SCES), trecho 2 lote 32 - Brasília - DF',
    'http://www.pier21.com.br/pier21/cinema.asp',
    1,
    '2023-05-22 11:00:00',
    'https://abrasilia.com/wp-content/uploads/2022/01/FachadaPier21_-2017-1.jpg',
    1,
    3,
    1
  ),
  (
    'Taguatinga Shopping',
    'QS 01, Lote 40 - Taguatinga, Brasília - DF',
    'https://www.taguatingashopping.com.br/',
    1,
    '2023-05-22 09:00:00',
    'https://i.ytimg.com/vi/OLDYkuXmIBg/maxresdefault.jpg',
    1,
    4,
    1
  ),
  (
    'Cinemark Taguatinga Shopping',
    'QS 01 rua 210, lote 40 Pistão sul - Taguatinga - DF',
    'https://www.taguatingashopping.com.br/cinema',
    1,
    '2023-05-22 11:00:00',
    'https://cdn.jornaldebrasilia.com.br/wp-content/uploads/2022/03/29174139/Capa-JBR-1-72.png',
    1,
    3,
    1
  ),
  (
    'Espaço Itaú de Cinema',
    'Shopping Casa Park (2º Piso) SGCV Sul Lote 22 – Guará - Brasília - DF',
    'http://www.itaucinemas.com.br/pag/brasilia-casa-park',
    1,
    '2023-05-22 11:00:00',
    'https://lisboalobaoproject.files.wordpress.com/2011/12/itau.jpg',
    1,
    3,
    1
  ),
  (
    'Kinoplex Pátio Brasil',
    'SCS Quadra 07 Bloco A - Brasília - DF',
    'https://www.patiobrasil.com.br/cinema/',
    1,
    '2023-05-22 11:00:00',
    'https://uploads.maisbrasilia.com/2021/05/f69a07fe-kinoplex.jpg',
    1,
    3,
    1
  ),
  (
    'Kinoplex Boulevard',
    'Setor Terminal Norte, Conjunto J, Asa Norte - Brasília - DF',
    'https://boulevardbrasilia.com.br/lojas/kinoplex.htm',
    1,
    '2023-05-22 11:00:00',
    'https://mir-s3-cdn-cf.behance.net/projects/404/3b2f55121855893.Y3JvcCw5MjAsNzIwLDE1Miww.jpg',
    1,
    3,
    1
  ),
  (
    'Kinoplex Park Shopping',
    'ParkShopping, SAI/SO Área 6580 - Brasília - DF',
    'https://www.parkshopping.com.br/lazer/cinema',
    1,
    '2023-05-22 11:00:00',
    'https://www.estilozzo.com/wp-content/uploads/2021/12/Fachada-Iluminada.jpg',
    1,
    3,
    1
  ),
  (
    'Kinoplex Terraço Shopping',
    'SHC AOS Entrequadras 2/8 lote 5 – Octogonal Sul - Brasília - DF',
    'https://terracoshopping.com.br/cinema/',
    1,
    '2023-05-22 11:00:00',
    'https://www.kinoplex.com.br/cinema/galeria/images/kinoplex-terraco-shopping/kinoplex-terraco-shopping-01.jpg',
    1,
    3,
    1
  ),
  (
    'Alameda Shopping',
    'CSB 02, Lotes 01/04 - Taguatinga, Brasília - DF',
    'https://alameda.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://etccomunica.com.br/wp-content/uploads/2019/07/Entrada_Alameda_.jpg',
    1,
    4,
    1
  ),
  (
    'Boulevard Shopping Brasília',
    'Setor Terminal Norte, Conj J - Asa Norte, Brasília - DF',
    'https://boulevardbrasilia.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://www.boulevardbrasilia.com.br/_next/image?url=https%3A%2F%2Fwww.intranetmall.com%2Fesperienza%2FimgShopping%2Fboulevardbrasilia-aGsp28PDQhYAvVE5oYLVs5rscLS6kFbL%2Fshopping%2F17-4-2023-9IDUDF1VE8.png&w=1920&q=75',
    1,
    4,
    1
  ),
  (
    'Águas Claras Shopping',
    'Av. das Araucárias, 1835/2005 - Águas Claras, Brasília - DF',
    'https://aguasclarashopping.com.br/?gclid=CjwKCAjw0N6hBhAUEiwAXab-\r\nTdxFwMYbPidgd8gUJK_NBQJXFExdyvRLUMIQzxfp2v0RV_YXpvMZFBoCY\r\nLEQAvD_BwE',
    1,
    '2023-06-04 14:10:00',
    'https://i.ytimg.com/vi/6urNmLUr8d4/maxresdefault.jpg',
    1,
    4,
    1
  ),
  (
    'Brasília Shopping',
    'SCN Quadra 05 BL A - Asa Norte, Brasília - DF',
    'https://brasiliashopping.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://i.pinimg.com/originals/44/0c/a9/440ca9df69199680f160650a385f811f.jpg',
    1,
    4,
    1
  ),
  (
    'Casa Park',
    'SGCV Sul Lote 22 Guará, Brasília-DF',
    'https://casapark.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://jornaldoguara.com.br/wp-content/uploads/2020/08/CasaPark_foto_Haruo-Mikami.jpg',
    1,
    4,
    1
  ),
  (
    'DF Plaza Shopping',
    'Rua Copaíba, Lote 01 - Águas Claras, Brasília - DF',
    'https://www.dfplaza.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://1.bp.blogspot.com/-mEQ3Rr4U8wY/YD-6f9DRSWI/AAAAAAAB3Kg/F_eLA-Gp9bAEeUzJ8qcXQQITVIKt3iloQCLcBGAsYHQ/s1280/DF%2BPLAZA%2BSHOPPING%2B-%2BDRIVE%2BTHRU%2BFOTO%2BDE%2BTELMO%2BXIMENES-blogdamalu.jpeg',
    1,
    4,
    1
  ),
  (
    'Fashion Mall',
    'SHCS EQS 302/303 - Asa Sul, Brasília - DF',
    'https://www.fashionmall.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://imgbr.imovelwebcdn.com/avisos/2/29/23/55/34/76/1200x1200/725945897.jpg',
    1,
    4,
    1
  ),
  (
    'Gama Shopping',
    'St. Central - Gama, Brasília - DF',
    'https://www.gamashopping.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://upload.wikimedia.org/wikipedia/commons/9/95/Shopping_do_Gama.jpg',
    1,
    4,
    1
  ),
  (
    'Jardim Botânico Shopping',
    'Quadra 01, Etapa 01, Rua 01, Lote 289/305 - Jardim Botânico,\r\nBrasília - DF',
    'https://jardimbotanicoshopping.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://imgbr.imovelwebcdn.com/avisos/2/29/49/70/18/37/720x532/2490788917.jpg',
    1,
    4,
    1
  ),
  (
    'JK Shopping',
    'St. M-Norte QNM 34 Área Especial 01 - Taguatinga, Brasília - DF',
    'https://jkshoppingdf.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://cdn.jornaldebrasilia.com.br/wp-content/uploads/2022/03/25143717/Capa-JBR-1-61.png',
    1,
    4,
    1
  ),
  (
    'Liberty Mall',
    'SCN Q 2 Bloco D - Asa Norte, Brasília - DF',
    'https://libertymall.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://intranetmall.com/35d6s5-dw9d56-5d6c93-99c5b9/3-14-7-2021-3BWEF4FC68.JPG',
    1,
    4,
    1
  ),
  (
    'ParkShopping',
    'SAI/SO Área 6580, Brasília - DF',
    'https://www.parkshopping.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://www.estilozzo.com/wp-content/uploads/2021/12/Fachada-Iluminada.jpg',
    1,
    4,
    1
  ),
  (
    'Patio Brasil Shopping',
    'Setor Comercial Sul Quadra 7 BL A - Asa Sul, Brasília - DF',
    'http://www.patiobrasil.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://upload.wikimedia.org/wikipedia/commons/3/35/Patio_brasil_02.jpg',
    1,
    4,
    1
  ),
  (
    'Pier 21',
    'St. de Clubes Esportivos Sul Trecho 2 - Asa Sul, Brasília - DF',
    'http://www.pier21.com.br/pier21/',
    1,
    '2023-06-04 14:10:00',
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/2d/39/85/pier-21.jpg?w=1200&h=-1&s=1',
    1,
    4,
    1
  ),
  (
    'Plaza Norte Shopping',
    'EQN 110/111 LOTE A - Asa Norte, Brasília - DF',
    'https://plazanorte.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://comerciobrasilia.com.br/wp-content/uploads/2022/05/20220518_070404-scaled.jpg',
    1,
    4,
    1
  ),
  (
    'Riacho Mall',
    'QN 7 área especial 01, Brasília - DF',
    'https://www.instagram.com/riachomall/',
    1,
    '2023-06-04 14:10:00',
    'https://photos.wikimapia.org/p/00/07/38/24/38_big.jpg',
    1,
    4,
    1
  ),
  (
    'Santa Maria Shopping',
    'CL 114 Bloco D - Santa Maria Norte, Brasília - DF',
    'https://www.shoppingsantamariadf.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://live.staticflickr.com/65535/50912486191_3e57ea5f32_b.jpg',
    1,
    4,
    1
  ),
  (
    'Shopping Conjunto Nacional',
    'SDN, CNB - Asa Norte, Brasília - DF',
    'https://www.conjuntonacional.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://i.pinimg.com/originals/04/a0/73/04a073903aae82a6d7f036d6853cd419.png',
    1,
    4,
    1
  ),
  (
    'Shopping ID',
    'Norte Comercial Sector - Quadra 06, Conjunto A Edifício\r\nVenâncio 3.000, Brasília - DF',
    'https://shoppingid.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://cdn.jornaldebrasilia.com.br/wp-content/uploads/2021/07/13171900/shopping-id.png',
    1,
    4,
    1
  ),
  (
    'Shopping Iguatemi',
    'St. de Habitações Individuais Norte CA 4 - Lago Norte, Brasília -\r\nDF',
    'https://iguatemi.com.br/brasilia/',
    1,
    '2023-06-04 14:10:00',
    'https://i.pinimg.com/originals/4a/75/1d/4a751dad9eec7a1ca977fe60d9b1ce1a.jpg',
    1,
    4,
    1
  ),
  (
    'Sobradinho Shopping',
    'Q 14 LT 12 - Sobradinho, Brasília - DF',
    'https://www.instagram.com/sobradinhoshopping/',
    1,
    '2023-06-04 14:10:00',
    'https://photos.wikimapia.org/p/00/02/20/08/93_big.jpg',
    1,
    4,
    1
  ),
  (
    'Terraço Shopping',
    'SHC AOS Entrequadras 2/8 lote 5, Octogonal - Sul, Brasília - DF',
    'https://terracoshopping.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://media-cdn.tripadvisor.com/media/photo-s/0d/7c/2e/a8/visao-de-dentro-do-shopping.jpg',
    1,
    4,
    1
  ),
  (
    'Venâncio Shopping',
    'Setor Comercial Sul Q. 6 - Asa Sul, Brasília - DF',
    'https://www.venancioshopping.com.br/',
    1,
    '2023-06-04 14:10:00',
    'https://www.estilozzo.com/wp-content/uploads/2022/01/VENANCIO-SHOPPING_FACHADA_TELMOXIMENES-e1643659866689.jpg',
    1,
    4,
    1
  ),
  (
    'Teatro da CAESB',
    'Águas Claras, Brasília - DF, 70297-400',
    'https://www.caesb.df.gov.br/reserva-do-teatro-da-caesb.html',
    1,
    '2023-06-04 15:33:27',
    'https://www.agenciabrasilia.df.gov.br/media/k2/items/src/73155a9aad07a6b6c4001d5cc6b7b719.jpg',
    1,
    6,
    1
  ),
  (
    'Teatro Maristão Brasília',
    'SGAS II SGAS 615, Brasília - DF',
    'https://www.tripadvisor.com.br/Attraction_Review-g303322-d9715296-Reviews-Teatro_Marista-Brasilia_Federal_District.html',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/R.e4691242fb661eec002370466efec035?rik=Mzf%2fknPbCB5zYw&pid=ImgRaw&r=0',
    1,
    6,
    1
  ),
  (
    'Teatro Pedro Calmon',
    'Avenida Do Exército, St. Militar Urbano, Brasília - DF',
    'https://www.tripadvisor.com.br/Attraction_Review-g303322-d7317935-Reviews-Pedro_Calmon_Theatre-Brasilia_Federal_District.html',
    1,
    '2023-06-04 15:33:27',
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/59/89/23/teatro-pedro-calmon.jpg?w=1000&h=-1&s=1',
    1,
    6,
    1
  ),
  (
    'Teatro Unip Brasília',
    'SGAS I SGAS 913 - Asa Sul, Brasília - DF',
    'https://teatrounip.com/',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/OIP.yT2bj-3EepltOYPwjqORUQHaE7?pid=ImgDet&rs=1',
    1,
    6,
    1
  ),
  (
    'Teatro La Salle',
    'SGAS Quadra 906, Conjunto E, Brasília-DF',
    '',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/OIP.8m3L6gf7svA8JpdbX04XTAHaFj?pid=ImgDet&rs=1',
    1,
    6,
    1
  ),
  (
    'Teatro Nacional Cláudio Santoro',
    'SCTS - Brasília, DF',
    'https://www.cultura.df.gov.br/teatro-nacional-claudio-santoro/',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/OIP.kD08DQm0q4RKfhrlk52wEwHaE8?pid=ImgDet&rs=1',
    1,
    6,
    1
  ),
  (
    'Teatro SESC Newton Rossi',
    'Centro de Atividades SESC Ceilândia - QNN 27 Area Especial Lote B, Ceilândia Norte, Brasília - DF.',
    'https://www.sescdf.com.br/Paginas/%C3%81reas/ESPA%C3%87OS-CULTURAIS-DO-SESC-DF.aspx',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/OIP.CxGAX1lXILOXZIRPVoKhdwHaFj?pid=ImgDet&w=1024&h=768&rs=1',
    1,
    6,
    1
  ),
  (
    'Teatro Royal Tulip',
    'SHTN Trecho 1 - Brasília, DF',
    'https://www.tripadvisor.com.br/Attraction_Review-g303322-d13129207-Reviews-Teatro_Royal_Tulip_Brasilia-Brasilia_Federal_District.html',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/OIP.0WuyWjLYBUCWsv9rr6TyOAHaED?pid=ImgDet&rs=1',
    1,
    6,
    1
  ),
  (
    'Teatro Mapati',
    'St. de Habitações Coletivas e Geminadas Norte 707 CASA 13 - Asa\r\nNorte, Brasília - DF',
    'https://www.tripadvisor.com.br/Attraction_Review-g303322-d4126956-Reviews-Teatro_Mapati-Brasilia_Federal_District.html',
    1,
    '2023-06-04 15:33:27',
    'https://diaonline.ig.com.br/wp-content/uploads/2019/08/cultura-braslia_3-1024x728.jpg',
    1,
    6,
    1
  ),
  (
    'Teatro Brasília Shopping',
    'SCN Quadra 05 - Asa Norte, Brasília - DF',
    'https://brasiliashopping.com.br/teatro-brasilia-shopping/',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/OIP.3IztgW-qtKme0s3ydbuynwHaE7?pid=ImgDet&rs=1',
    1,
    6,
    1
  ),
  (
    'Chapada Imperial',
    'Chapada Imperial é um santuário ecológico a 50 Km do Plano Piloto, possui tours guiados, trilhas de caminhada, mais de 30\r\ncachoeiras e tirolesa.',
    'http://www.chapadaimperial.com.br/',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/OIP.8gWfOOebfqYVkKhBGIa-OwAAAA?pid=ImgDet&rs=1',
    1,
    8,
    1
  ),
  (
    'Cachoeira Saia Velha',
    'A Cachoeira Saia Velha tem a paisagem natural de uma cachoeira tradicional, mas com a infraestrutura de um clube, fica dentro do Águas Correntes Park.\r\n\r\nLocalização: Acesso pela BR 040, a partir da Saída Sul de Brasília até o\r\nMonumento Solarium.',
    'https://www.tripadvisor.com.br/Attraction_Review-g303322-d2349371-Reviews-Saia_Velha_waterfall-Brasilia_Federal_District.html',
    1,
    '2023-06-04 15:33:27',
    'https://1.bp.blogspot.com/-lDNCQiEaW-Q/XllQGOrUMHI/AAAAAAAABRQ/UKJDA-wll3U68gsitRAXQ0k-Wq9H0PX3ACLcBGAsYHQ/s1600/02.jpg',
    1,
    8,
    1
  ),
  (
    'Parque Ecológico EcoBocaina',
    'Parque Ecológico EcoBocaina possui cachoeiras e poços de água mineral,\r\nparedões, cânions, mirantes, fauna e flora exuberantes.\r\n\r\nLocalização: GO 118 (atual BR 010), entrada da Rampa de Voo Livre, BR-\r\n010, 25, GO',
    'https://www.ecobocaina.com.br/',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/OIP.cn1Zu12FTQM5vrGhITGDwgHaE7?pid=ImgDet&rs=1',
    1,
    8,
    1
  ),
  (
    'Poço Azul',
    'Uma das cachoeiras mais conhecidas do DF, localizada a 45km do centro de Brasília em direção a Brazlândia. Complexo com mais de 10 cachoeiras.\r\n\r\nLocalização: DF 001/DF 220 – Abaixo do assentamento Morado dos\r\nPássaros, Região Administrativa de Brazlândia/DF',
    'https://www.instagram.com/pocoazulbrasilia/',
    1,
    '2023-06-04 15:33:27',
    'https://media-cdn.tripadvisor.com/media/photo-s/09/21/f8/6f/poco-azul.jpg',
    1,
    8,
    1
  ),
  (
    'Salto do Tororó',
    'Cachoeira localizada na região administrativa de Jardim\r\nBotânico, no Distrito Federal. É um local popular para a prática de rapel e\r\ncaminhadas.\r\n\r\nLocalização: DF-140 - Jardim botânico, Brasília - DF.',
    'https://www.tripadvisor.com.br/Attraction_Review-g303322-d6475325-Reviews-Cachoeira_do_Tororo-Brasilia_Federal_District.html',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/OIP.xs_iltMz16v6id3WKAw36wEyDL?pid=ImgDet&rs=1',
    1,
    8,
    1
  ),
  (
    'Buraco das Araras',
    'Está localizado dentro de uma fazenda particular, no\r\nmunicípio de Formosa, distante a aproximadamente 110km de Brasília.\r\nPossui também trilhas que levam a uma  Caverna  com um  rio\r\nsubterrâneo  apropriado para  mergulho.\r\n\r\nLocalização: Br-020 Distrito Bezerra, Formosa, Goiás',
    'https://viagensdepassagem.wordpress.com/roteiros/brasil/distrito-federal/roteiros-naturais-do-df-e-regiao/buraco-das-araras/#:~:text=O%20Buraco%20das%20araras%20%C3%A9%20uma%20das%20maiores,at%C3%A9%20uma%20caverna%20com%20um%20rio%20subterr%C3%A2neo%20maravilhoso.',
    1,
    '2023-06-04 15:33:27',
    'https://viagensdepassagem.files.wordpress.com/2016/04/img_1636.jpg?w=600&h=450',
    1,
    8,
    1
  ),
  (
    'Parque Nacional da Chapada dos Veadeiros',
    'As caminhadas e banhos de\r\ncachoeira são as principais atividades no Parque, além da conservação da\r\nbiodiversidade e geodiversidade.\r\n\r\nLocalização: Rodovia GO 239, Km 36 - Vila de São Jorge, Alto Paraíso de\r\nGoiás - GO',
    'https://www.icmbio.gov.br/parnachapadadosveadeiros/',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/OIP.4CUchhjYjepnsASJbESfGwHaEw?pid=ImgDet&rs=1',
    1,
    8,
    1
  ),
  (
    'Salto do Corumbá',
    'Parque natural do cerrado goiano. Sua estrutura conta com 7 cachoeiras, camping, pousada, restaurantes, parque aquático e\r\natividades radicais em meio à natureza.\r\n\r\nLocalização: BR 414, Km. 383 Corumbá de Goiás, GO',
    'https://saltocorumba.com.br/',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/OIP.bRqwczPtqYC5uq2RAyOYZwHaD8?pid=ImgDet&rs=1',
    1,
    8,
    1
  ),
  (
    'Salto do Itiquira',
    'A cachoeira do Itiquira é uma queda de água de 169 metros de altura, localizada no município de Formosa, em Goiás, no Brasil.\r\n\r\nLocalização: Rodovia GO 440 - Km32, Formosa, Goiás',
    'https://saltodoitiquira.com.br/',
    1,
    '2023-06-04 15:33:27',
    'https://th.bing.com/th/id/R.d71ab92a6aa6ce10f0225cbc891285e5?rik=J%2f2yg9OeFz7EvA&pid=ImgRaw&r=0',
    1,
    8,
    1
  ),
  (
    'Museu Nacional',
    'O Museu Nacional da República (MuN) faz parte do Conjunto Cultural da República, juntamente com a Biblioteca Nacional de\r\nBrasília, e foi inaugurado em 15 de dezembro de 2006. \r\n\r\nSetor Cultural Sul, Lote 2 próximo à Rodoviária do Plano Piloto - Brasília – DF',
    'https://www.cultura.df.gov.br/museu-nacional-republica/',
    1,
    '2023-05-23 10:35:00',
    'https://th.bing.com/th/id/R.c03aa851cf73cd3e985609d630ce534a?rik=B2%2bZArhg7Fj3FA&pid=ImgRaw&r=0',
    1,
    7,
    1
  ),
  (
    'Memorial JK',
    'O Memorial JK é um espaço destinado a contar a história do político brasileiro Juscelino Kubitschek. \r\n\r\nEixo Monumental, Lado Oeste – Praça do Cruzeiro - Brasília DF. \r\n',
    'http://www.memorialjk.com.br/',
    1,
    '2023-05-23 10:35:00',
    'https://www.bekiaviajes.com/images/articulos/91000/91685/5.jpg',
    1,
    7,
    1
  ),
  (
    'Memorial dos Povos Indígenas',
    'No acervo, é possível encontrar objetos de\r\ndiversas etnias indígenas do Brasil.\r\n\r\nZona Cívico-Administrativa Em frente ao Memorial JK, Brasília – DF.\r\n',
    'https://www.cultura.df.gov.br/memorial-dos-povos-indigenas/',
    1,
    '2023-05-23 10:35:00',
    'https://s2.glbimg.com/ts94Y6DwnbMluj6qC3TnlMy9cvQ=/0x0:768x490/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2018/a/R/859Qq1QsOwKCSQOt0rXA/memorial.jpg',
    1,
    7,
    1
  ),
  (
    'Centro Cultural Banco do Brasil (CCBB)',
    'O local possui espaços de convivência, café, restaurante, galerias, salas de cinemas, teatro, jardins e uma praça central para eventos abertos, onde são realizados shows e espetáculos.\r\n\r\nSetor de Clubes Esportivos Sul (SCES), trecho 02, lote 22, Brasília- DF.\r\n\r\n',
    'https://ccbb.com.br/brasilia/',
    1,
    '2023-05-23 10:35:00',
    'https://www.eventim.com.br/obj/media/BR-eventim/teaser/venue/984x333/2016/ingressos-ccbbBSB-landing.png',
    1,
    7,
    1
  ),
  (
    'Museu dos Correios',
    'O Museu dos Correios preserva a história dos serviços postais e telegráficos e a memória dos Correios.\r\n\r\nSetor Comercial Sul (SCS), quadra 4, bloco A, 256, Asa Sul, Brasília-DF.\r\n\r\n\r\n',
    'https://www.correios.com.br/educacao-e-cultura/saiba-mais-museu-\r\ncorreios\r\n',
    1,
    '2023-05-23 10:35:00',
    'https://i1.wp.com/chicoterra.com/wp-content/uploads/2019/02/Fachada-do-Museu-Nacional-dos-Correios_05mai2013_Jair-Xavier.jpg?fit=800%2C650&ssl=1',
    1,
    7,
    1
  ),
  (
    'Catetinho',
    'Foi a primeira residência oficial do presidente Juscelino Kubitschek na época da construção da nova capital do país, Brasília.\r\n\r\nRodovia BR 040 s/n Trevo do – Gama, Brasília – DF.\r\n\r\n\r\n\r\n',
    'https://www.df.gov.br/museu-do-catetinho-2/',
    1,
    '2023-05-23 10:35:00',
    'https://media-cdn.tripadvisor.com/media/photo-s/0e/b8/a3/f9/vista-da-chegada-no-catetinho.jpg',
    1,
    7,
    1
  ),
  (
    'Museu da Memória Candanga',
    'Os cenários, objetos e fotos presentes no\r\nlocal relembram o início da capital brasileira.\r\n\r\nNúcleo Bandeirante, Setor Juscelino Kubitschek, lote D, Brasília - DF.\r\n\r\n\r\n\r\n',
    'https://www.cultura.df.gov.br/museu-vivo-da-memoria-candanga/\r\n',
    1,
    '2023-05-23 10:35:00',
    'https://www.letshotels.com.br/wp-content/uploads/2018/04/museu-vivo-da-memoria-candanga-brasilia.jpg',
    1,
    7,
    1
  ),
  (
    'Museu histórico de Brasília (Museu da Cidade)',
    'O Museu Histórico de Brasília (Museu da Cidade) integra o Conjunto Cultural Três Poderes. Foi projetado por Oscar Niemeyer e tem por objetivo preservar os trabalhos\r\nrelativos à história da construção de Brasília.\r\n\r\nCentro Cultural Três Poderes, Zona Cívico Administrativa, Praça dos Três Poderes, Brasília – DF.\r\n\r\n\r\n\r\n',
    'https://www.df.gov.br/museu-historico-de-brasilia-museu-da-cidade/\r\n',
    1,
    '2023-05-23 10:35:00',
    'https://th.bing.com/th/id/R.4d14eadc2eae349ab0fbed13f275ca8c?rik=9Enqbf3muU7Jsg&riu=http%3a%2f%2fwww.nomads.usp.br%2fvirus%2fvirus15%2fsecs%2fsubmitted%2fimg%2f03%2fimagem_01.jpg&ehk=on0TKCLD9r73Sy0ZNfUUAni%2fAp5guNVIQQ5ag3HHbic%3d&risl=&pid=ImgRaw&r=0',
    1,
    7,
    1
  ),
  (
    'Caixa Cultural',
    'É um espaço composto por cinco galerias, teatro, sala de oficina, Jardim das Esculturas e Átrio dos Vitrais.\r\n\r\nSetor Bancário Sul (SBS), quadra 4, lote 3/4, Brasília - DF. \r\n\r\n\r\n\r\n\r\n',
    'https://www.caixacultural.gov.br/Paginas/Brasilia.aspx\r\n',
    1,
    '2023-05-23 10:35:00',
    'https://dicasdacapital.com.br/wp-content/uploads/2020/12/1_caixa_cultural_2-6429656.png',
    1,
    7,
    1
  ),
  (
    'Museu de Arte de Brasília',
    'O acervo do MAB é formado por obras de arte\r\nmoderna e contemporânea, caracterizadas pela diversidade de técnicas e materiais, com pinturas, gravuras, desenhos, fotografias, esculturas, objetos e instalações.\r\n\r\nSHTN Trecho 1, projeto Orla Polo 03, Lote 05, SHTN Trecho 1 – Brasília - DF.\r\n\r\n\r\n\r\n\r\n\r\n',
    'https://www.cultura.df.gov.br/mab/',
    1,
    '2023-05-23 10:35:00',
    'https://1.bp.blogspot.com/-OsI74NHoldA/YHIjHQYOSeI/AAAAAAAAfvI/fjPXc79QpvwU2A-L74_ZYXQQPGg-0nRqACLcBGAsYHQ/s800/Museu%2Bde%2BArte%2Bde%2BBras%25C3%25ADlia%2B%25289%2529.jpg',
    1,
    7,
    1
  ),
  (
    'Espaço Lúcio Costa',
    'Construção subterrânea que abriga em seu acervo a Maquete de Brasília.\r\n\r\nPraça dos Três Poderes – Esplanada dos Ministérios, Brasília-DF.\r\n\r\n\r\n\r\n\r\n\r\n',
    'https://www.df.gov.br/espaco-lucio-costa-2/',
    1,
    '2023-05-23 10:35:00',
    'https://divisare-res.cloudinary.com/images/f_auto,q_auto,w_auto/v1452614485/k6odq48yxwjiflp5hotp/oscar-niemeyer-gonzalo-viramonte-espaco-lucio-costa-museum-1992.jpg',
    1,
    7,
    1
  ),
  (
    'Panteão da Pátria e da Liberdade Tancredo Neves',
    'É um espaço criado para homenagear os “heróis nacionais” – aqueles que possuíam ideais de liberdade e democracia.\r\n\r\nCentro Cultural Três Poderes, Zona Cívico Administrativa, Praça dos Três Poderes, Brasília- DF.\r\n\r\n\r\n',
    'https://www.expedia.com.br/Panteao-Da-Liberdade-Plano-Piloto.d6223756.Guia-de-Viagem',
    1,
    '2023-05-23 10:35:00',
    'https://www.rotasturisticas.pt/imagens/visitar/br/large/photos1-5585-brasilia_panteao_da_patria_tancredo_neves.jpg',
    1,
    7,
    1
  ),
  (
    'Museu da Imprensa',
    'Tem por objetivo proporcionar à população acesso a uma parte importante da história da comunicação do Brasil.\r\n\r\nLote 800, quadra 6, Sig Quadra 6, Cruzeiro/Sudoeste/Octogonal- Brasília - DF.\r\n\r\n\r\n\r\n',
    'http://museu.in.gov.br/web/museu-da-\r\nimprensa#portlet_com_liferay_journal_content_web_portlet_JournalContentP\r\nortlet_INSTANCE_InFgbjC8N2yB_',
    1,
    '2023-05-23 10:35:00',
    'https://muitainformacao.com.br/upload/MUSEU_1_2_3.jpg',
    1,
    7,
    1
  ),
  (
    'Museu Histórico do Senado Federal',
    'Museu é responsável por manter e disponibilizar a todos os cidadãos a história do Senado Federal.\r\n\r\nPraça do Congresso, Térreo, Brasília- DF.\r\n\r\n\r\n\r\n',
    'https://www12.senado.leg.br/institucional/museu',
    1,
    '2023-05-23 10:35:00',
    'https://sindilegis.org.br/wp-content/uploads/2021/07/Destaque-museu-do-senado.jpg',
    1,
    7,
    1
  ),
  (
    'Espaço Oscar Niemeyer',
    'Um espaço que tem como função homenagear o\r\nartista e arquiteto Oscar Niemeyer.\r\n\r\nSetor de Administração Federal Sul (SAF), quadra 4, conjunto C, Brasília-DF.\r\n\r\n\r\n\r\n\r\n',
    'https://www.cultura.df.gov.br/espaco-oscar-niemeyer/',
    1,
    '2023-05-23 10:35:00',
    'https://www.aovivodebrasilia.com.br/wp-content/uploads/2019/08/espaco-oscar-niemeyer.jpg',
    1,
    7,
    1
  ),
  (
    'Fundação Athos Bulcão',
    'A instituição desenvolve importantes projetos na área de arte-educação para adolescentes.\r\n\r\nCRS 510 Bloco B Loja 51, Brasília - DF.\r\n\r\n\r\n\r\n',
    'https://www.fundathos.org.br/',
    1,
    '2023-05-23 10:35:00',
    'https://i.pinimg.com/originals/9b/95/a4/9b95a456f3bf2d23300f93b6ca436ba0.jpg',
    1,
    7,
    1
  ),
  (
    'Parque Ecológico Dom Bosco',
    'Localizado na beira do Lago Paranoá, perto\r\nda barragem, o parque oferece a seus visitantes paisagens exuberantes,\r\nalém de trilhas dentro do cerrado nativo.\r\n\r\nLocalização: SHIS QL 30 - Lago Sul\r\nEntrada franca\r\nAberto todos os dias das 6h às 18h',
    'https://www.ibram.df.gov.br/parque-ecologico-dom-bosco/',
    1,
    '2023-05-23 10:35:00',
    'https://especiais.correiobraziliense.com.br/wp-content/uploads/2022/04/CBPFOT140420212176-scaled.jpg',
    1,
    5,
    1
  ),
  (
    'Parque Ecológico de Águas Claras',
    'ideal para a prática de corridas e\r\ncaminhadas. Possui Diversas quadras, campos e equipamentos de ginástica.\r\n\r\nLocalização: Av. Castanheiras-Centro\r\nEntrada franca\r\nAberto todos os dias das 6h às 22h',
    'https://www.aguasclaras.df.gov.br/2016/06/30/parque-ecologico-de-aguas-claras/',
    1,
    '2023-05-23 10:35:00',
    'https://www.eldogomes.com.br/wp-content/uploads/2022/06/214DC486-6CC9-429F-9962-F44205767659.jpeg',
    1,
    5,
    1
  ),
  (
    'Parque Ecológico Olhos D’água',
    'O parque oferece aos visitantes: trilhas,\r\nrelógio do sol e áreas para contemplação, além de servir de palco para\r\ndiversas atividades culturais.\r\n\r\n\r\nLocalização: SQN 413/414\r\nEntrada franca\r\nAberto todos os dias das 6h às 19h',
    'https://www.ibram.df.gov.br/ecologico-olhos-dagua/',
    1,
    '2023-05-23 10:35:00',
    'https://cdn.jornaldebrasilia.com.br/wp-content/uploads/2019/09/olhos.jpg',
    1,
    5,
    1
  ),
  (
    'Parque Ecológico Ezechias Heringer ou parque do Guará',
    'Possui grande\r\nbiodiversidade, incluindo pequenos mamíferos. Entre seus atrativos estão os\r\nequipamentos de lazer e esporte.\r\n\r\nLocalização: QE 23, Guará II\r\nEntrada franca\r\nAberto todos os dias das 6h às 18h',
    'https://www.guara.df.gov.br/category/sobre-a-ra/parques-do-guara/parque-ecologico-ezechias-heringer/',
    1,
    '2023-05-23 10:35:00',
    'https://radardf.com.br/wp-content/uploads/2020/12/Voluntarios-vao-plantar-750-mudas-nativas-no-Parque-Ezechias-Heringer-no-Guara-RADARDF.jpg',
    1,
    5,
    1
  ),
  (
    'Parque Lago do Cortado',
    'Situado na região central de Taguatinga, este\r\nparque abriga o Ribeirão do Cortado, que contém várias cachoeirinhas.\r\n\r\n\r\nLocalização: QNF/QNL Taguatinga\r\nEntrada franca\r\nAberto todos os dias das 6h às 18h',
    'https://ibram.df.gov.br/wp-content/uploads/2018/12/Lago-do-Cortado.pdf',
    1,
    '2023-05-23 10:35:00',
    'https://falacomunidade.net/wp-content/uploads/2021/03/mirante-lago-do-cortado.jpg',
    1,
    5,
    1
  ),
  (
    'Parque Três meninas',
    'O local é uma antiga fazenda construída nos anos 60,\r\nonde se destacam três pequenas casas feitas pelos antigos proprietários\r\npara suas três filhas. Possui pista de skate, parques infantis, quadras\r\npoliesportivas e ciclovia.\r\n\r\nLocalização: Quadras 609 à 611 Samambaia\r\nEntrada franca\r\nAberto todos os dias das 7h às 18h',
    'https://www.ibram.df.gov.br/parque-tres-meninas/',
    1,
    '2023-05-23 10:35:00',
    'https://1.bp.blogspot.com/-6d0g8Z32FMs/XUgzGSPEvEI/AAAAAAAAoB8/B_gsbCEQ6d4FB_T5Bt3LI3EyJRXl2eUKgCLcBGAs/s1600/02.jpg',
    1,
    5,
    1
  ),
  (
    'Parque Saburo Onoyama',
    'O espaço conta ainda com diversas quadras\r\npoliesportivas e boa infraestrutura para o lazer, além de várias trilhas e uma\r\npiscina pública.\r\n\r\nLocalização: AE- Taguatinga Sul\r\nEntrada franca\r\nAberto todos os dias das 6h às 18h',
    'https://www.ibram.df.gov.br/voce-conhece-a-historia-do-parque-saburo-onoyama/',
    1,
    '2023-05-23 10:35:00',
    'https://live.staticflickr.com/65535/48206261236_7dc2fd1dfa_b.jpg',
    1,
    5,
    1
  ),
  (
    'Parque Garças',
    'Localizado no final do Lago Norte, oferece um excelente\r\nponto de acesso ao Lago Paranoá, onde se forma uma extensa faixa de\r\npraia.\r\n\r\nLocalização: QI 15/16 - Lago Norte\r\nEntrada franca\r\nAberto todos os dias das 6h às 18h',
    'https://www.tripadvisor.com/Attraction_Review-g303322-d6474181-Reviews-Parque_Das_Garcas-Brasilia_Federal_District.html',
    1,
    '2023-05-23 10:35:00',
    'https://media-cdn.tripadvisor.com/media/photo-s/13/bd/7e/0c/estrada-da-entrada-principal.jpg',
    1,
    5,
    1
  ),
  (
    'Parque Recreativo do Gama',
    'Conhecido como Prainha, é cortado pelas\r\nmuitas corredeiras e cachoeiras do Ribeirão do Gama.\r\n\r\nLocalização: Boa Vista-DVO - Gama\r\nEntrada franca\r\nAberto todos os dias das 6h às 18h',
    'https://www.ibram.df.gov.br/recreativo-do-gama/',
    1,
    '2023-05-23 10:35:00',
    'https://uploads.metropoles.com/wp-content/uploads/2015/10/17180049/J7A1182.jpg',
    1,
    5,
    1
  ),
  (
    'Parque do Paranoá',
    'Conta com quadras esportivas, parquinhos, amplo espaço para brincar e trilhas largas.\r\n\r\nLocalização: Quadras 02 e 03 Paranoá\r\nEntrada franca\r\nAberto todos os dias das 6h às 18h',
    'https://www.agenciabrasilia.df.gov.br/2021/01/26/parque-do-paranoa-tera-mais-conforto-e-seguranca/',
    1,
    '2023-05-23 10:35:00',
    'https://cdn.jornaldebrasilia.com.br/wp-content/uploads/2022/11/10101147/10.11.-Parque-Ecologico-do-Paranoa.-Foto-Paulo-H.-Carvalho-Agencia-Brasilia4.jpeg',
    1,
    5,
    1
  ),
  (
    'Parque Península Sul',
    'Oferece uma bela vista do Lago Paranoá, possui\r\numa trilha que margeia o parque, além de vários piers.\r\n\r\nLocalização: SHIS QL 12 - Lago Sul\r\nEntrada franca\r\nAberto todos os dias das 6h às 22h',
    'https://ibram.df.gov.br/wp-content/uploads/2018/12/Ecologico-Peninsula-Sul.pdf',
    1,
    '2023-05-23 10:35:00',
    'https://media-cdn.tripadvisor.com/media/photo-m/1280/1c/34/a9/10/parque-ecologico-peninsula.jpg',
    1,
    5,
    1
  ),
  (
    'Parque Ecológico Recanto das Emas',
    'Possui um cenário ideal para\r\ncontemplação da natureza e boas caminhadas.\r\n\r\nLocalização: Quadra 311 Recanto das Emas\r\nEntrada franca\r\nAberto todos os dias',
    'https://www.ibram.df.gov.br/ecologico-recanto-das-emas/',
    1,
    '2023-05-23 10:35:00',
    'https://www.ferias.tur.br/imgs/1790/recantodasemas/g_recanto-das-emas-df-cachoeira-no-parque-ecologico-e-vivencial-2.jpg',
    1,
    5,
    1
  ),
  (
    'Jardim Botânico',
    'O Jardim Botânico possui muitos quilômetros de trilhas que\r\ncortam o cerrado, além de belas alamedas de pinheiros, centro de visitantes,\r\norquidário e uma atrativa casa de chá.\r\n\r\nLocalização: SMDB - Área Especial - Lago Sul\r\nEntrada R$ 2,00\r\nAberto de terça a domingo das 9h às 17h',
    'https://www.jardimbotanico.df.gov.br',
    1,
    '2023-05-23 10:35:00',
    'https://i0.wp.com/portalcontexto.com.br/wp-content/uploads/2020/09/jbb.jpg?fit=800%2C600&ssl=1',
    1,
    5,
    1
  ),
  (
    'Parque da Cidade Dona Sarah Kubitschek',
    'É um dos maiores parques\r\nurbanos do mundo. Recebe grande visitação, pois é um dos principais\r\ncentros de lazer ao ar livre de Brasília. Possui diversos atrativos,\r\nprincipalmente para práticas esportivas.\r\n\r\nLocalização: Eixo Monumental\r\nEntrada franca\r\nAberto todos os dias das 5h às 0h',
    'https://www.ibram.df.gov.br/dona-sarah-kubitschek/',
    1,
    '2023-05-23 10:35:00',
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/01/46/cd/visao-aerea.jpg?w=1200&h=-1&s=1',
    1,
    5,
    1
  ),
  (
    'Parque Nacional de Brasília',
    'Unidade de Conservação com visitação\r\npública, também conhecido como Água Mineral. o Parque surgiu da\r\nnecessidade de ações que protegessem as nascentes fornecedoras de água\r\npotável à Capital Federal e que mantivessem a vegetação em estado natural.\r\n\r\nLocalização: Via Epia BR-040 – Setor Militar Urbano\r\nParque Nacional de Brasília cobra ingressos para o público em geral\r\nAberto todos os dias das 9h às 16h.',
    'https://www.df.gov.br/agua-mineral/',
    1,
    '2023-05-23 10:35:00',
    'https://melhoresdestinosdobrasil.com.br/wp-content/uploads/2015/06/parque-nacional-de-brasilia.jpg',
    1,
    5,
    1
  ),
  (
    'Palácio da Alvorada',
    'É a residência oficial do Presidente da República. Foi projetado por\r\nOscar Niemeyer em 1956 e inaugurado em 30 de junho de 1958.\r\n\r\nEndereço: Zona Cívico-Administrativa - Brasília, DF\r\n\r\nHorário de visitação: Quartas-feiras, das 15h às 17h. A partir das 13h, há a distribuição de\r\nsenhas de acesso, por ordem de chegada, para a formação dos grupos. São entregues, em\r\nmédia, 300 senhas. A visita é conjugada, iniciando pelo Palácio da Alvorada, com duração de,\r\naproximadamente, 60 minutos. Com agendamento.\r\n\r\nEntrada: gratuita',
    'https://www.gov.br/planalto/pt-br/conheca-a-presidencia/palacios-e-residencias/palacio-da-alvorada',
    1,
    '2023-06-08 12:00:00',
    'https://upload.wikimedia.org/wikipedia/commons/e/eb/Homologa%C3%A7%C3%A3o_do_tombamento_de_obras_do_Niemeyer_%2834321040524%29.jpg',
    1,
    2,
    1
  ),
  (
    'Esplanada dos Ministérios',
    'A Esplanada compõe-se de uma vasta área verde na qual se\r\nencontram 17 prédios que abrigam os Ministérios do Poder Executivo (10 do lado sul e 7 do\r\nlado norte).\r\n\r\nEndereço: Eixo Monumental – Brasília, DF',
    'https://www.df.gov.br/esplanada-dos-ministerios/',
    1,
    '2023-06-08 12:00:00',
    'https://cdn.folhape.com.br/img/pc/1100/1/dn_arquivo/2022/01/enquadramento-capa-15.jpg',
    1,
    2,
    1
  ),
  (
    'Catedral Metropolitana Nossa Senhora Aparecida',
    'É um marco na história da arquitetura\r\nmoderna, foi projetada por Oscar Niemeyer. A nave circular está abaixo do nível do solo, onde\r\nse chega por um túnel de piso e paredes negras. Na entrada ficam esculturas em bronze que\r\nrepresentando os quatro evangelistas, com 3 metros de altura.\r\n\r\nEndereço: Esplanada dos Ministérios lote 12 - Brasília, DF\r\n\r\nHorário das Missas:\r\nDe Terça à Sexta-feira: 12h15\r\nSábado: 17h\r\nDomingo: 08h, 10h30 e 18h\r\n\r\nVisitação:\r\nDe Terça a sexta: das 08h às 16h45\r\nSábado: das 08h às 16h45\r\nDomingo: das 9h às 17h45\r\n(No horário das celebrações – Missas, casamentos e Batizados – não é permitido a visitação)',
    'https://catedral.org.br',
    1,
    '2023-06-08 12:00:00',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Catedral_Metropolitana_Nossa_Senhora_Aparecida_-_Bras%C3%ADlia_-_DF.jpg/2560px-Catedral_Metropolitana_Nossa_Senhora_Aparecida_-_Bras%C3%ADlia_-_DF.jpg',
    1,
    2,
    1
  ),
  (
    'Palácio Itamaraty',
    'Sede do Ministério das Relações Exteriores e também conhecido como\r\nPalácio dos Arcos, é uma das obras mais conhecidas de Oscar Niemeyer.\r\n\r\nEndereço: Zona Cívico-Administrativa BL H - Brasília, DF\r\n\r\nVisitação: Os agendamentos são feitos exclusivamente pelo endereço eletrônico\r\nvisita@itamaraty.gov.br, em dias úteis (segunda a sexta-feira), entre 9h e 17h, até o dia anterior\r\nà data desejada.\r\nO limite por grupo/horário é de 15 (quinze) pessoas. Caso o grupo seja composto por mais de\r\n15 (quinze) pessoas, será necessário realizar o agendamento de mais um horário para o mesmo dia, ou em dias distintos, de acordo com a disponibilidade da agenda.\r\nA visitação poderá ser cancelada ou sofrer alterações de roteiro a qualquer momento, sem\r\naviso prévio, mesmo quando tenha sido previamente confirmada, por motivos de força maior, compromissos oficiais ou questões de segurança.',
    'https://www.df.gov.br/palacio-itamaraty/',
    1,
    '2023-06-08 12:00:00',
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0a/07/0a/55/palacio-itamaraty.jpg?w=1200&h=1200&s=1',
    1,
    2,
    1
  ),
  (
    'Complexo da Torre de TV',
    'A torre foi projetada por Lúcio Costa e possui 230 metros de altura\r\nalém de um mirante panorâmico a 75 metros do solo, com capacidade para 150 pessoas, de\r\nonde se tem uma vista de 360o da cidade. Foi inaugurada em 1967 para receber antenas de\r\nemissoras de rádio e TV.\r\n\r\nEndereço: Brasília, DF\r\n\r\nVisitação:\r\n*Mirante*\r\nHorário de funcionamento:\r\nTerça a sexta-feira: 12:00 às 17:45\r\nSábado, domingo e feriados: 9:00 às 17:45\r\n\r\n*Feira de Artesanato*\r\nHorário de funcionamento:\r\nTerça a sexta-feira: 9:00 às 17:00\r\nSábado, domingo e feriados: 9:00 às 18:00\r\n\r\n*Fonte Luminosa*\r\nHorário de funcionamento:\r\nSegunda a sexta-feira: 16:00 às 18:00 / 19:00 às 22:00\r\nSábado e domingo: 8:00 às 12:00 / 14:00 às 16:00 / 19:00 às 22:00',
    'http://www.portalturismobrasil.com.br/atracao/473/Complexo-da-Torre-de-Tv',
    1,
    '2023-06-08 12:00:00',
    'https://mistobrasilia.com/wp-content/uploads/2020/12/torre-de-tv-luzes.jpg',
    1,
    2,
    1
  ),
  (
    'Centro de Convenções Ulysses Guimarães',
    'O Centro de Convenções tem capacidade para\r\nreceber até 9,4 mil pessoas. Possui cinco auditórios; 13 salas moduláveis por divisórias\r\nacústicas retráteis, que permitem combinações diversas; e estrutura de apoio com cafeterias,\r\ncamarins e espaço para montagem de posto médico.\r\nEndereço: SDC – Ulysses Guimarães, Brasília – DF',
    'https://ulysses.tur.br',
    1,
    '2023-06-08 12:00:00',
    'https://cdn.wegow.com/media/venues/centro-de-convencoes-ulysses-guimaraes/centro-de-convencoes-ulysses-guimaraes-1641316087.123005.2560x1440.jpg',
    1,
    2,
    1
  ),
  (
    'Planetário de Brasília',
    'foi inaugurado em 15 de março de 1974, e devido ao uso de altíssima\r\ntecnologia em ferramentas multimídia e de interação se encontra entre os mais modernos do\r\nmundo.\r\n\r\nEndereço: St. de Divulgação Cultural – Brasília, DF\r\n\r\nVisitação: terça a domingo das 7:30hs às 19:30hs, inclusive feriados\r\n\r\nEntrada gratuita',
    'https://www.secti.df.gov.br/programacao-do-planetario/',
    1,
    '2023-06-08 12:00:00',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToGLvWg1zcVmLfAeL_PScPeKHjvz_dM0hRBw&usqp=CAU',
    1,
    2,
    1
  ),
  (
    'Estádio Nacional de Brasília Mané Garrincha',
    'Atualmente é, em volume, a maior construção\r\nde Brasília. O projeto abrange a acessibilidade em todas as suas dependências. Sua estrutura\r\né semelhante a um grande chapéu e tem por objetivo projetar sombra e oferecer conforto em\r\nseu interior.\r\n\r\nEndereço: Setor de Recreação Pública Norte – Eixo Monumental, Brasília, DF.',
    'https://arenabsb.com.br/estadio/',
    1,
    '2023-06-08 12:00:00',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzSx7PJqVRfs498eiR1UKpWcuw6xu6MEnlxg&usqp=CAU',
    1,
    2,
    1
  ),
  (
    'Congresso Nacional',
    'Foi inaugurado em 21 de abril de 1960. Possui um edifício principal na\r\nhorizontal, que serve de base para as cúpulas do Senado Federal e da Câmara dos\r\nDeputados. A cúpula maior, de 60 metros e altura de 10,02 metros, de forma convexa, abriga o\r\nPlenário da Câmara dos Deputados. A cúpula menor, com diâmetro de 36 metros e 10,02\r\nmetros de altura, de forma côncava, abriga o Plenário do Senado Federal. Entre as duas\r\ncúpulas, fazendo um contraponto estão as duas torres gêmeas de 28 andares e 100 metros de\r\naltura, interligadas por uma passarela.\r\n\r\nEndereço: Praça dos Três Poderes – Brasília, DF\r\n\r\nVisitação: O Palácio do Congresso Nacional está aberto à visitação das 8h30 às 17h30, com a\r\nsaída do primeiro grupo às 9h. Nas segundas, quintas e sextas, as visitas são realizadas em\r\ninglês, francês, espanhol e libras, para as quais recomendamos que sejam agendadas. Nos\r\nfinais de semana e feriados, há visitas em inglês às 10h15 e 16h15, e em Libras às 12h15, sem\r\na necessidade de agendamento.\r\nEntrada gratuita.',
    'https://www.guiadasemana.com.br/brasilia/turismo/estabelecimento/congresso-nacional',
    1,
    '2023-06-08 12:00:00',
    'https://s4.static.brasilescola.uol.com.br/be/2023/02/sede-do-congresso-nacional-em-brasilia-com-reflexo-do-predio-no-espelho-dagua-a-sua-frente.jpg',
    1,
    2,
    1
  ),
  (
    'Palácio do Planalto',
    'Palácio do Planalto foi projetado pelo Arquiteto Oscar Niemeyer É o local\r\nde trabalho da Presidência do Brasil. Nele está situado o Gabinete do Presidente da República.\r\n\r\nEndereço: Praça dos Três Poderes, Esplanada dos Ministérios, Brasília, DF\r\n\r\nVisitação: Para realizar o agendamento é necessário acessar\r\nhttps://visitapr.presidencia.gov.br/exec/index.php, preencher o formulário de agendamento de\r\nvisitas e ler o Termo de Condições. Posteriormente, o responsável receberá um e-mail de\r\nconfirmação da visitação, com o nome de todos os visitantes agendados, que deverá ser\r\napresentado no momento da visitação.',
    'https://www.gov.br/planalto/pt-br/conheca-a-presidencia/palacios-e-residencias/palacio-do-planalto',
    1,
    '2023-06-08 12:00:00',
    'https://s2.glbimg.com/w8LAVuh-BP6p8KC3JokE_3UsamM=/smart/e.glbimg.com/og/ed/f/original/2017/01/09/espelho_dagua.jpg',
    1,
    2,
    1
  ),
  (
    'Palácio do Supremo Tribunal Federal',
    'Está localizado no terceiro vértice da Praça dos Três\r\nPoderes, na lateral oposta ao Palácio do Planalto, foi concebido pelo arquiteto Oscar Niemeyer\r\ncom projeto original de Lúcio Costa. Em frente ao prédio fica a estátua “A Justiça”, obra do\r\nescultor Alfredo Ceschiatti. É o edifício construído para abrigar o Supremo Tribunal Federal,\r\nórgão máximo de apelação e corte constitucional do Brasil. Endereço: Praça dos Três\r\nPoderes, Esplanada dos Ministérios, Brasília, DF\r\n\r\nVisitação: Em dias úteis, de segunda a sexta-feira, 10h e 11h; segundas, terças e sextas, às 14h, 15h, 16h e 17h. As visitas são permitidas apenas com agendamento prévio através do e-\r\nmail: visitacao@stf.jus.br.',
    'https://portal.stf.jus.br/textos/verTexto.asp?servico=sobreStfVisitacaoPublica&pagina=principal1',
    1,
    '2023-06-08 12:00:00',
    'https://www.abecbrasil.org.br/novo/wp-content/uploads/2019/01/Stf_01.jpg',
    1,
    2,
    1
  ),
  (
    'Catedral Militar Rainha da Paz',
    'O prédio forma um triângulo que define a nave e o altar da\r\nigreja lembrando uma tenda miliar, foi projetada pelo arquiteto Oscar Niemeyer. Essa estrutura\r\nfoi executada para abrigar o altar da missa solene celebrada pelo Papa João Paulo II, em 1991,\r\nna Esplanada dos Ministérios, quando aconteceu sua última visita a Brasília.\r\n\r\nEndereço: Via Canteiro Central do Eixo Monumental, Brasília, DF\r\n\r\nVisitação: Segunda a segunda, das 7h às 22h Missas: segunda a sexta-feira, às 19h. Sábado,\r\nàs 17h. Domingo, às 8h, 10h e 18h30. Primeira sexta-feira de cada mês, às 15h. Todo dia 25 de\r\ncada mês, às 11h e 19h.',
    'https://www.catedralmilitarrainhadapaz.com.br',
    1,
    '2023-06-08 12:00:00',
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/02/10/72/catedral-militar-rainha.jpg?w=1200&h=-1&s=1',
    1,
    2,
    1
  ),
  (
    'Ermida Dom Bosco',
    'A Ermida foi inaugurada em 1957 e localiza-se às margens do Lago\r\nParanoá, de onde se tem uma vista privilegiada da cidade de Brasília. O Monumento foi o\r\nprimeiro templo construído em Brasília, em homenagem a Dom Bosco. A pequena construção\r\nfica em um ponto por onde passa o paralelo 15, local em que Dom Bosco, em sonho, anteviu\r\nem 1883 a construção da Capital brasileira no Planalto Central.\r\n\r\nEndereço: SHIS, QI 29, Conjunto A, Área Isolada Estrada Parque Dom Bosco, Brasília, DF\r\n\r\nVisitação: Diariamente, das 6h às 20h.',
    'https://www.tripadvisor.com.br/Attraction_Review-g303322-d8372305-Reviews-Ermida_Dom_Bosco-Brasilia_Federal_District.html',
    1,
    '2023-06-08 12:00:00',
    'https://curtamais.com.br/uploads/conteudos/1912691d49ad114256e567ac4dc51aa5.jpg',
    1,
    2,
    1
  ),
  (
    'Quartel-General do Exército',
    'O Quartel-General do Exército foi projetado por Oscar\r\nNiemeyer e inaugurado em 1973. Em frente ao QG está a Praça Duque de Caxias, um jardim\r\nprojetado por Roberto Burle Marx contempla e um lago artificial onde se destacam algumas\r\nesculturas de pedra em forma de cristais de rocha, que ficou conhecida como a Praça dos\r\nCristais.\r\n\r\nEndereço: Setor Militar Urbano, Eixo Monumental, SRPN, Trecho 1, Brasília, DF\r\n\r\nVisitação: Aos finais de semana e feriados, as visitas são abertas ao público e não há\r\nnecessidade de agendamento, no horário das 10h às 16h.',
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/c2/d5/38/vista-do-predio-do-qg.jpg?w=1200&h=-1&s=1',
    1,
    '2023-06-08 12:00:00',
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/c2/d5/38/vista-do-predio-do-qg.jpg?w=1200&h=-1&s=1',
    1,
    2,
    1
  ),
  (
    'Ponte JK',
    'A Ponte Juscelino Kubitschek, também conhecida como Ponte JK, foi projetada por\r\nAlexandre Chan. Sua estrutura é formada por três arcos inspirados pelo movimento de uma\r\npedra quicando sobre o espelho d\'água. Em 2003 foi premiada internacionalmente como a\r\nponte mais bela do mundo.\r\n\r\nEndereço: Setor de Clubes Esportivos Sul Lago Sul, Brasília, DF',
    'https://www.vice.df.gov.br/ponte-juscelino-kubitschek-ou-terceira-ponte/',
    1,
    '2023-06-08 12:00:00',
    'https://www.vice.df.gov.br/wp-conteudo/uploads/2019/11/BSB-60-ANOS-28-300x200.jpg',
    1,
    2,
    1
  ),
  (
    'Pontão do Lago Sul',
    'O Pontão do Lago Sul está localizado às margens do Lago Paranoá. Foi\r\nconstruído para desenvolver o turismo cultural, gastronômico, de negócios e de entretenimento\r\nna região e hoje já se transformou em um dos pontos mais importantes e atrativos de Brasília,\r\nconsagrado como uma área de lazer nobre e de luxo.\r\n\r\nEndereço: SHIS, Q L 10, Lote 1/30, Lago Sul, Brasília, DF\r\n\r\nVisitação: Domingo e segunda, das 7h à 0h; terça a quinta-feira, das 7h à 1h; sexta-feira e\r\nsábado, das 7h às 2h. Obs.: os restaurantes têm horários de funcionamento independentes.',
    'https://www.pontao.com.br/home',
    1,
    '2023-06-08 12:00:00',
    'https://www.pontao.com.br/arquivos/4-1214101515.jpg',
    1,
    2,
    1
  ),
  (
    'Santuário Dom Bosco',
    'o santuário foi construído em homenagem ao copadroeiro de Brasília\r\n– São João Bosco. Possui uma beleza singular e impactante. O templo possui 80 colunas com\r\n16 m de altura, que se tocam no topo formando arcos góticos e integram harmoniosamente\r\nobras como os vitrais produzidos pelo artista belga Hubert Van Doorne.\r\n\r\nEndereço: SEPS, Quadra 702, Bloco B, Brasília, DF\r\n\r\nVisitação: Diariamente, das 7h às 20h. Missas: segunda-feira a sábado, às 7h e 18h; e\r\ndomingo, às 8h, 11h, 18h e 19h30.',
    'https://paroquias.salesianos.br/paroquia/santuario-sao-joao-bosco-df',
    1,
    '2023-06-08 12:00:00',
    'https://arqbrasilia.com.br/wp-content/uploads/2023/05/Santuario-Dom-Bosco.jpg',
    1,
    2,
    1
  ),
  (
    'Templo da Boa Vontade – TBV',
    'É um monumento que tem o formato de uma pirâmide de\r\nmármore com sete faces, com 21 metros de altura e 28 de diâmetro. No seu ápice, encontra-se\r\num cristal puro de 21 kg, lembrando os templos do antigo Egito. O templo ainda conta com uma\r\nGaleria de Arte, o Memorial Alziro Zarur, a Sala Egípcia, o Salão Nobre, uma Fonte e os jardins\r\nsubterrâneos.\r\n\r\nEndereço: SGAS, 915, Lotes 75/6, Brasília, DF\r\n\r\nVisitação: Diariamente 24h na nave principal; demais espaços, das 8h às 20h.',
    'https://www.tbv.com.br',
    1,
    '2023-06-08 12:00:00',
    'https://imgsapp2.correiobraziliense.com.br/app/noticia_127983242361/2019/10/16/798163/20191016101831682115i.jpg',
    1,
    2,
    1
  ),
  (
    'Torre de TV Digital',
    'Foi inaugurada no dia 21 de abril de 2012 e foi o último projeto edificado\r\nde Oscar Niemeyer antes de falecer em 5 de dezembro de 2012. Foi apelidada de “flor do\r\ncerrado”. A Torre de TV Digital tem 182 m de altura. Nas laterais, há duas cúpulas de vidro. A\r\nmais alta está a 80 m do chão; e a mais baixa, a 60 m.\r\n\r\nEndereço: Torre de TV Digital de Brasília, Lago Norte, Brasília, DF\r\n\r\nVisitação: Terça a sexta: de 12h as 18h. Sábado, domingos e feriados: 9h as 18h.',
    'https://www.df.gov.br/torre-de-tv-digital/',
    1,
    '2023-06-08 12:00:00',
    'https://www.gov.br/mcom/pt-br/media/noticias/2022/07-12_antena-de-tv-digital-de-brasilia_fotozack.png/@@images/16024067-4e3a-4a00-90cf-550cda2aeba4.png',
    1,
    2,
    1
  ),
  (
    'Praça dos Três Poderes',
    'Obra de Oscar Niemeyer e Lúcio Costa, a Praça dos Três Poderes é um espaço amplo (tem 120 x 220 m) que abriga as sedes dos três poderes: o Palácio do Planalto (poder Executivo), o Congresso (poder Legislativo) e o Supremo Tribunal Federal (poder Judiciário).\r\n\r\nNa praça há algumas esculturas: Os Dois Candangos (no centro dela), considerada um símbolo de Brasília; A Justiça (em frente ao STF); a cabeça de Juscelino Kubitscheck, (na fachada do Museu Histórico de Brasília); o Pombal; a Pira da Pátria; o Marco Brasília; e o Mastro da Bandeira, que tem a maior bandeira permanentemente hasteada do mundo.\r\n\r\nO Museu da Cidade foi projetado por Oscar Niemeyer e inaugurado em 1960 para preservar os trabalhos relativos à história da construção de Brasília. Possui uma exposição permanente com inscrições históricas.\r\n\r\nNo subsolo da praça, próximo ao STF, se encontra o Espaço Lúcio Costa, que abriga a enorme Maquete de Brasília.\r\nVisitação: de terça a domingo, das 9h às 18h. Entrada franca.\r\n\r\nAo lado da bandeira também se localiza o Panteão da Pátria, uma coleção permanente de obras que homenageiam os heróis nacionais.\r\nVisitação: de terça a domingo, inclusive feriados, das 09h às 18h. Entrada franca.',
    'https://www.df.gov.br/praca-dos-tres-poderes/',
    1,
    '2023-06-08 12:00:00',
    'https://www.vice.df.gov.br/wp-conteudo/uploads/2019/12/BSB-60-ANOS-69-1620x1080.jpg',
    1,
    2,
    1
  ),
  (
    'TIAGO IORC - TURNÊ DARAMÔ',
    'Data: sex., 16 de jun., 19:00 – sáb., 17 de jun., 03:00\r\n\r\nLocal: Centro de Convenções Ulysses Guimarães\r\n',
    'https://www.alphatickets.com.br/Detalhes.aspx?event=D6C1F60E-37D8-4665-9421-FB9DB9991ED0&hostname=&dt=20230504001132',
    1,
    '2023-06-16 19:00:00',
    'https://s3.amazonaws.com/assets.bilheteriadigital/eventos/48380a.jpg?1677858485',
    1,
    1,
    1
  ),
  (
    'ROGER WATERS – Brasília',
    'Data: ter., 24 de out., 18:00 – 23:00\r\n\r\nLocal: Estádio Mané Garrincha Portão 1, SRPN - Asa Norte, Brasília - DF',
    'https://agendametal.com.br/show/roger-waters-brasilia/',
    1,
    '2023-10-24 18:00:00',
    'https://www.radiorock.com.br/wp-content/uploads/2017/05/roger-waters-destaque.jpg',
    1,
    1,
    1
  ),
  (
    'PAULA TOLLER EM BRASÍLIA',
    'Data: sáb., 23 de set., 20:00\r\n\r\nLocal: Centro de Convenções Ulysses Guimarães SDC - Ulysses Guimarães, Brasília - DF',
    'https://www.alphatickets.com.br/Detalhes.aspx?event=781C9413-D2D1-408D-B6FC-2891F970BC8F&hostname=&dt=20230127154158',
    1,
    '2023-09-23 20:00:00',
    'https://i.scdn.co/image/ab6761610000e5eb8d1e5292976ca29ce33dd4d4',
    1,
    1,
    1
  ),
  (
    'Churrasquinho Menos é Mais em Brasília',
    'Data: dom., 18 de jun., 14:00 – seg., 19 de jun., 03:00\r\n\r\nLocal: Estádio Mané Garrincha Portão 1, SRPN - Asa Norte, Brasília - DF',
    'https://brasilia.deboa.com/brasilia/festa-show/festas-shows-em-brasilia/churrasquinho-menos-e-mais-em-brasilia/',
    1,
    '2023-06-18 14:00:00',
    'https://akamai.sscdn.co/tb/letras-blog/wp-content/uploads/2021/07/60f92cd-Churrasquinho.jpg',
    1,
    1,
    1
  ),
  (
    'RBD TOUR 2023 - BRASÍLIA',
    'Data: seg., 9 de out., 20:00\r\n\r\nLocal: Estádio Mané Garrincha Portão 1, SRPN - Asa Norte, Brasília - DF',
    'https://allevents.in/brasília/claves',
    1,
    '2023-10-09 20:00:00',
    'https://cdn-az.allevents.in/events7/banners/52f0382c288d442c17f5b89559928f3a6f067a2263286257ff1a7849aac9f501-rimg-w960-h503-gmir.jpg?v=1685265805',
    1,
    1,
    1
  ),
  (
    'RED HOT CHILI PEPPERS - BRASÍLIA',
    'Data: ter., 7 de nov., 21:00 – 23:59\r\n\r\nLocal: Estádio Mané Garrincha Portão 1, SRPN - Asa Norte, Brasília - DF',
    '',
    1,
    '2023-11-09 21:00:00',
    'https://brasilia.deboa.com/wp-content/uploads/2023/03/Red-Hot-Chili-Peppers-em-Bras%C3%ADlia_deboa-Brasilia.jpg',
    1,
    1,
    1
  ),
  (
    'Lulu Santos em Brasília',
    'Data:sáb., 19 de ago.\r\n\r\nLocal: Centro de Convenções Ulysses Guimarães SDC - Ulysses Guimarães, Brasília - DF',
    'https://agitabrasilia.com/lulu-santos-em-brasilia/',
    1,
    '2023-08-19 19:00:00',
    'https://brasilia.deboa.com/wp-content/uploads/2023/03/Lulu-Santos-em-Bras%C3%ADlia_deboa-Brasilia.jpg',
    1,
    1,
    1
  );