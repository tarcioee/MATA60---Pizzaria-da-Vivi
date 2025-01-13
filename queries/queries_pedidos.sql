--Requisito 4
-- Inserir o pedido e retornar o id do pedido
WITH novo_pedido AS (
    INSERT INTO Pedido (ce_cliente, status_pedido, valor_total) 
    VALUES (2, 'Não-confirmado', <valor_total>) 
    RETURNING cp_id_pedido
)
-- Inserir o produto no pedido com o id retornado
INSERT INTO Produto_pedido (ce_produto, ce_pedido, qtd_compradas)
SELECT 3, cp_id_pedido, 3
FROM novo_pedido;


--Query para atualizar o status de um pedido:
UPDATE Pedido
SET status_pedido = 'Concluído'
WHERE cp_id_pedido = 1;  -- substitua pelo ID do pedido

--Excluir um produto específico
DELETE FROM Produto
WHERE cp_id_produto = 10;

--Query pra determinar os horários de pico dos pedidos no ultimo mes
SELECT 
    EXTRACT(HOUR FROM p.data_pedido) AS hora,
    COUNT(p.cp_id_pedido) AS total_pedidos
FROM 
    Pedido p
WHERE 
    p.status_pedido = 'Concluído'  -- Considera apenas pedidos concluídos
    AND p.data_pedido >= CURRENT_DATE - INTERVAL '1 month'  -- Filtra os pedidos do último mês
GROUP BY 
    hora
ORDER BY 
    total_pedidos DESC;

--Requisito 5
-- Atribuir um entregador e um cozinheiro disponíveis ao pedido
WITH FuncionariosDisponiveis AS (
    -- Atribui um entregador disponível
    SELECT f.cp_id_funcionario
    FROM Funcionario f
    JOIN Cargo c ON f.ce_cargo = c.cp_id_cargo
    WHERE c.nm_cargo = 'entregador' 
      AND f.status_funcionario = 'Disponível'
    LIMIT 1
),
CozinheirosDisponiveis AS (
    -- Atribui um cozinheiro disponível
    SELECT f.cp_id_funcionario
    FROM Funcionario f
    JOIN Cargo c ON f.ce_cargo = c.cp_id_cargo
    WHERE c.nm_cargo = 'cozinheiro' 
      AND f.status_funcionario = 'Disponível'
    LIMIT 1
)
INSERT INTO Funcionario_pedido (ce_funcionario, ce_pedido, papel)
SELECT fd.cp_id_funcionario, <id_do_pedido>, 'Entregador' FROM FuncionariosDisponiveis fd
UNION ALL
SELECT cd.cp_id_funcionario, <id_do_pedido>, 'Cozinheiro' FROM CozinheirosDisponiveis cd;


--Query para definir dados dos produtos, endereço e nome dos clientes para cada pedido em aberto que um funcionário especifico está responsável
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
  AND f.nm_funcionario = 'Robespierre';

--Query para comparar a quantidade de compras de produtos com promoção e sem promoção
SELECT 
    CASE 
        WHEN p.porcentagem_promoção > 0 THEN 'Com Promoção'
        ELSE 'Sem Promoção'
    END AS tipo_promocao,
    COUNT(pp.cp_id_pedido) AS total_compras
FROM 
    Produto p
JOIN 
    Produto_pedido pp ON p.cp_id_produto = pp.ce_produto
JOIN 
    Pedido ped ON pp.ce_pedido = ped.cp_id_pedido
WHERE 
    ped.status_pedido = 'Concluído'  -- Considera apenas pedidos concluídos
GROUP BY 
    tipo_promocao;

