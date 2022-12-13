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
    constraint CK_numero_personagem check(numero>0)
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
