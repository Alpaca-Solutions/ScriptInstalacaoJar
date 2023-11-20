create database AlpacaDB;
use AlpacaDB;

create table Endereco(
idEndereco int primary key auto_increment,
cep varchar(8),
rua varchar(50),
numero varchar(50),
bairro varchar(50),
cidade varchar(50),
estado varchar(50)
);

create table Empresa(
idEmpresa int primary key auto_increment,
nomeFantasia varchar(45),
razaoSocial varchar(45),
cnpj varchar(14),
fk_endereco int,
constraint fk_endereco foreign key (fk_endereco)
references Endereco(idEndereco)
);

create table Telefone(
idTelefone int primary key auto_increment,
numero char(11),
tipo varchar(45),
fkEmpresa int,
constraint fkEmpresa foreign key (fkEmpresa)
references Empresa(idEmpresa)
);


Create table Usuario(
idUsuario int primary key auto_increment,
nome varchar(50),
email varchar(50),
senha varchar(50),
tipoAcesso varchar(20),
nivelAcesso varchar(20),
ativo boolean,
fkEmpresa int,
constraint fkEmpresa foreign key (fkEmpresa)
references Empresa(idEmpresa)
);

create table Unidade(
idUnidade int primary key auto_increment,
nomeInstituicao varchar(45),
ativo boolean,
fkEndereco int,
constraint fkEndereco foreign key (fkEndereco) references Endereco(idEndereco)
);

create table Maquina(
idMaquina int primary key auto_increment,
NomeMaquina varchar(50) not null,
ipMaquina varchar(45),
sistemaOperacional varchar(45),
statusMaquina boolean,
ativo boolean,
fkEmpresa int,
fKUnidade int,
constraint fkEmpresa foreign key (fkEmpresa)
references Empresa(idEmpresa),
constraint fkUnidade foreign key (fKUnidade)
references Unidade(idUnidade)
);

CREATE TABLE TipoComponente (
  idTipoComponente INT PRIMARY KEY auto_increment,
  Cpu_ VARCHAR(20),
  DiscoRigido VARCHAR(45),
  Memoria VARCHAR(45),
  Rede VARCHAR(45)
);

CREATE TABLE Config (
  idComponentes INT PRIMARY KEY auto_increment,
  ValorConfiguracao VARCHAR(45),
  fkMaquina INT,
  fkTipoComponenteID INT,
  FOREIGN KEY (fkMaquina) REFERENCES Maquina(idMaquina),
  FOREIGN KEY (fkTipoComponenteID) REFERENCES TipoComponente(idTipoComponente)
);

CREATE TABLE UnidadeMedida (
  idParametros INT PRIMARY KEY auto_increment,
  Tipo VARCHAR(45),
  Valor VARCHAR(45),
  fkMaquina INT,
  FOREIGN KEY (fkMaquina) REFERENCES Maquina(idMaquina)
);

CREATE TABLE Medicoes (
  idMedicoes INT PRIMARY KEY auto_increment,
  valor DECIMAL(10,2),
  data_hora_leitura DATETIME,
  id_computador INT,
  fkTipoComponenteID INT,
  fkUnidadeMedidaID INT,
  FOREIGN KEY (fkTipoComponenteID) REFERENCES TipoComponente(idTipoComponente),
  FOREIGN KEY (fkUnidadeMedidaID) REFERENCES UnidadeMedida(idParametros)
);

CREATE TABLE MetricasAlertas (
  idMetricasAlertas INT PRIMARY KEY auto_increment,
  TipoComponente VARCHAR(45),
  maximo VARCHAR(45),
  mensagemAlerta VARCHAR(45),
  minimo VARCHAR(45),
  dhHoraAlerta DATETIME,
  fkUnidadeMedida INT,
  fkTipoComponente INT,
  fkConfiguracao INT,
  FOREIGN KEY (fkUnidadeMedida) REFERENCES UnidadeMedida(idParametros),
  FOREIGN KEY (fkTipoComponente) REFERENCES TipoComponente(idTipoComponente),
  FOREIGN KEY (fkConfiguracao) REFERENCES Config(idComponentes)
);