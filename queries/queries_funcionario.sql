--Requisito 3
--Query para cadastro de um novo funcionário:
INSERT INTO Funcionario (ce_cargo, nm_funcionario, cpf_funcionario, email_funcionario, tel_funcionario, status_funcionario)
VALUES (1, 'Maria Oliveira', '98765432100', 'maria@pizzavivi.com', '987654321', 'Disponivel');

--Query para atualizar a disponibilidade de um funcionário
UPDATE Funcionario
SET status_funcionario = 'Indisponivel'
WHERE cp_id_funcionario = 1;  -- substitua pelo ID do funcionário

--Query para excluir um funcionário
DELETE FROM Funcionario
WHERE cp_id_funcionario = 1;  -- Substitua pelo ID do funcionário que deseja excluir

--Query para ver funcionários disponíveis
SELECT nm_funcionario, cpf_funcionario, ce_cargo, status_funcionario
FROM Funcionario
WHERE status_funcionario = 'Disponivel';

--Query para ver funcionários de um determinado cargo:
SELECT f.nm_funcionario, f.cpf_funcionario, f.tel_funcionario, f.status_funcionario
FROM Funcionario f
JOIN Cargo c ON f.ce_cargo = c.cp_id_cargo
WHERE c.nm_cargo = 'Atendente';  -- Substitua 'Atendente' pelo nome do cargo desejado

--Query para ver funcionários com salário acima de 2000 reais:
SELECT f.nm_funcionario, f.cpf_funcionario, c.nm_cargo, c.salario
FROM Funcionario f
JOIN Cargo c ON f.ce_cargo = c.cp_id_cargo
WHERE c.salario > 2000;  -- Filtra os funcionários que ganham mais de 2000

--Query para somar os salários de todos os funcionários:
SELECT SUM(c.salario) AS total_salarios
FROM Funcionario f
JOIN Cargo c ON f.ce_cargo = c.cp_id_cargo;
