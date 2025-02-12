--Materialized View para visualizar todos os pedidos realizados, seus produtos associados, e o status do pedido e entrega 
CREATE MATERIALIZED VIEW mv_pedidos_status_entrega AS
SELECT 
    p.cp_id_pedido,
    p.data_pedido,
    p.status_pedido,
    p.valor_total,
    c.nm_cliente,
    STRING_AGG(pr.nm_produto, ', ') AS produtos,
    f1.nm_funcionario AS entregador,
    f2.nm_funcionario AS cozinheiro,
    CASE
        WHEN p.status_pedido = 'Em aberto' THEN 'Aguardando'
        WHEN p.status_pedido = 'Concluído' THEN 'Finalizado'
        WHEN p.status_pedido = 'Cancelado' THEN 'Cancelado'
        WHEN f1.status_funcionario = 'Disponível' AND f2.status_funcionario = 'Disponível' THEN 'Em Preparação'
        ELSE 'Em Entrega'
    END AS status_entrega
FROM 
    Pedido p
JOIN 
    Cliente c ON p.ce_cliente = c.cp_id_cliente
JOIN 
    Produto_pedido pp ON pp.ce_pedido = p.cp_id_pedido
JOIN 
    Produto pr ON pp.ce_produto = pr.cp_id_produto
LEFT JOIN 
    Funcionario_pedido fp1 ON fp1.ce_pedido = p.cp_id_pedido AND fp1.papel = 'Entregador'
LEFT JOIN 
    Funcionario f1 ON f1.cp_id_funcionario = fp1.ce_funcionario
LEFT JOIN 
    Funcionario_pedido fp2 ON fp2.ce_pedido = p.cp_id_pedido AND fp2.papel = 'Cozinheiro'
LEFT JOIN 
    Funcionario f2 ON f2.cp_id_funcionario = fp2.ce_funcionario
GROUP BY 
    p.cp_id_pedido, p.data_pedido, p.status_pedido, p.valor_total, c.nm_cliente, f1.nm_funcionario, f2.nm_funcionario;

--REFRESH MATERIALIZED VIEW mv_pedidos_status_entrega;
