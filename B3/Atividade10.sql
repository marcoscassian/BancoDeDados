CREATE DATABASE loja_online_1M;
USE loja_online_1M;

CREATE TABLE clientes (
    cli_id INT AUTO_INCREMENT PRIMARY KEY,
    cli_nome VARCHAR(100) NOT NULL,
    cli_cidade VARCHAR(100) NOT NULL
);

CREATE TABLE produtos (
    pro_id INT AUTO_INCREMENT PRIMARY KEY,
    pro_nome VARCHAR(100) NOT NULL,
    pro_categoria VARCHAR(50) NOT NULL,
    pro_preco DECIMAL(10,2) NOT NULL
);

CREATE TABLE vendas (
    ven_id INT AUTO_INCREMENT PRIMARY KEY,
    cli_id INT NOT NULL,
    ven_data DATE NOT NULL,
    FOREIGN KEY (cli_id) REFERENCES clientes(cli_id)
);

CREATE TABLE vendas_produtos (
    vp_id INT AUTO_INCREMENT PRIMARY KEY,
    ven_id INT NOT NULL,
    pro_id INT NOT NULL,
    vp_quantidade INT NOT NULL,
    FOREIGN KEY (ven_id) REFERENCES vendas(ven_id),
    FOREIGN KEY (pro_id) REFERENCES produtos(pro_id)
);


INSERT INTO clientes (cli_nome, cli_cidade) VALUES
('Ana Silva', 'São Paulo'),
('João Souza', 'Rio de Janeiro'),
('Maria Costa', 'Belo Horizonte'),
('Pedro Lima', 'São Paulo');

INSERT INTO produtos (pro_nome, pro_categoria, pro_preco) VALUES
('Notebook', 'Informática', 3500.00),
('Mouse', 'Informática', 80.00),
('Geladeira', 'Eletrodoméstico', 2200.00),
('Televisão', 'Eletrônicos', 1800.00),
('Livro SQL', 'Livros', 120.00);

INSERT INTO vendas (cli_id, ven_data) VALUES
(1, '2025-09-01'),
(2, '2025-09-02'),
(1, '2025-09-05'),
(3, '2025-09-06');

INSERT INTO vendas_produtos (ven_id, pro_id, vp_quantidade) VALUES
(1, 1, 1),  
(1, 2, 2),  
(2, 3, 1),  
(3, 5, 3),  
(4, 4, 1),  
(4, 2, 1);

#1-Quantos clientes existem cadastrados na loja?
select count(*) from clientes;

#2-Quantos produtos estão cadastrados na loja?
select count(*) from produtos;

#3-Qual é o preço médio dos produtos da loja?
select round(avg(pro_preco),2) from produtos;

#4-Qual é o produto mais caro e o mais barato?
select pro_nome, min(pro_preco) from produtos;
select pro_nome, max(pro_preco) from produtos;

#5-Qual foi a primeira data de venda registrada?
select min(ven_data) from vendas;

#6-Qual foi a última data de venda registrada?
select max(ven_data) from vendas;

#7-Quantas vendas foram registradas no total?
select count(*) from vendas_produtos;

#8-Quantos itens no total foram vendidos (somando todas as quantidades)?
select sum(vp_quantidade) from vendas_produtos;

#9-Qual foi o valor total de vendas da loja?
select sum(pro_preco * vp_quantidade) from produtos
join vendas_produtos
on vendas_produtos.pro_id = 
produtos.pro_id;

#10-Qual foi o valor médio das vendas realizadas?
select sum(produtos.pro_preco * vendas_produtos.vp_quantidade) / sum(vendas_produtos.vp_quantidade)
from produtos
join vendas_produtos on vendas_produtos.pro_id = produtos.pro_id;

#11-Qual foi o valor total gasto por todos os clientes juntos?
select sum(vp.vp_quantidade * p.pro_preco) from vendas_produtos vp
inner join produtos p on vp.pro_id = p.pro_id;

#12-Qual foi o valor médio gasto por item vendido?
select p.pro_nome, sum(vp.vp_quantidade * p.pro_preco) / sum(vp.vp_quantidade) from produtos p 
join vendas_produtos vp on vp.pro_id = p.pro_id
group by p.pro_nome;

#13-Qual foi o valor total de compras feitas pela cliente Ana Silva?
select c.cli_nome, sum(vp.vp_quantidade * p.pro_preco) as ValorTotalGasto from clientes c
join vendas v on c.cli_id = v.cli_id
join vendas_produtos vp on v.ven_id = vp.ven_id
join produtos p on p.pro_id = vp.pro_id
where c.cli_nome = 'Ana Silva';

#14-Qual foi o produto mais caro já vendido em alguma compra?
select p.pro_nome, p.pro_preco as ProdutoMaisCaroVendido from produtos p
join vendas_produtos vp on vp.pro_id = p.pro_id
order by p.pro_preco desc
limit 1;

#15-Qual foi o produto mais barato já vendido em alguma compra?
select p.pro_nome, p.pro_preco as ProdutoMaisBaratoVendido from produtos p
join vendas_produtos vp on vp.pro_id = p.pro_id
order by p.pro_preco asc
limit 1;

#16-Qual é o valor total gasto apenas em produtos da categoria "Informática"?
select sum(p.pro_preco * vp_quantidade) from produtos p
join vendas_produtos vp on vp.pro_id = p.pro_id
where p.pro_categoria = "Informática";

#17-Qual foi o total de unidades de produtos vendidos em todas as vendas juntas?

#18-Qual foi o valor total de vendas realizadas em setembro de 2025?

#19-Qual foi o valor total de vendas realizadas para clientes da cidade de São Paulo?

#20-Qual é o preço médio dos produtos que já foram vendidos pelo menos uma vez?
