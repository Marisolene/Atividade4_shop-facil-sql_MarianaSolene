-- 02_selects.sql
-- Consultas exemplares

-- 1) Listar pedidos com dados do cliente e valor total
SELECT p.id_pedido, p.data, p.valor_total, p.status,
       c.id_cliente, c.nome AS cliente_nome, c.email
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
ORDER BY p.data DESC
LIMIT 10;

-- 2) Produtos mais vendidos (soma de quantidades)
SELECT pr.id_produto, pr.nome, SUM(ip.quantidade) AS total_vendido
FROM produto pr
LEFT JOIN item_pedido ip ON pr.id_produto = ip.id_produto
GROUP BY pr.id_produto, pr.nome
ORDER BY total_vendido DESC
LIMIT 10;

-- 3) Itens de um pedido específico (ex: pedido 1)
SELECT ip.id_item, ip.id_pedido, pr.nome AS produto, ip.quantidade, ip.valor_unitario
FROM item_pedido ip
JOIN produto pr ON ip.id_produto = pr.id_produto
WHERE ip.id_pedido = 1;

-- 4) Pedidos pendentes e seus clientes
SELECT p.id_pedido, p.data, p.valor_total, c.nome, c.email
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
WHERE p.status = 'PENDENTE'
ORDER BY p.data ASC;

-- 5) Total faturado por categoria
SELECT cat.id_categoria, cat.nome AS categoria, SUM(ip.quantidade * ip.valor_unitario) AS faturamento
FROM categoria cat
JOIN produto pr ON pr.id_categoria = cat.id_categoria
JOIN item_pedido ip ON ip.id_produto = pr.id_produto
GROUP BY cat.id_categoria, cat.nome
ORDER BY faturamento DESC;
