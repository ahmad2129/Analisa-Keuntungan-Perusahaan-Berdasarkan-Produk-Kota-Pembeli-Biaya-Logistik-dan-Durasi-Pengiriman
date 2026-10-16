# 📊 Analisa Keuntungan Perusahaan Berdasarkan Produk, Kota Pembeli, Biaya Logistik, dan Durasi Pengiriman

## 📌 Overview Project
Project ini bertujuan untuk menganalisis pengaruh biaya logistik dan faktor lain terhadap keuntungan penjualan produk e-commerce, serta mengetahui kategori barang dan kota asal pembeli dengan keuntungan terbesar dan terkecil.

Analisis dilakukan menggunakan **SQL** pada **Brazilian E-Commerce Public Dataset by Olist** yang berisi data pelanggan, produk, pesanan, pembayaran, dan item pesanan.

Melalui analisis ini diharapkan dapat diperoleh insight yang membantu penjual dalam menentukan harga, memilih mitra logistik, dan memprioritaskan kategori produk yang paling menguntungkan.

## ❗ Problem Statement
Menteri Perdagangan merespons keluhan para penjual terkait pengenaan biaya logistik atau ongkos kirim oleh sejumlah platform e-commerce. Skema tersebut dinilai membebani seller karena biaya pengiriman dibebankan sepenuhnya kepada penjual, sehingga keuntungan dapat menjadi kecil meskipun nilai penjualan besar.

> Sumber: detikBali – *Mendag Respons Ongkir Dibebankan Seller di E-Commerce: Masih Dibahas* (11 Mei 2026)

Dengan menganalisis data transaksi, kita dapat mengetahui seberapa besar biaya logistik memengaruhi keuntungan. Insight dari analisis ini dapat membantu:

- Penjual dalam memilih mitra logistik yang lebih hemat dan cepat
- Tim produk dalam meninjau ulang harga dan diskon pada kategori yang merugi
- Tim marketing dalam menentukan kategori yang perlu didorong penjualannya

## ❓ Business Question
Beberapa pertanyaan yang ingin dijawab dalam analisis ini antara lain:

1. Apakah terdapat pengaruh logistik terhadap keuntungan penjualan suatu produk tertentu?
2. Faktor lain apa yang memengaruhi keuntungan penjualan produk?
3. Kategori barang dan kota asal pembeli mana yang memiliki keuntungan terbesar dan terkecil?

## 📊 Dataset
- **Nama:** Brazilian E-Commerce Public Dataset by Olist
- **Sumber:** [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data?select=olist_orders_dataset.csv)
- **Format:** CSV

| Tabel | Jumlah Baris | Jumlah Kolom | Keterangan |
|---|---:|---:|---|
| olist_customers_dataset | 99.441 | 5 | Data pelanggan dan lokasi (primary key: customer_id) |
| product_category_name_translation | 74 | 2 | Terjemahan nama kategori produk |
| olist_products_dataset | 32.951 | 9 | Data produk dan dimensinya (primary key: product_id) |
| olist_orders_dataset | 99.441 | 8 | Data pesanan dan tanggal pengiriman (primary key: order_id) |
| olist_order_payments_dataset | 103.886 | 5 | Data pembayaran pesanan |
| olist_order_items_dataset | 112.650 | 7 | Data item pesanan, harga, dan biaya kurir (freight_value) |

## 🧹 Data Preparation
1. **Duplicate value:** tidak ditemukan pada seluruh tabel.
2. **Missing value:** ditemukan pada tabel `olist_products_dataset` (610 baris atau 1,85% pada kategori dan atribut deskripsi produk), `olist_orders_dataset` (kolom tanggal persetujuan dan pengiriman), serta `olist_order_items_dataset` (383 baris atau 0,34% pada `freight_value`).
   - `product_category_name` diisi dengan "Unknown"
   - Kolom numerik produk diisi dengan **median**, karena memiliki outlier sehingga rata-rata dapat menggeser nilai tengah
   - Kolom tanggal pada tabel orders diisi dengan `order_purchase_timestamp` agar dapat diubah menjadi timestamp
3. **Tipe data:** kolom tanggal pada `olist_orders_dataset` dan `shipping_limit_date` pada `olist_order_items_dataset` diubah menjadi `timestamp`.
4. **Outlier:** ditemukan pada seluruh kolom numerik, kecuali `customer_zip_code_prefix`. Outlier dianggap valid sehingga tidak dilakukan penanganan khusus (disarankan konfirmasi ke pemberi data).
5. **Feature Engineering:** dibuat kolom `durasi_hari_pengiriman` pada tabel orders untuk mengetahui lama waktu pengiriman.

## 🔍 Insight dari Data

Kategori **computers_accessories** memberikan **keuntungan terbesar (489.899)** meskipun nilai penjualannya lebih kecil daripada **bed_bath_table**, karena bed_bath_table menanggung **biaya kurir yang lebih tinggi** (217.878 dibanding 153.180) sehingga keuntungannya lebih rendah (402.172). Transaksi computers_accessories dan mayoritas kategori lain terpusat di **Sao Paulo**, yang durasi pengirimannya relatif lebih cepat dibandingkan **Goiania** dan **Rio de Janeiro**. Meski demikian, masih terdapat kombinasi kategori dan kota yang merugi, seperti **garden_tools di Cuiaba (-11.565)** dan **musical_instruments di Sao Paulo (-10.488)**, akibat modal dan biaya kurir yang lebih besar daripada penjualan. Selain itu, mayoritas transaksi berada pada kategori transaksi **sedang** (51.952 transaksi), sedangkan kategori office_furniture masih memiliki jumlah transaksi yang rendah (1.778).

## 💡 Recommendation

Disarankan untuk **mencari mitra logistik dengan biaya pengiriman yang lebih murah**, termasuk **mitra di kota Goiania dan Rio de Janeiro** agar pengiriman lebih cepat dan hemat, sehingga keuntungan dapat meningkat. Dapat dipertimbangkan pula untuk menjalankan **marketing campaign di media sosial** pada kategori dengan transaksi yang masih rendah seperti office_furniture agar lebih diperhatikan pelanggan online. Selain itu, disarankan **meninjau ulang harga barang dan diskon** agar produk tidak dijual di bawah modal dan biaya pengiriman, sekaligus untuk mendorong peningkatan transaksi berkategori besar.

## 📈 Data Manipulation dan Analisis
Analisis dilakukan menggunakan SQL dengan tahapan berikut:

- Menghitung jumlah transaksi, total sales, total biaya kurir, dan keuntungan setiap kategori barang, lalu diberi peringkat
- Menganalisis keuntungan kategori barang berdasarkan kota asal pelanggan dan durasi pengiriman
- Menampilkan kombinasi kategori dan kota dengan keuntungan terkecil (kerugian)
- Menghitung jumlah transaksi berdasarkan kategori transaksi (kecil, sedang, besar)

## 📊 Presentasi Project
Untuk melihat penjelasan lengkap dari project ini, silakan lihat slide presentasi berikut:

🔗 [Slide Presentasi](https://github.com/ahmad2129/Analisis-Keuntungan-Perusahaan-Berdasarkan-Produk-Kota-Pembeli-Biaya-Logistik-dan-Durasi-Pengiriman/blob/main/report/Presentasi%20Mini%20Project%20SQL%201%20Ahmad%20Malik%20Ibrahim.pdf)

## 🛠 Tools yang Digunakan
- **PostgreSQL** (Data Exploration, Data Cleaning, Feature Engineering, dan Analisis)

## 👤 Author
**Ahmad Malik Ibrahim**
Lulusan kedokteran dengan minat pada statistik, analisis, dan matematika, yang sedang menargetkan karir sebagai data analis.
