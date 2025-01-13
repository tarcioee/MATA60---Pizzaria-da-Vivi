--Procedure a ser utilizada sempre que adicionarem algo no carrinho
CREATE OR REPLACE PROCEDURE sp_atualizar_valor_total_pedido(
    p_id_pedido INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Atualizar o valor_total do pedido com base no preço, quantidade comprada e porcentagem de promoção dos produtos
    WITH TotalPedido AS (
        SELECT pp.ce_pedido, 
               SUM((pr.preco_produto * pp.qtd_compradas) * (1 - COALESCE(pr.porcentagem_promoção, 0) / 100)) AS novo_valor_total
        FROM Produto_pedido pp
        JOIN Produto pr ON pp.ce_produto = pr.cp_id_produto
        WHERE pp.ce_pedido = p_id_pedido
        GROUP BY pp.ce_pedido
    )
    UPDATE Pedido p
    SET valor_total = tp.novo_valor_total
    FROM TotalPedido tp
    WHERE p.cp_id_pedido = tp.ce_pedido;
    
END;
$$;

--CALL sp_atualizar_valor_total_pedido(<id_do_pedido>);
