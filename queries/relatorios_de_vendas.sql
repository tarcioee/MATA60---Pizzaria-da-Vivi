--Requisito 8
--Query para gerar um relatório de vendas:
SELECT p.nm_produto, SUM(pp.qtd_compradas) AS qtd_vendida, SUM(pp.qtd_compradas * p.preco_produto) AS total_vendas
FROM Produto p
JOIN Produto_pedido pp ON p.cp_id_produto = pp.ce_produto
GROUP BY p.nm_produto;

-- Resumo do número de clientes que fizeram pedidos em cada mês e nunca compraram produtos com ingredientes do tipo "animal"
SELECT 
    TO_CHAR(p.data_pedido, 'YYYY-MM') AS mes,  -- Agrupa por mês (ano-mês)
    COUNT(DISTINCT p.ce_cliente) AS numero_de_clientes
FROM 
    Pedido p
JOIN 
    Produto_pedido pp ON p.cp_id_pedido = pp.ce_pedido
JOIN 
    Produto_ingrediente pi ON pp.ce_produto = pi.ce_produto
JOIN 
    Ingrediente i ON pi.ce_ingrediente = i.cp_id_ingrediente
WHERE 
    p.status_pedido = 'Concluído'  -- Apenas pedidos concluídos
    AND p.data_pedido >= CURRENT_DATE - INTERVAL '1 month'  -- Considera o último mês
    AND NOT EXISTS (  -- Verifica se o cliente NUNCA comprou produtos com ingredientes "animal"
        SELECT 1
        FROM Produto_pedido pp2
        JOIN Produto_ingrediente pi2 ON pp2.ce_produto = pi2.ce_produto
        JOIN Ingrediente i2 ON pi2.ce_ingrediente = i2.cp_id_ingrediente
        WHERE pp2.ce_pedido = p.cp_id_pedido
        AND i2.tipo = 'animal'
    )
GROUP BY 
    TO_CHAR(p.data_pedido, 'YYYY-MM')  -- Agrupa por mês
ORDER BY 
    mes DESC;  -- Ordena para mostrar o mês mais recente primeiro


--Contar os clientes que compraram pizza ou aperitivo mas nunca compraram produtos com ingredientes do tipo "lacticínio"
SELECT 
    TO_CHAR(p.data_pedido, 'YYYY-MM') AS mes,  -- Agrupa por ano e mês
    COUNT(DISTINCT p.ce_cliente) AS numero_de_clientes
FROM 
    Pedido p
JOIN 
    Produto_pedido pp ON p.cp_id_pedido = pp.ce_pedido
JOIN 
    Produto pr ON pp.ce_produto = pr.cp_id_produto
JOIN 
    Produto_ingrediente pi ON pr.cp_id_produto = pi.ce_produto
JOIN 
    Ingrediente i ON pi.ce_ingrediente = i.cp_id_ingrediente
WHERE 
    p.status_pedido = 'Concluído'  -- Considera apenas pedidos concluídos
    AND pr.tipo_produto IN ('pizza', 'aperitivo')  -- Filtro para pizza ou aperitivo
    AND i.tipo != 'lacticinio'  -- Exclui ingredientes do tipo "lacticinio"
GROUP BY 
    TO_CHAR(p.data_pedido, 'YYYY-MM')  -- Agrupa por mês
HAVING 
    NOT EXISTS (  -- Filtra clientes que nunca compraram "lacticinio"
        SELECT 1
        FROM Produto_pedido pp2
        JOIN Produto pr2 ON pp2.ce_produto = pr2.cp_id_produto
        JOIN Produto_ingrediente pi2 ON pr2.cp_id_produto = pi2.ce_produto
        JOIN Ingrediente i2 ON pi2.ce_ingrediente = i2.cp_id_ingrediente
        WHERE pp2.ce_pedido = p.cp_id_pedido
        AND i2.tipo = 'lacticinio'
    )
ORDER BY 
    mes DESC;  -- Ordena por mês em ordem decrescente (últimos meses primeiro)


--Resumo pra conteção de danos:
--Query que define quais funcionários e de que cargos estiveram envolvidos em pedidos cancelados, e quantos
-- Resumo para contenção de danos com contagem de pedidos cancelados, ordenado por mais pedidos cancelados:
SELECT 
    f.nm_funcionario, 
    c.nm_cargo, 
    COUNT(p.cp_id_pedido) AS numero_pedidos_cancelados
FROM 
    Funcionario_pedido fp
JOIN 
    Funcionario f ON fp.ce_funcionario = f.cp_id_funcionario
JOIN 
    Cargo c ON f.ce_cargo = c.cp_id_cargo
JOIN 
    Pedido p ON fp.ce_pedido = p.cp_id_pedido
WHERE 
    p.status_pedido = 'Cancelado'
GROUP BY 
    f.nm_funcionario, c.nm_cargo
ORDER BY 
    numero_pedidos_cancelados DESC, c.nm_cargo, f.nm_funcionario;

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

