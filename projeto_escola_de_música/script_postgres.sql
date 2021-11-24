-- SELECT * from usuario;
-- SELECT * from aluno;
-- SELECT * from professor;
-- SELECT * from apresentacao;
-- SELECT * from instrumento;

-- ALTER TABLE usuario ADD CONSTRAINT login UNIQUE (login);


DROP DATABASE IF EXISTS escola_de_musica; -- excluir database

CREATE DATABASE IF NOT EXISTS escola_de_musica
DEFAULT CHARACTER SET utf8 -- uft8 (8-bit Unicode Transformation Format - Pode representar qualquer caracter universal padrão do Unicode, sendo também compatível com o ASCII)
DEFAULT COLLATE utf8_general_ci;

USE escola_de_musica;-- selecionar banco de dados

-- usuario
CREATE TABLE IF NOT EXISTS usuario (
  id SERIAL PRIMARY KEY,
  login VARCHAR(50) NOT NULL UNIQUE,
  senha VARCHAR(50) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  telefone VARCHAR(12) NOT NULL,
  cpf CHAR(15) NOT NULL UNIQUE
);

INSERT INTO usuario (login,senha,nome,telefone,cpf) 
VALUES
	('professor1', 'password', 'professor1', '61982458596', '24563125185'),
	('professor2' , 'password', 'professor2', '22222222222', '22222222222'),
	('aluno3' , 'password', 'aluno3', '33333333333', '33333333333'),
	('aluno4' , 'password', 'aluno4', '44444444444', '44444444444'),
	('Carlos5' , 'password', 'Carlos5', '61974582332', '74859632414'),
	('Leticia6' , 'password', 'Leticia6', '61974582136', '95863254152');


-- aluno
CREATE TABLE IF NOT EXISTS aluno (
  id SERIAL,
  usuario_id SERIAL UNIQUE,
  PRIMARY KEY (id, usuario_id),
    FOREIGN KEY (usuario_id)
    REFERENCES usuario (id)
);

INSERT INTO aluno (usuario_id) 
VALUES
(3),
(4),
(5),
(6);

-- professor
CREATE TABLE IF NOT EXISTS professor (
  id SERIAL,
  salarioBase REAL NOT NULL,
  data_admicao DATE NOT NULL,
  usuario_id SERIAL NOT NULL UNIQUE,
  PRIMARY KEY (id, usuario_id),
  FOREIGN KEY (usuario_id) REFERENCES usuario (id)
);

INSERT INTO professor (salarioBase, data_admicao, usuario_id) 
VALUES
(8205.36, '2021-01-30',1),
(1080.56, '2011-05-23',2),
(10000.00, '2021-01-30',6);

-- apresentacao 
CREATE TABLE IF NOT EXISTS apresentacao (
    id SERIAL PRIMARY KEY,
    data_apresentacao DATE NOT NULL,
    descricao TEXT
);

INSERT INTO  apresentacao (data_apresentacao, descricao)
VALUES 
('2019-12-31', 'virada de ano 2019'),
('2021-12-25', 'Natal 2021'),
('2021-10-31', 'Halloween 2021');

-- instrumento
CREATE TABLE IF NOT EXISTS instrumento (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(70) NOT NULL UNIQUE
);

INSERT INTO instrumento (nome)
VALUES
('saxofone'),
('trompete'),
('clarinete'),
('flauta'),
('baixoAcustico');

-- aula
CREATE TABLE IF NOT EXISTS aula (
  id SERIAL,
  descricao VARCHAR(70) NOT NULL,
  tempoDuracao INT NOT NULL,
  linkAula VARCHAR(255) NOT NULL UNIQUE,
  instrumento_id SERIAL NOT NULL,
  professor_id SERIAL NOT NULL,
  professor_usuario_id SERIAL NOT NULL,
  PRIMARY KEY (id, professor_id, professor_usuario_id),
	FOREIGN KEY (instrumento_id)
    REFERENCES instrumento (id),
    FOREIGN KEY (professor_id , professor_usuario_id)
    REFERENCES professor (id , usuario_id)
);

INSERT INTO aula (descricao, tempoDuracao, linkAula, instrumento_id, professor_id, professor_usuario_id) 
VALUES
('saxofone', 55, 'www.EMB.gov.br/saxofone',1,1,1),
('trompete', 55, 'www.EMB.gov.br/trompete',2,2,2),
('flauta', 120, 'www.EMB.gov.br/flauta',3,1,1),
('clarinete', 90, 'www.EMB.gov.br/clarinete',4,2,2),
('baixoAcustico', 55, 'www.EMB.gov.br/baixoAcustico',5,1,1);

-- prova
CREATE TABLE IF NOT EXISTS prova (
  id SERIAL,
  descricao TEXT,
  nota REAL,
  aluno_id SERIAL,
  aluno_usuario_id SERIAL,
  aula_id SERIAL,
  aula_professor_id SERIAL,
  aula_professor_usuario_id SERIAL,
  PRIMARY KEY (id, aluno_id, aluno_usuario_id, aula_id, aula_professor_id, aula_professor_usuario_id),
    FOREIGN KEY (aluno_id , aluno_usuario_id)
    REFERENCES aluno (id , usuario_id),
    FOREIGN KEY (aula_id , aula_professor_id , aula_professor_usuario_id)
    REFERENCES aula (id , professor_id , professor_usuario_id)
);

INSERT INTO prova (descricao, nota, aluno_id, aluno_usuario_id, aula_id, aula_professor_id, aula_professor_usuario_id)
VALUES
('prova sax', 0.10, 1, 3, 1, 1, 1),
('prova trompete', 0.5, 3, 5, 2, 2, 2);

-- profesores presentes nas apresentações
CREATE TABLE IF NOT EXISTS professor_has_apresentacao (
  professor_id SERIAL,
  professor_usuario_id SERIAL,
  apresentacao_id SERIAL,
  PRIMARY KEY (professor_id, professor_usuario_id, apresentacao_id),
    FOREIGN KEY (professor_id , professor_usuario_id)
    REFERENCES professor (id , usuario_id),
    FOREIGN KEY (apresentacao_id)
    REFERENCES apresentacao (id)
);

INSERT INTO professor_has_apresentacao (professor_id, professor_usuario_id, apresentacao_id)
VALUES
(1, 1, 1),
(1, 1, 2),
(2, 2, 3),
(2, 2, 4);


-- alunos presentes nas apresentações
CREATE TABLE IF NOT EXISTS aluno_has_apresentacao (
  aluno_id SERIAL,
  aluno_usuario_id SERIAL,
  apresentacao_id SERIAL,
  PRIMARY KEY (aluno_id, aluno_usuario_id, apresentacao_id),
    FOREIGN KEY (aluno_id , aluno_usuario_id)
    REFERENCES aluno (id , usuario_id),
    FOREIGN KEY (apresentacao_id)
    REFERENCES apresentacao (id)
);

INSERT INTO aluno_has_apresentacao (aluno_id, aluno_usuario_id, apresentacao_id)
VALUES
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
  instrumento_id SERIAL,
  apresentacao_id SERIAL,
  PRIMARY KEY (apresentacao_id, instrumento_id),
    FOREIGN KEY (apresentacao_id)
    REFERENCES apresentacao (id),
    FOREIGN KEY (instrumento_id)
    REFERENCES instrumento (id)
);

INSERT INTO instrumento_has_apresentacao (instrumento_id, apresentacao_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(1, 2),
(2, 3);

-- instrumentos dos alunos
CREATE TABLE IF NOT EXISTS instrumento_has_aluno (
  aluno_id SERIAL,
  aluno_usuario_id SERIAL,
  instrumento_id SERIAL,
  PRIMARY KEY (aluno_id, aluno_usuario_id, instrumento_id),
    FOREIGN KEY (aluno_id , aluno_usuario_id)
    REFERENCES aluno (id , usuario_id),
    FOREIGN KEY (instrumento_id)
    REFERENCES instrumento (id)
);

INSERT INTO instrumento_has_aluno (aluno_id, aluno_usuario_id, instrumento_id) 
VALUES
(1, 3, 1),
(2, 4, 2),
(3, 5, 3),
(4, 6, 1),
(1, 3, 2),
(2, 4, 4);

-- selecionando todos os dados do usuario onde o login seja igual a Leticia6
SELECT * 
FROM usuario
WHERE login = 'Leticia6';

-- selecionando todos os dados do usuario onde o login seja diferente de Leticia6
SELECT * 
FROM usuario
WHERE login <> 'Leticia6';
-- WHERE login != 'Leticia6';

-- selecionando todos os dados do usuario onde o login seja parecidos com leticia
SELECT * 
FROM usuario
WHERE login LIKE 'Leticia_';

-- selecionando todos os dados do usuario onde o login termina com algo parecido com 6
SELECT * 
FROM usuario
WHERE login LIKE '%6';

-- selecionando todos os dados do usuario onde o login não termina com algo parecido com 6
SELECT * 
FROM usuario
WHERE login NOT LIKE '%6';

-- selecionando todas as paresentações que ocorreram em uma data maior(DEPOIS) que 2021-01-01
SELECT *
FROM apresentacao
WHERE data_apresentacao >= '2021-01-01';

-- selecionando todas as apresentações que ocorreram em entre 2021-01-01 e 2021-12-01
SELECT *
FROM apresentacao
WHERE data_apresentacao BETWEEN '2021-01-01' AND '2021-12-01';

-- selecionando todas as aulas e com o tempo de duração em ordem cresente
SELECT * 
FROM aula
ORDER BY tempoduracao DESC;

-- selecionando todas as aulas com o tempo de duracao maior que 55 e que tenham sido aplicadas pelo professor com id 2
SELECT * 
FROM aula
WHERE tempoduracao>55 AND professor_id = 2;

-- selecionando todas as aulas com o tempo de duracao maior que 55 e que tenham sido aplicadas pelo professor com id 2 ou 1
SELECT * 
FROM aula
WHERE tempoduracao>55 AND (professor_id = 2 OR professor_id = 1);

--



