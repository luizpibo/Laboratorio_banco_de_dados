CREATE schema if not exists escola_de_musica;

use escola_de_musica;

-- table 
CREATE TABLE IF NOT EXISTS pessoa (
    id int not null AUTO_INCREMENT,
    nome varchar(50) not null,
    telefone varchar(17) not null,
    cpf varchar(14),
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
    descricao VARCHAR(255),
    nota DECIMAL(2, 2),
    PRIMARY KEY (id),
    FOREIGN KEY (id_aula) REFERENCES aula (id)
);

-- table instrumento
CREATE TABLE IF NOT EXISTS instrumento (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(30),
    PRIMARY KEY (id)
);