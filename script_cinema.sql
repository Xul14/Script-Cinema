#Perite exibir todos os databases existentes
show databases;

#Cria um database
create database db_videolocadora_tarde_20231;

#Exclui um database
drop database db_videolocadora_tarde_20231;

#Permite selecionar qual database sera usado
use db_videolocadora_tarde_20231;

#Exibe todas as tabelas do database
show tables;

#TABELA: CLASSIFICAÇÃO
create table tbl_classificacao(
	id int not null auto_increment primary key,
    sigla varchar(2) not null,
    nome varchar(45) not null,
    descricao varchar(100) not null,
    unique index(id)
);

#TABELA: GÊNERO
CREATE TABLE tbl_genero(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    UNIQUE INDEX(id)
);

#TABELA: SEXO
create table tbl_sexo(
	id int not null auto_increment primary key,
    sigla varchar(5) not null,
    nome varchar(45) not null,
    unique index(id)
);

#TABELA: NACIONALIDADE
create table tbl_nacionalidade(
	id int not null auto_increment primary key,
    nome varchar(45) not null,
    unique index(id)
);

#Exibe os dados de uma tabela
desc tbl_nacionalidade;
describe tbl_nacionalidade;

################################################# COMANDOS PARA ALTERAR UMA TABELA ###########################################################

##Add column -> Adiciona uma nova coluna na tabela
alter table tbl_nacionalidade add column descricao varchar(50) not null;

alter table tbl_nacionalidade
	add column teste int,
    add column teste2 varchar(10) not null;

##Drop column -> Exclui uma coluna da tabela
alter table tbl_nacionalidade drop column teste2;

##Modify column -> Altera a estrutura de uma coluna 
alter table tbl_nacionalidade modify column teste varchar(5) not null;

##Change -> Permite alterar a escrita e sua estrutura             
alter table tbl_nacionalidade change teste teste_nacionalidade int not null;

###############################################################################

#Exclui uma tabela 
drop table tbl_filme_genero;

######################## CRIANDO TABELAS COM FK #############################

#TABELA: FILME 
create table tbl_filme(
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_original varchar(100) not null,
    data_lancamento date not null,
    data_relancamento date,
    duracao time not null,
    foto_capa varchar(150) not null,
    sinopse text not null,
    id_classificacao int not null,
    
    ##É atribuido um nome ao processo para criar a FK
    constraint FK_Classificacao_Filme
    
	##É atribuido desta tabela que será a FK
    foreign key (id_classificacao)
    
	##Especifica de onde virá a FK
    references tbl_classificacao (id),
    
    unique index(id)
);

#TABELA: FILME GÊNERO
create table tbl_filme_genero(
	id int not null auto_increment,
    id_filme int not null,
    id_genero int not null,
    
    #Relacionamento de filme para filme genero
    constraint FK_Filme_FilmeGenero
    foreign key (id_filme)
    references tbl_filme(id),
    
    #Relacionamento de genero para filme genero
    constraint FK_Genero_FilmeGenero
    foreign key (id_genero)
    references tbl_genero(id),
    
    primary key(id),
    unique index(id)
);

##Permite excluir uma constraint de uma tabela
alter table tbl_filme_genero drop foreign key FK_Genero_FilmeGenero;

##Cria relação (constraint)e suas relações entre tabelas já existentes
alter table tbl_filme_genero 
	add constraint FK_Genero_FilmeGenero 
	foreign key(id_genero) 
	references tbl_genero(id);


##################################################################################

##TABELA: FILME AVALIAÇÃO    
create table tbl_filme_avaliacao(
	id int not null auto_increment primary key,
    nota float not null,
    comentario varchar(300),
    id_filme int not null,
    
    constraint FK_Filme_FilmeAvaliacao
    foreign key(id_filme)
    references tbl_filme(id),
    
    unique index (id)
);

##TABELA: DIRETOR
create table tbl_diretor(
	id int not null auto_increment primary key,
	nome varchar(100) not null,
    nome_artistico varchar(100),
    data_nascimento date not null,
    biografia text not null,
    foto varchar(150) not null,
    id_sexo int not null,
    
    constraint FK_Sexo_Diretor
    foreign key(id_sexo)
    references tbl_sexo(id),
    
    unique index (id)
);

##TABELA: DIRETOR NACIONALIDADE
create table tbl_diretor_nacionalidade(
	id int not null auto_increment primary key,
    id_diretor int not null,
    id_nacionalidade int not null,
    
    constraint FK_Diretor_DiretorNacionalidade
    foreign key(id_diretor)
    references tbl_diretor(id),
    
     constraint FK_Nacionalidade_DiretorNacionalidade
    foreign key(id_nacionalidade)
    references tbl_nacionalidade(id),
    
    unique index (id)
);

##TABELA: ATOR
create table tbl_ator(
	id int not null auto_increment primary key,
    nome varchar(100) not null,
	nome_artistico varchar(100),
    data_nascimento date not null,
    data_falecimento date,
    biografia text not null,
    foto varchar(150) not null,
    id_sexo int not null,
    
    constraint FK_Sexo_Ator
    foreign key(id_sexo)
    references tbl_sexo(id),
    
    unique index (id)
);

##TABELA: ATOR NACIONALIDADE
create table tbl_ator_nacionalidade(
	id int not null auto_increment primary key,
    id_ator int not null,
    id_nacionalidade int not null,
    
    constraint FK_Ator_AtorNacionalidade
    foreign key(id_ator)
    references tbl_ator(id),
    
     constraint FK_Nacionalidade_AtorNacionalidade
    foreign key(id_nacionalidade)
    references tbl_nacionalidade(id),
    
    unique index (id)
);

##TABELA: FILME DIRETOR
create table tbl_filme_diretor(
	id int not null auto_increment primary key,
    id_filme int not null,
    id_diretor int not null,
    
    constraint FK_Filme_FilmeDiretor
    foreign key(id_filme)
    references tbl_filme(id),
    
     constraint FK_Diretor_FilmeDiretor
    foreign key(id_diretor)
    references tbl_diretor(id),
    
    unique index (id)
);

##TABELA: FILME ATOR
create table tbl_filme_ator(
	id int not null auto_increment primary key,
    id_filme int not null,
    id_ator int not null,
    
    constraint FK_Filme_FilmeAtor
    foreign key(id_filme)
    references tbl_filme(id),
    
     constraint FK_Diretor_FilmeAtor
    foreign key(id_ator)
    references tbl_ator(id),
    
    unique index (id)
);

########################## INSERTS ##############################

##TABELA GÊNERO
insert into tbl_genero (nome) values ('Policial');
insert into tbl_genero (nome) values ('Drama');
insert into tbl_genero (nome) values ('Comédia');
insert into tbl_genero (nome) values ('Ação');
insert into tbl_genero (nome) values ('Fantasia'), ('Suspense');

#Insert com multiplos valores
insert into tbl_genero (nome) values ('Aventura'),
									 ('Romance'),
                                     ('Animação'),
                                     ('Musical');
                                     
select * from tbl_classificacao;
select * from tbl_genero;
                                     
##UPDATE
update tbl_genero set nome = 'Musical' where id = 8;

insert into tbl_classificacao (sigla, nome, descricao) values ('L', 'Livre', 'Não expõe crianças a conteúdos potencialmente prejudiciais');
insert into tbl_classificacao (sigla, nome, descricao) values ('10', 'Exibição em qualquer horário', 'Conteúdo violento ou linguagem inapropriada para crianças, ainda que em menor intensidade'),
															  ('12', 'Não recomendado para menore de 12 anos', 'As cenas podem conter agressão física, consumo de drogas e insinuação sexual'),
															  ('14', 'Não recomendado para menore de 14 anos', 'Conteúdo mais acentuado com violência e ou linguagem sexual'),
															  ('16', 'Não recomendado para menore de 16 anos', 'Conteúdos de sexo ou violência mais intensos, com cenas de tortura, suicídio, estupro ou nudez total'),
															  ('18', 'Não recomendado para menore de 18 anos', 'Conteúdos violentos e sexuais extremos com cenas de sexo, incesto, multilação ou abuso sexual');

##INSERT TABEL A FILME
insert into tbl_filme (
		 nome,
		 nome_original,
		 data_lancamento,
		 data_relancamento,
		 duracao, 
		 foto_capa,
	 	 sinopse,
		 id_classificacao
		)values(
		  'O Poderoso Chefão',
	      'The Godfather',
		  '1972-03-24', 
		  '2022-02-04', 
		  '02:55:00', 
		  'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/90/93/20/20120876.jpg',
		  'Don Vito Corleone (Marlon Brando) é o chefe de uma "família" de Nova York que está feliz, pois Connie (Talia Shire), sua filha, se casou com Carlo (Gianni Russo). Porém, durante a festa, Bonasera (Salvatore Corsitto) é visto no escritório de Don Corleone pedindo "justiça", vingança na verdade contra membros de uma quadrilha, que espancaram barbaramente sua filha por ela ter se recusado a fazer sexo para preservar a honra. Vito discute, mas os argumentos de Bonasera o sensibilizam e ele promete que os homens, que maltrataram a filha de Bonasera não serão mortos, pois ela também não foi, mas serão severamente castigados. Vito porém deixa claro que ele pode chamar Bonasera algum dia para devolver o "favor". Do lado de fora, no meio da festa, está o terceiro filho de Vito, Michael (Al Pacino), um capitão da marinha muito decorado que há pouco voltou da 2ª Guerra Mundial. Universitário educado, sensível e perceptivo, ele quase não é notado pela maioria dos presentes, com exceção de uma namorada da faculdade, Kay Adams (Diane Keaton), que não tem descendência italiana mas que ele ama. Em contrapartida há alguém que é bem notado, Johnny Fontane (Al Martino), um cantor de baladas românticas que provoca gritos entre as jovens que beiram a histeria. Don Corleone já o tinha ajudado, quando Johnny ainda estava em começo de carreira e estava preso por um contrato com o líder de uma grande banda, mas a carreira de Johnny deslanchou e ele queria fazer uma carreira solo. Por ser seu padrinho Vito foi procurar o líder da banda e ofereceu 10 mil dólares para deixar Johnny sair, mas teve o pedido recusado. Assim, no dia seguinte Vito voltou acompanhado por Luca Brasi (Lenny Montana), um capanga, e após uma hora ele assinou a liberação por apenas mil dólares, mas havia um detalhe: nas "negociações" Luca colocou uma arma na cabeça do líder da banda. Agora, no meio da alegria da festa, Johnny quer falar algo sério com Vito, pois precisa conseguir o principal papel em um filme para levantar sua carreira, mas o chefe do estúdio, Jack Woltz (John Marley), nem pensa em contratá-lo. Nervoso, Johnny começa a chorar e Vito, irritado, o esbofeteia, mas promete que ele conseguirá o almejado papel. Enquanto a festa continua acontecendo, Don Corleone comunica a Tom Hagen (Robert Duvall), seu filho adotivo que atua como conselheiro, que Carlo terá um emprego mas nada muito importante, e que os "negócios" não devem ser discutidos na sua frente. Os verdadeiros problemas começam para Vito quando Sollozzo (Al Lettieri), um gângster que tem apoio de uma família rival, encabeçada por Phillip Tattaglia (Victor Rendina) e seu filho Bruno (Tony Giorgio). Sollozzo, em uma reunião com Vito, Sonny e outros, conta para a família que ele pretende estabelecer um grande esquema de vendas de narcóticos em Nova York, mas exige permissão e proteção política de Vito para agir. Don Corleone odeia esta idéia, pois está satisfeito em operar com jogo, mulheres e proteção, mas isto será apenas a ponta do iceberg de uma mortal luta entre as "famílias".',
		   9
	);

select * from tbl_filme;
select * from tbl_classificacao;

################################################# RELAÇÃO ################################################

## RELAÇÃO ENTRE FILME E GÊNERO
insert into tbl_filme_genero (id_filme, id_genero) values (1, 2), (1, 3);

select * from tbl_filme_genero;

########################### INSERINDO DADOS ###########################################

##Forest Gump
insert into tbl_filme (
		 nome,
		 nome_original,
		 data_lancamento,
		 data_relancamento,
		 duracao, 
		 foto_capa,
	 	 sinopse,
		 id_classificacao
		)values(
          'FORREST GUMP - O CONTADOR DE HISTÓRIAS',
          'Forrest Gump',
          '1994-12-07',
          null,
          '2:20:00',
          'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/30/21/19874092.jpg',
          'Quarenta anos da história dos Estados Unidos, vistos pelos olhos de Forrest Gump (Tom Hanks), um rapaz com QI abaixo da média e boas intenções. Por obra do acaso, ele consegue participar de momentos cruciais, como a Guerra do Vietnã e Watergate, mas continua pensando no seu amor de infância, Jenny Curran.',
           9
        );
	
##Rei Leão
insert into tbl_filme (
		 nome,
		 nome_original,
		 data_lancamento,
		 data_relancamento,
		 duracao, 
		 foto_capa,
	 	 sinopse,
		 id_classificacao
		)values(
        'O REI LEÃO',
        'The Lion King',
        '1994-07-08',
        '2011-08-26',
        '1:29:00',
        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/84/28/19962110.jpg',
        'Clássico da Disney, a animação acompanha Mufasa (voz de James Earl Jones), o Rei Leão, e a rainha Sarabi (voz de Madge Sinclair), apresentando ao reino o herdeiro do trono, Simba (voz de Matthew Broderick). O recém-nascido recebe a bênção do sábio babuíno Rafiki (voz de Robert Guillaume), mas ao crescer é envolvido nas artimanhas de seu tio Scar (voz de Jeremy Irons), o invejoso e maquiavélico irmão de Mufasa, que planeja livrar-se do sobrinho e herdar o trono.',
        7
        );

## Á espera de um milagre
insert into tbl_filme (
		 nome,
		 nome_original,
		 data_lancamento,
		 data_relancamento,
		 duracao, 
		 foto_capa,
	 	 sinopse,
		 id_classificacao
		)values(
        'À ESPERA DE UM MILAGRE',
        'The Green Mile',
        '2000-03-10',
        null,
        '3:09:00',
        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/91/66/66/20156966.jpg',
        '1935, no corredor da morte de uma prisão sulista. Paul Edgecomb (Tom Hanks) é o chefe de guarda da prisão, que temJohn Coffey (Michael Clarke Duncan) como um de seus prisioneiros. Aos poucos, desenvolve-se entre eles uma relação incomum, baseada na descoberta de que o prisioneiro possui um dom mágico que é, ao mesmo tempo, misterioso e milagroso.',
        9
        );
        
 ##Batman       
insert into tbl_filme (
		 nome,
		 nome_original,
		 data_lancamento,
		 data_relancamento,
		 duracao, 
		 foto_capa,
	 	 sinopse,
		 id_classificacao
		)values(
        'BATMAN - O CAVALEIRO DAS TREVAS',
        'The Dark Knight',
        '2008-07-18',
        null,
        '2:32:00',
        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/86/98/32/19870786.jpg',
        'Após dois anos desde o surgimento do Batman (Christian Bale), os criminosos de Gotham City têm muito o que temer. Com a ajuda do tenente James Gordon (Gary Oldman) e do promotor público Harvey Dent (Aaron Eckhart), Batman luta contra o crime organizado. Acuados com o combate, os chefes do crime aceitam a proposta feita pelo Coringa (Heath Ledger) e o contratam para combater o Homem-Morcego.',
        8
        );
    
    ##Vingadores
        insert into tbl_filme (
		 nome,
		 nome_original,
		 data_lancamento,
		 data_relancamento,
		 duracao, 
		 foto_capa,
	 	 sinopse,
		 id_classificacao
		)values(
        'VINGADORES: ULTIMATO',
        'Avengers: Endgame',
        '2019-04-25',
        '2019-07-11',
        '3:01:00',
        'https://br.web.img2.acsta.net/c_310_420/pictures/19/04/26/17/30/2428965.jpg',
        'Em Vingadores: Ultimato, após Thanos eliminar metade das criaturas vivas em Vingadores: Guerra Infinita, os heróis precisam lidar com a dor da perda de amigos e seus entes queridos. Com Tony Stark (Robert Downey Jr.) vagando perdido no espaço sem água nem comida, o Capitão América/Steve Rogers (Chris Evans) e a Viúva Negra/Natasha Romanov (Scarlett Johansson) precisam liderar a resistência contra o titã louco.',
        8
        );

################# Insert ator e sexo #############

insert into tbl_sexo (sigla, nome) values ('F', 'Feminino'), ('M', 'Masculino');

insert into tbl_filme_genero (id_filme, id_genero) values (2, 6), (2, 3), (2,1);
insert into tbl_filme_genero (id_filme, id_genero) values (3, 5), (3, 7), (3,8);
insert into tbl_filme_genero (id_filme, id_genero) values (4, 9), (4, 2);
insert into tbl_filme_genero (id_filme, id_genero) values (5, 4), (5, 10);
insert into tbl_filme_genero (id_filme, id_genero) values (6, 4), (6, 5), (6, 9);

select * from tbl_filme_genero;

###################### ATORRRRR #####################
 insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Marlon Brando',
         null,
        '1924-04-01',
        '2004-07-01',
        '- Trabalhou como ascensorista de elevador em uma loja por 4 dias, antes de se tornar famoso.Possui uma ilha particular no oceano Pacífico, na Polinésia, desde 1966.O Oscar que ganhou por "Sindicato dos Ladrões" foi roubado de sua casa, com o ator tendo solicitado à Academia de Artes e Ciências Cinematográficas a reposição da estatueta, em 1970.Recusou o Oscar recebido por "O Poderoso Chefão", em protesto pelo modo como os Estados Unidos e, especialmente, Hollywood vinham discriminando os índios nativos do país. Brando não compareceu à cerimônia de entrega do Oscar e enviou em seu lugar a atriz Sacheen Littlefeather, que subiu ao palco para receber a estatueta do ator como se fosse uma índia verdadeira, divulgando seu protesto.Em determinado momento das filmagens de "A Cartada Final", se recusava a estar no mesmo set que o diretor Frank Oz.Possui uma estrela na Calçada da Fama, localizada em 1777 Vine Street.',
         'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/51/54/20040663.jpg',
         2
        );
        
 insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Alfredo James Pacino',
		'Al Pacino',
        '1940-04-25',
        null,
        ' É um grande fã de ópera;- É um dos poucos astros de Hollywood que nunca casou;- Foi preso em janeiro de 1961, acusado de carregar consigo uma arma escondida;- Recusou o personagem Han Solo, da trilogia original de "Star Wars";- Foi o primeiro na história do Oscar a ser indicado no mesmo ano nas categorias de melhor ator e melhor ator coadjuvante.',
         'https://br.web.img3.acsta.net/c_310_420/pictures/19/03/19/18/33/1337912.jpg',
         2
        );

 insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'James Edmund Caan',
		'James Caan',
        '1940-03-26',
        '2022-07-06',
        ' James Caan foi um ator americano, mais conhecido por seu papel Sonny Corleone no clássico O Poderoso Chefão, dirigido por Francis Coppola. Em vida, Caan recebeu diversos prêmios, incluindo quatro indicações ao Golden Globes, uma ao Emmy e uma ao Oscar. Além disso, em 1978 Caan ganhou uma estrela na calçada da fama de Hollywood. Caan nasceu no Bronx, em Nova York e cresceu no Queens. O ator estudou na Universidade de Michigan e se transferiu para a Hempstead, sem colar grau, mas entre seus colegas de turma estavam Coppola e a atriz Lainie Kazan. Durante este tempo, Caan se interessou pela atuação e foi aceito na escola de teatro Neighborhood Playhouse, onde estudou por cinco anos.  Seus primeiros trabalhos foram em El Dorado, Countdown e Caminhos Mal Traçados, até participar de O Poderoso Chefão com o personagem que se tornaria sua assinatura',
         'https://br.web.img3.acsta.net/c_310_420/pictures/15/06/09/21/29/576102.jpg',
         2
        );
  
  ###### Atores Forest
insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Thomas Jeffrey Hanks',
		'Tom Hanks',
        '1956-07-09',
         null,
        ' Tom Hanks iniciou a carreira no cinema aos 24 anos, com um papel no filme de baixo orçamento Trilha de Corpos. Logo migrou para a TV, onde estrelou por dois anos a série Bosom Buddies. Nela passou a trabalhar com comédia, algo com o qual não estava habituado, rendendo convites para pequenas participações nas séries Táxi, Caras & Caretas e Happy Days.Em 1984, veio seu primeiro sucesso no cinema: a comédia Splash - Uma Sereia em Minha Vida, na qual era dirigido por Ron Howard e contracenava com Daryl Hannah. Em seguida vieram várias comédias, entre elas A Última Festa de Solteiro (1984), Um Dia a Casa Cai (1986) e Dragnet - Desafiando o Perigo (1987), tornando-o conhecido do grande público.Com Quero Ser Grande (1988) Hanks obteve sua primeira indicação ao Oscar de melhor ator. Apesar de consagrado como comediante, aos poucos passou a experimentar outros gêneros.',
         'https://br.web.img3.acsta.net/c_310_420/pictures/18/08/08/18/47/1167635.jpg',
         2
        );
        
insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Gary Alan Sinise',
		'Gary Sinise',
        '1955-03-17',
         null,
        'Gary Alan Sinise é um ator norte-americano, diretor de cinema e músico. Durante sua carreira, ganhou vários prêmios, incluindo um Emmy e um Globo de Ouro, além de ser nomeado para um Oscar. Também é conhecido por estrelar como o detetive Mac Taylor na série CSI: New York',
         'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/92/45/36/20200745.jpg',
         2
        );
        
insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Robin Virginia Gayle Wrigh',
		' Robin Wright',
        '1966-04-08',
         null,
        'Robin Wright nasceu em Dallas, Texas, filha de Gayle Gaston, uma vendedora de cosméticos, e Freddie Wright, funcionário de uma empresa farmacêutica. A atriz ficou famosa por seus papeis em House of Cards, Mulher-Maravilha, Corpo Fechado e Forrest Gump - O Contador de Histórias.Wright foi criada em San Diego, Califórnia. Quando jovem, frequentou a La Jolla High School, em La Jolla, e a Taft High School em Woodland Hills, em Los Angeles.A atriz começou sua carreira como modelo quando tinha 14 anos. Aos 18, interpretou Kelly Capwell na novela Santa Barbara (1984), da NBC Daytime, recebendo diversas indicações ao Daytime Emmy e voltando os olhos do público para seu trabalho.Das telas da TV para o cinema, Wright conseguiu um papel em Hollywood Vice Squad (1986) e protagonizou uma princesa em A Princesa Prometida, em 1987.',
         'https://br.web.img3.acsta.net/c_310_420/pictures/19/11/05/01/50/2018682.jpg',
         1
        );


######### Rei leão
insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Matthew Broderick',
		'Matthew Broderick',
        '1962-03-21',
         null,
        'Broderick nasceu em Nova York, filho de Patricia Biow, uma dramaturga, atriz e pintora, e de James Joseph Broderick, um ator.[1][2] A mãe de Broderick era judia e seu pai, um católico de ascedência irlandesa.[3][4][5] Broderick frequentou a escola primária City & Country School e cursou o ensino médio na Walden School. Depois da morte de sua mãe, suas pinturas foram exibidas na Tibor de Nagy Gallery em Nova York.',
         'https://br.web.img2.acsta.net/c_310_420/pictures/19/07/02/22/47/0236519.jpg',
         2
        );
        
insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Todd Jones',
		'James Earl Jones',
        '1931-01-17',
         null,
        'Do signo de Capricórnio;- Possui descendência africana, indígena e irlandesa;- Foi criado pelos avós maternos. Seus pais, Ruth Connolly and Robert Earl Jones, se separaram pouco antes de seu nascimento;- Começou a ter aulas de atuação para curar sua gagueira;- Também para melhorar sua dicção, começou a escrever poesias e contava com o apoio dos professores, que permitiam que ele as lesse em sala de aula;- É um veterano do exército dos Estados Unidos;- É membro da NRA (Associação Nacional de Rifles da América);- Foi casado com a atriz Julienne Marie, de quem se separou em 1972. Se casou novamente dez anos depois, em 82, com Cecilia Hart, com quem teve um filho;- Foi o primeiro afro-descendente a interpretar o presidente dos EUA. Foi no telefilme The Man, de 1972;- Conhecido por sua voz marcante, tendo conquistado notoriedade por dublar Darth Vader em Star Wars e Mufasa.',
         'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/55/34/20040970.jpg',
         2
        );

##### Espera de um milagre atores
insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Michael Clarke Duncan',
		'Michale Duncan',
        '1957-12-10',
         '2012-09-03',
        'Michael Clarke Duncan é conhecido pela atuação em À Espera de um Milagre, que lhe rendeu indicações ao Oscar e ao Globo de Ouro de Melhor Ator Coadjuvante. Fez sua estreia nos cinemas em 1995, com um papel não creditado em Sexta-Feira em Apuros. O primeiro trabalho de destaque viria três anos depois com Armageddon. Agradou tanto que Bruce Willis recomendou que Frank Darabont contratasse ele para À Espera de um Milagre, em 1999.Muitas vezes tratado como Big Mike, por causa da altura de 1,96 m, o ator se destacou ainda em Meu Vizinho Mafioso, Planeta dos Macacos, O Escorpião Rei e A Ilha. Participou também de três adaptações dos quadrinhos: O Demolidor, Sin City - A Cidade do Pecado e Lanterna Verde. Robert Rodriguez contava com o retorno dele para Sin City 2: A Dame to Kill For, algo que infelizmente não irá mais acontecer.Na TV, Clarke Duncan contou com participações em importantes seriados, como Um Maluco no Pedaço, Bones, Chuck e Two and a Half Men. Faleceu em setembro de 2012, aos 54 anos, após passar dois meses hospitalizado em Los Angeles..',
         'https://br.web.img3.acsta.net/c_310_420/pictures/14/09/06/19/41/147683.jpg',
         2
        );

insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'David Bowditch Morse',
		'David Morse',
        '1953-10-11',
         null,
        'David Bowditch Morse [1] [2] (nascido em 11 de outubro de 1953) é um ator americano. Ele chamou a atenção nacional pela primeira vez como Dr. Jack "Boomer" Morrison na série de drama médico St. Elsewhere (1982–88). Sua carreira no cinema incluiu papéis em The Negotiator , Contact , The Green Mile , Dancer in the Dark , Disturbia , The Long Kiss Goodnight , The Rock e 12 Monkeys.Em 2006, Morse teve um papel recorrente como o detetive Michael Tritter na série de drama médico House , pela qual recebeu uma indicação ao Emmy . Ele interpretou George Washington na minissérie da HBO de 2008, John Adams , que lhe rendeu uma segunda indicação ao Emmy. Ele foi aclamado por sua interpretação do tio Peck na peça off-Broadway How I Learned to Drive , ganhando um Drama Desk Award e um Obie Award . Ele teve sucesso na Broadway, retratando James "Sharky" Harkin em The Seafarer. De 2010 a 2013, ele interpretou Terry Colson, um policial honesto em um departamento de polícia corrupto de Nova Orleans , na série da HBO Treme . Morse apareceu na série Outsiders da WGN America (2016–17), na minissérie Showtime Escape at Dannemora (2018) e na série dramática de comédia da Netflix The Chair (2021).',
         'https://br.web.img2.acsta.net/c_310_420/pictures/15/02/25/18/50/212119.jpg',
         2
        );
        
########## Atores Batman
insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Christian Charles Philip Bale',
		'Christian Bale',
        '1974-01-30',
         null,
        'Caçula de três irmãs mais velhas, filho de um piloto de aviação comercial e de uma dançarina de circo, Bale começou a atuar por influência de uma delas. Pouca gente recorda que este ator inglês é o menino Jim, que tocou corações em Império do Sol (1987), de Steven Spielberg. Para ganhar o papel, derrotou cerca de quatro mil candidatos e sua atuação ainda rendeu prêmios.Mesmo tendo começado cedo (aos 9 anos fez seu primeiro comercial de cereais), foi somente com Psicopata Americano (2000) que ganhou mais notoriedade no papel de Patrick Bateman, que seria, incialmente, de Leonardo DiCaprio.Sua dedicação ao trabalho é reconhecida e sua "entrega" para viver Trevor em O Operário (2004), quando emagreceu cerca de 30 kg, foi considerada chocante demais.',
         'https://br.web.img3.acsta.net/c_310_420/pictures/15/02/24/18/43/126776.jpg',
         2
        );
        
	insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        ' Heathcliff Andrew Ledger',
		'Heath Ledger',
        '1979-04-04',
         '2008-01-22',
        'Extremamente tímido, este australiano descendente de irlandeses e escoceses optou por atuar desde cedo. Mesmo com a rápida fama conquistada, em parte por sua beleza, ele procurou interpretar papéis que não explorassem este aspecto e conseguiu atuações marcantes em sua curta carreira. Premiado após sua morte pela atuação como Coringa, Ledger tem seu lugar marcado para sempre na história do cinema mundial. (RC)- Filho de Sally Ramshaw e Kim Ledger;- Descendente de irlandeses e escoceses;- Teve três irmãs: Catherine (Kate) Ledger, Olivia Ledger e Ashleigh Bell;- Seu nome e o da irmã mais velha, Kate Ledger, foram retirados dos personagens principais do romance "Wuthering Heights" de Emily Brontë;- Teve um canguru de esimação, achado por sua mãe quando ainda era filhote;- Na escola, era concentrado em atuar e nos esportes.',
         'https://br.web.img2.acsta.net/c_310_420/pictures/18/08/16/19/43/2593099.jpg',
         2
        );
        
	insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Aaron Edward Eckhart',
		'Aaron Eckhart',
        '1968-03-12',
         null,
        'Eckhart nasceu em Cupertino, Califórnia, filho de Mary Martha Eckhart (nascida Lawrence), uma poetisa e autora de livros infantis, e James Conrad Eckhart, um executivo da área de informática.[2] É o mais novo de três irmãos.[3][4] Foi criado como membro da Igreja de Jesus Cristo dos Santos dos Últimos Dias (popularmente conhecida como Igreja Mórmon), e serviu como missionário da igreja na França e na Suíça.A família de Eckhart se mudou em 1981 para a Inglaterra,[2][7] devido à profissão de seu pai.[8] A família morou em Surrey, no sudeste do país, primeiro na cidade de Walton-on-Thames,[9] e posteriormente em Cobham.[8] Enquanto vivia na Inglaterra, Eckhart frequentou a American Community School, conhecida atualmente como ACS International Schools,[8] onde teve seu primeiro contato com a atuação, estrelando uma produção escolar no papel de Charlie Brown.[10][11] Em 1985 mudou-se para Sydney, Austrália, onde frequentou a American International School of Sydney em seu último ano no ensino médio; lá, desenvolveu ainda mais suas habilidades como ator em peças como Esperando Godot, embora admita que tenha sido uma produção "terrível".[12] Durante a primavera de sua temporada escolar,[3] no entanto, Eckhart abandonou os estudos para trabalhar no cinema de um shopping center local.[13][14] Acabou por obter seu diploma através de um curso de educação para adultos.[15] Isto deu a Eckhart tempo para aproveitar um ano esquiando e surfando no Havaí e na costa da França.[2][16] Em 1988, Eckhart retornou aos Estados Unidos e se inscreveu num curso de graduação em cinema na Universidade Brigham Young do Havaí,[17] porém posteriormente transferiu-se para a Universidade Brigham Young em Provo, Utah.[2] Formou-se em 1994 com um diploma de Bachelor of Fine Arts[',
         'https://br.web.img2.acsta.net/c_310_420/pictures/16/01/28/10/38/041658.jpg',
         2
        );
        
######## Atores de Vingadores
	insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Robert John Downey Jr',
		'Robert John Downey Jr',
        '1965-04-04',
         null,
        'Do céu ao inferno e ao céu novamente. Se alguém pensou no mito do pássaro fênix que renasce das cinzas, até que a comparação poderia se encaixar para definir este brilhante ator que já deu vida para personagens tão distantes em tempo e estilo, como Charles Chaplin (Chaplin - 1992) e Tony Stark (Homem de Ferro - 2008).Na ativa por mais de quatro décadas e dono de uma voz grave, afinada, Downey já dublou desenho animado (God, the Devil and Bob - 2000), se aventurou no mundo da música, em 2004, com o disco The Futurist (Sony) e fez bonito na televisão, onde faturou o Globo de Ouro, além de outros prêmios e indicações por Larry Paul, personagem do seriado Ally McBeal (2000 - 2002). Mas é no cinema que sua estrela parece brilhar mais intensamente. Tendo estreado aos cinco anos de idade, em 1970, dirigido pelo pai em Pound ',
         'https://br.web.img3.acsta.net/c_310_420/pictures/18/06/29/00/35/0101925.jpg',
         2
        );

	insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        ' Christopher Robert Evans',
		' Chris Evans',
        '1981-06-13',
         null,
        'Depois de uma infância e estudos ​​em Boston, Chris Evans decidiu ir para Nova York para tentar a sorte na comédia. Ele rapidamente consegue entrar na profissão, principalmente participando em séries de televisão (Boston Public). Sua carreira no cinema começou em 2001, em uma comédia para adolescentes (Não é Mais um Besteirol Americano). Mas sem ficar preso a apenas um gênero de filme, o ator vai para outras produções: trapaceia nas provas com Scarlett Johansson na comédia policial Nota Máxima (2004), interpreta o papel de Kim Basinger no thriller Celular - Um Grito de Socorro (2004) e seduz Jessica Biel em London (2005).O destino de Chris Evans como o conhecemos hoje começou em 2005, quando ele conseguiu seu primeiro papel como super-herói. Em Quarteto Fantástico, um sucesso de bilheteria adaptado dos quadrinhos da Marvel.',
         'https://br.web.img3.acsta.net/c_310_420/pictures/19/04/22/19/59/2129500.jpg',
         2
        );
        
	insert into tbl_ator (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 data_falecimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Mark Alan Ruffalo',
		'Mark Ruffalo',
        '1967-11-22',
         null,
        'Apesar de ter um pequeno papel em Ride With The Devil (1999), a primeira participação de destaque de Mark Ruffalo no cinema vem com o premiado drama Conte Comigo (2000). Ele conquista papéis importantes no thriller erótico Em Carne Viva (2003) e no drama Brilho Eterno de uma Mente Sem Lembranças (2004), antes de se lançar em comédias românticas como De Repente 30 (2004) e Dizem Por Aí... (2005). Ele retoma os dramas e suspenses com Zodíaco (2007) e Ensaio Sobre a Cegueira (2008). Em 2010, Martin Scorsese convida-o a atuar em Ilha do Medo, ao lado de Leonardo DiCaprio. Ele recebe sua primeira indicação ao Oscar como ator coadjuvante no drama Minhas Mães e Meu Pai (2010). Um grande passo para o reconhecimento popular vem com o papel de Hulk no grande sucesso Os Vingadores - The Avengers (2012), abrindo a porta para novas produções no papel do monstro gigantesco.',
         'https://br.web.img3.acsta.net/c_310_420/pictures/19/04/22/20/02/3083743.jpg',
         2
        );

############################################# DIRETORES #################################################

######## Diretor Poderoso chefão
	insert into tbl_diretor (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Francis Ford Coppola',
		'Ford Coppola',
        '1939-04-07',
        '- Em 1969, fundou juntamente com George Lucas a produtora American Zoetrope, em São Francisco, tendo como primeiro projeto o filme THX 1138 (1970);- É tio do ator Nicolas Cage;- Pai da tambem diretora Sofia Coppola;- Foi assistente de direção de Roger Corman;- Graduado na Universidade da Califórnia (UCLA), a mesma dos diretores, George Lucas e Steven Spielberg.',
         'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/35/21/99/19187501.jpg',
         2
        );
        
	insert into tbl_diretor (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Robert Lee Zemeckis',
		'Robert Zemeckis',
        '1952-05-14',
        ' Especialista em efeitos especiais, Robert Zemeckis é um dos partidários dos filmes do também diretor Steven Spielberg, que já produziu vários de seus filmes; - Trabalhando geralmente com seu parceiro de roteiros Bob Gale, os primeiros filmes de Robert apresentou ao público seu talento para comédias tipo pastelão, como Tudo por uma Esmeralda (1984); 1941 - Uma Guerra Muito Louca (1979) e, acrescentando efeitos muito especiais em Uma Cilada para Roger Rabbit (1988) e De Volta para o Futuro (1985); - Apesar destes filmes terem sidos feitos meramente para o puro entretenimento, com raros desenvolvimentos dos personagens ou mesmo com uma trama cuidadosa, eles são diversão na certa; - Seus filmes posteriores no entanto, se tornaram mais sérios e reflexivos, como o enormemente bem sucedido filme estrelado por Tom Hanks Forrest Gump (1994)',
         'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/57/81/20030814.jpg',
         2
        );

##Rei leão
	insert into tbl_diretor (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Roger Allers',
		'Roger Allers',
        '1949-06-29',
        'Nascido em Rye, Nova York, mas criado em Scottsdale, Arizona, Allers se tornou um fã de animação aos cinco anos de idade, depois de ver Peter Pan da Disney. Decidir o que ele queria buscar uma carreira na Disney e até mesmo trabalhar ao lado de Walt Disney, alguns anos mais tarde, ele foi enviado para a Disneylândia para um  kit de animação.[1] No entanto, Allers, até então um estudante do ensino médio, cresceu desanimado sobre a realização de seu sonho quando ele soube da morte de Walt Disney, em 1966.[2]Apesar de não ter a oportunidade de conhecer Walt, Allers ainda conseguiu uma graduação em Artes pela Universidade do Estado do Arizona. Mas quando ele se matriculou em uma aula na Universidade de Harvard, percebeu que seu interesse em animação foi revitalizado. Depois de receber seu diploma em Artes plásticas, ele passou os próximos dois anos viajando e vivendo na Grécia.[1] Enquanto estava lá, ele passou algum tempo vivendo em uma caverna, e, eventualmente, encontrou Leslee, quem mais tarde se casou.[3] Allers aceitou um emprego na Flynn Studios, onde ele trabalhou como animador de projetos como A Rua Sésamo, The Electric Company, Make a Wish, e vários outros comerciais.Em 1978, ele se mudou para Los Angeles com Steven Flynn para trabalhar em um filme intitulado Animalympics , que ele escreveu a história, design de personagens e animação para o filme. Três anos mais tarde, Allers serviu como membro da equipe de storyboard de Tron, que foi o primeiro filme do qual ele trabalhou. Em 1980, Allers e sua família mudou-se para Toronto, Canadá, onde trabalhou por Nelvana Estúdios como animador em um recurso intitulado Rock & Rule. Após um breve retorno a Los Angeles, Allers fez desde design de personagens, animação preliminar e desenvolvimento da história para animação japonesa, Little Nemo: Adventures in Slumberland. Nos próximos dois anos, ele residiu em Tóquio para servir como um diretor de animação e supervisionar os artistas japoneses.Voltando para Los Angeles em 1985, ele soube que a Disney estava procurando por um artista de storyboard para trabalhar em Oliver & Company. Quando ele se candidatou para o trabalho, Allers foi convidado a desenhar alguns exemplos como experiência, e trabalhou em portfólio e foi contratado logo em seguida.[1] Desde então, ele atuou como um artista de storyboard em A Pequena Sereia, The Prince and the Pauper, e The Rescuers Down Under antes que ele foi nomeado Chefe de História em Beauty and the Beast. Quando seu trabalho em Beauty foi concluído, Allers tornou-se artista de storyboard durante a re-escrita de Aladdin.[1]',
         'https://br.web.img3.acsta.net/r_512_288/medias/nmedia/18/91/54/06/20150846.jpg',
         2
        );
        
	insert into tbl_diretor (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Robert Ralph Minkoff',
		'Rob Minkoff',
        '1962-08-11',
        'Minkoff nasceu em Palo Alto, Califórnia. Ele estudou na Palo Alto (High School e graduou-se na California Institute of the Arts, no início da década de 1980, no Departamento de Personagens de Animação. Enquanto ele estava na CalArts, ele foi contratado pela Walt Disney Animation Studios, em 1983, como um artista para The Black Cauldron (1985). Ele foi, então, supervisor de animação para The Great Mouse Detective (1986), antes de ser um designer de personagens para The Brave Little Toaster (1987). Ele também escreveu a canção Good Company de Oliver & Company (1988), antes de se tornar um animador de personagens para A Pequena Sereia (1989). Em seguida, ele se tornou um diretor para os dois curtas de Roger Rabbit chamados Tummy Trouble (1989) e a Roller Coaster Rabbit (1990) e foi parte da equipe de desenvolvimento do roteiro de Beauty and the Beast (1991). Ele também dirigiu um curta de Mickey Mouse, que foi exibido no Disney-MGM Studios chamado Mickeys Audition (1992).',
         'https://br.web.img2.acsta.net/c_310_420/medias/nmedia/18/91/54/07/20150847.jpg',
         2
        );
        
	insert into tbl_diretor (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Ferenc Árpád Darabont',
		'Ardeth Bey',
        '1959-01-28',
        'Frank Darabont (Montbéliard, 28 de janeiro de 1959) é um cineasta, roteirista e produtor de cinema francês radicado nos Estados Unidos.Fez várias adaptações dos livros de Stephen King.',
         'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/90/95/95/20122149.jpg',
         2
        );
        
insert into tbl_diretor (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Christopher Edward Nolan',
		'Ardeth Bey',
        '1970-07-30',
        'Com apenas sete anos de idade, Christopher Nolan já se arriscava por trás das câmeras. Utilizando-se da câmera Super 8 do pai, ele realizou vários pequenos filmes estrelados por seus brinquedos. A vontade de dirigir não passou e ele acabou se tornando um importante realizador.Formou-se em literatura na Universidade de Londres, na mesma época em que começou a realizar filmes em 16mm. Seu curta "Larceny" foi exibido no Festival de Cinema de Cambridge em 1996.Nolan estreou na direção com Following (1998), mas foi Amnésia (2000) que chamou a atenção da grande público, abrindo seu caminho para o sucesso em Hollywood. Na sequência, comandou Al Pacino, Robin Williams e Hilary Swank em Insônia (2002).Em 2005, dirigiu o filme que mudou para sempre sua história: Batman Begins. Ele investiu em um Homem-Morcego mais sombrio e realista',
         'https://br.web.img3.acsta.net/c_310_420/pictures/15/02/26/15/33/118611.jpg',
         2
        );
        
insert into tbl_diretor (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Joseph Vincent Russo',
		'Joe Russo',
        '1971-07-08',
        'Joseph Vincent Russo nasceu na cidade de Cleveland, nos EUA. Começou sua carreira como diretor de videoclipes, sempre ao lado do irmão Anthony Russo. Ambos se graduaram em cinema na Universidade de Iowa. Ao lado de Anthony, estreou como realizador de longas em L.A.X.',
         'https://br.web.img2.acsta.net/c_310_420/pictures/15/11/24/17/01/231901.jpg',
         2
        );
        
insert into tbl_diretor (
		 nome,
		 nome_artistico,
		 data_nascimento,
		 biografia, 
		 foto,
		 id_sexo
		)values(
        'Anthony J. Russo',
		'Anthony Russo',
        '1970-02-03',
        'Anthony e Joe Russo foram criados em Cleveland, Ohio, e frequentaram a escola Benedictine High School.[1] Eles eram estudantes de pós-graduação na Case Western Reserve University quando começaram a dirigir, escrever, e produzir seu primeiro longa, Pieces. Eles finaciaram o filme através de empréstimos de alunos e cartões de crédito',
         'https://br.web.img2.acsta.net/c_310_420/pictures/15/11/24/16/59/250993.jpg',
         2
        );

####################### ADICIONANDO NACIONALIDADES ###############################
insert into tbl_nacionalidade (nome) values('Americano');
insert into tbl_nacionalidade (nome) values('Francês');
insert into tbl_nacionalidade (nome) values('Britânico');
insert into tbl_nacionalidade (nome) values('Brasileiro');
insert into tbl_nacionalidade (nome) values('Australiano');

#################################### ADICIONANDO NACIONALIDADE AOS ATORES E DIRETORES ######################################
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(1,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(2,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(3,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(4,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(5,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(6,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(7,4);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(8,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(9,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(10,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(11,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(12,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(12,3);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(13,5);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(14,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(15,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(16,1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(17,1);

insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(1,1);
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(2,1);
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(3,1);
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(4,1);
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(5,1);
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(5,2);
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(6,3);
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(7,1);
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(8,1);

######################################### FILME DIRETOR #################################
insert into tbl_filme_diretor (id_filme, id_diretor) values(1,2);
insert into tbl_filme_diretor (id_filme, id_diretor) values(2,1);
insert into tbl_filme_diretor (id_filme, id_diretor) values(3,3);
insert into tbl_filme_diretor (id_filme, id_diretor) values(3,4);
insert into tbl_filme_diretor (id_filme, id_diretor) values(4,5);
insert into tbl_filme_diretor (id_filme, id_diretor) values(5,6);
insert into tbl_filme_diretor (id_filme, id_diretor) values(6,7);
insert into tbl_filme_diretor (id_filme, id_diretor) values(6,8);

#################################### FILME ATOR #########################################
insert into tbl_filme_ator (id_filme, id_ator) values(1,1);
insert into tbl_filme_ator (id_filme, id_ator) values(1,2);
insert into tbl_filme_ator (id_filme, id_ator) values(1,3);
insert into tbl_filme_ator (id_filme, id_ator) values(2,4);
insert into tbl_filme_ator (id_filme, id_ator) values(2,5);
insert into tbl_filme_ator (id_filme, id_ator) values(2,6);
insert into tbl_filme_ator (id_filme, id_ator) values(3,7);
insert into tbl_filme_ator (id_filme, id_ator) values(3,8);
insert into tbl_filme_ator (id_filme, id_ator) values(3,9);
insert into tbl_filme_ator (id_filme, id_ator) values(4,4);
insert into tbl_filme_ator (id_filme, id_ator) values(4,10);
insert into tbl_filme_ator (id_filme, id_ator) values(4,11);
insert into tbl_filme_ator (id_filme, id_ator) values(5,12);
insert into tbl_filme_ator (id_filme, id_ator) values(5,13);
insert into tbl_filme_ator (id_filme, id_ator) values(5,14);
insert into tbl_filme_ator (id_filme, id_ator) values(6,15);
insert into tbl_filme_ator (id_filme, id_ator) values(6,16);
insert into tbl_filme_ator (id_filme, id_ator) values(6,17);

########################## FILME AVALIAÇÃO ################################
insert into tbl_filme_avaliacao (
	nota,
    comentario,
    id_filme
	)values(
	'5.0',
    'Um realista e chocante retrato de como a máfia agia nos anos 40. Uma obra-prima de valor incalculável. Marlon Brando em uma perfeita atuação , deixando um marco no cinema como um dos personagens mais respeitados e aclamados pelo público e pela crítica .',
	 1
);

insert into tbl_filme_avaliacao (
	nota,
    comentario,
    id_filme
	)values(
	'5.0',
    'Woooollllll, um drama épico!!! Tom Hanks merecia o OSCAR de todos os tempos.... Forrest Gump é o filme! Mesmo sendo longo é incansável! Tenho orgulho de dizer que sou fã desse ator sensacional e desse filme brilhante! Um clássico cinematográfico! :)',
	 2
);

insert into tbl_filme_avaliacao (
	nota,
    comentario,
    id_filme
	)values(
	'5.0',
    'Um dos maiores clássicos da história do cinema. Sendo em minha humilde opinião, a melhor animação da história do cinema . Roteiro impecável, perfeito e deslumbrante. parte didática do filme é maravilhosa, parte técnica perfeita.',
	 3
);

insert into tbl_filme_avaliacao (
	nota,
    comentario,
    id_filme
	)values(
	'5.0',
    'Filmaço. Foi ridículo não ter levado o Oscar... eita academia, fazendo suas cagadas...',
	 4
);

insert into tbl_filme_avaliacao (
	nota,
    comentario,
    id_filme
	)values(
	'5.0',
    'Sem palavras para descrever, incrível, muito bom, vi e revi diversas vezes, heath ledger está perfeito como o coringa',
	 5
);

insert into tbl_filme_avaliacao (
	nota,
    comentario,
    id_filme
	)values(
	'5.0',
    'Devastador, este é o efeito de “Vingadores: Ultimato”. Um gigantesco estrondo que transforma esta experiência cinematográfica em algo arrebatador, cuja vivência ficará na memória por um longo tempo.',
	 6
);


alter table tbl_nacionalidade drop column descricao;
delete from tbl_ator where id= 18;

desc tbl_filme;

################################################################################################################ SELECTS ##########################################################################################################################

##Select -> server para especificar quais colunas serão exibidas.
##From -> server para especificar quais tabelas serão utilizadas.
##Where -> server para especificar o critério de busca.

##Retorna apenas as colunas escolhidas
select id, nome, nome_original from tbl_filme;
select tbl_filme.id, tbl_filme.nome, tbl_filme.nome_original from tbl_filme;

##Criação de nomeclaturas pelo AS -> Alias
select tbl_filme.id as id_filme,
	   tbl_filme.nome as nome_filme,
	   tbl_filme.nome_original
from tbl_filme;

##Permite ordenar de forma crescente e decrescente
select * from tbl_filme order by nome asc;
select * from tbl_filme order by nome desc;
select * from tbl_filme order by nome, data_lancamento desc, sinopse asc;

##limitar a quantidade de registros que serão exibidos
select * from tbl_filme limit 2;

## ucase ou upper -> Deixa tudo em uppercase
## lcase ou lower -> deixa tudo em lowerCase
select ucase(tbl_filme.nome) as nome,
	   lcase(tbl_filme.nome_original) as nome_original,
       length(tbl_filme.nome) as qtde_caracteres,
       concat('<span>Filme: ',tbl_filme.nome, '</span>') as nome_filme_formatado_span,
       concat('Filme: ',tbl_filme.nome) as nome_filme_formatado,
	   tbl_filme.sinopse,
       concat(substr(tbl_filme.sinopse, 1, 50), '... Leia mais') as sinopse_reduzida
from tbl_filme;

####################################### CÁLCULOS E OPERAÇÕES ##############################################

alter table tbl_filme add column valor_unitario float;

update tbl_filme set valor_unitario = 43.50 where id = 1;
update tbl_filme set valor_unitario = 37.80 where id = 2;
update tbl_filme set valor_unitario = 50.10 where id = 4;
update tbl_filme set valor_unitario = 39.00 where id = 6;

select * from tbl_filme;

## CÁLCULOS
select min(valor_unitario) as minimo from tbl_filme;
select max(valor_unitario) as maximo from tbl_filme;
select round(avg(valor_unitario),2) as media from tbl_filme;
select round(sum(valor_unitario), 2)as total from tbl_filme;

## OPERAÇÕES
select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario ,
	   round((tbl_filme.valor_unitario - ((tbl_filme.valor_unitario * 10)/ 100)), 2) as valor_desconto
from tbl_filme;

select tbl_filme.nome, tbl_filme.foto_capa, 
	  concat("R$ ", tbl_filme.valor_unitario) as valor_unitario ,
	  concat("R$ ", round((tbl_filme.valor_unitario - ((tbl_filme.valor_unitario * 10)/ 100)), 2)) as valor_desconto
from tbl_filme;

## OPERADORES DE COMPARAÇÃO
# = -> IGUAL
# < -> MENOR
# > -> MAIOR
# <= -> MENOR OU IGUAL
# >= -> MAIOR OU IGUAL
# <> -> DIFERENTE
# LIKE 
# IS 

## OPERADORES LÓGICOS
# AND
# OR
# NOT

## Apenas trocar o operador
select  tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario >= 40
order by tbl_filme.valor_unitario desc;

select  tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario <> 40 or tbl_filme.valor_unitario is null ;

# Between - retorna os regirtros entre dois valores
select  tbl_filme.nome, tbl_filme.valor_unitario from tbl_filme
where tbl_filme.valor_unitario between 40 and 50;

# Not between - retorna os regirtros que não estão entre dois valores
select  tbl_filme.nome, tbl_filme.valor_unitario from tbl_filme
where tbl_filme.valor_unitario not between 40 and 50;

select * from tbl_filme where tbl_filme.valor_unitario like '%43.5%';

select * from tbl_filme;

########################### DATA E HORA #####################################

##Data atual
select curdate() as data_atual;
select current_date() as data_atual;


##Hora atual
select current_time() as hora_atual;
select curtime() as hora_atual;

##Data e hora
select current_timestamp() as data_hora_atual;

##Foramatação data e hora
select time_format(curtime(), '%H') as hora_formatada;		#Somente a hora de 00 a 23
select time_format(curtime(), '%h') as hora_formatada;		#Somente a hora de 00 a 12
select time_format(curtime(), '%i') as hora_formatada;      #Retorna o minuto
select time_format(curtime(), '%s') as hora_formatada;      #Retorna o segundo
select time_format(curtime(), '%H:%i') as hora_formatada;   #Retorna hora e minuto
select time_format(curtime(), '%r') as hora_formatada;      # Padrão AM/PM
select time_format(curtime(), '%T') as hora_formatada;      # Retorna hora, minuto e segundo

##Hora, minuto e segundo separadamente
select hour(curtime()) as hora_formatada;
select minute(curtime()) as hora_formatada;
select second(curtime()) as hora_formatada;

##Formatando Data
select date_format(curdate(), '%d') as data_formatada;  #Retorna o dia
select date_format(curdate(), '%m') as data_formatada;  #Retorna o mês
select date_format(curdate(), '%M') as data_formatada;  #Retorna o nome do mês
select date_format(curdate(), '%b') as data_formatada;  #Retorna o nome do mês abreviado
select date_format(curdate(), '%y') as data_formatada;  #Retorna os ultimos digitos do ano
select date_format(curdate(), '%Y') as data_formatada;  #Retorna o ano por extenso
select date_format(curdate(), '%w') as data_formatada;  #Retorna o dia da semana
select date_format(curdate(), '%W') as data_formatada;  #Retorna o nome do dia da semana

select day(curdate()) as data_formatada; 		 #Retorna dia do ano
select month(curdate()) as data_formatada;  	 #Retorna mês do ano
select year(curdate()) as data_formatada;  		 #Retorna o ano
select dayname(curdate()) as data_formatada; 	 #Retorna o dia da semana
select dayofmonth(curdate()) as data_formatada;  #Retorna o dia do mês
select dayofyear(curdate()) as data_formatada;   #Retorna o dia do ano
select dayofweek(curdate()) as data_formatada;   #Retorna o dia da semana sequêncial
select monthname(curdate()) as data_formatada;   #Retorna o nome do mês
select yearweek(curdate()) as data_formatada;    #Retorna o ano e a semana do ano
select weekofyear(curdate()) as data_formatada;  #Retorna a semana do ano

select date_format(curdate(), '%d/%m/%Y') as data_formatada_br;
select date_format(str_to_date( '05/07/2020', '%d/%m/%Y'), '%Y-%m-%d') as data_universal;

##Diferença de datas

select datediff('2023-05-24', '2023-05-01') as qtde_dias;
select (datediff('2023-05-24', '2023-05-01')* 5) as valor_pagar;

##Diferença e soma entre horas
select timediff('16:16:19', '16:15:00') as valor_pagar;
select addtime('16:16:19', '1:00:00') as valor_pagar;
select addtime(timediff('16:16:19', '00:20:00'), '01:00:00') as novo;

## Criptografia
select 'senai' as dados,
	md5('Senai') as dados_cripto,
	sha('Senai') as dados_cripto,
	sha2('Senai', 512) as dados_cripto;
    
################################# RELACIONAMENTO ENTRE TABELAS #################################
    use db_videolocadora_tarde_20231;
############## WHERE ##############

#Exemplo 01
select tbl_ator.nome, tbl_ator.data_nascimento,
	   tbl_sexo.sigla
from tbl_ator, tbl_sexo
where tbl_sexo.id = tbl_ator.id_sexo
	;

#Exemplo 02
select tbl_ator.nome, tbl_ator.foto, tbl_ator.biografia,
	   tbl_sexo.sigla, tbl_sexo.nome,
       tbl_nacionalidade.nome
       
from tbl_ator, tbl_sexo, tbl_ator_nacionalidade, tbl_nacionalidade

where tbl_sexo.id = tbl_ator.id_sexo and 
	  tbl_ator.id = tbl_ator_nacionalidade.id_ator and
      tbl_nacionalidade.id = tbl_ator_nacionalidade.id_nacionalidade
order by tbl_ator.nome;

############## FROM ##############

#Exemplo 01
select tbl_ator.nome, tbl_ator.data_nascimento,
	   tbl_sexo.sigla
	from tbl_ator
		inner join tbl_sexo
			on tbl_sexo.id = tbl_ator.id_sexo
	;
    
    #Exemplo 02
select tbl_ator.nome, tbl_ator.foto, tbl_ator.biografia,
	   tbl_sexo.sigla, tbl_sexo.nome,
       tbl_nacionalidade.nome
       
	from tbl_ator
		inner join tbl_sexo
			on tbl_sexo.id = tbl_ator.id_sexo 
		inner join tbl_ator_nacionalidade 
			on tbl_ator.id = tbl_ator_nacionalidade.id_ator 
        inner join tbl_nacionalidade 
			on  tbl_nacionalidade.id = tbl_ator_nacionalidade.id_nacionalidade;

desc tbl_ator;
desc tbl_genero;
desc tbl_nacionalidade;
desc tbl_filme;
######### EXERCICIO #########
select tbl_filme.nome as nome_filme, tbl_filme.data_lancamento as data_lancamento, tbl_filme.sinopse as sinopse,
	   tbl_genero.nome as genero_filme,
       tbl_ator.nome as nome_ator, tbl_ator.biografia as biografia_ator,
       tbl_nacionalidade.nome as nacionalidade_ator,
       tbl_sexo.nome as sexo_ator
       
	from tbl_filme
		inner join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
		inner join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero
		inner join tbl_filme_ator
			on tbl_filme.id = tbl_filme_ator.id_filme
		inner join tbl_ator
			on tbl_ator.id = tbl_filme_ator.id_ator
		inner join tbl_sexo
			on tbl_sexo.id = tbl_ator.id_sexo
		inner join tbl_ator_nacionalidade
			on tbl_ator.id = tbl_ator_nacionalidade.id_ator
		inner join tbl_nacionalidade
			on tbl_nacionalidade.id = tbl_ator_nacionalidade.id_nacionalidade
	order by tbl_filme.nome, tbl_ator.nome;

insert into tbl_classificacao(sigla, nome, descricao) values('NA', 'Não Aplicavél', 'Não aplicavél a nenhum filme');
insert into tbl_filme ( nome,
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao,
                        valor_unitario
                        ) values (
                        'A Lista de Schindler',
                        'Schindlers List',
                        '1993-12-31',
                        '2019-03-01',
                        '03:15:00',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/19/04/10/19/44/2904073.jpg',
                        'A inusitada história de Oskar Schindler (Liam Neeson), um sujeito oportunista, sedutor, "armador", simpático, comerciante no mercado negro, mas, acima de tudo, um homem que se relacionava muito bem com o regime nazista, tanto que era membro do próprio Partido Nazista (o que não o impediu de ser preso algumas vezes, mas sempre o libertavam rapidamente, em razão dos seus contatos). No entanto, apesar dos seus defeitos, ele amava o ser humano e assim fez o impossível, a ponto de perder a sua fortuna mas conseguir salvar mais de mil judeus dos campos de concentração.',
                        '11',
                        '29.90'
                        );
                        
insert into tbl_genero(nome)values('Histórico');
insert into tbl_genero(nome)values('Guerra');
                        
select * from tbl_genero;
select * from tbl_filme;

select tbl_filme.nome as nome_filme, tbl_classificacao.nome as nome_classifcacao
	from tbl_filme
		inner join tbl_classificacao
			on tbl_classificacao.id = tbl_filme.id_classificacao;
            
select tbl_filme.nome as nome_filme, tbl_genero.nome as nome_genero
	from tbl_filme
		inner join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
		inner join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero;

### LEFT JOIN

select tbl_filme.nome as nome_filme, tbl_classificacao.nome as nome_classifcacao
	from tbl_filme
		left join tbl_classificacao
			on tbl_classificacao.id = tbl_filme.id_classificacao;
            
select tbl_filme.nome as nome_filme, tbl_genero.nome as nome_genero, tbl_classificacao.nome as nome_classificacao
	from tbl_filme
		left join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
		left join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero
		inner join tbl_classificacao
			on tbl_classificacao.id = tbl_filme.id_classificacao;
            

### RIGHT JOIN

select tbl_filme.nome as nome_filme, tbl_classificacao.nome as nome_classifcacao
	from tbl_filme
		right join tbl_classificacao
			on tbl_classificacao.id = tbl_filme.id_classificacao
    order by tbl_filme.nome;
    
select tbl_filme.nome as nome_filme, tbl_genero.nome as nome_genero, tbl_classificacao.nome as nome_classificacao
	from tbl_filme
		right join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
		right join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero
		left join tbl_classificacao
			on tbl_classificacao.id = tbl_filme.id_classificacao;

## FULL JOIN
select tbl_filme.nome as nome_filme, tbl_filme.data_lancamento,
	   tbl_genero.nome as nome_genero, 
       tbl_classificacao.nome as nome_classificacao
	from tbl_filme
		left join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
		left join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero
		inner join tbl_classificacao
			on tbl_classificacao.id = tbl_filme.id_classificacao
            
union distinct

select tbl_filme.nome as nome_filme, tbl_filme.data_lancamento,
	   tbl_genero.nome as nome_genero, 
       tbl_classificacao.nome as nome_classificacao
	from tbl_filme
		right join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
		right join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero
		left join tbl_classificacao
			on tbl_classificacao.id = tbl_filme.id_classificacao
            
;



