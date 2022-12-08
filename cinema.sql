/*criação do banco de dados do cinema*/
create database cinema;

/*utilização do banco de dados cinema*/
use cinema;

/*criação da tabela funcionário*/
create table funcionario
(
	cpf char(11) not null,
    nome varchar(45) not null,
    dia	int	not null,
    mes	int	not null,
    ano	int not null,
    genero varchar(1) null,
	cep	char(8)	not null,
    numero_end int not null,
    condominio varchar(45) null,
    funcionario_cpf char(11) null,
    numero_cart	int	not null,
    foto blob not null, /*como adicionar?*/
    digital	blob not null, /*como adicionar?*/
	constraint PK_funcionario primary key (cpf),
    constraint AK_funcionario_cep unique (cep),
    constraint FK_funcionario_funcionario FOREIGN KEY (funcionario_cpf) REFERENCES funcionario (cpf),
    constraint AK_funcionario_numero unique (numero_cart),
    constraint CK_cpf check(cpf like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    constraint CK_ano check(ano>0),
    constraint CK_numero check(numero_end>0),
    constraint CK_genero check(genero like 'f' or 'm')
    /* constraint AK_funcionario_digital unique(digital) 	tá dando erro :( */
);
drop table funcionario; /*para testar o erro*/

/*criação da tabela telefone*/
create table telefone
(
    telefone int not null,
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
    constraint CK_cliente check(cpf like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
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
    constraint CK_tipo_filme check(tipo like 'd' or 'l')
);

/*criação da tabela sala*/
create table sala 
(
	numero int not null,
    tipo varchar(1) default 'n' not null,
    constraint PK_sala primary key (numero),
    constraint CK_numero_sala check(numero>0),
    constraint CK_tipo check(tipo like 'n' or 'p')
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
    carteira_de_estudante blob not null,
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