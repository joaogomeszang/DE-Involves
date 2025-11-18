CREATE TABLE public.ft_ponto_extra (
    id_ponto_venda     BIGINT   NOT NULL,
    id_linha_produto   BIGINT   NOT NULL,
    mes                INTEGER  NOT NULL,
    ano                INTEGER  NOT NULL,
    soma_pontos        INTEGER  NOT NULL
);

CREATE TABLE public.ft_ponto_extra_agregada (
    id_ponto_venda  BIGINT   NOT NULL,
    mes             INTEGER  NOT NULL,
    ano             INTEGER  NOT NULL,
    soma_pontos     INTEGER  NOT NULL
);

CREATE TABLE public.ft_disponibilidade_agregada (
    id_ponto_venda   BIGINT   NOT NULL,
    ano              INTEGER  NOT NULL,
    mes              INTEGER  NOT NULL,
    quantidade       INTEGER  NOT NULL
);

CREATE TABLE public.ft_disponibilidade (
    id_ponto_venda     BIGINT       NOT NULL,
    id_linha_produto   BIGINT       NOT NULL,
    mes                INTEGER      NOT NULL,
    ano                INTEGER      NOT NULL,
    quantidade         INTEGER      NOT NULL
);

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
    data_ref VARCHAR(50), 
    mes INTEGER,
    ano INTEGE
);
