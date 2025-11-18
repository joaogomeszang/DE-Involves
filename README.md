<img width="667" height="742" alt="image" src="https://github.com/user-attachments/assets/698e64e6-cce8-42c5-9090-58e76ba485fc" /># DE-Involves
Teste Data Engineer

---

# **Projeto de ETL com Pentaho Data Integration (PDI) — Modelo Dimensional**

Este projeto apresenta a construção de um processo ETL utilizando **Pentaho Data Integration (PDI)** para ingestão, transformação e carga de dados referentes a coletas realizadas em pontos de venda, com base no dataset `DATASET_TESTE_DE.csv`.
Além disso, inclui a criação de um **modelo dimensional** no PostgreSQL e um **job principal** orquestrando todas as transformações.

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

* `ft_disponibilidade (id_ponto_venda, id_linha_produto, mes, ano, quantidade)`
* `ft_disponibilidade_agregada (id_ponto_venda, mes, ano, quantidade)`
* `ft_ponto_extra (id_ponto_venda, id_linha_produto, mes, ano, soma_pontos)`
* `ft_ponto_extra_agregada (id_ponto_venda, mes, ano, soma_pontos)`

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
* Extrair mês/ano = Setembro/2020
* Popular:

  * **ft_disponibilidade**
  * **ft_disponibilidade_agregada**

---

### **🔹 Questão 10 – Fato Ponto Extra**

Regras aplicadas:

* Filtrar registros com `TIPO_COLETA = 'Ponto Extra'`
* Somar valores numéricos da coluna `VALOR`
* Extrair mês/ano = Setembro/2020
* Popular:

  * **ft_ponto_extra**
  * **ft_ponto_extra_agregada**

---

## **📊 Resultados (prints)**
<img width="1301" height="557" alt="image" src="https://github.com/user-attachments/assets/8e10c851-c860-43bb-b5eb-c80ee3c64599" />
<img width="1223" height="496" alt="image" src="https://github.com/user-attachments/assets/1122e557-018b-4680-9da3-25c15d358753" />
<img width="1300" height="503" alt="image" src="https://github.com/user-attachments/assets/cc01cbba-f6d7-450c-b2f2-b72136d61f08" />
<img width="716" height="541" alt="image" src="https://github.com/user-attachments/assets/cb60cd2a-25d7-4586-a090-bddce682125d" />
<img width="509" height="767" alt="image" src="https://github.com/user-attachments/assets/8e061071-1c5f-453c-8786-5f767b2e9245" />
<img width="640" height="658" alt="image" src="https://github.com/user-attachments/assets/ffd590d2-cda7-4fa0-8810-61ff49f4bd1c" />
<img width="619" height="699" alt="image" src="https://github.com/user-attachments/assets/477ca725-66d8-45ae-b40a-4f1e14c9fa17" />
<img width="667" height="742" alt="image" src="https://github.com/user-attachments/assets/4dffdae0-db83-45de-9122-cf737387c8e9" />
<img width="586" height="606" alt="image" src="https://github.com/user-attachments/assets/873c44fb-add2-429e-8d29-a1763ca8e644" />
<img width="680" height="770" alt="image" src="https://github.com/user-attachments/assets/84f82335-aea9-46eb-9dbf-31119b473a34" />
<img width="564" height="620" alt="image" src="https://github.com/user-attachments/assets/bc00d001-12ff-4d90-a751-43fa4e207193" />









Se quiser, posso deixar ainda mais bonito com badges, instruções de contribuição, ou até montar uma versão em inglês pro repositório.
