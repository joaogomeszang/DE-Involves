-- ============================================
-- DROP TABLES
-- ============================================
DROP TABLE IF EXISTS public.ft_ponto_extra CASCADE;
DROP TABLE IF EXISTS public.ft_ponto_extra_agregada CASCADE;
DROP TABLE IF EXISTS public.ft_disponibilidade CASCADE;
DROP TABLE IF EXISTS public.ft_disponibilidade_agregada CASCADE;

DROP TABLE IF EXISTS public.dim_pdv CASCADE;
DROP TABLE IF EXISTS public.dim_linha_produto CASCADE;
DROP TABLE IF EXISTS public.dim_calendario CASCADE;

-- ============================================
-- DIMENÇÕES
-- ============================================

-- DIM PDV
CREATE TABLE public.dim_pdv (
    sk_pdv BIGINT NOT NULL,
    id_ponto_venda INTEGER,
    nome_ponto_venda VARCHAR(150),
    perfil_ponto_venda VARCHAR(50),

    version INTEGER,
    date_from DATE,
    date_to DATE

    -- PRIMARY KEY (sk_pdv)
);

-- DIM LINHA PRODUTO
CREATE TABLE public.dim_linha_produto (
    sk_linha_produto BIGINT NOT NULL,
    id_linha_produto INTEGER,
    nome_linha_produto VARCHAR(150),
    marca_linha_produto VARCHAR(100),

    version INTEGER,
    date_from DATE,
    date_to DATE

    -- PRIMARY KEY (sk_linha_produto)
);

-- DIM CALENDARIO (SCD1)
CREATE TABLE public.dim_calendario (
    sk_calendario BIGINT NOT NULL,
    data_ref DATE,
    mes SMALLINT,
    ano SMALLINT
    
    -- PRIMARY KEY (sk_calendario)
);

-- ============================================
-- FATOS
-- ============================================

CREATE TABLE public.ft_ponto_extra (
    sk_pdv BIGINT NOT NULL,
    sk_linha_produto BIGINT NOT NULL,
    sk_calendario BIGINT NOT NULL,
    soma_pontos INTEGER NOT NULL

    -- FOREIGN KEY (sk_pdv) REFERENCES dim_pdv(sk_pdv),
    -- FOREIGN KEY (sk_linha_produto) REFERENCES dim_linha_produto(sk_linha_produto),
    -- FOREIGN KEY (sk_calendario) REFERENCES dim_calendario(sk_calendario)
);

CREATE TABLE public.ft_ponto_extra_agregada (
    sk_pdv BIGINT NOT NULL,
    sk_calendario BIGINT NOT NULL,
    soma_pontos INTEGER NOT NULL
);

CREATE TABLE public.ft_disponibilidade (
    sk_pdv BIGINT NOT NULL,
    sk_linha_produto BIGINT NOT NULL,
    sk_calendario BIGINT NOT NULL,
    quantidade INTEGER NOT NULL
);

CREATE TABLE public.ft_disponibilidade_agregada (
    sk_pdv BIGINT NOT NULL,
    sk_calendario BIGINT NOT NULL,
    quantidade INTEGER NOT NULL
);

