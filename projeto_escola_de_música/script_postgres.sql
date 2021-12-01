-- SELECT * from usuario;
-- SELECT * from aluno;
-- SELECT * from professor;
-- SELECT * from apresentacao;
-- SELECT * from instrumento;
-- ALTER TABLE usuario ADD CONSTRAINT login UNIQUE (login);


-- Seleciona todas as informacoes das conexoes ativas do banco de dados
-- SELECT *
-- FROM pg_stat_activity
-- WHERE datname = 'escola_de_musica';

-- Sumary
-- Creates, inserts, alters 
-- Selects básicos
-- Selects joins

-- Adicionando coluna de contratado na tabela de professores
-- ALTER TABLE professor ADD COLUMN contratado bolean DEFAULT true;


DROP DATABASE IF EXISTS escola_de_musica; -- excluir database se existir

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
  usuario_id SERIAL,
  PRIMARY KEY (id, usuario_id),
    FOREIGN KEY (usuario_id)
    REFERENCES usuario (id) ON DELETE CASCADE
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
  FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE CASCADE
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
('2021-10-31', 'Halloween 2021'),
('2022-10-31', 'Halloween 2022');

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
    REFERENCES instrumento (id) ON DELETE CASCADE,
    FOREIGN KEY (professor_id , professor_usuario_id)
    REFERENCES professor (id , usuario_id) ON DELETE CASCADE
);

INSERT INTO aula (descricao, tempoDuracao, linkAula, instrumento_id, professor_id, professor_usuario_id) 
VALUES
('saxofone', 55, 'www.EMB.gov.br/saxofone',1,1,1),
('trompete', 55, 'www.EMB.gov.br/trompete',2,2,2),
('clarinete', 90, 'www.EMB.gov.br/clarinete',3,2,2),
('flauta', 120, 'www.EMB.gov.br/flauta',4,1,1),
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
    REFERENCES aluno (id , usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (aula_id , aula_professor_id , aula_professor_usuario_id)
    REFERENCES aula (id , professor_id , professor_usuario_id) ON DELETE CASCADE
);

INSERT INTO prova (descricao, nota, aluno_id, aluno_usuario_id, aula_id, aula_professor_id, aula_professor_usuario_id)
VALUES
('prova sax', 0.10, 1, 3, 1, 1, 1),
('prova trompete', 0.5, 3, 5, 2, 2, 2);

-- profesores presentes nas apresentações
CREATE TABLE IF NOT EXISTS apresentacao_professor (
  professor_id SERIAL,
  professor_usuario_id SERIAL,
  apresentacao_id SERIAL,
  PRIMARY KEY (professor_id, professor_usuario_id, apresentacao_id),
    FOREIGN KEY (professor_id , professor_usuario_id)
    REFERENCES professor (id , usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (apresentacao_id)
    REFERENCES apresentacao (id) ON DELETE CASCADE
);

INSERT INTO apresentacao_professor (professor_id, professor_usuario_id, apresentacao_id)
VALUES
(1, 1, 1),
(1, 1, 2),
(2, 2, 3),
(2, 2, 2);


-- alunos presentes nas apresentações
CREATE TABLE IF NOT EXISTS apresentacao_aluno (
  aluno_id SERIAL,
  aluno_usuario_id SERIAL,
  apresentacao_id SERIAL,
  PRIMARY KEY (aluno_id, aluno_usuario_id, apresentacao_id),
    FOREIGN KEY (aluno_id , aluno_usuario_id)
    REFERENCES aluno (id , usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (apresentacao_id)
    REFERENCES apresentacao (id) ON DELETE CASCADE
);

INSERT INTO apresentacao_aluno (aluno_id, aluno_usuario_id, apresentacao_id)
VALUES
(1, 3, 1),
(2, 4, 1),
(3, 5, 2),
(4, 6, 2),
(1, 3, 3),
(2, 4, 3),
(3, 5, 3),
(4, 6, 3),
(1, 3, 4),
(2, 4, 4),
(3, 5, 4);

-- instrumentos das apresentações
CREATE TABLE IF NOT EXISTS apresentacao_instrumento (
  instrumento_id SERIAL,
  apresentacao_id SERIAL,
  PRIMARY KEY (apresentacao_id, instrumento_id),
    FOREIGN KEY (apresentacao_id)
    REFERENCES apresentacao (id) ON DELETE CASCADE,
    FOREIGN KEY (instrumento_id)
    REFERENCES instrumento (id) ON DELETE CASCADE
);

INSERT INTO apresentacao_instrumento (instrumento_id, apresentacao_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(1, 2),
(2, 3);

-- instrumentos dos alunos
CREATE TABLE IF NOT EXISTS aluno_instrumento (
  aluno_id SERIAL,
  aluno_usuario_id SERIAL,
  instrumento_id SERIAL,
  PRIMARY KEY (aluno_id, aluno_usuario_id, instrumento_id),
    FOREIGN KEY (aluno_id , aluno_usuario_id)
    REFERENCES aluno (id , usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (instrumento_id)
    REFERENCES instrumento (id) ON DELETE CASCADE
);

INSERT INTO aluno_instrumento (aluno_id, aluno_usuario_id, instrumento_id) 
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

-- selecionar nome do aluno e nome dos seus instrumentos respectivos
SELECT usuario.nome AS "nome usuario", instrumento.nome AS "nome do instrumento"
  FROM aluno_instrumento
  JOIN usuario     ON usuario.id = aluno_instrumento.aluno_usuario_id
  JOIN instrumento ON instrumento.id = aluno_instrumento.instrumento_id;


-- selecionando nome dos alunos e descricao das apresentacoes que cada aluno participou
SELECT usuario.nome AS "nome do aluno", apresentacao.descricao AS "descricao da apresentacao"
  FROM apresentacao_aluno
  JOIN usuario      ON usuario.id = apresentacao_aluno.aluno_usuario_id
  JOIN apresentacao ON apresentacao.id = apresentacao_aluno.apresentacao_id;

-- selecionando todos os alunos da apresentacao com o id 3
SELECT usuario.nome AS "nome do aluno"
  FROM apresentacao_aluno
  JOIN usuario ON usuario.id = apresentacao_aluno.aluno_usuario_id
WHERE apresentacao_aluno.apresentacao_id = 3;

-- selecionando nomes do alunos, descricao da apresentacao, data da apresentacao onde a descricao da aparesentacao =  Halloween 2021
SELECT usuario.nome AS "nome do usuario", AP.descricao AS "descricao da apresentacao", AP.data_apresentacao AS "data apresentacao"
  FROM apresentacao AS ap
  JOIN apresentacao_aluno ON apresentacao_aluno.apresentacao_id = ap.id
  JOIN usuario            ON usuario.id = apresentacao_aluno.aluno_usuario_id
WHERE ap.descricao = 'Halloween 2021';

-- selecionando nomes do alunos, descricao da apresentacao, data da apresentacao onde a descricao da aparesentacao tem Halloween no inicio da descrição
SELECT usuario.nome AS "nome do usuario", AP.descricao AS "descricao da apresentacao", AP.data_apresentacao AS "data apresentacao"
  FROM apresentacao AS ap
  JOIN apresentacao_aluno ON apresentacao_aluno.apresentacao_id = ap.id
  JOIN usuario            ON usuario.id = apresentacao_aluno.aluno_usuario_id
WHERE ap.descricao LIKE 'Halloween%';

-- selecionando nome dos alunos, descricao da apresentacao, data da apresentacao onde a descricao da aparesentacao tem Halloween no inicio da descrição ordenando por nome do aluno
SELECT usuario.nome AS "nome do usuario", AP.descricao AS "descricao da apresentacao", AP.data_apresentacao AS "data apresentacao"
  FROM apresentacao AS ap
  JOIN apresentacao_aluno ON apresentacao_aluno.apresentacao_id = ap.id
  JOIN usuario            ON usuario.id = apresentacao_aluno.aluno_usuario_id
WHERE ap.descricao LIKE 'Halloween%'
ORDER BY usuario.nome;

-- Mostrar quantidade de alunos em cada apresentação
SELECT AP.descricao AS "descricao da apresentacao", COUNT(AP.id) AS "Quantidade de alunos"
  FROM apresentacao AS AP
  JOIN apresentacao_aluno ON apresentacao_aluno.apresentacao_id = ap.id
GROUP BY AP.descricao
ORDER BY AP.descricao ASC;

-- Selecionar descricao da aula, instrumento e nome do professor
SELECT aula.descricao AS "Descrição da aula", instrumento.nome AS "Nome do instrumento", usuario.nome AS "Nome do professor"
FROM aula
JOIN usuario     ON usuario.id = aula.professor_usuario_id
JOIN instrumento ON instrumento.id = aula.instrumento_id;

-- Selecionar nome do aluno e quantidade de apresentações que o aluno participou
SELECT usuario.nome AS "Nome do aluno", COUNT(usuario.id)
FROM apresentacao_aluno
JOIN usuario ON usuario.id = apresentacao_aluno.aluno_usuario_id
GROUP BY usuario.nome
ORDER BY usuario.nome;

-- tempo de contrato dos professor ainda contratados
SELECT 
	usuario.nome AS "nome do professor", 
	AGE(professor.data_admicao) AS "tempo de contrato" 
	FROM professor 
	JOIN usuario ON professor.usuario_id = usuario.id
  WHERE professor.contratado;

-- Viewers 

-- VIEW para mostrar quantidade de alunos em cada apresentacao
CREATE VIEW vw_quantidade_alunos_apresentacao AS 
SELECT AP.descricao AS "descricao da apresentacao", COUNT(AP.id) AS "Quantidade de alunos"
  FROM apresentacao AS AP
  JOIN apresentacao_aluno ON apresentacao_aluno.apresentacao_id = ap.id
GROUP BY AP.descricao
ORDER BY AP.descricao ASC;

-- view nome do aluno e quantidade de apresentacoes que ele participou
CREATE VIEW vw_quantidade_de_apresentacoes_todos_alunos AS
SELECT usuario.nome AS "Nome do aluno", COUNT(usuario.id)
FROM apresentacao_aluno
JOIN usuario ON usuario.id = apresentacao_aluno.aluno_usuario_id
GROUP BY usuario.nome
ORDER BY usuario.nome;

-- view nome do professor e tempo de contrato ate agora
CREATE VIEW vw_tempo_contrato_professor_now AS
SELECT 
	usuario.nome AS "nome do professor", 
	AGE(professor.data_admicao) AS "tempo de contrato" 
	FROM professor 
	JOIN usuario ON professor.usuario_id = usuario.id
  WHERE professor.contratado;

CREATE FUNCTION adicionaProfessor() RETURNS INTEGER AS '
  SELECT (5+3) + 2
' LANGUAGE SQL;

-- recod seria atribuir qualquer tipo de retorno
DROP FUNCTION busca_professores_por_salario
CREATE FUNCTION busca_professores_por_salario(valor_salario DECIMAL) RETURNS SETOF professor AS $$
	SELECT * FROM professor WHERE professor.salariobase > valor_salario;
$$ LANGUAGE SQL;

SELECT * from busca_professores_salario(2000);

-- Funcao para adicionar um novo usuario 
CREATE FUNCTION 
  adiciona_usuario(
    login varchar(50), 
    senha varchar(50), 
    nome varchar(50), 
    telefone varchar(12), 
    cpf varchar(15)
  )
  RETURNS void AS $$
    
  INSERT INTO usuario (login, senha, nome, telefone, cpf) values(login, senha, nome, telefone, cpf)

  $$ LANGUAGE SQL; 

SELECT adiciona_usuario('luizPibo', '1234554321', 'luiz fernandinho', '61983385897', '12341235122');
-- Funcao para adicionar um novo professor 
DROP FUNCTION adiciona_professor()
CREATE FUNCTION adiciona_professor(salario_base REAL, data_admicao DATE, id_user INTEGER) RETURNS void AS $$
	INSERT INTO professor (salarioBase, data_admicao, usuario_id) VALUES (salario_base, data_admicao, id_user)
$$ LANGUAGE plpgsql;

SELECT adiciona_professor(4500,'2021-12-01', 7);


-- DELETE FROM usuario WHERE id = 7;
-- SELECT * FROM professor

-- plpgsql

CREATE FUNCTION 
  adiciona_usuario(
    login varchar(50), 
    senha varchar(50), 
    nome varchar(50), 
    telefone varchar(12), 
    cpf varchar(15)
  )
  RETURNS boolean AS $$
  BEGIN
    INSERT INTO usuario (login, senha, nome, telefone, cpf) values(login, senha, nome, telefone, cpf);
    RETURN true; 
  END
  $$ LANGUAGE plpgsql; 

-- checagem

CREATE OR REPLACE FUNCTION mostra_mensagem() RETURNS VARCHAR(50) AS $$
  DECLARE
    aux VARCHAR(50) DEFAULT 'oie';
  BEGIN
    RETURN aux; 
  END
$$ LANGUAGE plpgsql; 

CREATE OR REPLACE FUNCTION salario_ok(professor professor) RETURNS VARCHAR AS $$
  DECLARE
    aux VARCHAR(50) DEFAULT 'oie';
  BEGIN
    IF professor.salariobase > 5000 THEN
      RETURN 'Salário acima de R$ 5000';
    END IF;
    IF professor.salariobase < 2000 THEN
      RETURN 'Salário abaixo de R$ 2000';
    END IF;
   RETURN 'Não entra na selecao';
  END;
$$ LANGUAGE plpgsql; 

-- Selecionar todos os professores e checar qual deles tem salario acima de 5000 e os que tem salario a baixo de 2000
SELECT usuario.nome, professor.salariobase, salario_ok(professor)
FROM professor
JOIN usuario ON usuario.id = professor.usuario_id;



CREATE OR REPLACE FUNCTION faixa_salarial(professor professor) RETURNS VARCHAR AS $$
  DECLARE
    aux VARCHAR(50) DEFAULT 'oie';
  BEGIN
    CASE 
      WHEN professor.salariobase<1000 THEN
        RETURN 'salario menor que R$ 1000';
      WHEN professor.salariobase<2000 THEN
        RETURN 'salario menor que R$ 2000';
      WHEN professor.salariobase<3000 THEN
        RETURN 'salario menor que R$ 3000';
      WHEN professor.salariobase>3000 THEN
        RETURN 'salario superior a R$ 3000';
    END CASE;
  END;
$$ LANGUAGE plpgsql; 

SELECT usuario.nome, professor.salariobase, faixa_salarial(professor)
FROM professor
JOIN usuario ON usuario.id = professor.usuario_id;