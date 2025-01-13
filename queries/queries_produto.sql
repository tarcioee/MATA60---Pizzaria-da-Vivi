--Requisito 2
--Query para cadastro de um novo produto:
INSERT INTO Produto (tipo_produto, nm_produto, preco_produto, descricao, tamanho_pizza, volume_bebida, qtd_disponivel, porcentagem_promoção)
VALUES ('pizza', 'Pizza Margherita', 25.50, 'Pizza com molho de tomate, mussarela e manjericão', 'Grande', NULL, 100, 10.0);

--Query para atualizar o estoque de um produto:
UPDATE Produto
SET qtd_disponivel = qtd_disponivel + 10
WHERE cp_id_produto = 1; 

-- Query pra retirar produtos comprados do estoque
UPDATE Produto
SET qtd_disponivel = qtd_disponivel - pp.qtd_compradas
FROM Produto_pedido pp
WHERE Produto.cp_id_produto = pp.ce_produto
  AND pp.ce_pedido = <id_do_pedido>;

--Consultar o preço de um produto
SELECT 
    cp_id_produto, 
    nm_produto, 
    preco_produto, 
    porcentagem_promoção,
    preco_produto * (1 - porcentagem_promoção / 100) AS preco_com_desconto
FROM 
    Produto
WHERE 
    cp_id_produto = 10; 

--Consultar quais são os produtos mais vendidos em cada categoria
SELECT 
    pr.tipo_produto, 
    pr.nm_produto,
    SUM(pp.qtd_compradas) AS total_vendido
FROM 
    Produto pr
JOIN 
    Produto_pedido pp ON pr.cp_id_produto = pp.ce_produto
JOIN 
    Pedido p ON pp.ce_pedido = p.cp_id_pedido
WHERE 
    p.status_pedido = 'Concluído'  -- Considera apenas pedidos concluídos
GROUP BY 
    pr.tipo_produto, pr.nm_produto
ORDER BY 
    pr.tipo_produto, total_vendido DESC;


--Requisito 4
--Query para ver pizzas e aperitivos sem ingrediente do tipo "animal"
SELECT p.nm_produto, p.tipo_produto
FROM Produto p
LEFT JOIN Produto_ingrediente pi ON p.cp_id_produto = pi.ce_produto
LEFT JOIN Ingrediente i ON pi.ce_ingrediente = i.cp_id_ingrediente
WHERE (p.tipo_produto IN ('pizza', 'aperitivo')) 
  AND (i.tipo != 'animal' OR i.tipo IS NULL);

--Query para ver pizzas e aperitivos sem ingrediente do tipo "lacticinio"
SELECT p.nm_produto, p.tipo_produto
FROM Produto p
LEFT JOIN Produto_ingrediente pi ON p.cp_id_produto = pi.ce_produto
LEFT JOIN Ingrediente i ON pi.ce_ingrediente = i.cp_id_ingrediente
WHERE (p.tipo_produto IN ('pizza', 'aperitivo')) 
  AND (i.tipo != 'lacticinio' OR i.tipo IS NULL);

--Requisito 7
--Query para reajustar os valores dos produtos com base em uma porcentagem:
UPDATE Produto
SET preco_produto = preco_produto * (1 + <porcentagem_aumento> / 100);

--definir a porcentagem de promoção de todos os produtos 
UPDATE Produto
SET porcentagem_promoção = 20;

--definir a porcentagem de promoção para produto especifico
UPDATE Produto
SET porcentagem_promoção = 10
WHERE cp_id_produto = 3;


--Requisito 8
--Query para gerar um relatório de estoque:
SELECT nm_produto, qtd_disponivel
FROM Produto;

