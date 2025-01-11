--Requisito 1
--Query para cadastro de um novo cliente:
INSERT INTO Cliente (nm_cliente, tel_cliente, endereco, cpf_cliente, qtd_compras, categoria_cliente)
VALUES ('João Silva', '999999999', 'Rua A, 123', '12345678901', 0, 'bronze'); --modificar aqui

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

--Requisito 7
--Query para atualizar a quantidade de compras de um cliente (ao registrar um novo pedido):
UPDATE Cliente
SET qtd_compras = qtd_compras + 1
WHERE cp_id_cliente = 1;  -- substitua pelo ID do cliente

--Query para aplicar um desconto a um cliente:
UPDATE Pedido
SET valor_total = valor_total * 0.9  -- 10% de desconto
WHERE ce_cliente = 1 AND status_pedido = 'Em aberto';  -- substitua pelo ID do cliente

--Query para verificar quantas compras o cliente atingiu:
SELECT qtd_compras
FROM Cliente
WHERE cp_id_cliente = 1;  -- substitua pelo ID do cliente