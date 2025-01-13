-- Role para Administrador
CREATE ROLE admin_role;

-- Role para Moderador
CREATE ROLE funcionario_role;

-- Role para Usuário Final
CREATE ROLE user_role;

-- Criação de usuários
CREATE USER admin_user WITH PASSWORD 'admin_pass';
CREATE USER funcionario_user WITH PASSWORD 'funcionario_pass';
CREATE USER regular_user WITH PASSWORD 'user_pass';

-- Associação de roles
GRANT admin_role TO admin_user;
GRANT funcionario_role TO funcionario_user;
GRANT user_role TO regular_user;

-- Conceder permissões para o administrador
GRANT ALL PRIVILEGES ON DATABASE Databased TO admin_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_user;

-- Conceder permissões para o moderador
GRANT SELECT, INSERT, UPDATE ON TABLE Cliente, Pedido, Produto, Funcionario TO funcionario_user;
GRANT SELECT, UPDATE ON TABLE Produto_pedido, Funcionario_pedido, Produto_ingrediente TO funcionario_user;
GRANT SELECT ON TABLE Cargo, Ingrediente TO funcionario_user;

-- Conceder permissões para o usuário final
GRANT SELECT ON TABLE Produto, Pedido TO regular_user;
GRANT INSERT ON TABLE Pedido, Produto_pedido TO regular_user;

