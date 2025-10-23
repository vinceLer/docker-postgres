<h1 align="center">

🛢️ docker-postgres

</h1>

supposed Docker is installed

# PostgreSQL Docker Setup

A lightweight and official PostgreSQL container (Alpine) with automatic initialization, correct permissions handling, and ready-to-use configuration

---

## 🔑 Magic Key Explanation

In the `docker-compose.yml`, this crucial line is :

```yaml
entrypoint: ["/bin/sh", "-c", "chown -R postgres:postgres /var/lib/postgresql/data && exec docker-entrypoint.sh postgres"]
```

➡️ This line executes **before startup** :

```bash
chown -R postgres:postgres /var/lib/postgresql/data
```
→ Give the correct permissions to the postgres user on the volume (even if it was created as root)

```bash
exec docker-entrypoint.sh postgres
```
→ then run the real official initialization script.

✅ Résult :

No need for user : no manual chmod.

The image remains official and light (Alpine).

Works immediately on the first launch.

## Connection from a local client

Example (Adminer, DBeaver, psql…) :

- `Host` : localhost
- `Port` : 5432 (by default, not exposed, accessible by the Docker network)
- `Database` : postgres_db
- `User` : postgres_user
- `Password` : password

## CLI 

Run container : 

`docker-compose up -d`

Check `postgresql` database docker image and the inserted data :

docker exec -i postgres_container psql -U postgres_user -d postgres_db < upsert_users.sql

```bash
docker exec -it postgres_container psql -U postgres_user -d postgres_db -c "SELECT * FROM users;"
```

In terminal, result like this:

```bash 
id |  name  |        email         
----+--------+---------------------
  1 | Alice  | alice@example.com
  2 | Bob    | bob@example.com
  3 | Franck | franck@example.com
  4 | Diana  | diana@example.com
(4 rows)
```

If needed to start from scratch the database, run this command before the `docker-compose up` (this, will delete volume) : 

`docker-compose down -v`
