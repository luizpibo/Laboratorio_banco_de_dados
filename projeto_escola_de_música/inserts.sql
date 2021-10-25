
-- Usuarios
INSERT INTO usuario VALUES
(1,1, "professor1", "password","professor1","61982458596","24563125185"),
(2,2, "professor2" , "password", "professor2", "22222222222", "22222222222"),
(3,3, "aluno3" , "password","aluno3", "33333333333", "33333333333"),
(4,3, "aluno4" , "password","aluno4", "44444444444", "44444444444"),
(5,3, "Carlos5" , "password","Carlos5", "61974582332", "74859632414"),
(6,3, "Leticia6" , "password","Leticia6", "61974582136", "95863254152");
-- Professores
INSERT INTO professor VALUES
(1,1),(2,2),(3,3),(4,4);

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
(3,"flauta"),
(4,"clarinete"),
(5,"baixoAcustico");

-- Aulas
INSERT INTO aula VALUES
(1, "saxofone", 55, "www.EMB.gov.br/saxofone",1,1,1),
(2, "trompete", 55, "www.EMB.gov.br/trompete",2,2,2),
(3, "flauta", 120, "www.EMB.gov.br/flauta",3,1,1),
(4, "clarinete", 90, "www.EMB.gov.br/clarinete",4,2,2),
(5, "baixoAcustico", 55, "www.EMB.gov.br/baixoAcustico",5,1,1);

-- apresentacao
INSERT INTO  apresentacao VALUES 
(1, "2019-12-31", "virada de ano 2019"),
(2, "2021-12-25", "Natal 2021"),
(3, "2021-10-31", "Halloween 2021");

-- prova
INSERT INTO prova VALUES
(1, "saxofone", 8, 1, 3, 1, 1, 1, 1),
(2, "trompete", 7, 2, 4, 2, 2, 2, 2),
(3, "flauta", 9, 3, 5, 1, 1, 2, 2),
(4, "clarinete", 8, 4, 6, 2, 2, 1, 1);

-- professores nas apresentações
INSERT INTO professor_has_apresentacao VALUES
(1, 1, 1),
(1, 1, 2),
(2, 2, 3),
(2, 2, 4);


-- alunos nas paresentações
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
INSERT INTO instrumento_has_apresentacao VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(1, 2),
(2, 3);

-- instrumentos dos alunos
INSERT INTO instrumento_has_aluno VALUES
(1, 3, 1),
(2, 4, 2),
(3, 5, 3),
(4, 6, 1),
(1, 3, 2),
(2, 4, 4);

