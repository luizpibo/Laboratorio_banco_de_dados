DROP schema if exists escola_de_musica;
CREATE schema if not exists escola_de_musica;

drop database if exists escola_de_musica; -- excluir database

create database if not exists escola_de_musica
default character set utf8 -- uft8 (8-bit Unicode Transformation Format - Pode representar qualquer caracter universal padrão do Unicode, sendo também compatível com o ASCII)
default collate utf8_general_ci;

use escola_de_musica;

-- table pessoa
CREATE TABLE IF NOT EXISTS pessoa (
    id int not null AUTO_INCREMENT,
    nome varchar(50) NOT NULL,
    telefone varchar(17) NOT NULL,
    cpf varchar(11),
    primary key (id)
);

-- table usuario
CREATE TABLE IF NOT EXISTS usuario (
    id INT NOT NULL AUTO_INCREMENT,
    id_pessoa INT NOT NULL,
    login VARCHAR(50),
    senha VARCHAR(255),
    PRIMARY KEY (id, id_pessoa),
    FOREIGN KEY (id_pessoa) REFERENCES pessoa (id)
);

-- table aluno
CREATE TABLE IF NOT EXISTS aluno (
    id INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id, id_usuario),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id)
);

-- table funcionarios
CREATE TABLE IF NOT EXISTS funcionario (
    id INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    salario_base DECIMAL(7, 2) NOT NULL,
    data_admicao DATE NOT NULL,
    PRIMARY KEY (id, id_usuario),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id)
);

-- table professor
CREATE TABLE IF NOT EXISTS professor (
    id INT NOT NULL AUTO_INCREMENT,
    id_funcionario INT NOT NULL,
    PRIMARY KEY (id, id_funcionario),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario (id)
);

-- table aula
CREATE TABLE IF NOT EXISTS aula (
    id INT NOT NULL AUTO_INCREMENT,
	id_instrumento INT NOT NULL, 
	id_professor INT NOT NULL,   
	descricao VARCHAR(255) NOT NULL,
    tempo_duracao INT NOT NULL,
    link_aula VARCHAR(150) NOT NULL,
	
    PRIMARY KEY (id)
);

-- table apresentacao 
CREATE TABLE IF NOT EXISTS apresentacao (
    id INT NOT NULL AUTO_INCREMENT,
    data_apresentacao date NOT NULL,
    descricao VARCHAR(300) NOT NULL,
    PRIMARY KEY (id)
);

-- table prova
CREATE TABLE IF NOT EXISTS prova (
    id INT NOT NULL AUTO_INCREMENT,
    id_aula INT NOT NULL,
	id_aluno INT NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    nota DECIMAL(4, 2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_aula) REFERENCES aula (id),
	FOREIGN KEY (id_aluno) REFERENCES aluno (id)
);

-- table instrumento
CREATE TABLE IF NOT EXISTS instrumento (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);


-- aluno_has_instrumento
CREATE TABLE IF NOT EXISTS aluno_has_instrumento (
	id_aluno INT NOT NULL,
    id_instrumento INT NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES aluno (id),
    FOREIGN KEY (id_instrumento) REFERENCES instrumento (id),
    PRIMARY KEY (id_aluno, id_instrumento)
);

-- aluno_has_apresentacao
CREATE TABLE IF NOT EXISTS aluno_has_apresentacao (
	id_aluno INT NOT NULL,
    id_apresentacao INT NOT NULL,
	FOREIGN KEY (id_aluno) REFERENCES aluno (id),
    FOREIGN KEY (id_apresentacao) REFERENCES apresentacao (id),
    PRIMARY KEY (id_aluno, id_apresentacao)
);

-- aluno_has_aula
CREATE TABLE IF NOT EXISTS aluno_has_aula (
	id_aluno INT NOT NULL,
    id_aula INT NOT NULL,
	FOREIGN KEY (id_aluno) REFERENCES aluno (id),
    FOREIGN KEY (id_aula) REFERENCES aula (id),
    PRIMARY KEY (id_aluno, id_aula)
);

-- professor_has_apresentação
CREATE TABLE IF NOT EXISTS professor_has_apresentacao (
	id_professor INT NOT NULL,
    id_apresentacao INT NOT NULL,
	FOREIGN KEY (id_professor) REFERENCES professor (id),
    FOREIGN KEY (id_apresentacao) REFERENCES apresentacao (id),
    PRIMARY KEY (id_professor, id_apresentacao)
);

-- instrumento_has_apresentacao
CREATE TABLE IF NOT EXISTS instrumento_has_apresentacao (
	id_instrumento INT NOT NULL,
    id_apresentacao INT NOT NULL,
	FOREIGN KEY (id_instrumento) REFERENCES instrumento (id),
    FOREIGN KEY (id_apresentacao) REFERENCES apresentacao (id),
    PRIMARY KEY (id_instrumento, id_apresentacao)
);