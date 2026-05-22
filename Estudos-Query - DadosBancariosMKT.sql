-- ============================================================
-- Dataset "Bank Marketing Dataset" 
-- Utilizado para aprendizado com base na aula da 
-- Universidade dos Dados by: Andre Yukio
-- ============================================================

SELECT * FROM mkt.bank LIMIT 10;

-- PARTE 1: EXPLORAÇÃO E ENTENDIMENTO DOS DADOS

-- Utilização do DESC para melhor entendimento de como estão alocados os tipos dos dados, percebe-se que existem valores Inteiros e Textos. Existem valores faltantes "null" em todas as colunas. --

DESC bank;

-- Quantos registros e quantas colunas existem no dataset? --
-- Total de 4521 registros -- 

SELECT COUNT(*) AS total_registros
FROM bank;

-- Total de 17 Colunas --

SELECT COUNT(*) AS total_colunas
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'bank';

-- Qual o saldo médio dos clientes? --

SELECT AVG(balance) AS saldo_medio
FROM Bank;

-- Quais são as profissões mais frequentes na base? --
-- Top 3 são "Management" 969 com aproximadamente 21%, "Blue-Collar" 946 com aproximadamente 21% e "Technician" 768 com aproximadamente 17% --

SELECT job,
	COUNT(*) AS total_por_profissoes
FROM bank
GROUP BY job
ORDER BY total_por_profissoes DESC;

-- Quantos clientes possuem crédito em default? -- 
-- 76 clientes, relativamente poucos, ou seja, a base é composta majoritariamente por clientes adimplentes -- Duvida, esses convertem menos? ou mais? em relação aos "Não" Default?? --

SELECT COUNT(*) AS pendencia_credito
FROM bank
WHERE `default` = 'yes';

-- PARTE 2: ANÁLISE DE CONVERSÃO

-- Qual a distribuição da coluna y? Quantos clientes aderiram ao depósito e quantos não? --
-- Cerca de 88,47% não aderiram (4000) e cerca de 11,53% aderiram (521) ou seja 88% do tempo dos vendedores com possiveis clientes não estão levando a efetivação de novos negocios, para objetivos futuros, como identificar quais contatos teriam mais chance de adesão??? --

SELECT y, 
	COUNT(*) AS Adesões
FROM bank
GROUP BY y;

-- Qual o saldo médio dos clientes que aderiram vs. os que não aderiram? -- 
-- Saldo médio de 1571,95 para os que aderiram e de 1403,21 para os que não aderiram. --

SELECT y, AVG(balance) AS saldo_medio
FROM Bank
GROUP BY y
ORDER BY saldo_medio DESC;

-- Interessante, a taxa de conversão para os que estão como "Sim" para Default é maior.... --

SELECT `default`, 
       COUNT(*) AS total,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS aderiram,
       ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taxa_conversao
FROM bank
GROUP BY `default`;

-- PARTE 3: ANÁLISE POR PERFIL DO CLIENTE

-- Qual a taxa de adesão por tipo de profissão? Qual profissão converte mais? -- 
-- Top 3 dividido entre aposentados com 23,48%, estudantes com 22,62% e profissões não preechidas com 18,42% Basicamente aposentados geralmente têm dinheiro acumulado, tem menos despesas fixas, talvez estudantes pensem mais no futuro?? ou são mais faceis de convencer?? --

SELECT job,
	COUNT(*) AS total_por_profissoes,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) aderiram,
	ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taxa_conversao
FROM bank
GROUP BY job
ORDER BY taxa_conversao DESC;

-- Os aposentados tem um saldo medio maior do que os estudantes, isso indica que eles possuem menos despesas fixas de fato? ou a aposentadoria e o tempo de vida influenciam para esse saldo maior quando comparado com estudantes? --

SELECT job, 
       ROUND(AVG(balance), 2) AS saldo_medio
FROM bank
WHERE y = 'yes'
  AND job IN ('retired', 'student')
GROUP BY job;

-- A escolaridade (education) influencia na adesão? Mostre a taxa de conversão por nível educacional. --
-- 	Os dados mostram que aqueles que tem uma escolaridade maior acabam tendo uma taxa de conversão maior, mais conhecimento/entendimento/maturidade?? ou será a remuneração maior que abre mais portas para a conversão??
SELECT education,
	COUNT(*) AS total_education,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) aderiram,
	ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taxa_conversao_education
FROM bank
GROUP BY education
ORDER BY taxa_conversao_education DESC;

-- Mais conhecimento/entendimento/maturidade?? ou será a remuneração maior que abre mais portas para a conversão??
-- Maior escolaridade reflete em um emprego melhor? refletindo em um maior 'saldo'? Mais chance de conversão?
SELECT education,
       ROUND(AVG(balance), 2) AS saldo_medio,
       ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taxa_conversao_education_balance
FROM bank
GROUP BY education
ORDER BY taxa_conversao_education_balance DESC;

-- PARTE 4: ANÁLISE POR FAIXA ETÁRIA

-- Aparentemente nos dados apresentados a aposentadoria e o tempo de vida influenciam para esse saldo maior (Claro que existem diversas outras variaveis que não estão presentes) --
SELECT 
    CASE 
        WHEN age <= 30 THEN '18-30'
        WHEN age <= 40 THEN '31-40'
        WHEN age <= 50 THEN '41-50'
        WHEN age <= 60 THEN '51-60'
        ELSE '60+'
    END AS faixa_etaria,
    ROUND(AVG(balance), 2) AS saldo_medio
FROM bank
GROUP BY faixa_etaria
ORDER BY saldo_medio;

-- E a taxa de conversão com base na faixa etaria? faz sentido??
-- Detalhe interessante, a segunda maior taxa de conversão em relação a faixa etaria são de pessoas entre 18 e 30 anos e ao mesmo tempo essa faixa é a que tem o menor saldo medio... ou seja, nem tudo se trata de valor/saldo disponivel mas sim de motivação/disposição??
SELECT 
    CASE 
        WHEN age <= 30 THEN '18-30'
        WHEN age <= 40 THEN '31-40'
        WHEN age <= 50 THEN '41-50'
        WHEN age <= 60 THEN '51-60'
        ELSE '60+'
    END AS faixa_etaria,
    COUNT(*) AS total,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS aderiram,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taxa_conversao_faixa,
    ROUND(AVG(balance), 2) AS saldo_medio
FROM bank
GROUP BY faixa_etaria
ORDER BY taxa_conversao_faixa DESC;

-- PARTE 5: ANÁLISE DA CAMPANHA - EFICIÊNCIA E SAZONALIDADE

-- Qual o mês em que ocorerram mais contatos? E qual teve a melhor taxa de conversão?
-- Aparentemente os dados demonstram que no final do ano existe uma taxa de conversão maior, porém seria necessário avaliar uma amostra maior pois nesse caso ocorreram poucos contatos... outra observação interessante é que no mês de maio apesar de inumeros contatos a taxa de conversão foi relativamente baixa comparado com os meses de top conversão, talvez a instituição está alocando forças em quantidade mas não em qualidade?? Outra questão pode ser a Sazonalidade? Bonificações de final de ano/no caso do Brasil, decimo terceiro seria um influenciador..
SELECT `month`, 
	COUNT(*) AS meses_contatos,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) aderiram,
	ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taxa_conversao_meses
FROM bank
GROUP BY `month`
ORDER BY taxa_conversao_meses DESC;

-- Qual a duração média da chamada para quem aderiu vs. quem não aderiu?
SELECT y, AVG(duration) AS duracao_media
FROM Bank
GROUP BY y
ORDER BY duracao_media DESC;

-- Clientes que já foram contatados antes convertem mais do que os que nunca foram contatados? Ou seja, vale a pena tentar um segundo contato??
-- A Taxa de conversão daqueles em primeiro contato foi de 9,10% e a taxa de conversão daqueles que tiveram pelomenos + de 1 contato é de 22,55%, ou seja vale a pena um segundo contato?? O Momento no ano pode afetar isso?
SELECT
	COUNT(*) AS contatos_total,
    CASE WHEN previous > 0 THEN 'contato_anterior' ELSE 'primeiro_contato' END AS contatos,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS aderiram,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taxa_conversao_contato
FROM bank
GROUP BY contatos
ORDER BY taxa_conversao_contato DESC;

-- A taxa de conversão se mantem maior em boa parte dos casos relacionados a um próximo contato, ou seja, com os dados apresentados não é só necessáriamente relacionado ao mês de contato (sazonalidade) mas também um follow-up do possivel cliente, será que um segundo/terceiro contato não sai mais barato do que investir em um novo lead que ainda não ocorreu contato??
SELECT `month`,
	CASE WHEN previous > 0 THEN 'contato_anterior' ELSE 'primeiro_contato' END AS contatos,
	COUNT(*) AS contatos_total,
	ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taxa_conversao_contato
FROM bank
GROUP BY `month`, contatos
ORDER BY taxa_conversao_contato DESC, `month`;
