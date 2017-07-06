---
layout: post
title: Using db:structure dump and load instead of db:schema
---

Today I faced the following problem: I had a migration creating a `index` in SQL, like this:

```sql
CREATE UNIQUE INDEX some_table_single_row ON some_table((1))
```

which will make this table unique in the database.

Problem is, Rails won't import this INDEX to `db/schema.rb` and, because of it, my test database didn't created it and I had a failing test.

## rake:structure

Rails comes with a rake task called `db:structure` which will do pretty much what `db:schema` does but using the specific database
tool for it, in this case `pg_dump`.

So, I created structure dump from dev database:

```
[$] rake db:structure:dump
```

which creates a `db/structure.sql` file, dropped my test database and re-created it from this new dump:

```
[$] RAILS_ENV=test rake:structure:load
```

Et voilà, tests were passing.