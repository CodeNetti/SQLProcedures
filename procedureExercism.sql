create database db_lojaVt; -- criando database loja virtual
use db_LojaVt;

create table tbl_Cli(
	nm_cliente char(80) not null,
    no_CPF char(11) not null,
    nm_Logradouro varchar(80) not null,
    no_Log char(5) not null,
    ds_Log varchar(40) not null,
    no_CEP char(8) not null,
    nm_Bairro varchar(30) not null,
    sg_UF char(2) not null,
    ds_login varchar(20) not null,
    ds_Senha char(6) not null
);

/*
	adicionando campo ds_status como 
    ultima coluna da tabela cliente
*/
alter table tbl_cli
add column ds_Status bit not null;

-- adicionando coluna na primeira posição
alter table tbl_cli
add column id_Cliente int primary key auto_increment first;

-- excluindo coluna da tabela
alter table tbl_cliente
add column id_Cliente  int primary key auto_increment first;

-- adicionando nova coluna após algum campo
alter table tbl_cli
add column nm_Cidade varchar(30) not null after nm_Bairro;

-- modificando estrura de dados e restrições
alter table tbl_cli
modify column nm_cliente varchar(80) not null;

alter table tbl_cli
modify column no_log varchar(5) not null;

alter table tbl_Cli
modify column ds_log varchar(40) null;

-- alterando o nome da coluna
alter table tbl_cli
change column nm_Logradouro nm_log varchar(40) not null;

alter table tbl_cli
change column ds_log ds_Complemento varchar(40) not null;


alter table tbl_Cli
modify column nm_log varchar(80) not null;

alter table tbl_Cli
modify column ds_Complemento varchar(40) null;

-- alterando o nome da tabela
alter table tbl_cli
rename to tbl_Cliente;


-- comando para ver estrutura da tabela
desc tbl_cliente;

create table tbl_foneCli(
	id_telefone int primary key auto_increment,
    id_Cliente int,
    no_Telefone char(11),
    constraint foreign key(id_Cliente) references tbl_Cliente(id_Cliente)
);

alter table tbl_foneCli
modify column  no_Telefone char(11) not null;

desc tbl_foneCli;

create table tbl_pagamento
(
	id_pgto int primary key auto_increment,
    nm_pgto varchar(15) not null
);




-- procedure para inserir valores na tabela Pagamento
create procedure sp_iinsPgto(
in p_NmPgto varchar(15)
)
insert into tbl_Pagamento(nm_pgto)
values(p_nmPgto);

-- chamando a procedure
call sp_iinsPgto('Cartão');


-- procedure para dar um select valores na tabela Pagamento
create procedure sp_selectPg()
select * from tbl_pagamento;
-- chamando a procedure
call sp_selectPg();

-- procedure para dar um update  na tabela Pagamento
create procedure sp_altPagg(
in p_id int,
in p_nmPgt varchar(15)
)
update tbl_pagamento
set nm_pgto = p_nmPgt where id_pgto = p_id;
-- chamando a procedure
call sp_altPagg(3,'Cartão');



-- procedure para inserir dados do cliente e apagemnto 
DELIMITER $$

CREATE PROCEDURE sp_InsClienteTelefone(
    IN p_nm_cliente VARCHAR(80),
    IN p_no_CPF CHAR(11),
    IN p_nm_Logradouro VARCHAR(40),
    IN p_no_Log CHAR(5),
    IN p_ds_Complemento VARCHAR(40),
    IN p_no_CEP CHAR(8),
    IN p_nm_Bairro VARCHAR(30),
    IN p_sg_UF CHAR(2),
    IN p_ds_login VARCHAR(20),
    IN p_ds_Senha CHAR(6),
    IN p_ds_Status BIT,
    IN p_nm_Cidade VARCHAR(30),
    IN p_no_Telefone CHAR(11)
)
BEGIN
    DECLARE v_id_cliente INT;

    INSERT INTO tbl_Cliente(
        nm_cliente, no_CPF, nm_log, no_log, ds_Complemento, no_CEP,
        nm_Bairro, sg_UF, ds_login, ds_Senha, ds_Status, nm_Cidade
    ) VALUES (
        p_nm_cliente, p_no_CPF, p_nm_Logradouro, p_no_Log, p_ds_Complemento, p_no_CEP,
        p_nm_Bairro, p_sg_UF, p_ds_login, p_ds_Senha, p_ds_Status, p_nm_Cidade
    );

    SET v_id_cliente = LAST_INSERT_ID();

    INSERT INTO tbl_foneCli(id_Cliente, no_Telefone)
    VALUES (v_id_cliente, p_no_Telefone);

END $$

DELIMITER 

-- chamando a procedure
call sp_InsClienteTelefone(
    'João da Silva', '12345678901', 'Rua das Flores', '101',
    'Apto 2A', '12345678', 'Centro', 'SP', 'joao123',
    '12456', 1, 'São Paulo', '98765432101'
);


