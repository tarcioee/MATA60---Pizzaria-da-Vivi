--Requisito 8
--Query para gerar um relatório de vendas:
SELECT p.nm_produto, SUM(pp.qtd_compradas) AS qtd_vendida, SUM(pp.qtd_compradas * p.preco_produto) AS total_vendas
FROM Produto p
JOIN Produto_pedido pp ON p.cp_id_produto = pp.ce_produto
GROUP BY p.nm_produto;

--Resumo dos provaveis vegetarianos do último mês:
--Query que irá contar os clientes que fizeram pedidos no último mês, que não compraram produtos com ingredientes do tipo "animal" e, para cada cliente, vai retornar o número de pedidos feitos e o total gasto em reais.
SELECT 
    p.ce_cliente, 
    COUNT(DISTINCT p.cp_id_pedido) AS total_pedidos,
    SUM(p.valor_total) AS total_valor
FROM Pedido p
JOIN Produto_pedido pp ON p.cp_id_pedido = pp.ce_pedido
JOIN Produto pr ON pp.ce_produto = pr.cp_id_produto
LEFT JOIN Produto_ingrediente pi ON pr.cp_id_produto = pi.ce_produto
LEFT JOIN Ingrediente i ON pi.ce_ingrediente = i.cp_id_ingrediente
WHERE p.data_pedido >= CURRENT_DATE - INTERVAL '1 month'  -- Filtra pedidos do último mês
  AND (i.tipo != 'animal' OR i.tipo IS NULL)  -- Produtos sem ingrediente do tipo "animal"
GROUP BY p.ce_cliente
HAVING COUNT(DISTINCT i.cp_id_ingrediente) = 0;  -- Garantir que o cliente não comprou produto com ingrediente tipo "animal"

--Resumo de quantos provaveis intolerantes a lactose do ultimo mês: 
--Query que irá contar o numero de clientes que fizeram pedidos de pizza ou aperitivo no último mês, que não compraram produtos com ingredientes do tipo "lacticinio"
SELECT COUNT(DISTINCT p.ce_cliente)
FROM Pedido p
JOIN Produto_pedido pp ON p.cp_id_pedido = pp.ce_pedido
JOIN Produto pr ON pp.ce_produto = pr.cp_id_produto
JOIN Produto_ingrediente pi ON pr.cp_id_produto = pi.ce_produto
JOIN Ingrediente i ON pi.ce_ingrediente = i.cp_id_ingrediente
WHERE p.data_pedido >= CURRENT_DATE - INTERVAL '1 month'
  AND pr.tipo_produto IN ('pizza', 'aperitivo')
  AND i.tipo != 'lacticinio'
  AND p.status_pedido = 'Concluído';

--Resumo pra conteção de danos:
--Query que define quais funcionários e de que cargos estiveram envolvidos em pedidos cancelados
SELECT f.nm_funcionario, c.nm_cargo, p.cp_id_pedido
FROM Funcionario_pedido fp
JOIN Funcionario f ON fp.ce_funcionario = f.cp_id_funcionario
JOIN Cargo c ON f.ce_cargo = c.cp_id_cargo
JOIN Pedido p ON fp.ce_pedido = p.cp_id_pedido
WHERE p.status_pedido = 'Cancelado'
ORDER BY c.nm_cargo, f.nm_funcionario;

--Query que irá contar o numero de clientes que fizeram pedidos no último mês, que não compraram produtos com ingredientes do tipo "animal"
SELECT COUNT(DISTINCT p.ce_cliente) AS numero_de_clientes
FROM Pedido p
JOIN Produto_pedido pp ON p.cp_id_pedido = pp.ce_pedido
JOIN Produto_ingrediente pi ON pp.ce_produto = pi.ce_produto
JOIN Ingrediente i ON pi.ce_ingrediente = i.cp_id_ingrediente
WHERE p.data_pedido >= CURRENT_DATE - INTERVAL '1 month'
AND i.tipo != 'animal'
AND p.status_pedido = 'Concluído';

--Query que conta o numero de clientes que fizeram pedido com produto do tipo bebida alcoolica
SELECT COUNT(DISTINCT p.ce_cliente) AS numero_de_clientes
FROM Pedido p
JOIN Produto_pedido pp ON p.cp_id_pedido = pp.ce_pedido
JOIN Produto pr ON pp.ce_produto = pr.cp_id_produto
WHERE pr.tipo_produto = 'bebida alcoolica'
AND p.status_pedido = 'Concluído';

