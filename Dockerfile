# Usa a imagem oficial do PostgreSQL
FROM postgres:15

# Define variáveis de ambiente (você pode alterar)
ENV POSTGRES_USER=meu_usuario
ENV POSTGRES_PASSWORD=minha_senha
ENV POSTGRES_DB=meu_banco

# Expõe a porta padrão do PostgreSQL
EXPOSE 5432

