# 🏦 Análise de Campanhas de Telemarketing Bancário — SQL

*13 perguntas que a IA poderia responder, mas mesmo assim eu quis treinar* 🤖

## Sobre o Projeto

Este projeto é uma análise exploratória de dados (EDA) realizada **inteiramente em SQL**, utilizando o dataset **Bank Marketing** da UCI Machine Learning Repository. O objetivo é investigar os fatores que influenciam a adesão de clientes a um depósito a prazo, a partir de dados de campanhas de telemarketing de um banco português.

O foco não é apenas extrair dados, mas **formular hipóteses, testá-las com queries e interpretar os resultados** — simulando o dia a dia de um analista de dados.

---

## Dataset

- **Fonte:** [Bank Marketing Dataset — UCI / Kaggle](https://www.kaggle.com/datasets/janiobachmann/bank-marketing-dataset)
- **Registros:** 4.521 clientes
- **Colunas:** 17 variáveis (demográficas, financeiras e de campanha)
- **Variável alvo:** `y` — se o cliente aderiu ao depósito a prazo (yes/no)

### Principais variáveis utilizadas

| Variável | Descrição |
|----------|-----------|
| `age` | Idade do cliente |
| `job` | Profissão |
| `education` | Nível de escolaridade |
| `balance` | Saldo em conta |
| `default` | Crédito em inadimplência |
| `housing` | Empréstimo habitacional |
| `loan` | Empréstimo pessoal |
| `duration` | Duração da chamada (segundos) |
| `campaign` | Nº de contatos na campanha atual |
| `previous` | Nº de contatos em campanhas anteriores |
| `poutcome` | Resultado da campanha anterior |
| `month` | Mês do contato |
| `y` | Aderiu ao depósito? (sim/não) |

---

## Estrutura da Análise

O arquivo `Estudos-Query - DadosBancariosMKT.sql` está organizado em 5 partes:

### Parte 1 — Exploração e Entendimento dos Dados
Reconhecimento da estrutura da tabela, tipos de dados, volume de registros e distribuição das variáveis principais.

### Parte 2 — Análise de Conversão (Visão Geral)
Taxa de adesão geral (~11,5%), comparação de saldo entre quem aderiu e quem não aderiu, e análise de inadimplência vs. conversão.

### Parte 3 — Análise por Perfil do Cliente
Investigação de quais profissões e níveis de escolaridade convertem mais, incluindo cruzamentos para entender se o fator real é a escolaridade ou a renda associada a ela.

### Parte 4 — Análise por Faixa Etária
Criação de faixas etárias com CASE WHEN para investigar a relação entre idade, saldo e conversão.

### Parte 5 — Análise da Campanha (Eficiência e Sazonalidade)
Avaliação de sazonalidade, duração das chamadas e impacto do follow-up (recontato) na taxa de conversão.

## Principais Achados

### 📌 Taxa de conversão geral é baixa (~11,5%)
88% dos contatos não resultam em adesão, indicando oportunidade de otimização na seleção de leads.

### 📌 Aposentados e estudantes são os perfis que mais convertem
Aposentados convertem ~23% (maior saldo, menos despesas) e estudantes ~22% (menor saldo, mas maior disposição). São motivações diferentes: **capital disponível vs. visão de futuro**.

### 📌 Saldo influencia, mas não explica tudo
Clientes com maior saldo convertem mais na maioria dos casos. Porém, a faixa 18-30 anos tem o menor saldo médio e a segunda maior taxa de conversão — indicando que **motivação e disposição também pesam**.

### 📌 Maior escolaridade → maior saldo → maior conversão
A escolaridade (tertiary) lidera em conversão (14,3%), mas a investigação mostrou que a correlação se mantém com o saldo. O caminho provável é: **mais estudo → melhor emprego → mais saldo → mais conversão**.

### 📌 Sazonalidade: final do ano converte mais, maio converte menos
Outubro e dezembro têm as maiores taxas de conversão (46% e 45%), porém com amostras pequenas. Maio concentra o maior volume de contatos (1398) com a pior conversão (6,6%) — possível problema de **quantidade vs. qualidade**.

### 📌 Follow-up mais que dobra a taxa de conversão
Clientes recontactados convertem ~22,5% vs. ~9% no primeiro contato. Esse efeito se mantém independente do mês, confirmando que **não é sazonalidade — o recontato é um fator real**.

---

## Técnicas SQL Utilizadas

- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`
- Funções de agregação: `COUNT`, `AVG`, `SUM`
- `CASE WHEN` para criação de faixas e flags
- Análise cruzada de múltiplas variáveis

---

## Ferramentas

- **MySQL** — execução das queries
- **MySQL Workbench** — IDE utilizada
- **Dataset:** Bank Marketing (UCI Machine Learning Repository)

---

## Próximos Passos

Os insights extraídos nesta análise servem como base para etapas futuras de um pipeline de Data Science:

- **Feature Engineering em SQL** — criação de uma tabela final com variáveis tratadas (faixas etárias, flags de risco, score de contato) pronta para modelagem
- **Modelagem Preditiva** — utilizar os dados preparados para treinar modelos de classificação (ex: prever adesão ao depósito)
- **Segmentação de Clientes** — aplicar clustering para definir perfis de abordagem distintos

---

## Aprendizados com o Projeto

Este projeto foi desenvolvido como parte do meu aprendizado em SQL com base na aula da **Universidade dos Dados** by (Andre Yukio). Mais do que praticar sintaxe, o objetivo foi exercitar o pensamento analítico, formular hipóteses a partir dos dados, testá-las com queries e interpretar os resultados com visão de negócio.

---

## Contato

Caso queira trocar uma ideia sobre o projeto ou sobre dados em geral, fique à vontade para me contatar!
https://www.linkedin.com/in/jo%C3%A3o-rodrigues-ab3b2725b/
