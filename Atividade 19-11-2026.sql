#Exercícios plataforma hospedagens - 19/11/2026

/*Para resolução dos exercícios, utilize a função "Reverse Engineer"
disponível em "Database" localizado na parte superior do MySQL,
para gerar os Diagramas Lógicos e facilitar a resolução dos problemas.*/

/*
1. Exiba somente os campos com o valor mais alto
de aluguel.
*/
SELECT * FROM RESERVAS
ORDER BY PRECO_TOTAL DESC
LIMIT 10;
/*
2. Realize uma consulta que mostre o nome do cliente que mais
gastou, além de exibir o total de dias passados na hospedagem
*/
SELECT
c.nome AS nome_cliente,
SUM(r.preco_total) AS total_gasto,
SUM(DATEDIFF(r.data_fim, r.data_inicio)) AS total_dias
FROM clientes c
INNER JOIN RESERVAS r ON c.cliente_id = r.cliente_id
GROUP BY c.cliente_id, c.nome
ORDER BY total_gasto DESC
LIMIT 1;
/*
3. Desenvolva uma consulta em que sejam exibidos os tipos 
de imóveis mais bem avaliados, junto com os comentários.
*/
SELECT
h.tipo AS tipo_imovel,
a.nota,
a.comentario
FROM avaliacoes a
INNER JOIN hospedagens h ON a.hospedagem_id = h.hospedagem_id
WHERE a.nota = (
SELECT MAX(nota)
FROM avaliacoes
);
/*
4.Agora, realize uma consulta que retorne, além das 
avaliações e comentários, o nome do proprietario
e cidade da hospedagem dos tipos hoteis.
*/
SELECT
a.nota AS avaliacao,
a.comentario,
p.nome AS nome_proprietario,
e.cidade
FROM avaliacoes a
INNER JOIN hospedagens h ON a.hospedagem_id = h.hospedagem_id
INNER JOIN proprietarios p ON h.proprietario_id = p.proprietario_id
INNER JOIN enderecos e ON h.endereco_id = e.endereco_id
WHERE h.tipo LIKE '%hotel%';