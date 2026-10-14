-- IMPORT, ALTER TABLE, UPDATE, PRIMARY KEY, dan FOREIGN KEY
-- Menentukan Primary Key dan Foreign Key

alter table olist_customers_dataset 
add primary key (customer_id);

alter table product_category_name_translation
add primary key (product_category_name);

-- Menambahkan baris product_category_name_translation yang kurang dari olist_products_dataset
insert into product_category_name_translation (product_category_name, product_category_name_english)
select distinct 
	opd.product_category_name,
	opd.product_category_name
from olist_products_dataset opd
left join product_category_name_translation pcnt on opd.product_category_name = pcnt.product_category_name 
where pcnt.product_category_name is null and opd.product_category_name is not null;

alter table olist_products_dataset 
add primary key (product_id);

alter table olist_products_dataset 
add constraint fk_product_category_name_translation
foreign key (product_category_name) references product_category_name_translation(product_category_name);

alter table olist_orders_dataset 
add primary key (order_id);

alter table olist_orders_dataset 
add constraint fk_olist_customers_dataset
foreign key (customer_id) references olist_customers_dataset(customer_id);

-- Membuat Kolom Unique Untuk Dijadikan Primary Key olist_order_payments_dataset

alter table olist_order_payments_dataset 
add column payment_unique VARCHAR (200);

update olist_order_payments_dataset
set payment_unique = (order_id, payment_sequential, payment_type, payment_installments, payment_value)
where payment_unique is null;

alter table olist_order_payments_dataset
add primary key (payment_unique);

alter table olist_order_payments_dataset 
add constraint fk_olist_order_dataset
foreign key (order_id) references olist_orders_dataset (order_id);

-- Membuat Kolom Unique Untuk Dijadikan Primary Key olist_order_items_dataset

alter table olist_order_items_dataset 
add column item_unique VARCHAR (200);

update olist_order_items_dataset
set item_unique = (order_id, order_item_id, product_id)
where item_unique is null;

alter table olist_order_items_dataset 
add primary key (item_unique);

alter table olist_order_items_dataset 
add constraint fk_olist_products_dataset
foreign key (product_id) references olist_products_dataset (product_id);

alter table olist_order_items_dataset 
add constraint fk_olist_orders_dataset 
foreign key (order_id) references olist_orders_dataset (order_id);

-----------------------------------------------------------------------------

-- DATA UNDERSTANDING
-- DATA EXPLORATION

-- # Ukuran, Struktur, dan Tipe Data

-- Ukuran, struktur, dan tipe data tabel olist_customers_dataset
select count(*)
from olist_customers_dataset;
-- tabel olist_customers_dataset memiliki 99441 baris dan 5 kolom
-- tabel olist_customers_dataset memiliki customer_id sebagai primary key
-- kolom customer_id memiliki tipe data varchar
-- kolom customer_unique_id memiliki tipe data varchar
-- kolom customer_zip_code_prefix memiliki tipe data integer
-- kolom customer_city memiliki tipe data varchar
-- kolom customer_state memiliki tipe data varchar
-- Ukuran, struktur, dan tipe data tabel olist_customers_dataset sudah benar

-- Ukuran, struktur, dan tipe data tabel product_category_name_translation
select count(*)
from product_category_name_translation; 
-- tabel product_category_name_translation memiliki 74 baris dan 2 kolom
-- tabel product_category_name_translation memiliki product_category_name sebagai primary key
-- kolom product_category_name memiliki tipe data varchar
-- kolom product_category_name_english memiliki tipe data varchar
-- Ukuran, struktur, dan tipe data tabel product_category_name_translation sudah benar

-- Ukuran, struktur, dan tipe data tabel olist_products_dataset 
select count(*)
from olist_products_dataset; 
-- tabel olist_products_dataset memiliki 32951 baris dan 9 kolom
-- tabel olist_products_dataset memiliki product_id sebagai primary key dan product_category_name sebagai foreign key
-- kolom product_id memiliki tipe data varchar
-- kolom product_category_name memiliki tipe data varchar
-- kolom product_name_length memiliki tipe data integer
-- kolom product_description_lenght memiliki tipe data integer
-- kolom product_photos_qty memiliki tipe data integer
-- kolom product_weight_g memiliki tipe data integer
-- kolom product_length_cm memiliki tipe data integer
-- kolom product_height_cm memiliki tipe data integer
-- kolom product_width_cm memiliki tipe data integer
-- Ukuran, struktur, dan tipe data tabel olist_products_dataset sudah benar

-- Ukuran, struktur, dan tipe data tabel olist_orders_dataset 
select count(*)
from olist_orders_dataset ;
-- tabel olist_orders_dataset memiliki 99441 baris dan 8 kolom 
-- tabel olist_orders_dataset memiliki order_id sebagai primary key dan customer_id sebagai foreign key
-- kolom order_id memiliki tipe data varchar
-- kolom customer_id memiliki tipe data varchar
-- kolom order_status memiliki tipe data varchar
-- kolom order_purchase_timestamp memiliki tipe data varchar
-- kolom order_approved_at memiliki tipe data varchar
-- kolom order_delivered_carrier_date memiliki tipe data varchar
-- kolom order_delivered_customer_date memiliki tipe data varchar
-- kolom order_estimated_delivery_date memiliki tipe data varchar
-- Ukuran dan struktur tabel olist_orders_dataset sudah benar
-- Tipe data pada kolom order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, 
-- order_delivered_customer_date dan order_estimated_delivery_date kurang tepat. Lebih baik diganti menjadi timestamp

-- Ukuran, struktur, dan tipe data tabel olist_order_payments_dataset
select count (*)
from olist_order_payments_dataset ;
-- tabel olist_order_payments_dataset memiliki 103886 baris dan 5 kolom
-- tabel olist_order_payments_dataset memiliki payment_unique sebagai primary key dan order_id sebagai foreign key
-- kolom order_id memiliki tipe data varchar
-- kolom payment_sequential memiliki tipe data integer
-- kolom payment_type memiliki tipe data varchar
-- kolom payment_installments memiliki tipe data integer
-- kolom payment_value memiliki tipe data float
-- kolom payment_unique memiliki tipe data varchar
-- Ukuran, struktur, dan tipe data tabel olist_order_payments_dataset sudah benar

-- Ukuran, struktur, dan tipe data tabel olist_order_items_dataset
select count(*)
from olist_order_items_dataset;
-- tabel olist_order_items_dataset memiliki 112650 baris dan 7 kolom
-- tabel olist_order_items_dataset memiliki item_unique sebagai primary key
-- tabel olist_order_items_dataset memiliki order_id dan product_id sebagai foreign key
-- kolom order_id memiliki tipe data varchar
-- kolom order_item_id memiliki tipe data integer
-- kolom product_id memiliki tipe data varchar
-- kolom seller_id memiliki tipe data varchar
-- kolom shipping_limit_date memiliki tipe data varchar
-- kolom price memiliki tipe data float
-- kolom freight_value memiliki tipe data float
-- kolom item_unique memiliki tipe data varchar
-- Ukuran dan struktur tabel olist_order_items_dataset sudah benar
-- Tipe data pada kolom shipping_limit_date kurang tepat. Lebih baik diganti menjadi timestamp

-----------------------------------------------------------------------------

-- # Missing Value

-- Memeriksa missing value tabel olist_customers_dataset
select 
	'customer_id' as nama_kolom,
	count(*) filter(where customer_id is null or customer_id = '') as jumlah_missing,
	round((count(*) filter(where customer_id is null or customer_id = '')::numeric)*100/count(*), 2) as persentase_missing 
from olist_customers_dataset
union all
select 
	'customer_unique_id',
	count(*) filter(where customer_unique_id is null or customer_unique_id = ''),
	round((count(*) filter(where customer_unique_id is null or customer_unique_id = '')::numeric)*100/count(*), 2)
from olist_customers_dataset
union all 
select
	'customer_zip_code_prefix',
	count(*) filter(where customer_zip_code_prefix is null or customer_zip_code_prefix = 0),
	round((count(*) filter(where customer_zip_code_prefix is null or customer_zip_code_prefix = 0)::numeric)*100/count(*), 2)
from olist_customers_dataset
union all
select 
	'customer_city',
	count(*) filter(where customer_city is null or customer_city = ''),
	round((count(*) filter(where customer_city is null or customer_city = '')::numeric)*100/count(*), 2)
from olist_customers_dataset
union all
select 
	'customer_state',
	count(*) filter(where customer_state is null or customer_state = ''),
	round((count(*) filter(where customer_state is null or customer_state = '')::numeric)*100/count(*), 2)
from olist_customers_dataset;
-- Tidak terdapat missing value pada tabel olist_customers_dataset

-- Memeriksa missing value tabel product_category_name_translation
select 
	'product_category_name' as nama_kolom,
	count(*) filter(where product_category_name is null or product_category_name = '') as jumlah_missing,
	round((count(*) filter(where product_category_name is null or product_category_name = '')::numeric), 2) as persentase_missing
from product_category_name_translation
union all
select 
	'product_category_name_english',
	count(*) filter(where product_category_name_english is null or product_category_name_english = ''),
	round((count(*) filter(where product_category_name_english is null or product_category_name_english = '')::numeric), 2)
from product_category_name_translation;
-- Tidak terdapat missing value pada tabel product_category_name_translation

-- Memeriksa missing value tabel olist_products_dataset
select
	'product_id' as nama_kolom,
	count(*) filter(where product_id is null or product_id = '') as jumlah_missing,
	round((count(*) filter(where product_id is null or product_id = '')::numeric)*100/count(*), 2) as persentase_missing
from olist_products_dataset
union all
select 
	'product_category_name',
	count(*) filter(where product_category_name is null or product_category_name = ''),
	round((count(*) filter(where product_category_name is null or product_category_name = '')::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select 
	'product_name_lenght',
	count(*) filter(where product_name_lenght is null or product_name_lenght = 0),
	round((count(*) filter(where product_name_lenght is null or product_name_lenght = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select
	'product_description_lenght',
	count(*) filter(where product_description_lenght is null or product_description_lenght = 0),
	round((count(*) filter(where product_description_lenght is null or product_description_lenght = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select
	'product_photos_qty',
	count(*) filter(where product_photos_qty is null or product_photos_qty = 0),
	round((count(*) filter(where product_photos_qty is null or product_photos_qty = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select 
	'product_weight_g',
	count(*) filter(where product_weight_g is null or product_weight_g = 0),
	round((count(*) filter(where product_weight_g is null or product_weight_g = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select
	'product_length_cm',
	count(*) filter(where product_length_cm is null or product_length_cm = 0),
	round((count(*) filter(where product_length_cm is null or product_length_cm = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select
	'product_height_cm',
	count(*) filter(where product_height_cm is null or product_height_cm = 0),
	round((count(*) filter(where product_height_cm is null or product_height_cm = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select 
	'product_width_cm',
	count(*) filter(where product_width_cm is null or product_width_cm = 0),
	round((count(*) filter(where product_width_cm is null or product_width_cm = 0)::numeric)*100/count(*), 2)
from olist_products_dataset;
-- Terdapat missing value pada tabel olist_products_dataset
-- Missing value pada kolom product_category_name berjumlah 610 baris (1,85%)
-- Missing value pada kolom product_name_length berjumlah 610 baris (1,85%)
-- Missing value pada kolom product_description_lenght berjumlah 610 baris (1,85%)
-- Missing value pada kolom product_photos_qty berjumlah 610 baris (1,85%)
-- Missing value pada kolom product_weight_g berjumlah 6 baris (0,01%)
-- Missing value pada kolom product_length_cm berjumlah 2 baris (0,01%)
-- Missing value pada kolom product_height_cm berjumlah 2 baris (0,01%)
-- Missing value pada kolom product_width_cm berjumlah 2 baris (0,01%)

-- Memeriksa missing value tabel olist_orders_dataset
select 
	'order_id' as nama_kolom,
	count(*) filter(where order_id is null or order_id ='') as jumlah_missing,
	round((count(*) filter(where order_id is null or order_id ='')::numeric)*100/count(*), 2) as persentase_missing
from olist_orders_dataset 
union all
select 
	'customer_id',
	count(*) filter(where customer_id is null or customer_id =''),
	round((count(*) filter(where customer_id is null or customer_id ='')::numeric)*100/count(*), 2)
from olist_orders_dataset
union all 
select 
	'order_status',
	count(*) filter(where order_status is null or order_status =''),
	round((count(*) filter(where order_status is null or order_status ='')::numeric)*100/count(*), 2)
from olist_orders_dataset
union all
select 
	'order_purchase_timestamp',
	count(*) filter(where order_purchase_timestamp is null or order_purchase_timestamp=''),
	round((count(*) filter(where order_purchase_timestamp is null or order_purchase_timestamp='')::numeric)*100/count(*), 2)
from olist_orders_dataset
union all 
select 
	'order_approved_at',
	count(*) filter(where order_approved_at is null or order_approved_at =''),
	round((count(*) filter(where order_approved_at is null or order_approved_at ='')::numeric)*100/count(*), 2)
from olist_orders_dataset
union all 
select 
	'order_delivered_carrier_date',
	count(*) filter(where order_delivered_carrier_date is null or order_delivered_carrier_date=''),
	round((count(*) filter(where order_delivered_carrier_date is null or order_delivered_carrier_date='')::numeric)*100/count(*), 2)
from olist_orders_dataset
union all
select 
	'order_delivered_customer_date',
	count(*) filter(where order_delivered_customer_date is null or order_delivered_customer_date =''),
	round((count(*) filter(where order_delivered_customer_date is null or order_delivered_customer_date ='')::numeric)*100/count(*), 2)
from olist_orders_dataset
union all
select 
	'order_estimated_delivery_date',
	count(*) filter (where order_estimated_delivery_date is null or order_estimated_delivery_date=''),
	round((count(*) filter (where order_estimated_delivery_date is null or order_estimated_delivery_date='')::numeric)*100/count(*), 2)
from olist_orders_dataset;
-- Terdapat missing value pada tabel olist_orders_dataset
-- Missing value pada kolom order_approved_at berjumlah 160 baris (0,16%)
-- Missing value pada kolom order_delivered_carrier_date berjumlah 1783 baris (1,79%)
-- Missing value pada kolom order_delivered_customer_date berjumlah 2965 baris (2,98%)

-- Memeriksa missing value tabel olist_order_payments_dataset
select 
	'order_id' as nama_kolom,
	count(*) filter(where order_id is null or order_id = '') as jumlah_missing,
	round((count(*) filter(where order_id is null)::numeric)*100/count(*), 2) as persentase_missing
from olist_order_payments_dataset
union all
select
	'payment_sequential',
	count(*) filter(where payment_sequential is null),
	round((count(*) filter(where payment_sequential is null)::numeric)*100/count(*), 2)
from olist_order_payments_dataset
union all
select
	'payment_type',
	count(*) filter(where payment_type is null),
	round((count(*) filter(where payment_type is null)::numeric)*100/count(*), 2)
from olist_order_payments_dataset
union all
select
	'payment_installments',
	count(*) filter(where payment_installments is null),
	round((count(*) filter(where payment_installments is null)::numeric)*100/count(*), 2)
from olist_order_payments_dataset
union all
select
	'payment_value',
	count(*) filter(where payment_value is null),
	round((count(*) filter(where payment_value is null)::numeric)*100/count(*), 2)
from olist_order_payments_dataset
union all
select
	'payment_unique',
	count(*) filter(where payment_unique is null),
	round((count(*) filter(where payment_unique is null)::numeric)*100/count(*), 2)
from olist_order_payments_dataset;
-- Tidak terdapat missing value pada tabel olist_order_payments_dataset

-- Memeriksa missing value tabel olist_order_items_dataset
select 
	'order_id' as nama_kolom,
	count(*) filter(where order_id is null or order_id = '') as jumlah_missing,
	round((count(*) filter(where order_id is null or order_id = '')::numeric)*100/count(*), 2) as persentase_missing
from olist_order_items_dataset
union all
select
	'order_item_id',
	count(*) filter(where order_item_id is null or order_item_id = 0),
	round((count(*) filter(where order_item_id is null or order_item_id = 0)::numeric)*100/count(*), 2)
from olist_order_items_dataset
union all 
select
	'product_id',
	count(*) filter(where product_id is null or product_id = ''),
	round((count(*) filter(where product_id is null or product_id = '')::numeric)*100/count(*), 2)
from olist_order_items_dataset
union all
select
	'seller_id',
	count(*) filter(where seller_id is null or seller_id = ''),
	round((count(*) filter(where seller_id is null or seller_id = '')::numeric)*100/count(*), 2)
from olist_order_items_dataset
union all
select
	'shipping_limit_date',
	count(*) filter(where shipping_limit_date is null),
	round((count(*) filter(where shipping_limit_date is null)::numeric)*100/count(*), 2)
from olist_order_items_dataset
union all
select
	'price',
	count(*) filter(where price is null or price = 0),
	round((count(*) filter(where price is null or price = 0)::numeric)*100/count(*), 2)
from olist_order_items_dataset
union all
select
	'freight_value',
	count(*) filter(where freight_value is null or freight_value = 0),
	round((count(*) filter(where freight_value is null or freight_value = 0)::numeric)*100/count(*), 2)
from olist_order_items_dataset
union all
select
	'item_unique',
	count(*) filter(where item_unique is null or item_unique = ''),
	round((count(*) filter(where item_unique is null or item_unique = '')::numeric)*100/count(*), 2)
from olist_order_items_dataset;
-- Terdapat missing value pada tabel olist_order_items_dataset
-- Missing value pada kolom freight_value berjumlah 383 baris (0,34%)

-----------------------------------------------------------------------------

-- # Duplicate Value

-- Memeriksa duplicate value tabel olist_customers_dataset	
select 
	customer_id,
	count(*) as jumlah_duplicate
from olist_customers_dataset
group by customer_id 
having count(*) > 1 ;

with duplikat as (
	select
		(select count(*) from olist_customers_dataset) as jumlah_seluruh,
		(select count(*) from olist_customers_dataset) - 
		(select count(*) from (select distinct * from olist_customers_dataset)) as jumlah_duplicate)
select jumlah_duplicate, (jumlah_duplicate/jumlah_seluruh*100) as persentase_duplicate
from duplikat;
-- Tidak terdapat duplicate value pada tabel olist_customers_dataset


-- Memeriksa duplicate_value pada tabel product_category_name_translation
select 
	product_category_name,
	count(*) as jumlah_duplicate
from product_category_name_translation
group by product_category_name
having count(*) > 1;

with duplikat as (
	select 
		(select count(*) from product_category_name_translation) as jumlah_seluruh,
		(select count(*) from product_category_name_translation) -
		(select count(*) from (select distinct * from product_category_name_translation)) as jumlah_duplicate)
select 
	jumlah_duplicate,
	round(((jumlah_duplicate*100/jumlah_seluruh)::numeric), 2) as persentase_duplicate
from duplikat;
-- Tidak terdapat duplicate value pada tabel product_category_name_translation


-- Memeriksa duplicate value tabel olist_products_dataset
select 
	product_id,
	count(*)
from olist_products_dataset
group by product_id
having count(*) > 1 ;

with duplikat as (
	select 
		(select count(*) from olist_products_dataset) as jumlah_seluruh,
		(select count(*) from olist_products_dataset) -
		(select count(*) from (select distinct * from olist_products_dataset)) as jumlah_duplicate
)
select jumlah_duplicate, (jumlah_duplicate*100/jumlah_seluruh) as persentase_duplicate
from duplikat;
-- Tidak terdapat duplicate value pada tabel olist_products_dataset


-- Memeriksa duplicate value tabel olist_orders_dataset
select 
	order_id,
	count(*)
from olist_orders_dataset
group by order_id
having count(*) > 1;

with duplikat as (
	select 
		(select count(*) from olist_orders_dataset) as jumlah_seluruh,
		(select count(*) from olist_orders_dataset) -
		(select count(*) from (select distinct * from olist_orders_dataset)) as jumlah_duplicate
)
select jumlah_duplicate, (jumlah_duplicate*100/jumlah_seluruh) as persentase_duplicate
from duplikat;
-- Tidak terdapat duplicate value pada tabel olist_orders_dataset


-- Memeriksa duplicate value tabel olist_order_payments_dataset
select
	order_id,
	count(*)
from olist_order_payments_dataset
group by order_id
having count(*) > 1;

select *
from olist_order_payments_dataset
where order_id = '53f5a7f622d498ff3eeb334b8efa7ae7';

select
	payment_unique,
	count(*)
from olist_order_payments_dataset
group by payment_unique 
having count(*) > 1;

with duplikat as (
	select
		(select count(*) from olist_order_payments_dataset) as jumlah_seluruh,
		(select count(*) from olist_order_payments_dataset) - 
		(select count(*) from(select distinct * from olist_order_payments_dataset)) as jumlah_duplicate
)
select jumlah_duplicate, (jumlah_duplicate/jumlah_seluruh*100) as persentase_duplicate 
from duplikat;
-- Tidak terdapat duplicate value pada tabel olist_order_payments_dataset


-- Memeriksa duplicate value tabel olist_order_items_dataset
select 
	order_id,
	count(*)
from olist_order_items_dataset
group by order_id
having count(*) > 1;

select *
from olist_order_items_dataset
where order_id = 'd66cd5f088e61b54931e6a5fd6b53198';

select 
	item_unique,
	count(*)
from olist_order_items_dataset
group by item_unique
having count(*) > 1;

with duplikat as (
	select 	
		(select count(*) from olist_order_items_dataset) as jumlah_seluruh,
		(select count(*) from olist_order_items_dataset) - 
		(select count(*) from(select distinct * from olist_order_items_dataset)) as jumlah_duplicate
)
select jumlah_duplicate, (jumlah_duplicate/jumlah_seluruh*100) as persentase_duplicate
from duplikat;
-- Tidak terdapat duplicate value pada tabel olist_order_items_dataset

-----------------------------------------------------------------------------

-- # Outlier

-- Memeriksa outlier tabel olist_customers_dataset
-- Memeriksa kolom customer_zip_code_prefix
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by customer_zip_code_prefix) as q1,
		PERCENTILE_CONT(0.75) within group (order by customer_zip_code_prefix) as q3
	from olist_customers_dataset
),
outlier as (
	select
		(q3 + (1.5*(q3-q1))) as upper_bound,
		(q1 - (1.5*(q3-q1))) as lower_bound
	from kuantil
),
outlier_sum as (
	select
		count (*) as jumlah_outlier
	from olist_customers_dataset ocd
	cross join outlier
	where (ocd.customer_zip_code_prefix > upper_bound) or (ocd.customer_zip_code_prefix < lower_bound)
)
select 
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_customers_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Tidak terdapat outlier pada tabel olist_customers_dataset


-- Memeriksa outlier tabel olist_products_dataset
-- Memeriksa kolom product_name_lenght
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by product_name_lenght) as q1,
		PERCENTILE_CONT(0.75) within group (order by product_name_lenght) as q3
	from olist_products_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
sum_outlier as (
	select 
		count(*) as jumlah_outlier
	from olist_products_dataset opd
	cross join outlier
	where (opd.product_name_lenght > upper_bound) or (opd.product_name_lenght < lower_bound)
)
select 
	so.jumlah_outlier,
	round((so.jumlah_outlier*100/(select count(*) from olist_products_dataset)::numeric), 2) as persentase_outlier
from sum_outlier so;
-- Kolom product_name_lenght memiliki outlier sebanyak 290 baris (0,88%)

-- Memeriksa kolom product_description_lenght
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by product_description_lenght) as q1,
		PERCENTILE_CONT(0.75) within group (order by product_description_lenght) as q3
	from olist_products_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_products_dataset opd
	cross join outlier
	where (opd.product_description_lenght > upper_bound) or (opd.product_description_lenght < lower_bound)
)
select
	os.jumlah_outlier,
	round((os.jumlah_outlier *100/(select count(*) from olist_products_dataset opd)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom product_description_lenght memiliki outlier sebanyak 2078 baris (6,31%)

-- Memeriksa kolom product_photos_qty
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by product_photos_qty) as q1,
		PERCENTILE_CONT(0.75) within group (order by product_photos_qty) as q3
	from olist_products_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_products_dataset opd
	cross join outlier
	where (opd.product_photos_qty > upper_bound) or (opd.product_photos_qty < lower_bound)
)
select
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_products_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom product_photos_qty memiliki outlier sebanyak 849 baris (2,58%)

-- Memeriksa kolom product_weight_g
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by product_weight_g) as q1,
		PERCENTILE_CONT(0.75) within group (order by product_weight_g) as q3
	from olist_products_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_products_dataset opd
	cross join outlier
	where (opd.product_weight_g > upper_bound) or (opd.product_weight_g < lower_bound)
)
select
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_products_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom product_weight_g memiliki outlier sebanyak 4551 baris (13,81%)

-- Memeriksa kolom product_length_cm
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by product_length_cm) as q1,
		PERCENTILE_CONT(0.75) within group (order by product_length_cm) as q3
	from olist_products_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_products_dataset opd
	cross join outlier
	where (opd.product_length_cm > upper_bound) or (opd.product_length_cm < lower_bound)
)
select 
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_products_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom product_length_cm memiliki outlier sebanyak 1380 baris (4,19%)

-- Memeriksa kolom product_height_cm
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by product_height_cm) as q1,
		PERCENTILE_CONT(0.75) within group (order by product_height_cm) as q3
	from olist_products_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_products_dataset opd
	cross join outlier
	where (opd.product_height_cm > upper_bound) or (opd.product_height_cm < lower_bound)
)
select 
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_products_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom product_height_cm memiliki outlier sebanyak 1892 baris (5,74%)

-- Memeriksa kolom product_width_cm
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by product_width_cm) as q1,
		PERCENTILE_CONT(0.75) within group (order by product_width_cm) as q3
	from olist_products_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_products_dataset opd
	cross join outlier
	where (opd.product_width_cm > upper_bound) or (opd.product_width_cm < lower_bound)
)
select 
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_products_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom product_width_cm memiliki outlier sebanyak 912 baris (2,77%)


-- Memeriksa outlier tabel olist_order_payments_dataset
-- Memeriksa kolom payment_sequential
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by payment_sequential) as q1,
		PERCENTILE_CONT(0.75) within group (order by payment_sequential) as q3
	from olist_order_payments_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_order_payments_dataset oopd
	cross join outlier
	where (oopd.payment_sequential > upper_bound) or (oopd.payment_sequential < lower_bound)
)
select 
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_order_payments_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom payment_sequential memiliki outlier sebanyak 4526 baris (4,36%)

-- Memeriksa kolom payment_installments
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by payment_installments) as q1,
		PERCENTILE_CONT(0.75) within group (order by payment_installments) as q3
	from olist_order_payments_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_order_payments_dataset oopd
	cross join outlier
	where (oopd.payment_installments > upper_bound) or (oopd.payment_installments < lower_bound)
)
select 
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_order_payments_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom payment_installments memiliki outlier sebanyak 6313 baris (6,08%)

-- Memeriksa kolom payment_value
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by payment_value) as q1,
		PERCENTILE_CONT(0.75) within group (order by payment_value) as q3
	from olist_order_payments_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_order_payments_dataset oopd
	cross join outlier
	where (oopd.payment_value > upper_bound) or (oopd.payment_value < lower_bound)
)
select 
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_order_payments_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom payment_value memiliki outlier sebanyak 7981 baris (7,68%)


-- Memeriksa outlier tabel olist_order_items_dataset
-- Memeriksa kolom order_item_id
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by order_item_id) as q1,
		PERCENTILE_CONT(0.75) within group (order by order_item_id) as q3
	from olist_order_items_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_order_items_dataset ooid
	cross join outlier
	where (ooid.order_item_id > upper_bound) or (ooid.order_item_id < lower_bound)
)
select 
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_order_items_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom order_item_id memiliki outlier sebanyak 13984 baris (12,41%)

-- Memeriksa kolom price
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by price) as q1,
		PERCENTILE_CONT(0.75) within group (order by price) as q3
	from olist_order_items_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_order_items_dataset ooid
	cross join outlier
	where (ooid.price > upper_bound) or (ooid.price < lower_bound)
)
select 
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_order_items_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom price memiliki outlier sebanyak 8427 baris (7,48%)

-- Memeriksa kolom freight_value
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group (order by freight_value) as q1,
		PERCENTILE_CONT(0.75) within group (order by freight_value) as q3
	from olist_order_items_dataset
),
outlier as (
	select 
		q3 + (1.5*(q3-q1)) as upper_bound,
		q1 - (1.5*(q3-q1)) as lower_bound
	from kuantil
),
outlier_sum as (
	select 
		count(*) as jumlah_outlier
	from olist_order_items_dataset ooid
	cross join outlier
	where (ooid.freight_value > upper_bound) or (ooid.freight_value < lower_bound)
)
select 
	os.jumlah_outlier,
	round((os.jumlah_outlier*100/(select count(*) from olist_order_items_dataset)::numeric), 2) as persentase_outlier
from outlier_sum os;
-- Kolom freight_value memiliki outlier sebanyak 12134 baris (10,77%)


-- INSIGHT FROM DATA EXPLORATION
-- Tidak terdapat duplicate value pada semua tabel
-- Tipe data pada tabel olist_orders_dataset kolom order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date dan order_estimated_delivery_date kurang tepat. Lebih baik diganti menjadi timestamp
-- Tipe data pada tabel olist_order_items_dataset kolom shipping_limit_date kurang tepat. Lebih baik diganti menjadi timestamp
-- Terdapat missing value pada tabel olist_products_dataset berjumlah :
-- kolom product_name_length berjumlah 610 baris (1,85%)
-- kolom product_description_lenght berjumlah 610 baris (1,85%)
-- kolom product_photos_qty berjumlah 610 baris (1,85%)
-- kolom product_weight_g berjumlah 6 baris (0,01%)
-- kolom product_length_cm berjumlah 2 baris (0,01%)
-- kolom product_height_cm berjumlah 2 baris (0,01%)
-- kolom product_width_cm berjumlah 2 baris (0,01%)
-- Terdapat missing value pada tabel olist_order_items_dataset berjumlah :
-- kolom freight_value berjumlah 383 baris (0,34%)
-- Terdapat outlier pada semua kolom yang memiliki tipe data numerik pada setiap tabel, kecuali kolom customer_zip_code_prefix pada tabel olist_customers_dataset
-- Terdapat missing value pada tabel olist_orders_dataset
-- Missing value pada kolom order_approved_at berjumlah 160 baris (0,16%)
-- Missing value pada kolom order_delivered_carrier_date berjumlah 1783 baris (1,79%)
-- Missing value pada kolom order_delivered_customer_date berjumlah 2965 baris (2,98%)

-----------------------------------------------------------------------------

-- DATA PREPROCESSING
-- DATA CLEANING


-- # Penanganan Missing Value

-- Penanganan missing value pada tabel olist_orders_dataset

update olist_orders_dataset
set order_approved_at = order_purchase_timestamp
where order_approved_at is null or order_approved_at = '';

update olist_orders_dataset
set order_delivered_carrier_date = order_purchase_timestamp
where order_delivered_carrier_date is null or order_delivered_carrier_date = '';

update olist_orders_dataset
set order_delivered_customer_date = order_purchase_timestamp
where order_delivered_customer_date is null or order_delivered_customer_date = '';

-- Penanganan mising value pada tabel olist_orders_dataset dengan kolom order_approved_at, order_delivered_carrier_date, dan order_delivered_customer_date
-- Yaitu dengan diisi dengan tanggal yang ada pada kolom order_purchase_timestamp
-- Alasannya adalah untuk dapat merubah tipe data menjadi timestamp, tidak diperbolehkan terdapat missing value atau isi selain format tanggal
-- Kolom order_purchase_timestamp dipilih sebagai tanggal untuk missing value karena untuk menyesuaikan tanggal pemesanan


-- Penanganan missing value pada tabel olist_products_dataset 

update olist_products_dataset
set product_category_name = 'Unknown'
where product_category_name is null or product_category_name = '';

update olist_products_dataset
set product_name_lenght = (select
							 PERCENTILE_CONT(0.50) within group (order by product_name_lenght)
						   from olist_products_dataset)
where product_name_lenght is null or product_name_lenght = 0;

update olist_products_dataset
set product_description_lenght = (select
									PERCENTILE_CONT(0.50) within group (order by product_description_lenght)
								 from olist_products_dataset)
where product_description_lenght is null or product_description_lenght = 0;

update olist_products_dataset
set product_photos_qty = (select
							PERCENTILE_CONT(0.50) within group (order by product_photos_qty)
						  from olist_products_dataset)
where product_photos_qty is null or product_photos_qty = 0;

update olist_products_dataset
set product_weight_g = (select
							PERCENTILE_CONT(0.50) within group (order by product_weight_g)
						  from olist_products_dataset)
where product_weight_g is null or product_weight_g = 0;

update olist_products_dataset
set product_length_cm = (select
							PERCENTILE_CONT(0.50) within group (order by product_length_cm)
						  from olist_products_dataset)
where product_length_cm is null or product_length_cm = 0;

update olist_products_dataset
set product_height_cm = (select
							PERCENTILE_CONT(0.50) within group (order by product_height_cm)
						  from olist_products_dataset)
where product_height_cm is null or product_height_cm = 0;

update olist_products_dataset
set product_width_cm = (select
							PERCENTILE_CONT(0.50) within group (order by product_width_cm)
						  from olist_products_dataset)
where product_width_cm is null or product_width_cm = 0;

-- Penanganan mising value pada tabel olist_products_dataset dengan kolom product_category_name diisi dengan "Unknown"
-- Penanganan mising value pada tabel olist_products_dataset dengan kolom product_name_lenght, product_description_lenght, product_photos_qty, product_weight_g,
-- product_length_cm, product_height_cm, product_width_cm berupa diisi dengan median
-- Alasannya adalah kolom dengan missing value memiliki outlier/nilai ekstrim. Sehingga apabila menggunakan mean, dapat menyebabkan pergeseran nilai tengah

update olist_order_items_dataset
set freight_value = (select 
						PERCENTILE_CONT(0.50) within group (order by freight_value)
					from olist_order_items_dataset)
where freight_value is null or freight_value = 0;

-- Penanganan mising value pada tabel olist_order_items_dataset dengan kolom freight_value berupa diisi dengan median
-- Alasannya adalah kolom dengan missing value memiliki outlier/nilai ekstrim. Sehingga apabila menggunakan mean, dapat menyebabkan pergeseran nilai tengah


-- Memeriksa kembali missing value setelah penanganan
select
	'product_id' as nama_kolom,
	count(*) filter(where product_id is null or product_id = '') as jumlah_missing,
	round((count(*) filter(where product_id is null or product_id = '')::numeric)*100/count(*), 2) as persentase_missing
from olist_products_dataset
union all
select 
	'product_category_name',
	count(*) filter(where product_category_name is null or product_category_name = ''),
	round((count(*) filter(where product_category_name is null or product_category_name = '')::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select 
	'product_name_lenght',
	count(*) filter(where product_name_lenght is null or product_name_lenght = 0),
	round((count(*) filter(where product_name_lenght is null or product_name_lenght = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select
	'product_description_lenght',
	count(*) filter(where product_description_lenght is null or product_description_lenght = 0),
	round((count(*) filter(where product_description_lenght is null or product_description_lenght = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select
	'product_photos_qty',
	count(*) filter(where product_photos_qty is null or product_photos_qty = 0),
	round((count(*) filter(where product_photos_qty is null or product_photos_qty = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select 
	'product_weight_g',
	count(*) filter(where product_weight_g is null or product_weight_g = 0),
	round((count(*) filter(where product_weight_g is null or product_weight_g = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select
	'product_length_cm',
	count(*) filter(where product_length_cm is null or product_length_cm = 0),
	round((count(*) filter(where product_length_cm is null or product_length_cm = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select
	'product_height_cm',
	count(*) filter(where product_height_cm is null or product_height_cm = 0),
	round((count(*) filter(where product_height_cm is null or product_height_cm = 0)::numeric)*100/count(*), 2)
from olist_products_dataset
union all
select 
	'product_width_cm',
	count(*) filter(where product_width_cm is null or product_width_cm = 0),
	round((count(*) filter(where product_width_cm is null or product_width_cm = 0)::numeric)*100/count(*), 2)
from olist_products_dataset;

select
	'freight_value' as nama_kolom,
	count(*) filter(where freight_value is null or freight_value = 0) as jumlah_missing,
	round((count(*) filter(where freight_value is null or freight_value = 0)::numeric)*100/count(*), 2) as persentase_missing
from olist_order_items_dataset;

select 
	'order_id' as nama_kolom,
	count(*) filter(where order_id is null or order_id ='') as jumlah_missing,
	round((count(*) filter(where order_id is null or order_id ='')::numeric)*100/count(*), 2) as persentase_missing
from olist_orders_dataset 
union all
select 
	'customer_id',
	count(*) filter(where customer_id is null or customer_id =''),
	round((count(*) filter(where customer_id is null or customer_id ='')::numeric)*100/count(*), 2)
from olist_orders_dataset
union all 
select 
	'order_status',
	count(*) filter(where order_status is null or order_status =''),
	round((count(*) filter(where order_status is null or order_status ='')::numeric)*100/count(*), 2)
from olist_orders_dataset
union all
select 
	'order_purchase_timestamp',
	count(*) filter(where order_purchase_timestamp is null),
	round((count(*) filter(where order_purchase_timestamp is null)::numeric)*100/count(*), 2)
from olist_orders_dataset
union all 
select 
	'order_approved_at',
	count(*) filter(where order_approved_at is null),
	round((count(*) filter(where order_approved_at is null)::numeric)*100/count(*), 2)
from olist_orders_dataset
union all 
select 
	'order_delivered_carrier_date',
	count(*) filter(where order_delivered_carrier_date is null),
	round((count(*) filter(where order_delivered_carrier_date is null)::numeric)*100/count(*), 2)
from olist_orders_dataset
union all
select 
	'order_delivered_customer_date',
	count(*) filter(where order_delivered_customer_date is null),
	round((count(*) filter(where order_delivered_customer_date is null)::numeric)*100/count(*), 2)
from olist_orders_dataset
union all
select 
	'order_estimated_delivery_date',
	count(*) filter (where order_estimated_delivery_date is null),
	round((count(*) filter (where order_estimated_delivery_date is null)::numeric)*100/count(*), 2)
from olist_orders_dataset;

-- Missing value berhasil ditangani


-- # Penanganan Tipe Data

alter table olist_orders_dataset
alter column order_purchase_timestamp type timestamp
USING order_purchase_timestamp::timestamp without time zone;
-- Penaganan tipe data pada tabel olist_orders_dataset dan tabel olist_order_items_dataset

alter table olist_orders_dataset
alter column order_approved_at type timestamp
USING order_approved_at::timestamp without time zone;

alter table olist_orders_dataset
alter column order_delivered_carrier_date type timestamp
USING order_delivered_carrier_date::timestamp without time zone;

alter table olist_orders_dataset
alter column order_delivered_customer_date type timestamp
USING order_delivered_customer_date::timestamp without time zone;

alter table olist_orders_dataset
alter column order_estimated_delivery_date type timestamp
USING order_estimated_delivery_date::timestamp without time zone;

alter table olist_order_items_dataset
alter column shipping_limit_date type timestamp
USING shipping_limit_date::timestamp without time zone;
--Penanganan tipe data pada tabel olist_orders_dataset kolom order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date
-- dan pada tabel olist_order_items_dataset kolom shipping_limit_date dengan cara merubah tipe data menjadi timestamp


-- # Penanganan Duplicate Value
-- Tidak terdapat duplicate value pada seluruh tabel. Tidak ada penanganan


-- # Penanganan Outlier
-- Penanganan outlier berupa mengkonfirmasi kembali datanya kepada pemberi data. Apakah datanya valid atau tidak
-- Apabila pemberi data menyatakan bahwa data yang berupa outlier adalah valid, maka tidak ada penanganan outlier


-- Feature Engineering
alter table olist_orders_dataset
add column durasi_hari_pengiriman int;

update olist_orders_dataset
set durasi_hari_pengiriman = order_estimated_delivery_date::date - order_purchase_timestamp::date
where durasi_hari_pengiriman is null;

-----------------------------------------------------------------------------

-- EDA

-- Kategori barang dengan keuntungan terbesar (Top 5)
with sales as (
	select
		pcnt.product_category_name_english as nama_kategori_barang,
		round((sum(oopd.payment_value)::numeric), 2) as total_sales,
		count(ooid.order_id) as jumlah_transaksi,
		round((sum(ooid.price)::numeric), 2) as total_modal,
		round((sum(ooid.freight_value )::numeric), 2) as total_biaya_kurir
	from olist_order_payments_dataset oopd
	left join olist_orders_dataset ood on oopd.order_id = ood.order_id 
	left join olist_order_items_dataset ooid on ood.order_id = ooid.order_id 
	left join olist_products_dataset opd on ooid.product_id = opd.product_id 
	left join product_category_name_translation pcnt on opd.product_category_name = pcnt.product_category_name 
	where ooid.order_id is not null
	group by pcnt.product_category_name_english
),
profit as (
	select 
	nama_kategori_barang,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	(total_sales - total_modal - total_biaya_kurir) as keuntungan
	from sales
)
select 
	nama_kategori_barang,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	keuntungan,
	rank() over (
		order by keuntungan desc
		) as ranking
from profit
limit 5;
-- Kategori computers_accessories memberikan keuntungan yang paling besar dibandingkan kategori lain meskipun jumlah sales yang lebih kecil
-- Kategori seperti bed_bath_table memiliki sales yang lebih besar dibandingkan computers_accessories. Hal ini dapat terjadi akibat biaya kurir yang lebih mahal
-- Dianjurkan untuk mencari mitra logistik yang memiliki biaya pengiriman yang lebih murah sehingga keuntungan lebih besar
-- Dianjurkan untuk melakukan marketing campaign pada platform social media untuk kategori barang dengan jumlah transaksi yang masih rendah seperti office_furniture

-- Kategori barang dengan keuntungan terbesar berdasarkan kota asal pelanggan (Top 10)
with sales as (
	select
		pcnt.product_category_name_english as nama_kategori_barang,
		round((sum(oopd.payment_value)::numeric), 2) as total_sales,
		count(ooid.order_id) as jumlah_transaksi,
		round((sum(ooid.price)::numeric), 2) as total_modal,
		round((sum(ooid.freight_value )::numeric), 2) as total_biaya_kurir,
		ocd.customer_city as kota,
		round(avg(ood.durasi_hari_pengiriman), 2) as durasi_hari_pengiriman
	from olist_order_payments_dataset oopd
	left join olist_orders_dataset ood on oopd.order_id = ood.order_id 
	left join olist_customers_dataset ocd on ood.customer_id = ocd.customer_id 
	left join olist_order_items_dataset ooid on ood.order_id = ooid.order_id 
	left join olist_products_dataset opd on ooid.product_id = opd.product_id 
	left join product_category_name_translation pcnt on opd.product_category_name = pcnt.product_category_name 
	where ooid.order_id is not null
	group by pcnt.product_category_name_english, ocd.customer_city 
),
profit as (
	select 
	nama_kategori_barang,
	kota,
	durasi_hari_pengiriman,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	(total_sales - total_modal - total_biaya_kurir) as keuntungan
	from sales
)
select 
	nama_kategori_barang,
	kota,
	durasi_hari_pengiriman,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	keuntungan,
	rank() over (
		order by keuntungan desc
		) as ranking
from profit
limit 10;
-- Kategori computers_accessories sebagai kategori dengan keuntungan yang paling besar, transaksi terjadi di kota sao paula
-- Selain kategori computers_accessories, mayoritas pelangggan berasal dari kota sao paula
-- Durasi pengiriman ke sao paula relatif cepat jika dibandingkan kota lain seperti goiania dan rio de janeiro
-- Sehingga dapat disarankan untuk mencari mitra logistik di kota goiania dan rio de janeiro

-- Kategori barang dengan keuntungan terkecil (Top 10)
with sales as (
	select
		pcnt.product_category_name_english as nama_kategori_barang,
		round((sum(oopd.payment_value)::numeric), 2) as total_sales,
		count(ooid.order_id) as jumlah_transaksi,
		round((sum(ooid.price)::numeric), 2) as total_modal,
		round((sum(ooid.freight_value )::numeric), 2) as total_biaya_kurir,
		ocd.customer_city as kota,
		round(avg(ood.durasi_hari_pengiriman), 2) as durasi_hari_pengiriman
	from olist_order_payments_dataset oopd
	left join olist_orders_dataset ood on oopd.order_id = ood.order_id 
	left join olist_customers_dataset ocd on ood.customer_id = ocd.customer_id 
	left join olist_order_items_dataset ooid on ood.order_id = ooid.order_id 
	left join olist_products_dataset opd on ooid.product_id = opd.product_id 
	left join product_category_name_translation pcnt on opd.product_category_name = pcnt.product_category_name 
	where ooid.order_id is not null
	group by pcnt.product_category_name_english, ocd.customer_city 
),
profit as (
	select 
	nama_kategori_barang,
	kota,
	durasi_hari_pengiriman,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	total_modal,
	(total_sales - total_modal - total_biaya_kurir) as keuntungan
	from sales
)
select 
	nama_kategori_barang,
	kota,
	durasi_hari_pengiriman,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	total_modal,
	keuntungan,
	rank() over (
		order by keuntungan
		) as ranking
from profit
limit 10;
-- Masih terdapat kategori barang yang mengalami kerugian. Hal ini terjadi akibat modal dan biaya kurir yang lebih besar dibandingkan penjualan
-- Dianjurkan untuk meninjau ulang harga barang dan diskon agar tidak menjual barang lebih rendah dari modal dan biaya pengiriman

-- Jumlah setiap kategori transaksi
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group(order by payment_value) as q1,
		PERCENTILE_CONT(0.75) within group(order by payment_value) as q3
	from olist_order_payments_dataset
),
kategori as (
	select
		case 
			when payment_value < q1 then 'Kecil'
			when payment_value > q3 then 'Besar'
			else 'Sedang'
		end as kategori_transaksi
	from olist_order_payments_dataset
	cross join kuantil
)
select 
	kategori_transaksi,
	count(*) as jumlah_kategori_transaksi
from kategori
group by kategori_transaksi
order by jumlah_kategori_transaksi desc;
-- Mayoritas transaksi berupa kategori sedang
-- Dianjurkan untuk meninjau ulang harga barang dan diskon sehingga dapat meningkatkan transaksi berkategori besar

-- MEMBUAT VIEW

-- profit_category_ranking untuk melihat Kategori barang dengan keuntungan terbesar ke terkecil
create or replace view profit_category_ranking as 
with sales as (
	select
		pcnt.product_category_name_english as nama_kategori_barang,
		round((sum(oopd.payment_value)::numeric), 2) as total_sales,
		count(ooid.order_id) as jumlah_transaksi,
		round((sum(ooid.price)::numeric), 2) as total_modal,
		round((sum(ooid.freight_value )::numeric), 2) as total_biaya_kurir
	from olist_order_payments_dataset oopd
	left join olist_orders_dataset ood on oopd.order_id = ood.order_id 
	left join olist_order_items_dataset ooid on ood.order_id = ooid.order_id 
	left join olist_products_dataset opd on ooid.product_id = opd.product_id 
	left join product_category_name_translation pcnt on opd.product_category_name = pcnt.product_category_name 
	where ooid.order_id is not null
	group by pcnt.product_category_name_english
),
profit as (
	select 
	nama_kategori_barang,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	(total_sales - total_modal - total_biaya_kurir) as keuntungan
	from sales
)
select 
	nama_kategori_barang,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	keuntungan,
	rank() over (
		order by keuntungan desc
		) as ranking
from profit;

-- profit_city_category_ranking untuk melihat kategori barang dengan keuntungan terbesar berdasarkan kota asal pelanggan
create or replace view profit_city_category_ranking as
with sales as (
	select
		pcnt.product_category_name_english as nama_kategori_barang,
		round((sum(oopd.payment_value)::numeric), 2) as total_sales,
		count(ooid.order_id) as jumlah_transaksi,
		round((sum(ooid.price)::numeric), 2) as total_modal,
		round((sum(ooid.freight_value )::numeric), 2) as total_biaya_kurir,
		ocd.customer_city as kota,
		round(avg(ood.durasi_hari_pengiriman), 2) as durasi_hari_pengiriman
	from olist_order_payments_dataset oopd
	left join olist_orders_dataset ood on oopd.order_id = ood.order_id 
	left join olist_customers_dataset ocd on ood.customer_id = ocd.customer_id 
	left join olist_order_items_dataset ooid on ood.order_id = ooid.order_id 
	left join olist_products_dataset opd on ooid.product_id = opd.product_id 
	left join product_category_name_translation pcnt on opd.product_category_name = pcnt.product_category_name 
	where ooid.order_id is not null
	group by pcnt.product_category_name_english, ocd.customer_city 
),
profit as (
	select 
	nama_kategori_barang,
	kota,
	durasi_hari_pengiriman,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	(total_sales - total_modal - total_biaya_kurir) as keuntungan
	from sales
)
select 
	nama_kategori_barang,
	kota,
	durasi_hari_pengiriman,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	keuntungan,
	rank() over (
		order by keuntungan desc
		) as ranking
from profit;

-- lowest_profit_category untuk melihat kategori barang dengan keuntungan terkecil
create or replace view lowest_profit_category as 
with sales as (
	select
		pcnt.product_category_name_english as nama_kategori_barang,
		round((sum(oopd.payment_value)::numeric), 2) as total_sales,
		count(ooid.order_id) as jumlah_transaksi,
		round((sum(ooid.price)::numeric), 2) as total_modal,
		round((sum(ooid.freight_value )::numeric), 2) as total_biaya_kurir,
		ocd.customer_city as kota,
		round(avg(ood.durasi_hari_pengiriman), 2) as durasi_hari_pengiriman
	from olist_order_payments_dataset oopd
	left join olist_orders_dataset ood on oopd.order_id = ood.order_id 
	left join olist_customers_dataset ocd on ood.customer_id = ocd.customer_id 
	left join olist_order_items_dataset ooid on ood.order_id = ooid.order_id 
	left join olist_products_dataset opd on ooid.product_id = opd.product_id 
	left join product_category_name_translation pcnt on opd.product_category_name = pcnt.product_category_name 
	where ooid.order_id is not null
	group by pcnt.product_category_name_english, ocd.customer_city 
),
profit as (
	select 
	nama_kategori_barang,
	kota,
	durasi_hari_pengiriman,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	total_modal,
	(total_sales - total_modal - total_biaya_kurir) as keuntungan
	from sales
)
select 
	nama_kategori_barang,
	kota,
	durasi_hari_pengiriman,
	jumlah_transaksi,
	total_sales,
	total_biaya_kurir,
	total_modal,
	keuntungan,
	rank() over (
		order by keuntungan
		) as ranking
from profit;

-- sales_category untuk melihat jumlah setiap kategori transaksi
create or replace view sales_category as 
with kuantil as (
	select 
		PERCENTILE_CONT(0.25) within group(order by payment_value) as q1,
		PERCENTILE_CONT(0.75) within group(order by payment_value) as q3
	from olist_order_payments_dataset
),
kategori as (
	select
		case 
			when payment_value < q1 then 'Kecil'
			when payment_value > q3 then 'Besar'
			else 'Sedang'
		end as kategori_transaksi
	from olist_order_payments_dataset
	cross join kuantil
)
select 
	kategori_transaksi,
	count(*) as jumlah_kategori_transaksi
from kategori
group by kategori_transaksi
order by jumlah_kategori_transaksi desc;