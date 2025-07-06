# CRUD-Java-Web
Este projeto é um CRUD (Create, Read, Update, Delete) simples e funcional desenvolvido em Java utilizando JSP (JavaServer Pages) para a interface web. Ele demonstra a integração de uma aplicação web Java com um banco de dados MySQL, tudo orquestrado e conteinerizado com Docker Compose.

## Funcionalidades
- Create (Criar): Adicionar novos registros de clientes ao banco de dados.

- Read (Ler): Visualizar a lista de clientes existentes.

- Update (Atualizar): Modificar informações de clientes já cadastrados.

- Delete (Excluir): Remover registros de clientes do banco de dados.

## Tecnologias Utilizadas
- Backend: Java (Servlets, JSP)

- Servidor de Aplicação: Apache Tomcat (via Docker)

- Banco de Dados: MySQL 8.0 (via Docker)

- Construção do Projeto: Apache Ant

- Conteinerização: Docker e Docker Compose

- Gerenciamento de Dependências: MySQL Connector/J (para conexão JDBC)

## Pré-requisitos

Para rodar este projeto em sua máquina, você precisará ter instalado:

- Git: Para clonar o repositório.

- Docker Desktop: Inclui Docker Engine e Docker Compose. (Verifique sua instalação com docker --version e docker-compose --version)

- JDK 17 ou superior: (Opcional para rodar localmente sem Docker, mas necessário para compilar o projeto com Ant se você não usar o Docker para o build).

- Apache Ant: (Opcional, pois o Dockerfile pode lidar com o build se configurado para isso, mas útil para o desenvolvimento local).

- IDE Java (Recomendado): NetBeans (utilizado no desenvolvimento), IntelliJ IDEA, Eclipse.

## Configuração do Banco de Dados

O banco de dados MySQL (controleclientes) e a tabela clientes serão criados automaticamente dentro do contêiner Docker na primeira vez que o projeto for iniciado (ou quando o volume de dados do Docker for limpo).

- Banco de Dados: controleclientes

- Tabela: clientes

- Credenciais (root): admin

A estrutura da tabela clientes é definida no arquivo db_init/init.sql:

```
SQL

CREATE SCHEMA IF NOT EXISTS controleclientes;
USE controleclientes;
CREATE TABLE IF NOT EXISTS clientes (
    cpf VARCHAR(255) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(255)
);
```
# Passos para Subir o Projeto
Siga estes passos para configurar e executar a aplicação:

- Faça o download do repositório: 

Bash
git clone https://github.com/NickDevD/CRUD_JAVA_JSP.git
cd CRUD_JAVA_JSP 

# Navegue até a pasta raiz do projeto
Abra o projeto em sua IDE (Opcional):

O NetBeans foi utilizado no desenvolvimento e a estrutura do projeto foi otimizada para ele (nbproject/).

Gere o arquivo WAR da aplicação:
Este projeto usa Apache Ant para o build. Você precisará gerar o arquivo .war (Web Archive) que será implantado no Tomcat dentro do Docker.

Bash

ant clean build
Este comando irá compilar o código e criar o arquivo .war (ex: formulario_web.war) dentro da pasta dist/.

Remova volumes Docker armazenados (Crucial para inicialização do DB):
Este passo garante que o banco de dados MySQL seja inicializado do zero, executando o script db_init/init.sql e criando a tabela clientes.

Bash

docker-compose down -v
down: Para os serviços e remove os contêineres.

-v: Remove os volumes de dados nomeados, o que é essencial para limpar o estado anterior do banco de dados e forçar o init.sql a ser executado na próxima subida.

Construa as imagens e execute a aplicação:

Bash

docker-compose up --build -d
up: Inicia os serviços definidos no docker-compose.yml.

--build: Garante que a imagem da sua aplicação (web-app) seja reconstruída com o .war mais recente.

-d: Inicia os serviços em modo detached (segundo plano), liberando seu terminal.

Observação: O serviço mysql-db possui um healthcheck e o web-app depende dele, garantindo que o banco de dados esteja pronto antes da aplicação web iniciar.

Acesse a aplicação:
Após alguns instantes para os contêineres iniciarem, abra seu navegador e acesse:

http://localhost:8081/

# Estrutura do Projeto

```
CRUD_JAVA_JSP/
├── .github/              # Configurações do GitHub (ex: GitHub Actions)
├── .idea/                # Arquivos de configuração do IntelliJ IDEA
├── build/                # Diretório de saída da compilação Ant
├── db_init/              # Contém scripts SQL para inicialização do banco de dados
│   └── init.sql          # Script para criar o banco de dados e tabelas
├── dist/                 # Diretório de distribuição (onde o .war é gerado pelo Ant)
├── nbproject/            # Arquivos de configuração do NetBeans
├── src/                  # Código fonte Java (Servlets, classes auxiliares)
├── web/                  # Conteúdo web da aplicação (JSPs, recursos estáticos, WEB-INF)
├── .dockerignore         # Arquivo para ignorar arquivos/pastas ao construir a imagem Docker
├── build.xml             # Arquivo de configuração do Apache Ant para o processo de build
├── docker-compose.yml    # Define e orquestra os serviços Docker (app e MySQL)
├── Dockerfile            # Instruções para construir a imagem Docker da sua aplicação web
└── README.md             # Este arquivo README
```
