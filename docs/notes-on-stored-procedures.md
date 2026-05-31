# Stored Procedures
- Procedures for operations and multi-step logic
- Functions for reusable calculations or queries you want to embed in `select` statements
- Add `set nocount on` in production to suppress row affected message and reduce noise

**Procedure:** `add_to_cellar`

```sql
create procedure add_to_cellar
    @wine_id integer,
    @purchase_date date,
    @purchase_price numeric
as
begin
    set nocount on;
    insert into wine_cellar (wine_id, purchase_date, purchase_price, consumed)
    values (
        @wine_id,
        @purchase_date,
        @purchase_price,
        0 -- false by default
    );
end;
```

**Procedure:** `get_cellar`

```sql
create procedure get_cellar
    -- get wines not consumed
    -- no parameters required
as
begin
    set nocount on;
    select
        w.bottle_name,
        wc.purchase_date,
        format(wc.purchase_price, 'C', 'en-US') as purchase_price,
        datediff(day, wc.purchase_date, getdate()) as days_in_cellar
    from wine_cellar wc
    join wine w
        on wc.wine_id = w.id
    where 
        wc.consumed = 0;
end;
```