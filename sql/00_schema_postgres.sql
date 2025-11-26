-- 00_schema_postgres.sql
-- Schema para Shop Fácil (PostgreSQL)

-- limpar caso existam (ordem: dependências primeiro)
DROP TABLE IF EXISTS item_pedido CASCADE;
DROP TABLE IF EXISTS pagamento CASCADE;
DROP TABLE IF EXISTS pedido CASCADE;
DROP TABLE IF EXISTS produto CASCADE;
DROP TABLE IF EXISTS categoria CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;

-- Tabela CLIENTE
CREATE TABLE cliente (
  id_cliente      SERIAL PRIMARY KEY,
  nome            VARCHAR(150) NOT NULL,
  email           VARCHAR(150) UNIQUE NOT NULL,
  telefone        VARCHAR(20),
  cpf             VARCHAR(14) UNIQUE,
  endereco        TEXT
);

-- Tabela CATEGORIA
CREATE TABLE categoria (
  id_categoria    SERIAL PRIMARY KEY,
  nome            VARCHAR(100) NOT NULL,
  descricao       TEXT
);

-- Tabela PRODUTO
CREATE TABLE produto (
  id_produto      SERIAL PRIMARY KEY,
  nome            VARCHAR(150) NOT NULL,
  descricao       TEXT,
  preco           NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
  estoque         INTEGER NOT NULL DEFAULT 0 CHECK (estoque >= 0),
  id_categoria    INTEGER NOT NULL,
  CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria)
    REFERENCES categoria(id_categoria)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

-- Tabela PEDIDO
CREATE TABLE pedido (
  id_pedido       SERIAL PRIMARY KEY,
  data            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  valor_total     NUMERIC(12,2) NOT NULL DEFAULT 0,
  status          VARCHAR(30) NOT NULL DEFAULT 'PENDENTE',
  id_cliente      INTEGER NOT NULL,
  CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

-- Tabela ITEM_PEDIDO (associativa)
CREATE TABLE item_pedido (
  id_item         SERIAL PRIMARY KEY,
  id_pedido       INTEGER NOT NULL,
  id_produto      INTEGER NOT NULL,
  quantidade      INTEGER NOT NULL CHECK (quantidade > 0),
  valor_unitario  NUMERIC(10,2) NOT NULL CHECK (valor_unitario >= 0),
  CONSTRAINT fk_item_pedido_pedido FOREIGN KEY (id_pedido)
    REFERENCES pedido(id_pedido)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_item_pedido_produto FOREIGN KEY (id_produto)
    REFERENCES produto(id_produto)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

-- Tabela PAGAMENTO
CREATE TABLE pagamento (
  id_pagamento    SERIAL PRIMARY KEY,
  id_pedido       INTEGER UNIQUE NOT NULL,
  forma_pagamento VARCHAR(50) NOT NULL,
  valor           NUMERIC(12,2) NOT NULL CHECK (valor >= 0),
  data_pagamento  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status_pagamento VARCHAR(30) NOT NULL DEFAULT 'CONFIRMADO',
  CONSTRAINT fk_pagamento_pedido FOREIGN KEY (id_pedido)
    REFERENCES pedido(id_pedido)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Índices (opcionais)
CREATE INDEX idx_pedido_cliente ON pedido(id_cliente);
CREATE INDEX idx_produto_categoria ON produto(id_categoria);

