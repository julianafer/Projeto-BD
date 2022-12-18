/*criação do banco de dados do cinema*/
create database cinema;

/*utilização do banco de dados cinema*/
use cinema;

/* CRIAÇÃO DAS TABELAS */

/*criação da tabela funcionário*/
create table funcionario
(
    cpf char(11) not null,
    nome varchar(45) not null,
    dia_nasc int not null,
    mes_nasc int not null,
    ano_nasc int not null,
    genero varchar(1) null,
    cep	char(8)	not null,
    numero_end int not null,
    condominio varchar(45) null,
    funcionario_cpf char(11) null,
    numero_cart	int not null,
    foto blob null, /*botando null porque é blob*/
    digital varchar(45) null, /*botando null porque era blob mas botei varchar pra conseguir virar AK*/
    constraint PK_funcionario primary key (cpf),
    constraint AK_funcionario_cep unique (cep),
    constraint FK_funcionario_funcionario FOREIGN KEY (funcionario_cpf) REFERENCES funcionario (cpf),
    constraint AK_funcionario_numero unique (numero_cart),
    constraint CK_cpf check(length(cpf) = 11),
    constraint CK_numero check(numero_end>0),
    constraint CK_genero check(genero in ('f','m')),
    constraint CK_dia check(dia_nasc <= 31),
    constraint CK_mes check(mes_nasc <= 12),
    constraint CK_ano check(ano_nasc between 1900 and 2004),
    constraint AK_funcionario_digital unique(digital)
);

/*criação da tabela telefone*/
create table telefone
(
    telefone char(11) not null,
    funcionario_cpf char(11) not null,
    constraint PK_telefone primary key (telefone, funcionario_cpf),
    constraint FK_funcionario_cpf foreign key (funcionario_cpf) references funcionario (cpf)
);

/*criação da tabela email*/
create table email
(
    email varchar(45) not null,
    funcionario_cpf char(11) not null,
    constraint PK_email primary key (email, funcionario_cpf),
    constraint FK_cpf foreign key (funcionario_cpf) references funcionario (cpf)
);

/*criação da tabela cliente*/
create table cliente
(
    cpf char(11),
    nome varchar(45),
    constraint PK_cliente primary key (cpf),
    constraint CK_cliente check(length(cpf) = 11)
);

/*criação da tabela venda*/
create table venda
(
    codigo int not null,
    data_venda date not null,
    hora time not null,
    funcionario_cpf char(11) not null,
    cliente_cpf char(11) not null,
    constraint PK_codigo primary key (codigo),
    constraint FK_funcionario foreign key (funcionario_cpf) references funcionario (cpf),
    constraint FK_cliente_cpf foreign key (cliente_cpf) references cliente (cpf),
    constraint CK_codigo_venda check(codigo>0)
);

/*criação da tabela filme*/
create table filme
(
    codigo int not null,
    nome varchar(45) not null,
    tipo varchar(1) default 'd' not null,
    constraint PK_filme primary key (codigo),
    constraint CK_codigo_filme check(codigo>0),
    constraint CK_tipo_filme check(tipo in ('d','l'))
);

/*criação da tabela sala*/
create table sala 
(
    numero int not null,
    tipo varchar(1) default 'n' not null,
    constraint PK_sala primary key (numero),
    constraint CK_numero_sala check(numero>0),
    constraint CK_tipo check(tipo in ('n','p'))
);

/*criação da tabela sessão*/
create table sessao
(
    codigo int not null,
    sala_numero int not null,
    filme_codigo int not null,
    data_sessao date not null,
    hora time not null,
    constraint PK_sessao primary key (codigo),
    constraint FK_sala foreign key (sala_numero) references sala (numero),
    constraint FK_filme foreign key (filme_codigo) references filme (codigo),
    constraint CK_codigo_sessao check(codigo>0)
);

/*criação da tabela ingresso*/
create table ingresso
(
    codigo int not null,
    preço float not null,
    venda_codigo int not null,
    sessao_codigo int not null,
    constraint PK_ingresso primary key (codigo),
    constraint FK_venda foreign key (venda_codigo) references venda (codigo),
    constraint FK_sessao foreign key (sessao_codigo) references sessao (codigo),
    constraint CK_codigo_ingresso check(codigo>0)
);

/*criação da tabela estudante*/
create table estudante
(
    ingresso_codigo int not null,
    carteira_de_estudante blob null, /*deixando null porque é blob*/
    constraint PK_ingresso_estudante primary key (ingresso_codigo),
    constraint FK_ingresso foreign key (ingresso_codigo) references ingresso (codigo)
);

/*criação da tabela personagem*/
create table personagem
(
    numero int not null,
    filme_codigo int not null,
    nome varchar(45) not null,
    genero varchar(1) not null,
    constraint PK_personagem primary key (numero, filme_codigo),
    constraint FK_personagem_filme foreign key (filme_codigo) references filme (codigo),
    constraint CK_numero_personagem check(numero>0),
    constraint CK_genero_personagem check(genero in ('f','m'))
);

/*criaçao da tabela genero*/
create table genero 
(
    genero varchar(45) not null,
    filme_codigo int not null,
    constraint PK_genero primary key (genero, filme_codigo),
    constraint FK_genero_filme foreign key (filme_codigo) references filme (codigo)
);

/*criação da tabela poltrona*/
create table poltrona 
(
    sala_numero int not null,
    numero int not null,
    fileira varchar(1) not null,
    constraint PK_poltrona primary key (sala_numero, numero, fileira),
    constraint FK_sala_poltrona foreign key (sala_numero) references sala (numero)
);

/* INSERÇÃO DE DADOS */

/*inserindo dados na tabela funcionário*/
insert into funcionario values ('12345678901', 'Lucas Rangel', 7, 11, 2000, 'm', '12345678', 74, null, null, 12345, null, null);
insert into funcionario values ('52435698435', 'Gessica Kayane', 23, 9, 1995, 'f', '87654321', 500, 'bloco C', '12345678901', 98765, null, null);
insert into funcionario values ('54801375209', 'Carlinhos Maia', 1, 5, 2002, 'm', '56349810', 17, 'condomínio amarelo', '12345678901', 55555, null, null);
insert into funcionario values ('45677898766', 'Mel Maia', 15, 9, 2004, 'f', '94567000', 590, null, '52435698435', 45621, null, null);
insert into funcionario values ('65473289337', 'Christian Figueiredo', 5, 7, 1999, 'm', '64384610', 4, 'apt 601', '12345678901', 45021, null, null);

/*inserindo dados na tabela telefone*/
insert into telefone values ('11987003156', '12345678901'); #telefone do funcionário Lucas Rangel
insert into telefone values ('83955762138', '52435698435'); #telefone da funcionária Gessica Kayane
insert into telefone values ('11953436570', '52435698435'); #telefone da funcionária Gessica Kayane
insert into telefone values ('85965435696', '54801375209'); #telefone do funcionário Carlinhos Maia
insert into telefone values ('11936548541', '45677898766'); #telefone da funcionária Mel Maia
insert into telefone values ('11987654567', '65473289337'); #telefone do funcionário Christian Figueiredo

/*inserindo dados na tabela email*/
insert into email values ('lucas.rangel@gmail.com', '12345678901'); #email do funcionário Lucas Rangel
insert into email values ('lr.agengy@lr.agency', '12345678901'); #email do funcionário Lucas Rangel 
insert into email values ('gkay@gmail.com', '52435698435'); #email da funcionária Gessica Kayane
insert into email values ('carlinhos.maia@gmail.com', '54801375209'); #email do funcionário Carlinhos Maia
insert into email values ('mel.maia@gmail.com', '45677898766'); #email da funcionária Mel Maia
insert into email values ('christian@christian.figueiredo', '65473289337'); #email do funcionário Christian Figueiredo

/*inserindo dados na tabela cliente*/
insert into cliente values ('87514231876', 'Thomas Lima');
insert into cliente values ('65865438743', 'Rafaela Alves');
insert into cliente values ('11111111111', 'Arthur Oliveira');
insert into cliente values ('47532154376', 'Carla Maria');
insert into cliente values ('54734587900', 'Lívia Martins');
insert into cliente values ('12345678976', 'Ricardo Luiz');

/*inserindo dados na tabela venda*/
insert into venda values (123, '2022-05-28', '11:15:25', '12345678901', '11111111111'); # Lucas Rangel vendeu para Arthur Oliveira
insert into venda values (325, '2022-11-02', '09:10:25', '45677898766', '54734587900'); # Mel Maia vendeu para Lívia Martins
insert into venda values (873, '2022-09-30', '20:04:07', '65473289337', '87514231876'); # Christian Figueiredo vendeu para Thomas Lima
insert into venda values (404, '2021-01-21', '00:06:22', '52435698435', '47532154376'); # Gessica Kayane vendeu para Carla Maria
insert into venda values (762, '2021-10-09', '15:15:15', '54801375209', '65865438743'); # Carlinhos Maia vendeu para Rafaela Alves
insert into venda values (234, '2022-12-16', '19:30:45', '54801375209', '12345678976'); # Carlinhos Mais vendeu para Ricardo Luiz

/*inserindo dados na tabela filme*/
insert into filme values (31, 'Ricos de Amor', 'd');
insert into filme values (12, 'Crônicas de natal', 'l');
insert into filme values (73, 'Vingadores', 'd');
insert into filme values (45, 'Minha mãe é uma peça', 'd');
insert into filme values (25, 'Coringa', 'l');

/*inserindo dados na tabela sala*/
insert into sala values (1, 'n');
insert into sala values (2, 'n');
insert into sala values (3, 'n');
insert into sala values (4, 'n');
insert into sala values (5, 'p');

/*inserindo dados na tabela sessão*/
insert into sessao values (1234, 1, 25, '2021-11-09', '00:00:00'); # Coringa na sala 1
insert into sessao values (7652, 2, 44, '2021-12-31', '10:55:00'); # Minha mãe é uma peça na sala 2
insert into sessao values (1745, 3, 73, '2022-02-05', '16:00:00'); # Vingadores na sala 3
insert into sessao values (9786, 4, 12, '2022-07-08', '20:30:00'); # Crônicas de natal na sala 4
insert into sessao values (8888, 5, 31, '2022-08-07', '13:45:00'); # Ricos de Amor na sala 5

/*inserindo dados na tabela ingresso*/
insert into ingresso values (87654, 10.00, 123, 1234); # estudante
insert into ingresso values (54321, 10.00, 325, 7652); # estudante
insert into ingresso values (23456, 10.00, 873, 1745); # estudante
insert into ingresso values (56437, 10.00, 404, 9786); # estudante
insert into ingresso values (65421, 15.00, 762, 8888); # estudante
insert into ingresso values (34132, 30.00, 762, 8888);
insert into ingresso values (57898, 20.00, 325, 7652);

/*inserindo dados na tabela estudante*/
insert into estudante values (87654, null);
insert into estudante values (54321, null);
insert into estudante values (23456, null);
insert into estudante values (56437, null);
insert into estudante values (65421, null);

/*inserindo dados na tabela personagem*/
insert into personagem values (11, 31, 'Paula', 'f'); # Personagem paula do filme Ricos de Amor
insert into personagem values (22, 12, 'Papai Noel', 'm'); # Personagem Papai Noel do filme Crônicas de Natal
insert into personagem values (33, 73, 'Thanos', 'm'); # Personagem Thanos do filme Vingadores
insert into personagem values (44, 45, 'Hermínia', 'f'); # Personagem Hermínia do filme Minha mãe é uma peça
insert into personagem values (55, 25, 'Coringa', 'm'); # Personagem Coringa do filme Coringa

/*inserindo dados na tabela genero*/
insert into genero values ('Romance', 31);
insert into genero values ('Ficção', 12);
insert into genero values ('Aventura', 73);
insert into genero values ('Comédia', 45);
insert into genero values ('Drama', 25);

/*inserindo dados na tabela poltrona*/
insert into poltrona values (1, 1, 'a');
insert into poltrona values (2, 3, 'b');
insert into poltrona values (3, 5, 'a');
insert into poltrona values (4, 7, 'f');
insert into poltrona values (5, 9, 'a');

/* CONSULTA DE DADOS */

/*Obter nome e email dos funcionários com sobre nome Maia, ordenando pelo nome do funcionário em ordem descente*/
select f.nome as 'Funcionário',
	   e.email as 'E-mail'
from email as e
join funcionario as f
	 on e.funcionario_cpf = f.cpf
having f.nome like '%Maia'
order by f.nome desc;

/*Obter a quantidade de funcionários que possuem condomínio e que nasceram depois dos anos 1990 de cada genero*/
select genero as 'Gênero',
       COUNT(*) AS Quantidade
from funcionario
where condominio is not null and
      ano_nasc between 1990 and 2004
group by genero;

/*Obter o nome dos filmes que serão passados nas salas de número ímpar*/
select s.sala_numero as 'Número da sala',
       f.nome as 'Filme'
from sessao as s
join filme as f
     on s.filme_codigo = f.codigo
where s.sala_numero in (1,3,5)
order by s.sala_numero;

/*Obter horário e filme da sessão mais cedo do cinema*/
select min(s.hora) as 'Horário',
       f.nome as 'Filme'
from sessao as s
join filme as f
     on s.filme_codigo = f.codigo;