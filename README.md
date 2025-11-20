Meu perfil Github certo: https://github.com/joaozang (Estou recuperando ele :disappointed:)

## 📌 **Visão Geral do Projeto**

Este projeto implementa um pipeline ETL completo utilizando **Pentaho Data Integration (PDI)** para processar dados de coletas realizadas em pontos de venda, construir dimensões com **surrogate keys**, modelar fatos diárias e aplicar **Slowly Changing Dimensions (SCD Tipo 2)** para dimensões que podem mudar ao longo do tempo.

O Data Warehouse é estruturado em **PostgreSQL**, com execução orquestrada via *job* do Pentaho.

---

# 🏛️ **Arquitetura do Data Warehouse**

O modelo dimensional é composto por três dimensões e quatro tabelas fato.

### **📁 Dimensões**

| Tabela              | Descrição         | SK | SCD      |
| ------------------- | ----------------- | -- | -------- |
| `dim_calendario`    | Datas do dataset  | ✔  | ❌        |
| `dim_pdv`           | Pontos de venda   | ✔  | ✔ Tipo 2 |
| `dim_linha_produto` | Linhas de produto | ✔  | ✔ Tipo 2 |

### **📊 Fatos (granularidade diária)**

| Fato                          | Descrição                        |
| ----------------------------- | -------------------------------- |
| `ft_disponibilidade`          | Disponibilidade por PDV e linha  |
| `ft_disponibilidade_agregada` | Disponibilidade agregada por PDV |
| `ft_ponto_extra`              | Pontos extras por PDV e linha    |
| `ft_ponto_extra_agregada`     | Pontos extras agregados por PDV  |

---

# 📐 **Diagrama Dimensional (texto)**

```
dim_calendario (SCD1)
  sk_calendario (PK)
  data_ref
  mes
  ano

dim_pdv (SCD2)
  sk_pdv (PK)
  id_ponto_venda
  nome_ponto_venda
  perfil_ponto_venda
  version
  date_from
  date_to

dim_linha_produto (SCD2)
  sk_linha_produto (PK)
  id_linha_produto
  nome_linha_produto
  marca_linha_produto
  version
  date_from
  date_to

ft_disponibilidade
  sk_pdv (FK)
  sk_linha_produto (FK)
  sk_calendario (FK)
  quantidade

ft_disponibilidade_agregada
  sk_pdv (FK)
  sk_calendario (FK)
  quantidade

ft_ponto_extra
  sk_pdv (FK)
  sk_linha_produto (FK)
  sk_calendario (FK)
  soma_pontos

ft_ponto_extra_agregada
  sk_pdv (FK)
  sk_calendario (FK)
  soma_pontos
```

---

# ⚙️ **Pipeline ETL — Pentaho**

## **📌 Job Principal (`Job1.kjb`)**

```
Job1
 ├── carregar_dimensoes (questão 8)
 ├── carregar_fato_disponibilidade (questão 9)
 ├── carregar_fato_ponto_extra (questão 10)
```

---

# 🧩 **Transformações**

## 🔹 **Questão 8 — Dimensões**

### A transformação:

1. Lê o `DATASET_TESTE_DE.csv`
2. Normaliza dados
3. Cria registros únicos
4. Aplica SCD Tipo 2 (dim_pdv, dim_linha_produto):
5. Gera surrogate keys automaticamente 

## 🔹 **Questão 9 — Fato Disponibilidade**

1. Filtro `TIPO_COLETA = 'Disponibilidade'`
2. Mantém granularidade diária
3. Conta registros onde `VALOR = 'SIM'`
4. Faz 3 *Database Lookups*:

   * `sk_pdv`
   * `sk_linha_produto`
   * `sk_calendario`
5. Grava tabelas:

   * `ft_disponibilidade`
   * `ft_disponibilidade_agregada`

---

## 🔹 **Questão 10 — Fato Ponto Extra**

1. Filtro: `TIPO_COLETA = 'Ponto Extra'`
2. Aplica 3 *Database Lookup*
3. Calcula soma de pontos conforme agregações
4. Popula:

   * `ft_ponto_extra`
   * `ft_ponto_extra_agregada`

---

# 📅 **Por que a granularidade é diária?**

Mantive **todas as tabelas fato como diárias** para:

✔ preservar a granularidade original do dataset
✔ maximizar flexibilidade analítica
✔ possibilitar novas agregações sem recriar fatos
✔ não destruir informação histórica

Também **não filtrei setembro/2020 nas fatos**, mantendo a fato **genérica**, o que é uma boa prática de DW.

---

## **📊 Resultados (prints)**
<img width="1323" height="873" alt="image" src="https://github.com/user-attachments/assets/ddd788de-9622-4fc2-8623-78097920efbe" />
<img width="1483" height="868" alt="image" src="https://github.com/user-attachments/assets/bb0d0430-7ec8-47bc-a274-101f9b5168b3" />
<img width="1450" height="870" alt="image" src="https://github.com/user-attachments/assets/74e5f5bf-7b4a-4740-a470-2c6e93aadbe3" />
<img width="973" height="871" alt="image" src="https://github.com/user-attachments/assets/7aec5485-a26c-4025-8317-1c027d077f80" />
<img width="688" height="837" alt="image" src="https://github.com/user-attachments/assets/2f29260d-4aef-47f2-b2e0-eb5038ac2c92" />
<img width="951" height="831" alt="image" src="https://github.com/user-attachments/assets/21b4ba6f-1ca7-4855-90a8-88be5a6a0473" />
<img width="1122" height="836" alt="image" src="https://github.com/user-attachments/assets/0d53eef5-c19f-4d31-8dcb-3730ca50e687" />
<img width="643" height="832" alt="image" src="https://github.com/user-attachments/assets/83cb65e6-20e7-4872-926d-64fe3cc5ae64" />
<img width="546" height="828" alt="image" src="https://github.com/user-attachments/assets/fd417443-7f5e-4cfd-b3a6-069c9aaafbed" />
<img width="641" height="834" alt="image" src="https://github.com/user-attachments/assets/0080ba06-772f-4e4b-9403-7dff4a1858fe" />
<img width="510" height="835" alt="image" src="https://github.com/user-attachments/assets/13a0bc61-049a-4724-90d1-ca8d456c428c" />




















