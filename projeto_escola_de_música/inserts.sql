-- Pessoas
INSERT INTO pessoa VALUES 
(1,"professor1", "61982458596", "24563125185"),
(2,"professor2", "22222222222", "22222222222"),
(3,"aluno3", "33333333333", "33333333333"),
(4,"aluno4", "44444444444", "44444444444"),
(5,"Carlos5", "61974582332", "74859632414"),
(6,"Leticia6", "61974582136", "95863254152");

-- Usuarios
INSERT INTO usuario VALUES
(1,1, "professor1" , "password"),
(2,2, "professor2" , "password"),
(3,3, "aluno3" , "password"),
(4,3, "aluno4" , "password"),
(5,3, "Carlos5" , "password"),
(6,3, "Leticia6" , "password");

-- Funcionarios
INSERT INTO funcionario VALUES
(1, 1, 8205.36, '2021-01-30'),
(2, 2, 1080.56, '2011-05-23');

-- Professores
INSERT INTO professor VALUES
(1,1),
(2,2);

-- Alunos
INSERT INTO aluno VALUES
(1, 3),
(2, 4),
(3, 5),
(4, 6);

-- Instrumentos
INSERT INTO instrumento VALUES
(1,"saxofone"),
(2,"trompete"),
(3,"clarinete"),
(4,"flauta"),
(5,"baixoAcustico");

-- Aulas
INSERT INTO aula VALUES
(1, "saxofone", 55, "www.EMB.gov.br/saxofone"),
(2, "trompete", 55, "www.EMB.gov.br/trompete"),
(3, "flauta", 120, "www.EMB.gov.br/flauta"),
(4, "clarinete", 90, "www.EMB.gov.br/clarinete"),
(5, "baixoAcustico", 55, "www.EMB.gov.br/baixoAcustico");