-- db_init/init.sql

-- Garante que você está usando o banco de dados 'controleclientes'
CREATE SCHEMA IF NOT EXISTS controleclientes;

-- Cria a tabela 'clientes' se ela não existir
-- Ajuste os tipos de dados e nomes das colunas conforme sua necessidade (id, nome, preco)
CREATE TABLE IF NOT EXISTS clientes (
    cpfcli VARCHAR(255) PRIMARY KEY,
    nomecli VARCHAR(255) NOT NULL,
    endcli VARCHAR(255),
    telcli VARCHAR(255)
);

