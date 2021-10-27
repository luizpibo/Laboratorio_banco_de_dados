SELECT provas.id, provas.nota, professores.id_funcionario, professores.id_usuario, professores.id_pessoa, professores.nome, alunos.id_funcionario, alunos.id_usuario, alunos.id_pessoa, alunos.nome
FROM provas INNER JOIN professores ON provas.id_professor = professores.id
INNER JOIN alunos ON provas.id_aluno = alunos.id;

SELECT apresentacoes.id, apresentacoes.data_apresentacao, professores.id, alunos.id 
FROM apresentacoes 
INNER JOIN professores ON apresentacoes.id_professores = professores.id 
INNER JOIN alunos ON apresentacoes.id_alunos = alunos.id;

SELECT * FROM instrumentos INNER JOIN alunos ON instrumentos.id_alunos = alunos.id;

SELECT * FROM usuarios INNER JOIN alunos ON alunos.id_usuarios = usuarios.id;


 
 
 