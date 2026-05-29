create table appellation (
    id int identity(1,1) primary key,
    name nvarchar(255) not null unique
);
create table producer (
    id int identity(1,1) primary key,
    name nvarchar(255) not null unique
);
create table vintage (
    id int identity(1,1) primary key,
    year integer not null unique
);
create table grape (
    id int identity(1,1) primary key,
    name nvarchar(255) not null
);
create table color (
    id int identity(1,1) primary key,
    name nvarchar(255) not null unique
);
create table aroma (
    id int identity(1,1) primary key,
    name nvarchar(255) not null unique
);
create table flavor (
    id int identity(1,1) primary key,
    name nvarchar(255) not null unique
);

create table region (
    id int identity(1,1) primary key,
    name nvarchar(255) not null unique,
    appellation_id integer not null references appellation(id)
);
create table vineyard (
    id int identity(1,1) primary key,
    name nvarchar(255) not null unique,
    region_id integer not null references region(id)
);
create table grape_source (
    grape_id integer not null references grape(id),
    vineyard_id integer not null references vineyard(id),
    primary key (grape_id, vineyard_id)
);
create table wine (
    id int identity(1,1) primary key,
    producer_id integer not null references producer(id),
    vintage_id integer not null references vintage(id),
    bottle_name nvarchar(255) not null,
    region_id integer references region(id)
);
create table composition (
    id int identity(1,1) primary key,
    wine_id integer not null references wine(id),
    grape_id integer not null,
    vineyard_id integer not null,
    percentage integer,
    foreign key (grape_id, vineyard_id) references grape_source (grape_id, vineyard_id),
    check (percentage >= 0 and percentage <= 100)
);
create table color_notes (
    id int identity(1,1) primary key,
    wine_id integer not null references wine(id),
    color_id integer not null references color(id)
);
create table aroma_notes (
    id int identity(1,1) primary key,
    wine_id integer not null references wine(id),
    aroma_id integer not null references aroma(id)
);
create table tasting_notes (
    id int identity(1,1) primary key,
    wine_id integer not null references wine(id),
    flavor_id integer not null references flavor(id)
);

create table structure_notes (
    id int identity(1,1) primary key,
    wine_id integer not null references wine(id),
    acidity varchar(20),
    alcohol decimal,
    tannin varchar(20),
    constraint chk_alcohol check (alcohol >= 0 and alcohol <= 100),
    constraint chk_acidity_level check (acidity in ('High', 'Medium', 'Low')),
    constraint chk_tannin_level check (tannin in ('Silky', 'Grippy', 'Elegant','Green', 'Resolved', 'Chalky'))
);
create table wine_cellar (
    id int identity(1,1) primary key,
    wine_id integer not null references wine(id),
    purchase_date date,
    purchase_price numeric check (purchase_price >= 0),
    consumed bit default 0,
    consumed_date date, 
    constraint chk_consumed_date check (consumed_date is null or consumed = 1)
);