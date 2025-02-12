--Requisito 6
--Query para cadastrar um novo ingrediente:
INSERT INTO Ingrediente (nm_ingrediente, tipo)
VALUES ('Queijo', 'lacticinio');

--Alterar o nome ou tipo de um ingrediente específico
UPDATE Ingrediente
SET nm_ingrediente = 'Queijo Mozarela', 
    tipo = 'lacticinio'
WHERE cp_id_ingrediente = 3;

--Para excluir um ingrediente específico da tabela Ingrediente:
DELETE FROM Ingrediente
WHERE cp_id_ingrediente = 3;

--Query para consultar os tipos possíveis de ingrediente
SELECT DISTINCT tipo
FROM Ingrediente;

--Consultar tipo de um ingrediente
SELECT cp_id_ingrediente, nm_ingrediente, tipo
FROM Ingrediente
WHERE cp_id_ingrediente = 5;


--Query para associar ingredientes a um produto (por exemplo, associando queijo a uma pizza):
INSERT INTO Produto_ingrediente (ce_produto, ce_ingrediente, gramas_ingrediente)
VALUES (1, 1, 50);  -- Substitua os IDs pelos reais

--Query para deletar ingrediente
DELETE FROM Ingrediente
WHERE cp_id_ingrediente = 1;  -- Substitua pelo ID do ingrediente que deseja excluir

--Query para visualizar os ingredientes de uma pizza específica:
SELECT p.nm_produto, i.nm_ingrediente, pi.gramas_ingrediente
FROM Produto p
JOIN Produto_ingrediente pi ON p.cp_id_produto = pi.ce_produto
JOIN Ingrediente i ON pi.ce_ingrediente = i.cp_id_ingrediente
WHERE p.cp_id_produto = 1;  -- substitua pelo ID do produto (pizza)

