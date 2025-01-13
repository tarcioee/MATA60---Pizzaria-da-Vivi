-- Constraints para a tabela Cliente
ALTER TABLE Cliente 
    ADD PRIMARY KEY (cp_id_cliente), 
    ADD UNIQUE (cpf_cliente),
    ADD CHECK (categoria_cliente IN ('bronze', 'prata', 'ouro')),
    ADD CHECK (qtd_compras>=0);

-- Constraints para a tabela Pedido
ALTER TABLE Pedido
    ADD PRIMARY KEY (cp_id_pedido), 
    ADD CHECK (status_pedido IN ('Não-confirmado','Em aberto', 'Concluído', 'Cancelado')),
    ADD CHECK (valor_total > 0),
    ADD FOREIGN KEY (ce_cliente) REFERENCES Cliente(cp_id_cliente) ON DELETE CASCADE;

-- Constraints para a tabela Cargo
ALTER TABLE Cargo
    ADD PRIMARY KEY (cp_id_cargo),
    ADD CHECK (salario > 0);

-- Constraints para a tabela Funcionario
ALTER TABLE Funcionario
    ADD PRIMARY KEY (cp_id_funcionario),
    ADD UNIQUE (cpf_funcionario),
    ADD CHECK ( tarefas_ativas>=0 ),
    ADD FOREIGN KEY (ce_cargo) REFERENCES Cargo(cp_id_cargo) ON DELETE CASCADE;

-- Constraints para a tabela Produto
ALTER TABLE Produto
    ADD PRIMARY KEY (cp_id_produto),
    ADD CHECK (tipo_produto IN ('pizza', 'aperitivo', 'sobremesa', 'bebida', 'bebida alcoolica', 'utensilios')),
    ADD CHECK (qtd_disponivel > 0),
    ADD CHECK (porcentagem_promoção < 100);

-- Constraints para a tabela Ingrediente
ALTER TABLE Ingrediente
    ADD PRIMARY KEY (cp_id_ingrediente),
    ADD CHECK (tipo IN ('animal', 'vegetal', 'farinha', 'lacticinio', 'outro'));

-- Constraints para a tabela Funcionario_pedido
ALTER TABLE Funcionario_pedido
    ADD PRIMARY KEY (cp_id_pedido_id_funcionario),
    ADD FOREIGN KEY (ce_funcionario) REFERENCES Funcionario(cp_id_funcionario) ON DELETE CASCADE,
    ADD FOREIGN KEY (ce_pedido) REFERENCES Pedido(cp_id_pedido) ON DELETE CASCADE;

-- Constraints para a tabela Produto_pedido
ALTER TABLE Produto_pedido
    ADD PRIMARY KEY (cp_id_pedido_id_produto),
    ADD CHECK (qtd_compradas > 0),
    ADD FOREIGN KEY (ce_produto) REFERENCES Produto(cp_id_produto) ON DELETE CASCADE,
    ADD FOREIGN KEY (ce_pedido) REFERENCES Pedido(cp_id_pedido) ON DELETE CASCADE;

-- Constraints para a tabela Produto_ingrediente
ALTER TABLE Produto_ingrediente
    ADD PRIMARY KEY (cp_id_produto_id_ingrediente),
    ADD CHECK (gramas_ingrediente > 0),
    ADD FOREIGN KEY (ce_produto) REFERENCES Produto(cp_id_produto) ON DELETE CASCADE,
    ADD FOREIGN KEY (ce_ingrediente) REFERENCES Ingrediente(cp_id_ingrediente) ON DELETE CASCADE;
