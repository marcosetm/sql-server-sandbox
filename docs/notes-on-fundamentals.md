# Fundamentals 

## Syntax Differences

`top` 
- Limit the results returned

```sql
select top 10 bottle_name
from wine
order by bottle_name;
```

`getdate()` or `sysdatetime()`
- Both return timestamp from operating system sql server is running on
- Differece is the precision datatime type returned 
    - `getdate()` datetime with milliseconds
    - `sysdatetime()` datetime2(7) nanoseconds (7 decimal places)

```sql
-- wine purchased today
insert into wine_cellar (wine_id, purchase_date, purchase_price)
values (6, getdate(), 100.00)
```

`isnull()`
- `coallesce()` is also supported

> Note: using convert to convert data into string. `convert(datatype, value [, style])`. Can also use `cast(expression as datatype)`

```sql
select
    w.bottle_name,
    wc.purchase_date,
    isnull(convert(varchar, wc.consumed_date, 101), 'time to enjoy!')
from wine_cellar wc
join wine w 
    on wc.wine_id = w.id
where 
    (year(getdate()) - year(purchase_date)) >= 5;
```

## Data Types

`identity(seed, increment)`
- Equivalent to `serial`

```sql
create table wine (
    id identity(1,1) primary key,
    -- ...
);
```

> Note: When inserting into an identity column, must set the insert
```sql
set identity_insert table_name on;
-- explicit id inserts here
set identity_insert table_name off;
```

`bit`
- Equivalent to `boolean`
```sql
create table wine_cellar (
    id identity(1,1) primary key,
    -- ...
    consumed bit default 0
    -- ...
);
```

`nvarchar(characters)`
- supports unicode/utf-8 characters
    - support international characters
    - use for user-facing text

> Note: `enums` are not supported, must use `constraint` checks
```sql
create table structure_notes (
    -- ...
    constraint chk_alcohol check (alcohol >= 0 and alcohol <= 100)
    -- ...
);
```