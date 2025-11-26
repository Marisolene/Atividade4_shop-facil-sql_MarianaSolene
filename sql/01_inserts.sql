-- 01_inserts.sql
-- Popula categorias, produtos, clientes, pedidos, itens e pagamentos

-- =====================
-- CATEGORIAS
-- =====================
INSERT INTO categoria (nome, descricao) VALUES
('Eletrônicos', 'Smartphones, fones e acessórios'),
('Casa', 'Itens para casa e cozinha'),
('Moda', 'Roupas e acessórios'),
('Beleza', 'Produtos de beleza e cuidados');

-- =====================
-- PRODUTOS
-- =====================
INSERT INTO produto (nome, descricao, preco, estoque, id_categoria) VALUES
('Fone Bluetooth X100', 'Fone sem fio com cancelamento de ruído', 199.90, 50, 1),
('Smartphone Z', 'Smartphone com 128GB', 1299.00, 20, 1),
('Panela Antiaderente 24cm', 'Panela 24cm com revestimento', 89.50, 100, 2),
('Camiseta Básica', 'Camiseta algodão unissex', 39.90, 200, 3),
('Batom Vermelho', 'Batom matte longa duração', 29.90, 150, 4);

-- =====================
-- CLIENTES
-- =====================
INSERT INTO cliente (nome, email, telefone, cpf, endereco) VALUES
('Mariana Silva', 'mari.silva@example.com', '11-99999-0001', '123.456.789-00', 'Rua A, 123, São Paulo, SP'),
('João Souza', 'joao.souza@example.com', '11-99999-0002', '111.222.333-44', 'Av. B, 456, São Paulo, SP'),
('Ana Pereira', 'ana.pereira@example.com', '11-99999-0003', '555.666.777-88', 'Rua C, 789, SP');

-- =====================
-- PEDIDOS
-- =====================
-- Pedido 1 (Mariana)
INSERT INTO pedido (data, valor_total, status, id_cliente)
VALUES (CURRENT_TIMESTAMP, 399.80, 'CONCLUIDO', 1);

-- Pedido 2 (João)
INSERT INTO pedido (data, valor_total, status, id_cliente)
VALUES (CURRENT_TIMESTAMP - interval '3 days', 1299.00, 'ENVIADO', 2);

-- Pedido 3 (Ana)
INSERT INTO pedido (data, valor_total, status, id_cliente)
VALUES (CURRENT_TIMESTAMP - interval '1 day', 119.40, 'PENDENTE', 3);

-- =====================
-- ITEM_PEDIDO
-- =====================
-- Itens do Pedido 1
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, valor_unitario) VALUES
(1, 1, 2, 199.90);

-- Itens do Pedido 2
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, valor_unitario) VALUES
(2, 2, 1, 1299.00);

-- Itens do Pedido 3
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, valor_unitario) VALUES
(3, 4, 3, 39.90);

-- =====================
-- PAGAMENTOS
-- =====================
INSERT INTO pagamento (id_pedido, forma_pagamento, valor, status_pagamento) VALUES
(1, 'Cartão de Crédito', 399.80, 'CONFIRMADO'),
(2, 'Boleto', 1299.00, 'CONFIRMADO'),
(3, 'Cartão de Débito', 119.40, 'PENDENTE');

-- =====================
-- Ajuste do valor_total (caso queira recalcular a partir de itens)
-- (Exemplo: recalcula somando items)
-- =====================
-- Atualiza valor_total de cada pedido com soma dos itens
UPDATE pedido p
SET valor_total = sub.total
FROM (
  SELECT id_pedido, SUM(quantidade * valor_unitario) AS total
  FROM item_pedido
  GROUP BY id_pedido
) AS sub
WHERE p.id_pedido = sub.id_pedido;
