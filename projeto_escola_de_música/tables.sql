DROP DATABASE IF EXISTS escola_de_musica; -- excluir database

CREATE DATABASE IF NOT EXISTS escola_de_musica
DEFAULT CHARACTER SET utf8 -- uft8 (8-bit Unicode Transformation Format - Pode representar qualquer caracter universal padrão do Unicode, sendo também compatível com o ASCII)
DEFAULT COLLATE utf8_general_ci;

USE escola_de_musica;-- selecionar banco de dados

-- usuario
CREATE TABLE IF NOT EXISTS usuario (
  id INT(11) NOT NULL AUTO_INCREMENT,
  login VARCHAR(50) NOT NULL,
  senha VARCHAR(255) NOT NULL,
  nome VARCHAR(50) NULL DEFAULT NULL,
  telefone VARCHAR(15) NULL DEFAULT NULL,
  cpf VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (id)
);

-- Usuarios
INSERT INTO usuario VALUES
(1, "professor1", "password","professor1","61982458596","24563125185"),
(2, "professor2" , "password", "professor2", "22222222222", "22222222222"),
(3, "aluno3" , "password", "aluno3", "33333333333", "33333333333"),
(4, "aluno4" , "password", "aluno4", "44444444444", "44444444444"),
(5, "Carlos5" , "password", "Carlos5", "61974582332", "74859632414"),
(6, "Leticia6" , "password", "Leticia6", "61974582136", "95863254152");

-- aluno
CREATE TABLE IF NOT EXISTS aluno (
  id INT(11) NOT NULL AUTO_INCREMENT,
  usuario_id INT(11) NOT NULL,
  PRIMARY KEY (id, usuario_id),
    FOREIGN KEY (usuario_id)
    REFERENCES usuario (id)
);

-- Alunos
INSERT INTO aluno VALUES
(1, 3),
(2, 4),
(3, 5),
(4, 6);

-- professor
CREATE TABLE IF NOT EXISTS professor (
  id INT(11) NOT NULL AUTO_INCREMENT,
  salarioBase DECIMAL(7,2) NOT NULL,
  dataAdimicao DATE NOT NULL,
  usuario_id INT(11) NOT NULL,
  PRIMARY KEY (id, usuario_id),
  FOREIGN KEY (usuario_id)
    REFERENCES usuario (id)
);

-- professor
INSERT INTO professor VALUES
(1, 8205.36, '2021-01-30',1),
(2, 1080.56, '2011-05-23',2);

-- apresentacao 
CREATE TABLE IF NOT EXISTS apresentacao (
    id INT NOT NULL AUTO_INCREMENT,
    data_apresentacao date NOT NULL,
    descricao VARCHAR(300) NOT NULL,
    PRIMARY KEY (id)
);

-- apresentação
INSERT INTO  apresentacao VALUES 
(1, "2019-12-31", "virada de ano 2019"),
(2, "2021-12-25", "Natal 2021"),
(3, "2021-10-31", "Halloween 2021");

-- instrumento
CREATE TABLE IF NOT EXISTS instrumento (
  id INT(11) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

-- Instrumentos
INSERT INTO instrumento VALUES
(1,"saxofone"),
(2,"trompete"),
(3,"clarinete"),
(4,"flauta"),
(5,"baixoAcustico");

-- aula
CREATE TABLE IF NOT EXISTS aula (
  id INT(11) NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(70) NOT NULL,
  tempoDuracao INT(11) NOT NULL,
  linkAula VARCHAR(100) NOT NULL,
  instrumento_id INT(11) NOT NULL,
  professor_id INT(11) NOT NULL,
  professor_usuario_id INT(11) NOT NULL,
  PRIMARY KEY (id, professor_id, professor_usuario_id),
	FOREIGN KEY (instrumento_id)
    REFERENCES instrumento (id),
    FOREIGN KEY (professor_id , professor_usuario_id)
    REFERENCES professor (id , usuario_id)
);

-- Aulas
INSERT INTO aula VALUES
(1, "saxofone", 55, "www.EMB.gov.br/saxofone",1,1,1),
(2, "trompete", 55, "www.EMB.gov.br/trompete",2,2,2),
(3, "flauta", 120, "www.EMB.gov.br/flauta",3,1,1),
(4, "clarinete", 90, "www.EMB.gov.br/clarinete",4,2,2),
(5, "baixoAcustico", 55, "www.EMB.gov.br/baixoAcustico",5,1,1);

-- prova
CREATE TABLE IF NOT EXISTS prova (
  id INT(11) NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(35) NOT NULL,
  nota DECIMAL(3,2) NOT NULL,
  aluno_id INT(11) NOT NULL,
  aluno_usuario_id INT(11) NOT NULL,
  aula_id INT(11) NOT NULL,
  aula_professor_id INT(11) NOT NULL,
  aula_professor_usuario_id INT(11) NOT NULL,
  PRIMARY KEY (id, aluno_id, aluno_usuario_id, aula_id, aula_professor_id, aula_professor_usuario_id),
    FOREIGN KEY (aluno_id , aluno_usuario_id)
    REFERENCES aluno (id , usuario_id),
    FOREIGN KEY (aula_id , aula_professor_id , aula_professor_usuario_id)
    REFERENCES aula (id , professor_id , professor_usuario_id)
);

INSERT INTO `prova` (`id`, `descricao`, `nota`, `aluno_id`, `aluno_usuario_id`, `aula_id`, `aula_professor_id`, `aula_professor_usuario_id`) VALUES (NULL, 'prova sax', '0.10', '1', '3', '1', '1', '1');
INSERT INTO `prova` (`id`, `descricao`, `nota`, `aluno_id`, `aluno_usuario_id`, `aula_id`, `aula_professor_id`, `aula_professor_usuario_id`) VALUES (NULL, 'prova trompete', '0.5', '3', '5', '2', '2', '2');

-- prova
INSERT INTO prova VALUES
(1, "saxofone", 8.00, 1, 3, 1, 1, 1),
(2, "trompete", 7.00, 2, 4, 2, 2, 2),
(3, "flauta", 9.00, 3, 5, 1, 1, 2),
(4, "clarinete", 8.00, 4, 6, 2, 2, 1);

-- profesores presentes nas apresentações
CREATE TABLE IF NOT EXISTS professor_has_apresentacao (
  professor_id INT(11) NOT NULL,
  professor_usuario_id INT(11) NOT NULL,
  apresentacao_id INT(11) NOT NULL,
  PRIMARY KEY (professor_id, professor_usuario_id, apresentacao_id),
    FOREIGN KEY (professor_id , professor_usuario_id)
    REFERENCES professor (id , usuario_id),
    FOREIGN KEY (apresentacao_id)
    REFERENCES apresentacao (id)
);


INSERT INTO `professor_has_apresentacao` (`professor_id`, `professor_usuario_id`, `apresentacao_id`) VALUES ('2', '2', '3');
INSERT INTO `professor_has_apresentacao` (`professor_id`, `professor_usuario_id`, `apresentacao_id`) VALUES ('1', '1', '2');
INSERT INTO `professor_has_apresentacao` (`professor_id`, `professor_usuario_id`, `apresentacao_id`) VALUES ('1', '1', '1');
-- professores nas apresentações
INSERT INTO professor_has_apresentacao VALUES
(1, 1, 1),
(1, 1, 2),
(2, 2, 3),
(2, 2, 4);


-- alunos presentes nas apresentações
CREATE TABLE IF NOT EXISTS aluno_has_apresentacao (
  aluno_id INT(11) NOT NULL,
  aluno_usuario_id INT(11) NOT NULL,
  apresentacao_id INT(11) NOT NULL,
  PRIMARY KEY (aluno_id, aluno_usuario_id, apresentacao_id),
    FOREIGN KEY (aluno_id , aluno_usuario_id)
    REFERENCES aluno (id , usuario_id),
    FOREIGN KEY (apresentacao_id)
    REFERENCES apresentacao (id)
);

INSERT INTO `aluno_has_apresentacao` (`aluno_id`, `aluno_usuario_id`, `apresentacao_id`) VALUES ('1', '3', '1');
INSERT INTO `aluno_has_apresentacao` (`aluno_id`, `aluno_usuario_id`, `apresentacao_id`) VALUES ('2', '4', '3');
INSERT INTO `aluno_has_apresentacao` (`aluno_id`, `aluno_usuario_id`, `apresentacao_id`) VALUES ('3', '5', '2');
INSERT INTO `aluno_has_apresentacao` (`aluno_id`, `aluno_usuario_id`, `apresentacao_id`) VALUES ('4', '6', '1');
INSERT INTO `aluno_has_apresentacao` (`aluno_id`, `aluno_usuario_id`, `apresentacao_id`) VALUES ('5', '7', '4');

-- alunos que estão nas apresentações
INSERT INTO aluno_has_apresentacao VALUES
(1, 3, 1),
(2, 4, 1),
(3, 5, 2),
(4, 6, 2),
(1, 3, 3),
(2, 4, 3),
(3, 5, 3),
(4, 6, 3);


-- instrumentos das apresentações
CREATE TABLE IF NOT EXISTS instrumento_has_apresentacao (
  instrumento_id INT(11) NOT NULL,
  apresentacao_id INT(11) NOT NULL,
  PRIMARY KEY (apresentacao_id, instrumento_id),
    FOREIGN KEY (apresentacao_id)
    REFERENCES apresentacao (id),
    FOREIGN KEY (instrumento_id)
    REFERENCES instrumento (id)
);

INSERT INTO `instrumento_has_apresentacao` (`instrumento_id`, `apresentacao_id`) VALUES ('4', '1');
INSERT INTO `instrumento_has_apresentacao` (`instrumento_id`, `apresentacao_id`) VALUES ('2', '1');

INSERT INTO `instrumento_has_apresentacao` (`instrumento_id`, `apresentacao_id`) VALUES ('3', '2');
INSERT INTO `instrumento_has_apresentacao` (`instrumento_id`, `apresentacao_id`) VALUES ('1', '2');

INSERT INTO `instrumento_has_apresentacao` (`instrumento_id`, `apresentacao_id`) VALUES ('1', '3');
INSERT INTO `instrumento_has_apresentacao` (`instrumento_id`, `apresentacao_id`) VALUES ('2', '3');

-- instrumentos das apresentações
INSERT INTO instrumento_has_apresentacao VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(1, 2),
(2, 3);

-- instrumentos dos alunos
CREATE TABLE IF NOT EXISTS instrumento_has_aluno (
  aluno_id INT(11) NOT NULL,
  aluno_usuario_id INT(11) NOT NULL,
  instrumento_id INT(11) NOT NULL,
  PRIMARY KEY (aluno_id, aluno_usuario_id, instrumento_id),
    FOREIGN KEY (aluno_id , aluno_usuario_id)
    REFERENCES aluno (id , usuario_id),
    FOREIGN KEY (instrumento_id)
    REFERENCES instrumento (id)
);

INSERT INTO `instrumento_has_aluno` (`aluno_id`, `aluno_usuario_id`, `instrumento_id`) VALUES ('1', '3', '1');
INSERT INTO `instrumento_has_aluno` (`aluno_id`, `aluno_usuario_id`, `instrumento_id`) VALUES ('2', '4', '3');
INSERT INTO `instrumento_has_aluno` (`aluno_id`, `aluno_usuario_id`, `instrumento_id`) VALUES ('3', '5', '2');
INSERT INTO `instrumento_has_aluno` (`aluno_id`, `aluno_usuario_id`, `instrumento_id`) VALUES ('4', '6', '4');
INSERT INTO `instrumento_has_aluno` (`aluno_id`, `aluno_usuario_id`, `instrumento_id`) VALUES ('2', '4', '1');

INSERT INTO instrumento_has_aluno VALUES
(1, 3, 1),
(2, 4, 2),
(3, 5, 3),
(4, 6, 1),
(1, 3, 2),
(2, 4, 4);


SELECT nome, cpf 
FROM usuario as u, aluno_has_apresentacao as a 
WHERE a.apresentacao_id = 3 and a.aluno_usuario_id = u.id;

SELECT nome, cpf 
FROM usuario as u, aluno_has_apresentacao as a 
WHERE a.apresentacao_id = 3 ;


SELECT nome 
FROM instrumento as i, instrumento_has_apresentacao as ia 
WHERE ia.apresentacao_id = 3 GROUP BY(ia.apresentacao_id);