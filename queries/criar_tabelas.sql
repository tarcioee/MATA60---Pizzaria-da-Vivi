CREATE TABLE IF NOT EXISTS Cliente 
( 
    cp_id_cliente SERIAL,  
    nm_cliente VARCHAR(100) NOT NULL, 
    tel_cliente VARCHAR(15), 
    endereco VARCHAR(255), 
    cpf_cliente VARCHAR(11) NOT NULL,
    qtd_compras INT DEFAULT 0,
    categoria_cliente VARCHAR(10) DEFAULT 'bronze'
); 

CREATE TABLE IF NOT EXISTS Pedido 
( 
    cp_id_pedido SERIAL,  
    ce_cliente INT NOT NULL,  
    data_pedido DATE DEFAULT CURRENT_TIMESTAMP,  
    observações VARCHAR(255),
    status_pedido VARCHAR(20) NOT NULL DEFAULT 'Em aberto', 
    valor_total DECIMAL(10, 2) 
); 

CREATE TABLE IF NOT EXISTS Cargo 
( 
    cp_id_cargo SERIAL,  
    nm_cargo VARCHAR(100) NOT NULL,  
    salario DECIMAL(10, 2),  
    horas_semanais INT
); 

CREATE TABLE IF NOT EXISTS Funcionario 
( 
    cp_id_funcionario SERIAL,  
    ce_cargo INT NOT NULL,  
    nm_funcionario VARCHAR(100) NOT NULL,  
    cpf_funcionario VARCHAR(11),  
    email_funcionario VARCHAR(100),
    tel_funcionario VARCHAR(15),
    status_funcionario VARCHAR(15) ENUM('Indisponivel', 'Disponivel') NOT NULL DEFAULT 'Indisponivel'
); 

CREATE TABLE IF NOT EXISTS Produto 
( 
    cp_id_produto SERIAL,  
    tipo_produto VARCHAR(100),  
    nm_produto VARCHAR(100), 
    preco_produto DECIMAL(10, 2),  
    descricao VARCHAR(255),
    tamanho_pizza VARCHAR(20),  
    volume_bebida VARCHAR(20),    
    qtd_disponivel INT,
    porcentagem_promoção DECIMAL(10, 2)
); 

CREATE TABLE IF NOT EXISTS Ingrediente 
( 
    cp_id_ingrediente SERIAL,  
    nm_ingrediente VARCHAR(100),
    tipo VARCHAR(20)
); 

CREATE TABLE IF NOT EXISTS Funcionario_pedido
( 
    cp_id_pedido_id_funcionario SERIAL,  
    ce_funcionario INT NOT NULL,  
    ce_pedido INT NOT NULL,
    papel VARCHAR(50),  
    observação_funcionário VARCHAR(100)  

); 

CREATE TABLE IF NOT EXISTS Produto_pedido 
( 
    cp_id_pedido_id_produto SERIAL,  
    ce_produto INT NOT NULL,  
    ce_pedido INT NOT NULL, 
    qtd_compradas INT  
); 

CREATE TABLE IF NOT EXISTS Produto_ingrediente 
( 
    cp_id_produto_id_ingrediente SERIAL,  
    ce_produto INT NOT NULL,  
    ce_ingrediente INT NOT NULL,  
    gramas_ingrediente INT  
); 
