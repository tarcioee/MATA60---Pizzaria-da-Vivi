-- Criar roles específicas para cada tipo de usuário

-- Role de cliente (leitura e inserção de pedidos)
CREATE ROLE cliente NOLOGIN;

-- Role de funcionário (leitura e alteração de status de pedidos)
CREATE ROLE funcionario NOLOGIN;

-- Role de cozinheiro (leitura de pedidos em preparação)
CREATE ROLE cozinheiro NOLOGIN;

-- Role de entregador (leitura de pedidos para entrega)
CREATE ROLE entregador NOLOGIN;

-- Role de administrador (acesso total)
CREATE ROLE admin NOLOGIN;

-- Conceder permissões para a role de cliente
GRANT SELECT ON ALL TABLES IN SCHEMA public TO cliente;  -- Pode consultar dados
GRANT INSERT ON public.pedido TO cliente;  -- Pode inserir novos pedidos
GRANT UPDATE ON public.cliente TO cliente;  -- Pode atualizar suas próprias informações

-- Conceder permissões para a role de funcionário (geral)
GRANT SELECT ON public.pedido TO funcionario;  -- Pode consultar pedidos
GRANT UPDATE ON public.pedido TO funcionario;  -- Pode alterar status de pedidos

-- Conceder permissões para a role de cozinheiro
GRANT SELECT ON public.pedido TO cozinheiro;  -- Pode ver pedidos
GRANT UPDATE ON public.pedido TO cozinheiro;  -- Pode atualizar status de pedidos em preparação

-- Conceder permissões para a role de entregador
GRANT SELECT ON public.pedido TO entregador;  -- Pode consultar pedidos para entrega
GRANT UPDATE ON public.pedido TO entregador;  -- Pode alterar status de pedidos para "Entregue"

-- Conceder permissões para o administrador (total)
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin;

-- Atribuindo roles aos usuários
GRANT cliente TO nome_do_cliente;
GRANT funcionario TO nome_do_funcionario;
GRANT cozinheiro TO nome_do_cozinheiro;
GRANT entregador TO nome_do_entregador;
GRANT admin TO nome_do_admin;
