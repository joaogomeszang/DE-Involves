-- ============================================
-- DROP TABLES (se existirem)
-- ============================================
DROP TABLE IF EXISTS public.ft_ponto_extra CASCADE;
DROP TABLE IF EXISTS public.ft_ponto_extra_agregada CASCADE;
DROP TABLE IF EXISTS public.ft_disponibilidade CASCADE;
DROP TABLE IF EXISTS public.ft_disponibilidade_agregada CASCADE;

DROP TABLE IF EXISTS public.dim_pdv CASCADE;
DROP TABLE IF EXISTS public.dim_linha_produto CASCADE;
DROP TABLE IF EXISTS public.dim_calendario CASCADE;

-- ============================================
-- CREATE TABLES
-- ============================================

CREATE TABLE public.dim_pdv (
    id_ponto_venda INTEGER,
    nome_ponto_venda VARCHAR(100),
    perfil_ponto_venda VARCHAR(50)
);

CREATE TABLE public.dim_linha_produto (
    id_linha_produto INTEGER,
    nome_linha_produto VARCHAR(100),
    marca_linha_produto VARCHAR(100)
);

CREATE TABLE public.dim_calendario (
    data_ref DATE,
    mes INTEGER,
    ano INTEGER
);

CREATE TABLE public.ft_ponto_extra (
    id_ponto_venda     BIGINT   NOT NULL,
    id_linha_produto   BIGINT   NOT NULL,
    data_ref DATE,
    soma_pontos        INTEGER  NOT NULL
);

CREATE TABLE public.ft_ponto_extra_agregada (
    id_ponto_venda  BIGINT   NOT NULL,
    data_ref DATE,
    soma_pontos     INTEGER  NOT NULL
);

CREATE TABLE public.ft_disponibilidade (
    id_ponto_venda     BIGINT       NOT NULL,
    id_linha_produto   BIGINT       NOT NULL,
    data_ref DATE,
    quantidade         INTEGER      NOT NULL
);

CREATE TABLE public.ft_disponibilidade_agregada (
    id_ponto_venda   BIGINT   NOT NULL,
    data_ref DATE,
    quantidade       INTEGER  NOT NULL
);
