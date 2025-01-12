--Query pra adicionar um cargo à tabela de cargos
INSERT INTO Cargo (nm_cargo, salario, horas_semanais) VALUES ('Degustador', 15000.00, 40);

--Query para alterar nome ou salário de um cargo específico:
UPDATE Cargo
SET nm_cargo = 'Coordenador', 
    salario = 3500.00
WHERE cp_id_cargo = 1;

--Excluir um cargo específico
DELETE FROM Cargo
WHERE cp_id_cargo = 2;

--Cargos com salário superior a 1500
SELECT cp_id_cargo, nm_cargo, salario
FROM Cargo
WHERE salario > 1500;
