--Requisito 2
--Query para cadastro de um novo produto:
INSERT INTO Produto (tipo_produto, nm_produto, preco_produto, descricao, tamanho_pizza, volume_bebida, qtd_disponivel, porcentagem_promoção)
VALUES ('pizza', 'Pizza Margherita', 25.50, 'Pizza com molho de tomate, mussarela e manjericão', 'Grande', NULL, 100, 10.0);

--Query para atualizar o estoque de um produto após venda:
UPDATE Produto
SET qtd_disponivel = qtd_disponivel - 1
WHERE cp_id_produto = 1;  -- substitua pelo ID do produto

--Query que muda o valor de qtd_disponivel de um produto
UPDATE Produto
SET qtd_disponivel = qtd_disponivel + 5
WHERE cp_id_produto = 1;  -- Substitua pelo ID do produto que deseja atualizar

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

--Requisito 8
--Query para gerar um relatório de estoque:
SELECT nm_produto, qtd_disponivel
FROM Produto;

