CREATE TABLE IF NOT EXISTS Cliente 
( 
    cp_id_cliente INT PRIMARY KEY,  
    nm_cliente VARCHAR(100) NOT NULL, 
    tel_cliente VARCHAR(15), 
    endereco VARCHAR(255), 
    cpf_cliente VARCHAR(11) UNIQUE NOT NULL,
    qtd_compras INT DEFAULT 0,
   categoria_cliente VARCHAR(10) DEFAULT 'bronze',
   CHECK (categoria_cliente IN ('bronze', 'prata', 'ouro')) 
); 

CREATE TABLE IF NOT EXISTS Pedido 
( 
    cp_id_pedido INT PRIMARY KEY,  
    ce_cliente INT NOT NULL,  
    data_pedido DATE,  
    status_pedido VARCHAR(20) NOT NULL DEFAULT 'Em aberto', 
    valor_total DECIMAL(10, 2), 
    CHECK (status_pedido IN ('Em aberto', 'Concluído', 'Cancelado')),
    CHECK (valor_total>0),
    FOREIGN KEY (ce_cliente) REFERENCES Cliente(cp_id_cliente)
); 

CREATE TABLE IF NOT EXISTS Cargo 
( 
    cp_id_cargo INT PRIMARY KEY,  
    nm_cargo VARCHAR(100) NOT NULL,  
    salario DECIMAL(10, 2),  
    horas_semanais INT,  
    CHECK (salario > 0)
); 

CREATE TABLE IF NOT EXISTS Funcionario 
( 
    cp_id_funcionario INT PRIMARY KEY,  
    ce_cargo INT NOT NULL,  
    nm_funcionario VARCHAR(100) NOT NULL,  
    cpf_funcionario VARCHAR(11) UNIQUE,  
    email_funcionario VARCHAR(100),
    tel_funcionario VARCHAR(15), 
    FOREIGN KEY (ce_cargo) REFERENCES Cargo(cp_id_cargo) 
); 

CREATE TABLE IF NOT EXISTS Produto 
( 
    cp_id_produto INT PRIMARY KEY,  
    tipo_produto VARCHAR(100),  
    nm_produto VARCHAR(100), 
    preco_produto DECIMAL(10, 2),  
    descricao VARCHAR(255),
    tamanho_pizza VARCHAR(20),  
    volume_bebida VARCHAR(20),    
    qtd_disponivel INT  
   CHECK (tipo_produto IN ('pizza', 'aperitivo', 'sobremesa', 'bebida', 'bebida alcoolica', 'utensilios')), 
   CHECK (qtd_disponivel > 0)
); 

CREATE TABLE IF NOT EXISTS Ingrediente 
( 
    cp_id_ingrediente INT PRIMARY KEY,  
    nm_ingrediente VARCHAR(100),
    tipo VARCHAR(20),
    CHECK (tipo IN ('proteina', 'vegetal', 'farinha', 'lacticinio', 'outro')) 
); 

CREATE TABLE IF NOT EXISTS Funcionario_pedido
( 
    cp_id_pedido_id_funcionario INT PRIMARY KEY,  
    ce_funcionario INT NOT NULL,  
    ce_pedido INT NOT NULL,  
    FOREIGN KEY (ce_funcionario) REFERENCES Funcionario(cp_id_funcionario),  -- Correção da chave estrangeira
    FOREIGN KEY (ce_pedido) REFERENCES Pedido(cp_id_pedido)  -- Correção da chave estrangeira
); 

CREATE TABLE IF NOT EXISTS Produto_pedido 
( 
    cp_id_pedido_id_produto INT PRIMARY KEY,  
    ce_produto INT NOT NULL,  
    ce_pedido INT NOT NULL, 
    qtd_compradas INT,    
    CHECK (qtd_compradas > 0),
	FOREIGN KEY (ce_produto) REFERENCES Produto(cp_id_produto),
    FOREIGN KEY (ce_pedido) REFERENCES Pedido(cp_id_pedido)  
); 

CREATE TABLE IF NOT EXISTS Produto_ingrediente 
( 
    cp_id_produto_id_ingrediente INT PRIMARY KEY,  
    ce_produto INT NOT NULL,  
    ce_ingrediente INT NOT NULL,  
    gramas_ingrediente INT,  
    CHECK (gramas_ingrediente > 0),
    FOREIGN KEY ( ce_produto) REFERENCES Produto(cp_id_produto),  
    FOREIGN KEY (ce_ingrediente) REFERENCES Ingrediente(cp_id_ingrediente)  
); 