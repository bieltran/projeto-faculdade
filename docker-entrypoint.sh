#!/bin/bash
set -e

echo "Iniciando Sistema de Gestao Empresarial v2.1.0"

if [ -z "${DATABASE_URL:-}" ]; then
    echo "DATABASE_URL nao configurada. Informe a URL do banco PostgreSQL em nuvem."
    exit 1
fi

cd /app/backend

echo "Sincronizando schema Prisma com o banco em nuvem..."
npx prisma db push

if [ "${RUN_SEED:-false}" = "true" ]; then
    echo "Executando seed do banco..."
    npx prisma db seed
fi

echo "Banco de dados configurado."

cd /app

echo "Iniciando aplicacao..."
exec "$@"
