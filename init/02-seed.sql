-- =============================================================
-- Wine Cellar — Seed Script
-- Safe to re-run: all inserts use 
-- =============================================================

-- =============================================================
-- Clear tables in reverse FK dependency order before seeding
-- =============================================================
DELETE FROM composition;
DELETE FROM wine_cellar;
DELETE FROM structure_notes;
DELETE FROM aroma_notes;
DELETE FROM tasting_notes;
DELETE FROM color_notes;
DELETE FROM wine;
DELETE FROM grape_source;
DELETE FROM vineyard;
DELETE FROM region;
DELETE FROM appellation;
DELETE FROM producer;
DELETE FROM vintage;
DELETE FROM grape;
DELETE FROM color;
DELETE FROM aroma;
DELETE FROM flavor;

-- =============================================================
-- LOOKUP TABLES (no dependencies)
-- =============================================================

INSERT INTO appellation (name) VALUES
    ('Napa Valley'),
    ('Sonoma Coast'),
    ('Willamette Valley'),
    ('Bordeaux'),
    ('Burgundy'),
    ('Tuscany'),
    ('Rioja'),
    ('Mendoza'),
    ('Barossa Valley'),
    ('Marlborough')
;

INSERT INTO producer (name) VALUES
    ('Opus One'),
    ('Jordan Winery'),
    ('Stag''s Leap Wine Cellars'),
    ('Duckhorn Vineyards'),
    ('Chateau Margaux'),
    ('Chateau Latour'),
    ('Sassicaia'),
    ('Antinori'),
    ('Penfolds'),
    ('Cloudy Bay'),
    ('Catena Zapata'),
    ('La Rioja Alta'),
    ('Domaine Drouhin'),
    ('Williams Selyem'),
    ('Kistler Vineyards'),
    ('Far Niente'),
    ('Silver Oak'),
    ('Caymus Vineyards'),
    ('Beringer Vineyards'),
    ('Cakebread Cellars')
;

INSERT INTO vintage (year) VALUES
    (2015),
    (2016),
    (2017),
    (2018),
    (2019),
    (2020),
    (2021),
    (2022)
;

INSERT INTO grape (name) VALUES
    ('Cabernet Sauvignon'),
    ('Merlot'),
    ('Cabernet Franc'),
    ('Petit Verdot'),
    ('Malbec'),
    ('Pinot Noir'),
    ('Chardonnay'),
    ('Sauvignon Blanc'),
    ('Sangiovese'),
    ('Tempranillo'),
    ('Syrah'),
    ('Grenache'),
    ('Zinfandel'),
    ('Riesling'),
    ('Viognier');

INSERT INTO color (name) VALUES
    ('Ruby'),
    ('Garnet'),
    ('Purple'),
    ('Crimson'),
    ('Pale Gold'),
    ('Straw'),
    ('Deep Gold'),
    ('Amber'),
    ('Rose'),
    ('Brick Red')
;

INSERT INTO aroma (name) VALUES
    ('Blackberry'),
    ('Black Cherry'),
    ('Cassis'),
    ('Plum'),
    ('Raspberry'),
    ('Strawberry'),
    ('Vanilla'),
    ('Oak'),
    ('Cedar'),
    ('Tobacco'),
    ('Leather'),
    ('Earthy'),
    ('Floral'),
    ('Citrus'),
    ('Tropical Fruit'),
    ('Mineral'),
    ('Spice'),
    ('Dried Fruit'),
    ('Coffee'),
    ('Dark Chocolate')
;

INSERT INTO flavor (name) VALUES
    ('Dark Fruit'),
    ('Red Fruit'),
    ('Stone Fruit'),
    ('Citrus Zest'),
    ('Herbal'),
    ('Earthy'),
    ('Smoky'),
    ('Toasty Oak'),
    ('Vanilla'),
    ('Buttery'),
    ('Mineral'),
    ('Spicy'),
    ('Savory'),
    ('Floral'),
    ('Honey')
;

-- =============================================================
-- REGION (depends on appellation)
-- =============================================================

INSERT INTO region (name, appellation_id) VALUES
    ('Rutherford',       (SELECT id FROM appellation WHERE name = 'Napa Valley')),
    ('Oakville',         (SELECT id FROM appellation WHERE name = 'Napa Valley')),
    ('Stags Leap',       (SELECT id FROM appellation WHERE name = 'Napa Valley')),
    ('Russian River',    (SELECT id FROM appellation WHERE name = 'Sonoma Coast')),
    ('Dundee Hills',     (SELECT id FROM appellation WHERE name = 'Willamette Valley')),
    ('Pauillac',         (SELECT id FROM appellation WHERE name = 'Bordeaux')),
    ('Margaux',          (SELECT id FROM appellation WHERE name = 'Bordeaux')),
    ('Cote de Nuits',    (SELECT id FROM appellation WHERE name = 'Burgundy')),
    ('Bolgheri',         (SELECT id FROM appellation WHERE name = 'Tuscany')),
    ('Chianti Classico', (SELECT id FROM appellation WHERE name = 'Tuscany')),
    ('Alta',             (SELECT id FROM appellation WHERE name = 'Rioja')),
    ('Lujan de Cuyo',    (SELECT id FROM appellation WHERE name = 'Mendoza')),
    ('Eden Valley',      (SELECT id FROM appellation WHERE name = 'Barossa Valley')),
    ('Wairau Valley',    (SELECT id FROM appellation WHERE name = 'Marlborough'))
;

-- =============================================================
-- VINEYARD (depends on region)
-- =============================================================

INSERT INTO vineyard (name, region_id) VALUES
    ('To Kalon',         (SELECT id FROM region WHERE name = 'Oakville')),
    ('Beckstoffer',      (SELECT id FROM region WHERE name = 'Rutherford')),
    ('Fay Vineyard',     (SELECT id FROM region WHERE name = 'Stags Leap')),
    ('Rochioli',         (SELECT id FROM region WHERE name = 'Russian River')),
    ('Stoller',          (SELECT id FROM region WHERE name = 'Dundee Hills')),
    ('Pichon Baron',     (SELECT id FROM region WHERE name = 'Pauillac')),
    ('Palmer',           (SELECT id FROM region WHERE name = 'Margaux')),
    ('Romanee',          (SELECT id FROM region WHERE name = 'Cote de Nuits')),
    ('Sassicaia Estate', (SELECT id FROM region WHERE name = 'Bolgheri')),
    ('Antinori Estate',  (SELECT id FROM region WHERE name = 'Chianti Classico')),
    ('Vina Ardanza',     (SELECT id FROM region WHERE name = 'Alta')),
    ('Adrianna',         (SELECT id FROM region WHERE name = 'Lujan de Cuyo')),
    ('Hill of Grace',    (SELECT id FROM region WHERE name = 'Eden Valley')),
    ('Cloudy Bay Estate',(SELECT id FROM region WHERE name = 'Wairau Valley'))
;

-- =============================================================
-- GRAPE SOURCE (depends on grape + vineyard)
-- =============================================================

INSERT INTO grape_source (grape_id, vineyard_id) VALUES
    ((SELECT id FROM grape WHERE name = 'Cabernet Sauvignon'), (SELECT id FROM vineyard WHERE name = 'To Kalon')),
    ((SELECT id FROM grape WHERE name = 'Merlot'),             (SELECT id FROM vineyard WHERE name = 'To Kalon')),
    ((SELECT id FROM grape WHERE name = 'Cabernet Sauvignon'), (SELECT id FROM vineyard WHERE name = 'Beckstoffer')),
    ((SELECT id FROM grape WHERE name = 'Cabernet Franc'),     (SELECT id FROM vineyard WHERE name = 'Beckstoffer')),
    ((SELECT id FROM grape WHERE name = 'Cabernet Sauvignon'), (SELECT id FROM vineyard WHERE name = 'Fay Vineyard')),
    ((SELECT id FROM grape WHERE name = 'Pinot Noir'),         (SELECT id FROM vineyard WHERE name = 'Rochioli')),
    ((SELECT id FROM grape WHERE name = 'Chardonnay'),         (SELECT id FROM vineyard WHERE name = 'Rochioli')),
    ((SELECT id FROM grape WHERE name = 'Pinot Noir'),         (SELECT id FROM vineyard WHERE name = 'Stoller')),
    ((SELECT id FROM grape WHERE name = 'Cabernet Sauvignon'), (SELECT id FROM vineyard WHERE name = 'Pichon Baron')),
    ((SELECT id FROM grape WHERE name = 'Merlot'),             (SELECT id FROM vineyard WHERE name = 'Pichon Baron')),
    ((SELECT id FROM grape WHERE name = 'Cabernet Sauvignon'), (SELECT id FROM vineyard WHERE name = 'Palmer')),
    ((SELECT id FROM grape WHERE name = 'Merlot'),             (SELECT id FROM vineyard WHERE name = 'Palmer')),
    ((SELECT id FROM grape WHERE name = 'Pinot Noir'),         (SELECT id FROM vineyard WHERE name = 'Romanee')),
    ((SELECT id FROM grape WHERE name = 'Sangiovese'),         (SELECT id FROM vineyard WHERE name = 'Sassicaia Estate')),
    ((SELECT id FROM grape WHERE name = 'Cabernet Sauvignon'), (SELECT id FROM vineyard WHERE name = 'Sassicaia Estate')),
    ((SELECT id FROM grape WHERE name = 'Sangiovese'),         (SELECT id FROM vineyard WHERE name = 'Antinori Estate')),
    ((SELECT id FROM grape WHERE name = 'Tempranillo'),        (SELECT id FROM vineyard WHERE name = 'Vina Ardanza')),
    ((SELECT id FROM grape WHERE name = 'Malbec'),             (SELECT id FROM vineyard WHERE name = 'Adrianna')),
    ((SELECT id FROM grape WHERE name = 'Syrah'),              (SELECT id FROM vineyard WHERE name = 'Hill of Grace')),
    ((SELECT id FROM grape WHERE name = 'Sauvignon Blanc'),    (SELECT id FROM vineyard WHERE name = 'Cloudy Bay Estate'))
;

-- =============================================================
-- WINE (depends on producer, vintage, region)
-- =============================================================

INSERT INTO wine (bottle_name, producer_id, vintage_id, region_id) VALUES
    ('Opus One',                   (SELECT id FROM producer WHERE name = 'Opus One'),           (SELECT id FROM vintage WHERE year = 2019), (SELECT id FROM region WHERE name = 'Oakville')),
    ('Opus One',                   (SELECT id FROM producer WHERE name = 'Opus One'),           (SELECT id FROM vintage WHERE year = 2018), (SELECT id FROM region WHERE name = 'Oakville')),
    ('Jordan Cabernet',            (SELECT id FROM producer WHERE name = 'Jordan Winery'),      (SELECT id FROM vintage WHERE year = 2019), (SELECT id FROM region WHERE name = 'Rutherford')),
    ('Jordan Cabernet',            (SELECT id FROM producer WHERE name = 'Jordan Winery'),      (SELECT id FROM vintage WHERE year = 2020), (SELECT id FROM region WHERE name = 'Rutherford')),
    ('Stag''s Leap Cask 23',       (SELECT id FROM producer WHERE name = 'Stag''s Leap Wine Cellars'), (SELECT id FROM vintage WHERE year = 2018), (SELECT id FROM region WHERE name = 'Stags Leap')),
    ('Duckhorn Merlot',            (SELECT id FROM producer WHERE name = 'Duckhorn Vineyards'), (SELECT id FROM vintage WHERE year = 2020), (SELECT id FROM region WHERE name = 'Rutherford')),
    ('Chateau Margaux',            (SELECT id FROM producer WHERE name = 'Chateau Margaux'),    (SELECT id FROM vintage WHERE year = 2016), (SELECT id FROM region WHERE name = 'Margaux')),
    ('Chateau Latour',             (SELECT id FROM producer WHERE name = 'Chateau Latour'),     (SELECT id FROM vintage WHERE year = 2015), (SELECT id FROM region WHERE name = 'Pauillac')),
    ('Sassicaia',                  (SELECT id FROM producer WHERE name = 'Sassicaia'),          (SELECT id FROM vintage WHERE year = 2017), (SELECT id FROM region WHERE name = 'Bolgheri')),
    ('Tignanello',                 (SELECT id FROM producer WHERE name = 'Antinori'),           (SELECT id FROM vintage WHERE year = 2019), (SELECT id FROM region WHERE name = 'Chianti Classico')),
    ('Penfolds Grange',            (SELECT id FROM producer WHERE name = 'Penfolds'),           (SELECT id FROM vintage WHERE year = 2017), (SELECT id FROM region WHERE name = 'Eden Valley')),
    ('Cloudy Bay Sauvignon Blanc', (SELECT id FROM producer WHERE name = 'Cloudy Bay'),         (SELECT id FROM vintage WHERE year = 2022), (SELECT id FROM region WHERE name = 'Wairau Valley')),
    ('Catena Zapata Malbec',       (SELECT id FROM producer WHERE name = 'Catena Zapata'),      (SELECT id FROM vintage WHERE year = 2020), (SELECT id FROM region WHERE name = 'Lujan de Cuyo')),
    ('Vina Ardanza Reserva',       (SELECT id FROM producer WHERE name = 'La Rioja Alta'),      (SELECT id FROM vintage WHERE year = 2015), (SELECT id FROM region WHERE name = 'Alta')),
    ('Domaine Drouhin Pinot',      (SELECT id FROM producer WHERE name = 'Domaine Drouhin'),    (SELECT id FROM vintage WHERE year = 2019), (SELECT id FROM region WHERE name = 'Dundee Hills')),
    ('Williams Selyem Pinot',      (SELECT id FROM producer WHERE name = 'Williams Selyem'),    (SELECT id FROM vintage WHERE year = 2020), (SELECT id FROM region WHERE name = 'Russian River')),
    ('Kistler Chardonnay',         (SELECT id FROM producer WHERE name = 'Kistler Vineyards'),  (SELECT id FROM vintage WHERE year = 2021), (SELECT id FROM region WHERE name = 'Russian River')),
    ('Far Niente Cabernet',        (SELECT id FROM producer WHERE name = 'Far Niente'),         (SELECT id FROM vintage WHERE year = 2018), (SELECT id FROM region WHERE name = 'Oakville')),
    ('Silver Oak Cabernet',        (SELECT id FROM producer WHERE name = 'Silver Oak'),         (SELECT id FROM vintage WHERE year = 2017), (SELECT id FROM region WHERE name = 'Rutherford')),
    ('Caymus Special Selection',   (SELECT id FROM producer WHERE name = 'Caymus Vineyards'),   (SELECT id FROM vintage WHERE year = 2019), (SELECT id FROM region WHERE name = 'Rutherford')),
    ('Beringer Private Reserve',   (SELECT id FROM producer WHERE name = 'Beringer Vineyards'), (SELECT id FROM vintage WHERE year = 2018), (SELECT id FROM region WHERE name = 'Rutherford')),
    ('Cakebread Chardonnay',       (SELECT id FROM producer WHERE name = 'Cakebread Cellars'),  (SELECT id FROM vintage WHERE year = 2021), (SELECT id FROM region WHERE name = 'Rutherford')),
    ('Romane Conti',               (SELECT id FROM producer WHERE name = 'Domaine Drouhin'),    (SELECT id FROM vintage WHERE year = 2016), (SELECT id FROM region WHERE name = 'Cote de Nuits')),
    ('Rochioli Pinot Noir',        (SELECT id FROM producer WHERE name = 'Williams Selyem'),    (SELECT id FROM vintage WHERE year = 2020), (SELECT id FROM region WHERE name = 'Russian River'));

-- =============================================================
-- WINE CELLAR (depends on wine)
-- =============================================================

INSERT INTO wine_cellar (wine_id, purchase_date, purchase_price, consumed, consumed_date) VALUES
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One'                   AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), '2021-03-15', 350.00, 0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One'                   AND vintage_id = (SELECT id FROM vintage WHERE year = 2018)), '2020-06-10', 325.00, 1,  '2023-12-25'),
    ((SELECT id FROM wine WHERE bottle_name = 'Jordan Cabernet'            AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), '2021-09-01', 55.00,  0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Jordan Cabernet'            AND vintage_id = (SELECT id FROM vintage WHERE year = 2020)), '2022-11-20', 58.00,  0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Stag''s Leap Cask 23'       AND vintage_id = (SELECT id FROM vintage WHERE year = 2018)), '2020-08-14', 210.00, 0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Duckhorn Merlot'            AND vintage_id = (SELECT id FROM vintage WHERE year = 2020)), '2022-04-03', 75.00,  1,  '2024-02-14'),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Margaux'            AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), '2019-05-22', 850.00, 0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Latour'             AND vintage_id = (SELECT id FROM vintage WHERE year = 2015)), '2018-07-04', 950.00, 0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Sassicaia'                  AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), '2020-01-18', 180.00, 1,  '2023-06-15'),
    ((SELECT id FROM wine WHERE bottle_name = 'Tignanello'                 AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), '2021-10-30', 95.00,  0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Penfolds Grange'            AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), '2020-12-01', 750.00, 0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Cloudy Bay Sauvignon Blanc' AND vintage_id = (SELECT id FROM vintage WHERE year = 2022)), '2023-03-10', 28.00,  1,  '2023-07-04'),
    ((SELECT id FROM wine WHERE bottle_name = 'Catena Zapata Malbec'       AND vintage_id = (SELECT id FROM vintage WHERE year = 2020)), '2022-02-28', 65.00,  0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Vina Ardanza Reserva'       AND vintage_id = (SELECT id FROM vintage WHERE year = 2015)), '2019-11-11', 45.00,  0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Domaine Drouhin Pinot'      AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), '2021-07-22', 85.00,  0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Williams Selyem Pinot'      AND vintage_id = (SELECT id FROM vintage WHERE year = 2020)), '2022-05-16', 90.00,  1,  '2024-01-01'),
    ((SELECT id FROM wine WHERE bottle_name = 'Kistler Chardonnay'         AND vintage_id = (SELECT id FROM vintage WHERE year = 2021)), '2023-01-05', 80.00,  0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Far Niente Cabernet'        AND vintage_id = (SELECT id FROM vintage WHERE year = 2018)), '2020-09-09', 175.00, 0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Silver Oak Cabernet'        AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), '2019-08-20', 80.00,  1,  '2022-12-31'),
    ((SELECT id FROM wine WHERE bottle_name = 'Caymus Special Selection'   AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), '2021-04-17', 160.00, 0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Beringer Private Reserve'   AND vintage_id = (SELECT id FROM vintage WHERE year = 2018)), '2020-10-31', 90.00,  0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Cakebread Chardonnay'       AND vintage_id = (SELECT id FROM vintage WHERE year = 2021)), '2023-06-01', 50.00,  1,  '2023-09-15'),
    ((SELECT id FROM wine WHERE bottle_name = 'Romane Conti'               AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), '2019-02-14', 3500.00,0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Rochioli Pinot Noir'        AND vintage_id = (SELECT id FROM vintage WHERE year = 2020)), '2022-08-08', 95.00,  0, null);

-- =============================================================
-- STRUCTURE NOTES (depends on wine)
-- =============================================================

INSERT INTO structure_notes (wine_id, acidity, alcohol, tannin) VALUES
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One'                   AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), 'Medium', 14.5, 'Silky'),
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One'                   AND vintage_id = (SELECT id FROM vintage WHERE year = 2018)), 'Medium', 14.2, 'Elegant'),
    ((SELECT id FROM wine WHERE bottle_name = 'Jordan Cabernet'            AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), 'Medium', 13.9, 'Resolved'),
    ((SELECT id FROM wine WHERE bottle_name = 'Stag''s Leap Cask 23'       AND vintage_id = (SELECT id FROM vintage WHERE year = 2018)), 'High',   14.8, 'Grippy'),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Margaux'            AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), 'High',   13.5, 'Elegant'),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Latour'             AND vintage_id = (SELECT id FROM vintage WHERE year = 2015)), 'High',   13.0, 'Chalky'),
    ((SELECT id FROM wine WHERE bottle_name = 'Sassicaia'                  AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), 'Medium', 13.5, 'Silky'),
    ((SELECT id FROM wine WHERE bottle_name = 'Penfolds Grange'            AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), 'Medium', 14.5, 'Grippy'),
    ((SELECT id FROM wine WHERE bottle_name = 'Cloudy Bay Sauvignon Blanc' AND vintage_id = (SELECT id FROM vintage WHERE year = 2022)), 'High',   13.0, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Catena Zapata Malbec'       AND vintage_id = (SELECT id FROM vintage WHERE year = 2020)), 'Medium', 14.0, 'Silky'),
    ((SELECT id FROM wine WHERE bottle_name = 'Kistler Chardonnay'         AND vintage_id = (SELECT id FROM vintage WHERE year = 2021)), 'High',   13.8, null),
    ((SELECT id FROM wine WHERE bottle_name = 'Caymus Special Selection'   AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), 'Low',    15.2, 'Resolved'),
    ((SELECT id FROM wine WHERE bottle_name = 'Romane Conti'               AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), 'High',   13.0, 'Elegant');

-- =============================================================
-- AROMA NOTES (depends on wine + aroma)
-- =============================================================

INSERT INTO aroma_notes (wine_id, aroma_id) VALUES
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One' AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), (SELECT id FROM aroma WHERE name = 'Blackberry')),
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One' AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), (SELECT id FROM aroma WHERE name = 'Cassis')),
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One' AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), (SELECT id FROM aroma WHERE name = 'Cedar')),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Margaux' AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), (SELECT id FROM aroma WHERE name = 'Floral')),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Margaux' AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), (SELECT id FROM aroma WHERE name = 'Black Cherry')),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Margaux' AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), (SELECT id FROM aroma WHERE name = 'Tobacco')),
    ((SELECT id FROM wine WHERE bottle_name = 'Penfolds Grange' AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), (SELECT id FROM aroma WHERE name = 'Dark Chocolate')),
    ((SELECT id FROM wine WHERE bottle_name = 'Penfolds Grange' AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), (SELECT id FROM aroma WHERE name = 'Plum')),
    ((SELECT id FROM wine WHERE bottle_name = 'Penfolds Grange' AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), (SELECT id FROM aroma WHERE name = 'Spice')),
    ((SELECT id FROM wine WHERE bottle_name = 'Kistler Chardonnay' AND vintage_id = (SELECT id FROM vintage WHERE year = 2021)), (SELECT id FROM aroma WHERE name = 'Vanilla')),
    ((SELECT id FROM wine WHERE bottle_name = 'Kistler Chardonnay' AND vintage_id = (SELECT id FROM vintage WHERE year = 2021)), (SELECT id FROM aroma WHERE name = 'Oak')),
    ((SELECT id FROM wine WHERE bottle_name = 'Cloudy Bay Sauvignon Blanc' AND vintage_id = (SELECT id FROM vintage WHERE year = 2022)), (SELECT id FROM aroma WHERE name = 'Citrus')),
    ((SELECT id FROM wine WHERE bottle_name = 'Cloudy Bay Sauvignon Blanc' AND vintage_id = (SELECT id FROM vintage WHERE year = 2022)), (SELECT id FROM aroma WHERE name = 'Tropical Fruit'));

-- =============================================================
-- TASTING NOTES (depends on wine + flavor)
-- =============================================================

INSERT INTO tasting_notes (wine_id, flavor_id) VALUES
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One' AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), (SELECT id FROM flavor WHERE name = 'Dark Fruit')),
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One' AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), (SELECT id FROM flavor WHERE name = 'Toasty Oak')),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Margaux' AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), (SELECT id FROM flavor WHERE name = 'Earthy')),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Margaux' AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), (SELECT id FROM flavor WHERE name = 'Red Fruit')),
    ((SELECT id FROM wine WHERE bottle_name = 'Penfolds Grange' AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), (SELECT id FROM flavor WHERE name = 'Dark Fruit')),
    ((SELECT id FROM wine WHERE bottle_name = 'Penfolds Grange' AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), (SELECT id FROM flavor WHERE name = 'Smoky')),
    ((SELECT id FROM wine WHERE bottle_name = 'Kistler Chardonnay' AND vintage_id = (SELECT id FROM vintage WHERE year = 2021)), (SELECT id FROM flavor WHERE name = 'Buttery')),
    ((SELECT id FROM wine WHERE bottle_name = 'Kistler Chardonnay' AND vintage_id = (SELECT id FROM vintage WHERE year = 2021)), (SELECT id FROM flavor WHERE name = 'Stone Fruit')),
    ((SELECT id FROM wine WHERE bottle_name = 'Cloudy Bay Sauvignon Blanc' AND vintage_id = (SELECT id FROM vintage WHERE year = 2022)), (SELECT id FROM flavor WHERE name = 'Citrus Zest')),
    ((SELECT id FROM wine WHERE bottle_name = 'Cloudy Bay Sauvignon Blanc' AND vintage_id = (SELECT id FROM vintage WHERE year = 2022)), (SELECT id FROM flavor WHERE name = 'Mineral')),
    ((SELECT id FROM wine WHERE bottle_name = 'Catena Zapata Malbec' AND vintage_id = (SELECT id FROM vintage WHERE year = 2020)), (SELECT id FROM flavor WHERE name = 'Dark Fruit')),
    ((SELECT id FROM wine WHERE bottle_name = 'Catena Zapata Malbec' AND vintage_id = (SELECT id FROM vintage WHERE year = 2020)), (SELECT id FROM flavor WHERE name = 'Spicy')),
    ((SELECT id FROM wine WHERE bottle_name = 'Romane Conti' AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), (SELECT id FROM flavor WHERE name = 'Floral')),
    ((SELECT id FROM wine WHERE bottle_name = 'Romane Conti' AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), (SELECT id FROM flavor WHERE name = 'Earthy'));

-- =============================================================
-- COLOR NOTES (depends on wine + color)
-- =============================================================

INSERT INTO color_notes (wine_id, color_id) VALUES
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One'                   AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), (SELECT id FROM color WHERE name = 'Garnet')),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Margaux'            AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), (SELECT id FROM color WHERE name = 'Ruby')),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Latour'             AND vintage_id = (SELECT id FROM vintage WHERE year = 2015)), (SELECT id FROM color WHERE name = 'Garnet')),
    ((SELECT id FROM wine WHERE bottle_name = 'Sassicaia'                  AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), (SELECT id FROM color WHERE name = 'Ruby')),
    ((SELECT id FROM wine WHERE bottle_name = 'Penfolds Grange'            AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)), (SELECT id FROM color WHERE name = 'Purple')),
    ((SELECT id FROM wine WHERE bottle_name = 'Kistler Chardonnay'         AND vintage_id = (SELECT id FROM vintage WHERE year = 2021)), (SELECT id FROM color WHERE name = 'Pale Gold')),
    ((SELECT id FROM wine WHERE bottle_name = 'Cloudy Bay Sauvignon Blanc' AND vintage_id = (SELECT id FROM vintage WHERE year = 2022)), (SELECT id FROM color WHERE name = 'Straw')),
    ((SELECT id FROM wine WHERE bottle_name = 'Catena Zapata Malbec'       AND vintage_id = (SELECT id FROM vintage WHERE year = 2020)), (SELECT id FROM color WHERE name = 'Purple')),
    ((SELECT id FROM wine WHERE bottle_name = 'Romane Conti'               AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)), (SELECT id FROM color WHERE name = 'Garnet')),
    ((SELECT id FROM wine WHERE bottle_name = 'Jordan Cabernet'            AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)), (SELECT id FROM color WHERE name = 'Ruby'));

-- =============================================================
-- COMPOSITION (depends on wine + grape_source)
-- =============================================================

INSERT INTO composition (wine_id, grape_id, vineyard_id, percentage) VALUES
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One' AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)),
     (SELECT id FROM grape WHERE name = 'Cabernet Sauvignon'), (SELECT id FROM vineyard WHERE name = 'To Kalon'), 76),
    ((SELECT id FROM wine WHERE bottle_name = 'Opus One' AND vintage_id = (SELECT id FROM vintage WHERE year = 2019)),
     (SELECT id FROM grape WHERE name = 'Merlot'), (SELECT id FROM vineyard WHERE name = 'To Kalon'), 14),
    ((SELECT id FROM wine WHERE bottle_name = 'Sassicaia' AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)),
     (SELECT id FROM grape WHERE name = 'Cabernet Sauvignon'), (SELECT id FROM vineyard WHERE name = 'Sassicaia Estate'), 85),
    ((SELECT id FROM wine WHERE bottle_name = 'Sassicaia' AND vintage_id = (SELECT id FROM vintage WHERE year = 2017)),
     (SELECT id FROM grape WHERE name = 'Sangiovese'), (SELECT id FROM vineyard WHERE name = 'Sassicaia Estate'), 15),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Margaux' AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)),
     (SELECT id FROM grape WHERE name = 'Cabernet Sauvignon'), (SELECT id FROM vineyard WHERE name = 'Palmer'), 80),
    ((SELECT id FROM wine WHERE bottle_name = 'Chateau Margaux' AND vintage_id = (SELECT id FROM vintage WHERE year = 2016)),
     (SELECT id FROM grape WHERE name = 'Merlot'), (SELECT id FROM vineyard WHERE name = 'Palmer'), 20);
