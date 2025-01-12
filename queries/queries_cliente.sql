--Requisito 1
--Query para cadastro de um novo cliente:
INSERT INTO Cliente (nm_cliente, tel_cliente, endereco, cpf_cliente, qtd_compras, categoria_cliente)
VALUES ('João Silva', '999999999', 'Rua A, 123', '12345678901', 0, 'bronze');

--Query para atualizar dados do cliente (exemplo de atualização de telefone):
UPDATE Cliente
SET tel_cliente = '988888888'
WHERE cp_id_cliente = 1; -- substitua pelo ID do cliente

--Query excluir cliente
DELETE FROM Cliente
WHERE cp_id_cliente = 1;  -- Substitua pelo ID do cliente que deseja excluir

--Query para obter o histórico de compras de um cliente:
SELECT * 
FROM Pedido
WHERE ce_cliente = 1;  -- substitua pelo ID do cliente

--Consultar a quantidade de compras de um cliente
SELECT cp_id_cliente, nm_cliente, qtd_compras
FROM Cliente
WHERE cp_id_cliente = 1;

--Query pra contar o numero de pedidos de um cliente a partir das outras tabelas
SELECT COUNT(DISTINCT p.cp_id_pedido) AS numero_de_pedidos
FROM Pedido p
WHERE p.ce_cliente = 10;

--Requisito 7
--Query para atualizar a quantidade de compras de um cliente:
UPDATE Cliente
SET qtd_compras = qtd_compras + 1
WHERE cp_id_cliente = 1;  -- substitua pelo ID do cliente

--Query para atualizar a categoria de um cliente específico
UPDATE Cliente
SET categoria_cliente = 
    CASE
        WHEN qtd_compras >= 100 THEN 'ouro'
        WHEN qtd_compras >= 10 THEN 'prata'
        ELSE categoria_cliente  -- Se não atingir 10, mantém a categoria atual
    END
WHERE cp_id_cliente = 1; 