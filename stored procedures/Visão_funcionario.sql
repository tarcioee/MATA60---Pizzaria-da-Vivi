--Aqui tem a procedure que o funcionário mais precisa pra exercer seu trabalho
--Procedure para definir dados dos produtos, endereço e nome dos clientes para cada pedido em aberto que um funcionário especifico está responsável
CREATE OR REPLACE PROCEDURE sp_pedidos_em_aberto_por_funcionario(
    p_id_funcionario INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Consulta para listar os pedidos em aberto que o funcionário está responsável
    SELECT 
        p.cp_id_pedido, 
        p.data_pedido,
        pr.nm_produto,
        pp.qtd_compradas,
        pr.preco_produto,
        c.nm_cliente,
        c.endereco,
        f.nm_funcionario,
        p.status_pedido
    FROM Pedido p
    JOIN Produto_pedido pp ON p.cp_id_pedido = pp.ce_pedido
    JOIN Produto pr ON pp.ce_produto = pr.cp_id_produto
    JOIN Cliente c ON p.ce_cliente = c.cp_id_cliente
    JOIN Funcionario_pedido fp ON p.cp_id_pedido = fp.ce_pedido
    JOIN Funcionario f ON fp.ce_funcionario = f.cp_id_funcionario
    WHERE p.status_pedido = 'Em aberto'
      AND f.cp_id_funcionario = p_id_funcionario;
END;
$$;

--CALL sp_pedidos_em_aberto_por_funcionario(<id_do_funcionario>);
