
--drop nesta ordem por causa das chaves entrangeiras e dependências
 
DROP TABLE HISTORICO;
DROP TABLE Referenciar;
DROP TABLE COMPRA;
DROP TABLE PEDIDO;
DROP TABLE REVENDEDOR;
DROP TABLE PAGAMENTO;
DROP TABLE CARTAO_CLIENTE;
DROP TABLE CLIENTE;
DROP TABLE ENDERECO;

CREATE TABLE ENDERECO 
(id_endEntrega INTEGER NOT NULL PRIMARY KEY,  
 rua_entrega VARCHAR NOT NULL,  
 num_entrega INT NOT NULL,  
 bairro_entrega VARCHAR NOT NULL,  
 cidade_entrega VARCHAR NOT NULL,  
 compelemento_entrega VARCHAR,  
 uf_entrega CHAR(2) NOT NULL); 
 
INSERT INTO ENDERECO VALUES (1, 'Rua 0', 159, 'Vila Nova', 'Porto Alegre', null, 'RS');
INSERT INTO ENDERECO VALUES (2, 'Rua 1', 288, 'Centro', 'Baianópolis', 'Casa 2', 'BA');
INSERT INTO ENDERECO VALUES (3, 'Rua 2', 2425, 'Mangabeiras', 'Maceió', 'Loja Romeo', 'AL');
INSERT INTO ENDERECO VALUES (4, 'Rua 3', 990, 'Sobradinho', 'Brasilia', null, 'DF');
INSERT INTO ENDERECO VALUES (5, 'Rua 4', 990, 'Centro', 'Barcelona', null, 'RN');
INSERT INTO ENDERECO VALUES (6, 'Rua 5', 12, 'Centro', 'Fátima do Sul', 'Floricultura', 'MS');
INSERT INTO ENDERECO VALUES (7, 'Rua 6', 4, 'Bazílio', 'Rio Bonito', null, 'RJ');
INSERT INTO ENDERECO VALUES (8, 'Rua 7', 104, 'São Jorge', 'Santos', null, 'SP');
INSERT INTO ENDERECO VALUES (9, 'Rua 8', 787, 'Vila Nova', 'Porto Alegre', null, 'RS');
INSERT INTO ENDERECO VALUES (10, 'Rua 9', 610, 'Vila Nova', 'Porto Alegre', 'Apto 401', 'RS');
INSERT INTO ENDERECO VALUES (11, 'Rua 10', 200, 'Centro', 'Baianópolis', null, 'BA');
INSERT INTO ENDERECO VALUES (12, 'Rua 11', 354, 'Centro', 'Baianópolis', 'Mercado', 'BA');

select * from ENDERECO;

-- TESTE1: inserir um endereço diferente, mas com a mesma identificação. Ele acusa que já tem um endereço com esse id, e não adiciona.
-- INSERT INTO ENDERECO VALUES (4, 'Rua 5', 0, 'Centro', 'Barcelos', Portão Garagem, 'AM');
-- TESTE2: inserir um endereço igual (em caso de dois clientes cadastrados com mesmo endereço). Ele insere normalmente.
-- INSERT INTO ENDERECO VALUES (6, 'Rua 5', 0, 'Centro', 'Barcelos', Portão Garagem, 'AM');
-- TESTE3: deletar um endereço veinculado a algum cliente. Ele não permite a exclusão.
-- DELETE FROM ENDERECO WHERE id_endEntrega=1;
-- TESTE4: deletar um endereço não viunculado a algum cliente. Ele permite, pois não há vinculo. 
-- DELETE FROM ENDERECO WHERE id_endEntrega=4;

CREATE TABLE CLIENTE 
(num_tel BIGINT NOT NULL PRIMARY KEY,  
 email VARCHAR NOT NULL,  
 nome_c VARCHAR NOT NULL,  
 cod_c CHAR(6) NOT NULL UNIQUE,  
 id_endEntrega INTEGER NOT NULL ,  
 valor_carteira INT NOT NULL,
FOREIGN KEY(id_endEntrega) REFERENCES ENDERECO(id_endEntrega));


INSERT INTO CLIENTE VALUES (11111111, 'mariana@gmail.com', 'Mariana Silva', '4fRG9j', 1, 0.00);
INSERT INTO CLIENTE VALUES (22222222, 'carlos@hotmail.com', 'Carlos Lopes', '75gTTs', 2, 50.00);
INSERT INTO CLIENTE VALUES (33333333, 'isabella@gmail.com', 'Isabela Garcia', 'eYT5E4', 3, 0.00);
INSERT INTO CLIENTE VALUES (44444444, 'fernando@outlook.com', 'Fernando Marino', 'OPf84r', 5, 0.00);
INSERT INTO CLIENTE VALUES (55555555, 'roberta@gmail.com', 'Roberta Rocha', 'UD7845', 10, 100.00);
INSERT INTO CLIENTE VALUES (66666666, 'joao@yahoo.com', 'Joao Silva', '75Hgd7', 4, 0.00);
INSERT INTO CLIENTE VALUES (77777777, 'guilherme@outlook.com', 'Guilherme Dó', 'KkK143', 5, 0.00);
INSERT INTO CLIENTE VALUES (88888888, 'larah@hotmail.com', 'Larah West', '97Yu54', 9, 0.00);
INSERT INTO CLIENTE VALUES (99999999, 'tales@gmail.com', 'Tales Fernando', 'hgj415', 10, 0.00);
INSERT INTO CLIENTE VALUES (10101010, 'yas@gmail.com', 'Yasmin Hass', 'Rths9g', 11, 75.00);
INSERT INTO CLIENTE VALUES (11011011, 'vitor@hotmail.com', 'Vitor Costa', 'ref6fa', 6, 0.00);

select * from CLIENTE;
select * from ENDERECO natural join CLIENTE;


-- TESTE1: Atualizar novo endereço de um determinado cliente. Ele troca normalmente se o endereço existir na tabela ENDERECO.
-- UPDATE CLIENTE SET ref_endereco=2 WHERE num_tel=11111111;

 
 CREATE TABLE CARTAO_CLIENTE 
(cartaoNumero BIGINT NOT NULL PRIMARY KEY,  
 cartaoCVV INT NOT NULL,  
 cartaoVAL CHAR(7) NOT NULL,  
 cartaoNOME VARCHAR NOT NULL); 
 
INSERT INTO CARTAO_CLIENTE VALUES (1234567898521463, 795, '02/2027' , 'Mariana Silva'); 
INSERT INTO CARTAO_CLIENTE VALUES (48745741982251463, 654, '10/2025' , 'Mariana Silva'); 
INSERT INTO CARTAO_CLIENTE VALUES (7845129634571542, 150, '12/2020' , 'Fernando Marino');
INSERT INTO CARTAO_CLIENTE VALUES (1234441898521463, 784, '01/2021' , 'Yasmin Hass');



select * from CARTAO_CLIENTE;


-- TESTE1: Adicionar um novo cartão, mas com o mesmo número. Ele da erro, poius cartaoNumero é chave primária, única.
-- INSERT INTO CARTAO_CLIENTE VALUES (1234567898521463, 741, '03/2024' , 'Joseane Silva');
 
CREATE TABLE PAGAMENTO 
(id_pedPag VARCHAR PRIMARY KEY,
 totalApagar INT NOT NULL,  
 cupomD VARCHAR,  
 codPagOn INT,  
 tipo_Pag VARCHAR(10) NOT NULL CHECK (tipo_Pag='dinheiro' OR tipo_Pag='debito' OR tipo_Pag='credito' OR tipo_Pag='carteira'),  
 cartaoNumero BIGINT,
FOREIGN KEY(cartaoNumero) REFERENCES CARTAO_CLIENTE(cartaoNumero));

INSERT INTO PAGAMENTO VALUES ('1pag', 75.00, null, 9898, 'credito', 1234567898521463); 
INSERT INTO PAGAMENTO VALUES ('2pag', 67.64, '5%OFF', 7574, 'debito', 1234567898521463); 
INSERT INTO PAGAMENTO VALUES ('3pag', 75.00, null, null, 'dinheiro'); 
INSERT INTO PAGAMENTO VALUES ('4pag', 47.00, '6%OFF', 1520, 'carteira'); 
INSERT INTO PAGAMENTO VALUES ('5pag', 71.00, null, null, 'dinheiro'); 
INSERT INTO PAGAMENTO VALUES ('6pag', 100.00, null, null, 'dinheiro'); 
INSERT INTO PAGAMENTO VALUES ('7pag', 66.50, '5%OFF', 9987, 'debito'); 
INSERT INTO PAGAMENTO VALUES ('8pag', 50.00, null, null, 'dinheiro'); 
INSERT INTO PAGAMENTO VALUES ('9pag', 45.00, '10%OFF', null, 'dinheiro');
INSERT INTO PAGAMENTO VALUES ('10pag', 50.00, null, 7451, 'debito', 48745741982251463);
INSERT INTO PAGAMENTO VALUES ('11pag', 75.00, null, 4514, 'credito', 1234567898521463); 
INSERT INTO PAGAMENTO VALUES ('12pag', 65.00, null, null, 'dinheiro'); 
INSERT INTO PAGAMENTO VALUES ('13pag', 57.00, '5%OFF', null, 'dinheiro');



select * from PAGAMENTO;
select * from PAGAMENTO natural join CARTAO_CLIENTE;
UPDATE PAGAMENTO SET tipo_Pag = 'credito' WHERE id_pedPag = '2pag';
UPDATE PAGAMENTO SET totalApagar = 2000 WHERE id_pedPag = '13pag';



-- TESTE1: Não é possível deleter um pagamento realizado. Ele é sempre guardo no sistema.
-- DELETE FROM PAGAMENTO WHERE id_pedPag='3pagamento';


CREATE TABLE REVENDEDOR 
(nome_r VARCHAR NOT NULL PRIMARY KEY,  
 empresa VARCHAR NOT NULL,  
 tem_medio VARCHAR NOT NULL, 
 nota_r DECIMAL NOT NULL CHECK (nota_r>=0.0 AND nota_r<=5.0),  
 rua_r VARCHAR NOT NULL,
 num_r INTEGER NOT NULL,
 bairro_r VARCHAR NOT NULL,  
 cidade_r VARCHAR NOT NULL, 
 uf_r CHAR(2) NOT NULL); 
 
INSERT INTO REVENDEDOR VALUES ('Master Gas', 'Supergasbras', '10-15min', 4.8, 'Rua 6', 757, 'Vila Nova', 'Porto Alegre', 'RS');
INSERT INTO REVENDEDOR VALUES ('Piramide Gas II', 'Ultragaz', '10-30min', 4.8, 'Rua 7', 246, 'Vila Nova', 'Porto Alegre', 'RS');
INSERT INTO REVENDEDOR VALUES ('Gas Campo Novo', 'Nacional Gas', '10-30min', 4.5, 'Rua 10', 100, 'Campo Novo', 'Baianópolis','BA');
INSERT INTO REVENDEDOR VALUES ('Rota Sul Gas', 'Supergasbras', '10-30min', 4.9, 'Rua 2', 600, 'Centro', 'Barcelona', 'RN');
INSERT INTO REVENDEDOR VALUES ('Ferreira Gas', 'Nacional Gas', '10-30min', 4.7, 'Rua 1', 1520, 'Centro', 'Baianópolis','BA');
INSERT INTO REVENDEDOR VALUES ('Aquele Gás', 'Supergasbras', '10-12min', 5.0, 'Rua 8', 1520, 'Vila Nova', 'Porto Alegre','RS');
INSERT INTO REVENDEDOR VALUES ('Gás Super', 'Nacional Gas', '10-12min', 5.0, 'Rua 77', 11010, 'Centro', 'Fátima do Sul','MS');

select * from REVENDEDOR;
UPDATE REVENDEDOR SET bairro_r = 'Belem Velho' WHERE nome_r = 'Aquele Gás';

 
-- TESTE1: Não é possível deleter um revendedor. Mesmo que ele não faça mais parte da lista de revendedores, ele ainda permanece 
-- sistema, de forma inativa.
-- DELETE FROM REVENDEDOR WHERE nome_r='Master Gas'; 

CREATE TABLE PEDIDO 
(botijaoTIPO CHAR(4) NOT NULL,  
 botijaoValU INT NOT NULL,  
 botijaoQnt INT NOT NULL CHECK (botijaoQnt>=1 AND botijaoQnt<=5) ,  
 id_pedPag VARCHAR NOT NULL,  
 num_tel BIGINT NOT NULL,  
 nome_r VARCHAR NOT NULL,  
 id_pedido VARCHAR PRIMARY KEY,
FOREIGN KEY(id_pedPag) REFERENCES PAGAMENTO(id_pedPag),
FOREIGN KEY(num_tel) REFERENCES CLIENTE(num_tel),
FOREIGN KEY(nome_r) REFERENCES REVENDEDOR(nome_r));

INSERT INTO PEDIDO VALUES ('13kg', 75.00, 1, '1pag', 11111111, 'Master Gas', 'ped1');
INSERT INTO PEDIDO VALUES ('13kg', 71.00, 1, '2pag', 10101010, 'Gas Campo Novo', 'ped2');
INSERT INTO PEDIDO VALUES ('13kg', 75.00, 1, '3pag', 11111111, 'Master Gas', 'ped3');
INSERT INTO PEDIDO VALUES ('13kg', 50.00, 1, '8pag', 22222222, 'Ferreira Gas', 'ped5');
INSERT INTO PEDIDO VALUES ('13kg', 50.00, 1, '4pag', 22222222, 'Ferreira Gas', 'ped4');
INSERT INTO PEDIDO VALUES ('13kg', 65.00, 1, '12pag', 22222222, 'Piramide Gas II', 'ped6');
INSERT INTO PEDIDO VALUES ('13kg', 65.00, 1, '11pag', 11111111, 'Piramide Gas II', 'ped7');
INSERT INTO PEDIDO VALUES ('13kg', 70.00, 1, '7pag', 66666666, 'Rota Sul Gas', 'ped8');
INSERT INTO PEDIDO VALUES ('13kg', 70.00, 2, '6pag', 66666666, 'Rota Sul Gas', 'ped9');
INSERT INTO PEDIDO VALUES ('13kg', 50.00, 1, '10pag', 11111111, 'Aquele Gás', 'ped10');
INSERT INTO PEDIDO VALUES ('13kg', 71.00, 1, '5pag', 10101010, 'Gas Campo Novo', 'ped11');
INSERT INTO PEDIDO VALUES ('13kg', 60.00, 1, '13pag', 11011011, 'Gás Super', 'ped12');
INSERT INTO PEDIDO VALUES ('13kg', 50.00, 1, '9pag', 99999999, 'Ferreira Gas', 'ped13');

select * from PEDIDO
order by id_pedido;
select * from PEDIDO natural join PAGAMENTO
					 natural join CLIENTE
					 natural join REVENDEDOR;

CREATE TABLE COMPRA 
(id_pedido VARCHAR PRIMARY KEY,  
 avaliacao DECIMAL CHECK (avaliacao>=0.0 AND avaliacao<=5.0),  
 dataEhoraEntrega TIMESTAMP NOT NULL,  
 id_pedPag VARCHAR NOT NULL,  
FOREIGN KEY(id_pedido) REFERENCES PEDIDO(id_pedido),
FOREIGN KEY(id_pedPag) REFERENCES PAGAMENTO(id_pedPag));

INSERT INTO COMPRA VALUES ('ped1', 5.0, '07/08/2020 12:53:00', '1pag');
INSERT INTO COMPRA VALUES ('ped3', 5.0, '07/09/2020 09:30:00', '3pag');
INSERT INTO COMPRA VALUES ('ped7', 4.7, '15/06/2020 09:00:00', '11pag');
INSERT INTO COMPRA VALUES ('ped10', 1.0, '10/05/2020 17:45:00', '10pag');
INSERT INTO COMPRA VALUES ('ped4', 4.9, '14/05/2020 11:42:1', '4pag');
INSERT INTO COMPRA VALUES ('ped5', 5.0, '07/10/2020 19:50:05', '8pag');
INSERT INTO COMPRA VALUES ('ped6', 4.0, '10/02/2020 09:30:47', '12pag');
INSERT INTO COMPRA VALUES ('ped2', 5.0, '17/10/2020 10:17:42', '2pag');
INSERT INTO COMPRA VALUES ('ped11', 5.0, '10/12/2020 07:00:54', '5pag');
INSERT INTO COMPRA VALUES ('ped8', 5.0, '17/10/2020 10:17:42', '7pag');
INSERT INTO COMPRA VALUES ('ped9', 5.0, '02/04/2021 10:10:01', '6pag');
INSERT INTO COMPRA VALUES ('ped12', 5.0, '02/05/2021 17:00:42', '13pag');
INSERT INTO COMPRA VALUES ('ped13', 5.0, '10/05/2021 12:00:02', '9pag');

select * from COMPRA;
select * from COMPRA natural join PEDIDO
					 natural join PAGAMENTO;

CREATE TABLE HISTORICO 
(num_tel BIGINT,  
 id_pedido VARCHAR UNIQUE, 
 alarme_inicio DATE,  
 alarme_fim DATE,
FOREIGN KEY(num_tel) REFERENCES CLIENTE(num_tel),
FOREIGN KEY(id_pedido) REFERENCES COMPRA(id_pedido));

INSERT INTO HISTORICO VALUES (11111111,'ped1');
INSERT INTO HISTORICO VALUES (11111111,'ped3');
INSERT INTO HISTORICO VALUES (11111111,'ped7');
INSERT INTO HISTORICO VALUES (11111111,'ped10');
INSERT INTO HISTORICO VALUES (22222222,'ped4', '10/02/2020', '10/03/2020');
INSERT INTO HISTORICO VALUES (22222222,'ped5');
INSERT INTO HISTORICO VALUES (10101010,'ped2');
INSERT INTO HISTORICO VALUES (10101010,'ped11');
INSERT INTO HISTORICO VALUES (66666666,'ped8');
INSERT INTO HISTORICO VALUES (66666666,'ped9');
INSERT INTO HISTORICO VALUES (11011011,'ped12');
INSERT INTO HISTORICO VALUES (99999999,'ped13');


select * from HISTORICO;
select * from HISTORICO natural join CLIENTE
					 	natural join COMPRA;


CREATE TABLE Referenciar 
(nome_r VARCHAR,  
id_endEntrega BIGINT,
PRIMARY KEY (nome_r, id_endEntrega),
FOREIGN KEY(nome_r) REFERENCES REVENDEDOR(nome_r),
FOREIGN KEY(id_endEntrega) REFERENCES ENDERECO(id_endEntrega));

INSERT INTO Referenciar VALUES ('Master Gas', 1);
INSERT INTO Referenciar VALUES ('Master Gas', 9);
INSERT INTO Referenciar VALUES ('Master Gas', 10);
INSERT INTO Referenciar VALUES ('Piramide Gas II', 1);
INSERT INTO Referenciar VALUES ('Piramide Gas II', 9);
INSERT INTO Referenciar VALUES ('Piramide Gas II', 10);
INSERT INTO Referenciar VALUES ('Aquele Gás', 1);
INSERT INTO Referenciar VALUES ('Aquele Gás', 9);
INSERT INTO Referenciar VALUES ('Aquele Gás', 10);
INSERT INTO Referenciar VALUES ('Gas Campo Novo', 2);
INSERT INTO Referenciar VALUES ('Gas Campo Novo', 11);
INSERT INTO Referenciar VALUES ('Gas Campo Novo', 12);
INSERT INTO Referenciar VALUES ('Ferreira Gas', 2);
INSERT INTO Referenciar VALUES ('Ferreira Gas', 11);
INSERT INTO Referenciar VALUES ('Ferreira Gas', 12);
INSERT INTO Referenciar VALUES ('Rota Sul Gas', 5);
INSERT INTO Referenciar VALUES ('Gás Super',6);



select * from Referenciar;
select * from Referenciar natural join REVENDEDOR
					 	  natural join ENDERECO;

------------------------------ PARTE 2 DO TRABALHO ------------------------------
-- Definir uma visão útil a seu universo de discurso, envolvendo no mínimo 3 tabelas
-- decidimos focar no objetivo do trabalho/universo de discurso, que é a realização de um pedido de gás, com entrega doméstica;
-- sendo assim, focaremos em uma única tabela, denomeada PEDIDO_SOLICITANDO, usando CREATE VIEW, fazendo a tela de simulação de um
-- pedido sendo solicitado, mostrando o revendedor, tipo de botijão (em kg), total da compra, se teve uso de cupom de desconto,
-- e a forma de pagamento. Para melhor visualização também optamos por adicionar o nome do cliente.
CREATE VIEW NO_HISTORICO (Cliente, Revendedor, Tipo_Gas, Quantiade, Valor_Pago, Pagamento_Por, Codigo, Data_Hora) as
						  SELECT nome_c, nome_r, empresa, botijaoQnt ,totalApagar, tipo_Pag, codPagOn, dataEhoraEntrega from
						  CLIENTE natural join REVENDEDOR natural join PAGAMENTO natural join PEDIDO natural join COMPRA;
						  
select * from NO_HISTORICO;
DROP VIEW NO_HISTORICO;
						
-- Pelo menos duas consultas com GROUP BY, utilizando HAVING em uma
-- 1) O nome de cada cliente, revendedores ligados a ele, e a quantidade de pedidos que ele realizou para cada revendedor ligado a si
select distinct nome_c, count(id_pedido), nome_r
from CLIENTE natural join REVENDEDOR natural join PEDIDO 
group by nome_c, nome_r
order by nome_c;

-- 2) Revendedores que venderam R$90 ou mais (juntando todos os pedidos) em dinheiro, e o quanto venderam
-- Deve retornar Ferreira Gas, Gás Super e Rota Sul Gas
select nome_r, sum(totalApagar) 
from REVENDEDOR natural join PEDIDO natural join PAGAMENTO
where tipo_Pag = 'dinheiro'
group by nome_r
having sum(totalApagar) >= 90.00

-- Pelo menos duas consultas usando SUBCONSULTAS obrigatóriamente
-- 3) Nome dos clientes que fizeram pedidos em dinheiro e pedidos em cartão de credito
-- Deve retornar Mariana Silva e Yasmin Hass
select distinct nome_c
from CLIENTE natural join PEDIDO natural join PAGAMENTO
where tipo_Pag = 'dinheiro' and num_tel in (select num_tel
											 from PEDIDO natural join PAGAMENTO
											 where tipo_Pag = 'credito')

-- 4) Revendedores que antenderam Mariana Silva e Carlos Lopes
-- Deve retornar Piramide Gas II
select distinct nome_r
from REVENDEDOR natural join PEDIDO natural join CLIENTE
where nome_c = 'Mariana Silva' and nome_r in (select distinct nome_r
											from PEDIDO natural join CLIENTE
											where nome_c = 'Carlos Lopes')
											
-- 5) Para clientes que fizeram pedidos em dinheiro e pedidos em cartão de credito,
-- o nome do cliente, tipo de pagamento da compra de maior valor, e este valor
-- Deve retornar Mariana Silva, credito e 75 reais, assim como Yasmin Hass, credito e 150 reais
select nome_c, tipo_Pag, max(totalApagar)
from PEDIDO natural join PAGAMENTO natural join CLIENTE
where tipo_Pag = 'credito' and num_tel in (select num_tel
											from PEDIDO natural join PAGAMENTO
											where tipo_Pag = 'dinheiro')
group by nome_c, tipo_Pag;

-- Pelo menos uma consulta usando EXIST/NOT EXIST
-- 6) Clientes de Porto Alegre que não foram atendidos por nenhum dos revendedores que atenderam Mariana Silva 
-- Carlos Lopes é o único portoalegrence que não deve aparecer, pois foi atendido pelo revendedor em comum com Mariana Silva: Piramide Gas II
-- Deve retornar Roberta Rocha, Larah West e Tales Fernando 
select nome_c
from CLIENTE as EXC natural join ENDERECO
where cidade_entrega = 'Porto Alegre' and not exists (select nome_r
				 from REVENDEDOR natural join PEDIDO natural join CLIENTE
				 where nome_c = 'Mariana Silva' and nome_r in (select nome_r
															  from REVENDEDOR natural join PEDIDO natural join CLIENTE
															  where nome_c = EXC.nome_c));

-- Pelo menos uma consulta usando a VIEW declarada no item anterior
-- 7) O número total de pedidos finalizados em dinheiro, o número total de pedidos finalizados em cartão de crédito ou debito
-- Deve retornar credito, com 3, debito com 2 e dinheiro com 7
select Pagamento_Por, count(Pagamento_Por)
from NO_HISTORICO
where Pagamento_Por > 'carteira'
group by Pagamento_Por

-- 8) Empresa mais famosa entre os compradores; ou seja, a empresa que tem mais pedidos realizados/efetuados, e o número de pedidos
-- Deve retornar Nacional Gas, com 6 pedidos 
select Tipo_Gas, count(Tipo_Gas)
from NO_HISTORICO
group by Tipo_Gas
having count(Tipo_Gas) = (select max(maxEMPRESA)
						 from (select Tipo_Gas, count(Tipo_Gas) maxEMPRESA
						 	  from NO_HISTORICO
							  group by Tipo_Gas) as maxEMPRESA)


-- 9) Estados que ainda não possuem revendedores
-- Deve retornar AL, DF, RJ e SP
select UF_entrega
from ENDERECO 
where UF_entrega not in (select distinct UF_r
					 	from Referenciar natural join REVENDEDOR)

-- 10) Empresas que possuem mais revendedores
-- Deve retornar Nacional Gas e Supergasbras, ambas com 3 revendedores
select empresa, count(nome_r)
from REVENDEDOR
group by empresa
having count(nome_r) = (select max(maxREV)
					   from (select empresa, count(nome_r) maxREV
							from REVENDEDOR
							group by empresa) as maxREV)


