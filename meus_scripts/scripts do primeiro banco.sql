--Criando banco de dados caso ele não exista

CREATE SCHEMA IF NOT EXISTS 'laboratorio' DEFAULT CHARACTER SET utf8

--Criando tabela de clientes caso ela não exista


CREATE TABLE IF NOT EXISTS clientes (
	idCliente int(11)NOT NULL,
	nome VARCHAR(45) NOT NULL,
	endereco VARCHAR(75) NOT NULL,
	cidade VARCHAR(45) NOT NULL,
	cep VARCHAR(45) NOT NULL,
	uf VARCHAR(2) NOT NULL,
	cnpj VARCHAR(15) NOT NULL,
	ie VARCHAR(45) NOT NULL,
	PRIMARY KEY (idCliente)
),

CREATE TABLE IF NOT EXISTS vendedores (
	idVendedor INT(11) NOT NULL,
	nome VARCHAR(45) NOT NULL,
	salario DECIMAL(7,2) NOT NULL,
	faixaComissao VARCHAR(1) NOT NULL,
	PRIMARY KEY (idVendedor)
),

CREATE TABLE IF NOT EXISTS pedidos (
	idPedido INT(11) NOT NULL,
	prazoEntrega INT(11) NOT NULL,
	clientes_idCliente INT(11) NOT NULL,
	vendedores_idVendedor INT(11) NOT NULL,
	PRIMARY KEY (idPedido),
	FOREIGN KEY(clientes_idCliente) REFERENCES clientes(idCliente),
	FOREIGN KEY(vendedores_idVendedor) REFERENCES vendedores(idVendedor),

)
