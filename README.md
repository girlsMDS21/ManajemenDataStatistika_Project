<img width="150" alt="Skincare" src="https://user-images.githubusercontent.com/39205545/224728354-0909553e-6dd6-490d-9a59-14e067591912.png">

# My Skincare

# Menu

\- [Tentang](#scroll-overview)

\- [Screenshot](#rice_scene-screenshot)

\- [Demo](#dvd-demo)

\- [Dokumentasi](#blue_book-documentation)

\- [Requirements](#exclamation-requirements)

\- [Skema Database](#floppy_disk-skema-database)

\- [ERD](#rotating_light-erd)

\- [Deskripsi Data](#heavy_check_mark-deskripsi-data)

\- [Struktur Folder](#open_file_folder-stuktur-folder)

\- [Tim Pengembang](#smiley_cat-tim-pengembang)

## Tentang

Data yang digunakan pada project ini adalah data skincare. Data tersebut diperoleh dari hasil scrapping dan google dengan link: <https://github.com/agorina91/final_project/blob/master/Dash_App_and_Models/skindataall.csv.>

## Screenshot Shiny
![ss](https://user-images.githubusercontent.com/39205545/224727119-3ebf841f-0d76-4fc6-a2dd-cae3509ec61e.png)

## Skema

<img width="500" alt="Skema Database" src="https://user-images.githubusercontent.com/39205545/224727239-e6227c6a-363b-4302-a598-500f4c46f357.png">


## ER Diagram

<img width="500" alt="ERD update" src="https://user-images.githubusercontent.com/39205545/224727336-cc4703de-30c1-4814-a8da-fc45f747cb17.png">


## Deskripsi Data

Data yang digunakan pada project ini adalah `data skincare`.\
Data tersebut diperoleh dari google link: <https://github.com/agorina91/final_project/blob/master/Dash_App_and_Models/skindataall.csv>.\
Dalam database skincare yang dikembangkan, terdapat 6 tabel yang saling berelasi, yaitu `customer`, `problem`, `produk`, `brand`, `kategori_produk`, dan `skin_type`.\

1.  `Tabel customer`: Dalam data customer memiliki 6 kolom, diantaranya `kolom id_cust`, username, `gender`, `age`, `id_skin_type`, dan `job`.\
    Customer memiliki relationship terhadap data problem dengan hubungan 1:N (satu ke banyak)\
    Untuk kolom jenis kelamin akan dilakukan random generate number 0 dan 1 dengan keterangan 0 = laki-laki dan 1 = perempuan.\
    Untuk kolom usia akan dilakukan random generate number dari 18-65 tahun.\
    Untuk kolom pekerjaan akan dilakukan random generate number 0 dan 1 dengan keterangan 0 = karyawan dan 1 = lainnya\

2.  `Tabel Problem` memiliki 3 kolom yaitu `id_cust`, `skin_problem`, dan `alergi`.\
    Dengan menggunakan data tersebut, akan dibuat riset berdasarkan permasalahan kulit untuk mengetahui kecocokan skincare seseorang berdasarkan ingredients.

    Satu id_cust memiliki permasalahan kulit yang berbeda-beda, namun dari beberapa orang pasti ada juga yang memiliki permasalahan kulit yang sama.\
    Kolom skin_problem berupa data kategorik\
    Kolom alergi berupa data kategorik\

3.  `Tabel Produk` memiliki 7 kolom, diantaranya `id_cust`, `id_brand` , `nama_produk`, `komposisi`, `id-kategori`, `harga` dan `rating`.\
    id_brand merupakan data kategori yang memiliki hubungan 1:1 dengan nama_brand yang dijelaskan pada kolom Brand. Namun, cust mungkin saja memakai brand yang sama meskipun produk berbeda. Sehingga cust ke brand memiliki hubungan M:N(banyak ke banyak) dan brand ke nama_produk memilikihubungan 1:N (satu ke banyak, karena satu brand mempunyai banyak nama_produk).

    Kolom komposisi berupa data text.

    Kolom id_kategori berupada data integer yang akan dijelaskan dalam kolom Kategori_Produk.\
    Kolom harga berupa data integer dalam rupiah.\
    Kolom rating berupa data double precision rating skala 1-5.\

4.  `Tabel Kategori_Produk`, memiliki 2 kolom, diantaranya `id_kategori` dan `kategori`.\
    Kolom `id_kategori` berupa data integer\
    Kolom `kategorik` berupa data text yang menjelaskan keterangan dari id_kategori.

5.  `Tabel Skin_Type`, memiliki 2 kolom, diantaranya `id_skin_type` dan `skin_type`.\
    Kolom `id_skin_type` berupa data integer\
    Kolom `skin_type` berupa data text yang menjelaskan keterangan dari id_skin_type.

6.  `Tabel Brand` , memiliki 2 kolom, diantaranya `id_brand` dan `nama_brand`.\
    Kolom `id_brand` berupa data integer\
    Kolom `nama_brand` berupa data text yang menjelaskan keterangan dari id_brand

Berikut, deskripsi dan query SQL untuk membuat tabel:

1.  Tabel Cust\
    Tabel ini memiliki isi kolom sebagai berikut:\
    `id cust` : data integer dengan length maksimal 10, NUT NULL artinya tidak ada data yang kosong pada kolom ini, dan kolom ini merupakan PRIMARY KEY yang berhubungan dengan tabel problem.\
    `username` : data text dengan length maksimal 20.\
    `gender` : data integer\
    `age` : data integer\
    `id_skin_type` : data integer dengan keterangan 1 = kulit normal, 2= kulit berminyak, 3= kulit kering, 4 = kulit kombinasi, 5 = kulit sensitif. Kolom ini merupakan PRIMARY KEY yang berhubungan dengan tabel skin_type\
    `job` : data integer

``` sql
CREATE TABLE IF NOT EXISTS public."Cust"
(
    id_cust integer NOT NULL,
    username text COLLATE pg_catalog."default" NOT NULL,
    gender integer NOT NULL,
    age integer NOT NULL,
    job integer NOT NULL,
    id_skin_type integer NOT NULL,
    CONSTRAINT "Cust_pkey" PRIMARY KEY (id_cust, id_skin_type),
    CONSTRAINT "Cust_Ke_Problem" FOREIGN KEY (id_cust)
        REFERENCES public."Problem" (id_cust) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "Cust_Ke_SkinType" FOREIGN KEY (id_skin_type)
        REFERENCES public."Skin_Type" (id_skin_type) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
```

2.  Tabel Problem

    Tabel ini memiliki isi kolom sebagai berikut:

    `id_cust`: data integer dengan length maksimal 10, NUT NULL artinya tidak ada data yang kosong pada kolom ini, dan kolom ini merupakan PRIMARY KEY karena berhubungan dengan tabel cust dan tabel produk

    `skin_problem` : data text karena setiap cust mempunyai permasalahan kulit yang berbeda-beda.

    `alergi`: data tiap cust memiliki alergi terhadap suatu ingredients atau tidak.

    ``` sql
    CREATE TABLE IF NOT EXISTS public."Problem"
    (
        id_cust integer NOT NULL,
        skin_problem text COLLATE pg_catalog."default" NOT NULL,
        alergi text COLLATE pg_catalog."default" NOT NULL,
        CONSTRAINT "Problem_pkey" PRIMARY KEY (id_cust)
    )
    ```

    3.  Tabel Produk

        Tabel ini memiliki isi kolom sebagai berikut:

        `id_cust` : data integer dengan length maksimal 10, NUT NULL artinya tidak ada data yang kosong pada kolom ini, dan kolom ini merupakan PRIMARY KEY karena berhubungan dengan tabel produk

        `id_brand` : data integer karena dari 100 data cust yang digunakan, terdapat duplicate pada brand yang mereka gunakan, sehingga harus dikategorikan menjadi 52 kategori brand. Kolom ini merupakan PRIMARY KEY dan berhubungan dengan tabel brand.

        `nama_produk` : setiap brand memiliki nama produk yang berbeda-beda sekalipun produk tersebut dari kategori yang sama.

        `komposisi` : setiap produk memiliki komposisi yang berbeda-beda

        `id-kategori` : data integer karena dari 100 data cust yang digunakan, terdapat duplicate pada kategori produk yang mereka gunakan, sehingga harus dikategorikan menjadi 14 kategori produk. Kolom ini merupakan PRIMARY KEY dan berhubungan dengan tabel kategori_produk.

        `harga` : data integer hasil dari scrapping data di internet. Harga yang tertera pada kolom ini sudah dalam rupiah.

        `rating` : data double precision dengan skala rating 1-5.

        ``` sql
        CREATE TABLE IF NOT EXISTS public."Produk"
        (
            id_cust integer NOT NULL,
            id_brand integer NOT NULL,
            nama_produk text COLLATE pg_catalog."default" NOT NULL,
            komposisi text COLLATE pg_catalog."default" NOT NULL,
            id_kategori integer NOT NULL,
            rating double precision NOT NULL,
            harga integer NOT NULL,
            CONSTRAINT "Produk_pkey" PRIMARY KEY (id_kategori, id_brand, id_cust),
            CONSTRAINT "Produk_ke_Brand_fkey" FOREIGN KEY (id_brand)
                REFERENCES public."Brand" (id_brand) MATCH SIMPLE
                ON UPDATE NO ACTION
                ON DELETE NO ACTION
                NOT VALID,
            CONSTRAINT "Produk_ke_Kategori" FOREIGN KEY (id_kategori)
                REFERENCES public."Kategori_Produk" (id_kategori) MATCH SIMPLE
                ON UPDATE NO ACTION
                ON DELETE NO ACTION
                NOT VALID,
            CONSTRAINT "Produk_ke_Problem" FOREIGN KEY (id_cust)
                REFERENCES public."Problem" (id_cust) MATCH SIMPLE
                ON UPDATE NO ACTION
                ON DELETE NO ACTION
                NOT VALID
        )
        ```

<!-- -->

4.  Tabel Skin_Type

    Tabel ini memiliki isi kolom sebagai berikut:

    `id_skin_type` : berupa data integer dan PRIMARY KEY karena memiliki relasi dengan tabel cust\
    `skin_type` : berupa data text yang menjelaskan keterangan dari id_skin_type.

    ``` sql
    CREATE TABLE IF NOT EXISTS public."Skin_Type"
    (
        id_skin_type integer NOT NULL,
        skin_type text COLLATE pg_catalog."default",
        CONSTRAINT "Skin_Type_pkey" PRIMARY KEY (id_skin_type)
    )
    ```

5.  Tabel Brand

    Tabel ini memiliki isi kolom sebagai berikut:

    `id_brand` : berupa data integer dan PRIMARY KEY karena memiliki relasi dengan tabel produk\
    `nama_brand` : berupa data text yang menjelaskan keterangan dari id_brand.

    ``` sql
    CREATE TABLE IF NOT EXISTS public."Brand"
    (
        nama_brand text COLLATE pg_catalog."default" NOT NULL,
        id_brand integer NOT NULL,
        CONSTRAINT "Brand_pkey" PRIMARY KEY (id_brand)
    )
    ```

6.  Tabel Kategori_Produk

    Tabel ini memiliki isi kolom sebagai berikut:

    `id_kategori` : berupa data integer dan PRIMARY KEY karena memiliki relasi dengan tabel produk\
    `kategori` : berupa data text yang menjelaskan keterangan dari id_kategori.

    ``` sql
    CREATE TABLE IF NOT EXISTS public."Kategori_Produk"
    (
        id_kategori integer NOT NULL,
        kategori text COLLATE pg_catalog."default" NOT NULL,
        CONSTRAINT "Kategori_Produk_pkey" PRIMARY KEY (id_kategori)
    )
    ```

## Link Rshiny

<https://rekaagustiaastari.shinyapps.io/MySkincare/>

## Tim Pengembang

Fradha Intan Arassah : Data Manager

Reka Agustia Astari : Rshiny

Firda Aulia Maghfiroh : Tech Writer

Ainun Salsabila
