# Configurar banco em nuvem

O projeto agora usa PostgreSQL via Prisma. A API continua sendo Node/Express, mas o banco não precisa mais rodar na maquina local.

## Opcao recomendada: Render Blueprint

O arquivo `render.yaml` na raiz do projeto ja esta pronto para o Render criar:

- uma API Node.js publica;
- um banco PostgreSQL em nuvem;
- a variavel `DATABASE_URL` ligada automaticamente ao banco;
- `JWT_SECRET` gerado automaticamente.

Passos:

1. Suba este projeto para um repositorio no GitHub.
2. No Render, escolha **New > Blueprint**.
3. Conecte o repositorio do projeto.
4. Confirme a criacao dos recursos definidos em `render.yaml`.
5. Depois do deploy, abra a URL publica da API e teste `/health`.

Exemplo:

```text
https://projeto-faculdade-api.onrender.com/health
```

Se responder `{"status":"OK"}`, a API esta online.

Depois configure o `.env` da raiz do app:

```env
EXPO_PUBLIC_API_URL=https://projeto-faculdade-api.onrender.com/api
```

Use a URL real mostrada no painel do Render.

## Opcao manual: criar o banco

Crie um banco PostgreSQL em um destes serviços:

- Neon
- Supabase
- Railway
- Render

Depois copie a connection string do banco. Ela normalmente tem este formato:

```env
postgresql://usuario:senha@host:5432/nome_do_banco?sslmode=require
```

## 2. Configurar o backend

Na pasta `backend`, crie o arquivo `.env` baseado em `backend/.env.example` e preencha:

```env
DATABASE_URL="postgresql://usuario:senha@host:5432/erp_crm?sslmode=require"
JWT_SECRET="troque_por_uma_chave_grande"
PORT=3002
NODE_ENV=development
FRONTEND_URL="*"
ADMIN_EMAIL="admin@admin.com"
ADMIN_PASSWORD="admin"
```

Depois rode:

```bash
cd backend
npm install
npx prisma generate
npx prisma db push
npm run dev
```

## 3. Configurar o app React Native

Para testar em varios dispositivos, o celular precisa acessar uma API publica. Suba o backend em um serviço como Render, Railway ou Fly.io e coloque a URL no `.env` da raiz:

```env
EXPO_PUBLIC_API_URL=https://sua-api-publica.onrender.com/api
```

Com isso, nenhum celular precisa apontar para IP local ou trocar porta.

## 4. Rodar o app

```bash
npm install
npx expo start --clear
```

Se estiver usando Expo Go, abra o QR Code no celular. O app chamara a API publica configurada em `EXPO_PUBLIC_API_URL`.
