-- Esta view pode ser usada para ver rapidamente o total de compras e o valor total gasto por cada cliente.
CREATE MATERIALIZED VIEW mv_historico_compras_cliente AS
SELECT 
    c.cp_id_cliente,
    c.nm_cliente,
    COUNT(p.cp_id_pedido) AS total_pedidos,
    SUM(p.valor_total) AS total_gasto
FROM 
    Cliente c
JOIN 
    Pedido p ON c.cp_id_cliente = p.ce_cliente
WHERE 
    p.status_pedido = 'Concluído'  -- Considera apenas pedidos concluídos
GROUP BY 
    c.cp_id_cliente, c.nm_cliente;

--REFRESH MATERIALIZED VIEW mv_historico_compras_cliente;