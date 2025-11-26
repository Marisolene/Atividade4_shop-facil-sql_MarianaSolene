-- 03_updates_deletes.sql
-- Exemplos de UPDATEs e DELETEs

BEGIN;

-- UPDATE 1: Ajustar preço de um produto
UPDATE produto
SET preco = 189.90
WHERE id_produto = 1;

-- UPDATE 2: Marcar pedido como CANCELADO
UPDATE pedido
SET status = 'CANCELADO'
WHERE id_pedido = 3 AND status <> 'CONCLUIDO';

-- UPDATE 3: Repor estoque de um produto
UPDATE produto
SET estoque = estoque + 50
WHERE id_produto = 2;

-- DELETE 1: Remover pagamento pendente de um pedido cancelado (exemplo condicional)
DELETE FROM pagamento
WHERE id_pedido = 3 AND status_pagamento = 'PENDENTE';

-- DELETE 2: Excluir um produto sem vendas (sem entradas em item_pedido)
DELETE FROM produto
WHERE id_produto NOT IN (SELECT DISTINCT id_produto FROM item_pedido);

-- DELETE 3: Excluir clientes inativos (exemplo: sem pedidos)
DELETE FROM cliente
WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM pedido);

COMMIT;
