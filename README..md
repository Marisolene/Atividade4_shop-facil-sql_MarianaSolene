# Shop Fácil — Scripts SQL (PostgreSQL)

Repositório com scripts SQL para a atividade prática: criação e manipulação de dados do minimundo "Shop Fácil" (loja online).

## Conteúdo
- `sql/00_schema_postgres.sql` — criação das tabelas (schema) com chaves primárias e estrangeiras.
- `sql/01_inserts.sql` — comandos INSERT para povoar as tabelas principais.
- `sql/02_selects.sql` — consultas SELECT exemplares (JOINs, WHERE, ORDER BY, LIMIT).
- `sql/03_updates_deletes.sql` — exemplos de UPDATE e DELETE (pelo menos 3 cada).

## Instruções (PGAdmin / psql)
1. Crie um banco de dados PostgreSQL (ex.: `shop_facil_db`).
2. Abra o arquivo `sql/00_schema_postgres.sql` no Query Tool do PGAdmin e execute.
3. Execute `sql/01_inserts.sql` para povoar.
4. Teste as consultas em `sql/02_selects.sql`.
5. Execute os comandos de atualização e remoção em `sql/03_updates_deletes.sql`.

## Notas
- Se usar MySQL, veja os ajustes no final do README (tipos AUTO_INCREMENT, sintaxe ligeiramente diferente).
- Todos os scripts são idempotentes quando possível (DROP TABLE IF EXISTS usado no schema).

