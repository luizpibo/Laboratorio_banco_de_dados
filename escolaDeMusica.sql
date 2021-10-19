drop database if exists escolaDeMusica; -- excluir database

create database if not exists escolaDeMusica
default character set utf8 -- uft8 (8-bit Unicode Transformation Format - Pode representar qualquer caracter universal padrão do Unicode, sendo também compatível com o ASCII)
default collate utf8_general_ci;

use escolaDeMusica;-- selecionar banco de dados
-- table pessoa

CREATE TABLE IF NOT EXISTS pessoas (
 id int not null,
 nome varchar(50) not null,
 telefone char(14) not null,
 cpf char(11),
 primary key (id)
);
-- table usuario
CREATE TABLE IF NOT EXISTS usuarios (
 id INT NOT NULL,
 id_pessoa INT NOT NULL,
 login CHAR(50),
 senha VARCHAR(255),
 PRIMARY KEY (id, id_pessoa),
 FOREIGN KEY (id_pessoa) REFERENCES pessoas (id)
);
-- table aluno
CREATE TABLE IF NOT EXISTS alunos (
 id INT NOT NULL,
 id_usuario INT NOT NULL,
 PRIMARY KEY (id, id_usuario),
 FOREIGN KEY (id_usuario) REFERENCES usuarios (id) 
);
-- table funcionarios
CREATE TABLE IF NOT EXISTS funcionarios (
 id INT NOT NULL,
 id_usuario INT NOT NULL,
 salario_base  DECIMAL(7,2) NOT NULL,
 data_admicao DATE NOT NULL,
 PRIMARY KEY (id, id_usuario),
 FOREIGN KEY (id_usuario) REFERENCES usuarios (id)
);
-- table professor
CREATE TABLE IF NOT EXISTS professores (
    id INT NOT NULL,
    id_funcionario INT NOT NULL,
    PRIMARY KEY (id, id_funcionario),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios (id)

);
-- table aula
CREATE TABLE IF NOT EXISTS aulas (
    id INT NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    tempo_duracao INT NOT NULL,
    link_aulas VARCHAR(150) NOT NULL,
    PRIMARY KEY (id)
);
-- table apresentacao 
CREATE TABLE IF NOT EXISTS apresentacoes (
    id INT NOT NULL,
    data_apresentacao date NOT NULL,
    descricao VARCHAR(300) NOT NULL,
    PRIMARY KEY (id) 
);
-- table prova
CREATE TABLE IF NOT EXISTS provas (
    id INT NOT NULL,
    id_aula INT NOT NULL,
    descricao VARCHAR(255),
    nota DECIMAL(2,1),
    PRIMARY KEY (id),
    FOREIGN KEY (id_aula) REFERENCES aulas (id)
);
-- table instrumento
CREATE TABLE IF NOT EXISTS instrumentos (
    id INT NOT NULL,
    nome VARCHAR(30),
    PRIMARY KEY (id)
);
INSERT INTO pessoas VALUES 
(958, "José", 61982458596, 24563125185),
(345, "Maria", 61997458213, 85236547185),
(854, "João", 61984523697, 74582165123),
(236, "Carlos", 61974582332, 748596324142),
(321, "Leticia", 61974582136, 95863254152);

INSERT INTO usuarios VALUES
(523, 958, 215463, "a254a"),
(856, 345, 211102, "b457b"),
(574, 854, 210254, "c745c"),
(879, 236, 210241, "d985d"),
(892, 321, 21024156, "e547e");

INSERT INTO alunos VALUES
(475, 523),
(742, 856),
(256, 574),
(346, 879),
(726, 892);

INSERT INTO funcionarios VALUES
(651, 523, 8205.36, '20210130'),
(816, 856, 7301.45, '20190514'),
(941, 574, 2566.32, '20180215'),
(142, 879, 4550.56, '20001204'),
(216, 892, 1080.56, '20110523');

INSERT INTO professores VALUES
(246, 651),
(735, 816),
(429, 941),
(124, 142),
(683, 216);

INSERT INTO aulas VALUES
(421, "saxofone", 55, "www.EMB.gov.br/saxofone"),
(741, "trompete", 55, "www.EMB.gov.br/trompete"),
(216, "flauta", 120, "www.EMB.gov.br/flauta"),
(325, "clarinete", 90, "www.EMB.gov.br/clarinete"),
(523, "baixoAcustico", 55, "www.EMB.gov.br/baixoAcustico");

INSERT INTO apresentacoes VALUES
(856, '20211120', "nível básico"),
(423, '20211024', "nível técnico"),
(147, '20211203', "nível básico-infanto Juvenil"),
(852, '20211014', "nível técnico"),
(963, '20211020', "nível básico");

INSERT INTO provas VALUES
(141, 421, "B2", 05.5),
(225, 741, "B4", 07.3),
(336, 216, "T1", 08.5),
(997, 325, "T3", 09.9),
(664, 523, "B1", 05.0);

INSERT INTO instrumentos VALUES
(111, "saxofone"),
(222, "trompete"),
(333, "clarinete"),
(444, "flauta"),
(555, "baixoAcustico");
