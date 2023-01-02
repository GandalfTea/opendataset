
pg_dump --no-owner --dbname=postgresql://su:lafiel@localhost:5432/api > ../db.sql

tsc app.ts --outDir ./compiled/
node ./compiled/app.js

