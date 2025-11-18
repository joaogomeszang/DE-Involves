
Meu perfil Github certo: https://github.com/joaozang (Estou recuperando ele :disappointed:)

# **Projeto de ETL com Pentaho Data Integration (PDI) — Modelo Dimensional**

Este projeto apresenta a construção de um processo ETL utilizando **Pentaho Data Integration (PDI)** para ingestão, transformação e carga de dados referentes a coletas realizadas em pontos de venda, com base no dataset `DATASET_TESTE_DE.csv`.
Além disso, inclui a criação de um **modelo dimensional** no PostgreSQL e um **job principal** orquestrando todas as transformações.

*Optei por manter todas as tabelas de fato em granularidade diária, para garantir que o modelo preserve a granularidade original do dataset mantenha o maior nível de flexibilidade analítica possível evitando perda de informação e aumentando a reutilização das tabelas fato. Optei também por não filtrar especificamente para Setembro/2020 dentro das tabelas fato, porque a fato deve sempre permanecer genérica e não filtrada, mantendo as boas práticas de DW*

---

## **📦 Requisitos Mínimos**

### **1. Docker**

* Docker 20+
* Docker Compose (opcional)

### **2. Pentaho Data Integration (PDI)**

* Versão recomendada: **8.3, 9.1, 9.3 ou 10.x**
* Sistema operacional: Windows, Linux ou MacOS

---

## **🐘 Subindo o Banco de Dados com Docker**

Navegue até a raiz do projeto e rode os comandos abaixo:

```bash
docker build -t meu_banco .
docker run --name pg_container -p 5432:5432 -d meu_banco
docker start pg_container

```

Após subir o banco, pode acessar com:

```bash
 docker exec -it pg_container psql -U meu_usuario -d meu_banco
```
Ao acessar o PostgreSQL, copie e cole o conteúdo do arquivo init.sql que se encontra na raíz do projeto.
Por último, ao inicializar o Pentaho, colocar as seguintes credenciais nas Table Output das Transformations Questão 8, Questão 9 e Questão 10:

POSTGRES_USER=meu_usuario
POSTGRES_PASSWORD=minha_senha
POSTGRES_DB=meu_banco
Porta 5432

---

## **🗄️ Estrutura do Modelo Dimensional**

As tabelas criadas no banco seguem este layout:

### **Dimensões**

* `dim_calendario (data_ref, mes, ano)`
* `dim_pdv (id_ponto_venda, nome_ponto_venda, perfil_ponto_venda)`
* `dim_linha_produto (id_linha_produto, nome_linha_produto, marca_linha_produto)`

### **Fatos**

* `ft_disponibilidade (id_ponto_venda, id_linha_produto, data_ref, quantidade)`
* `ft_disponibilidade_agregada (id_ponto_venda, data_ref, quantidade)`
* `ft_ponto_extra (id_ponto_venda, id_linha_produto, data_ref, soma_pontos)`
* `ft_ponto_extra_agregada (id_ponto_venda, data_ref, soma_pontos)`

---

## **🔧 Metodologia (ETL)**

O projeto utiliza **Pentaho Data Integration** seguindo as instruções:

### **📌 Job Principal**

Foi criado um *job* chamado **Job1.kjb**, responsável por Executar as transformações das questões 8, 9 e 10

A estrutura do job é:

```
Job1
 ├── transformação_dimensoes (questão 8)
 ├── transformação_fato_disponibilidade (questão 9)
 ├── transformação_fato_ponto_extra (questão 10)
```

---

## **📄 Descrição das Questões e Metodologia**

### **🔹 Questão 8 – Dimensões**

Transformação responsável por:

* Ler o dataset `DATASET_TESTE_DE.csv`
* Tratar datas (data_ref, mês, ano)
* Popular:

  * `dim_calendario`
  * `dim_pdv`
  * `dim_linha_produto`
* Evitar duplicidades 

---

### **🔹 Questão 9 – Fato Disponibilidade**

Regras aplicadas:

* Filtrar apenas registros com `TIPO_COLETA = 'Disponibilidade'`
* Contar ocorrências onde `VALOR = 'SIM'`
* Popular:

  * **ft_disponibilidade**
  * **ft_disponibilidade_agregada**

---

### **🔹 Questão 10 – Fato Ponto Extra**

Regras aplicadas:

* Filtrar registros com `TIPO_COLETA = 'Ponto Extra'`
* Somar valores numéricos da coluna `VALOR`
* Popular:

  * **ft_ponto_extra**
  * **ft_ponto_extra_agregada**

---

## **📊 Resultados (prints)**
<img width="1283" height="909" alt="image" src="https://github.com/user-attachments/assets/b5f82663-425c-4783-b4df-575689b9331a" />
<img width="1214" height="901" alt="image" src="https://github.com/user-attachments/assets/4243938c-e908-44a2-9e05-a74df131769e" />
<img width="1298" height="884" alt="image" src="https://github.com/user-attachments/assets/6dcf9e70-453a-4558-b0fd-a7652f023abd" />
<img width="773" height="905" alt="image" src="https://github.com/user-attachments/assets/e872c152-df1e-4439-859b-cc1b4b16ee0e" />
<img width="511" height="836" alt="image" src="https://github.com/user-attachments/assets/7a9677ad-fba6-4b80-b9d1-a2b6cb6e9696" />
<img width="636" height="832" alt="image" src="https://github.com/user-attachments/assets/640c48c4-b6f1-4be0-82ec-9a65025af5c4" />
<img width="602" height="835" alt="image" src="https://github.com/user-attachments/assets/6f4266e6-49a2-4dd5-a177-bbe9239c7520" />
<img width="667" height="839" alt="image" src="https://github.com/user-attachments/assets/9f566a8f-c623-4af7-859d-ae2fbc3b876c" />
<img width="513" height="824" alt="image" src="https://github.com/user-attachments/assets/25f7de78-d65a-49e6-8e33-1220d47f4886" />
<img width="698" height="829" alt="image" src="https://github.com/user-attachments/assets/faee4e97-6a3a-4472-92f0-c903f47c7f8a" />
<img width="519" height="835" alt="image" src="https://github.com/user-attachments/assets/0cb56ba1-2cbf-498e-a99c-bb94760f60b5" />









