KELOMPOK 2 - PROGRESS PROJECT (part 1) <br />

Fradha Intan Arassah     - Technical Writer <br />
Reka Agustia Astari      - Shiny Developer <br />
Firda Aulia Maghfiroh    - Data Manager <br />
Ainun Salsabila <br />

![Skincare](https://user-images.githubusercontent.com/39205545/221737487-5c7c84e4-2b66-4d12-b7c5-43d201abf5e6.png)


Data yang digunakan pada project ini adalah `data skincare`. <br />
Data tersebut diperoleh dari google link: https://github.com/agorina91/final_project/blob/master/Dash_App_and_Models/skindataall.csv. <br />
Dalam data skincare yang digunakan, terdapat 4 independent data, yaitu `data customer`, `data problem`, `data ingredients` dan `data tipe produk`.<br />

1.	`Tabel customer`: Dalam data customer memiliki 6 kolom, diantaranya `kolom id_cust`, `nama`, `jenis_kelamin`, `usia`, `skin_type`, dan `pekerjaan`. <br />
Customer memiliki relationship terhadap data problem dengan hubungan 1:N (satu ke banyak) dengan nama table customer_ke_problem.<br />
Untuk kolom jenis kelamin akan dilakukan random generate number 0 dan 1 dengan keterangan 0 = laki-laki dan 1 = perempuan.<br />
Untuk kolom usia akan dilakukan random generate number dari 18-65 tahun.<br />
Untuk kolom pekerjaan akan dilakukan random generate number 0 dan 1 dengan keterangan 0 = karyawan dan 1 = lainnya<br />

2.	`Tabel problem` memiliki 2 kolom yaitu kolom `skin_problem`, dan `alergi`. tabel data problem_ke_ingridients dengan hubungan M:N(banyak ke banyak) memiliki 2 kolom, yaitu `skin_problem` dan `komposisi`. <br />
Dengan menggunakan data tersebut, akan dibuat riset berdasarkan permasalahan kulit untuk mengetahui kecocokan skincare seseorang berdasarkan ingredients. <br />
Kolom skin_problem berupa data kategorik <br />
Kolom alergi berupa data kategorik <br />

3.	`Tabel ingredient` memiliki 4 kolom, diantaranya `komposisi`, `merk`, `harga` dan `review`. <br />
Kolom komposisi berupa data kategorik <br />
Kolom merk/brand berupa data kategorik <br />
Kolom harga berupa numerik dalam dollar yang akan di convert ke rupiah <br />
Kolom review berupa data numerik rating skala 1-5 <br />

4.	`Tabel tipe produk`, memiliki 5 kolom, diantaranya `id_kategori`, `nama_kategori`, `tgl_produksi`, `tgl_exp` , dan `id_bpom`. Tabel problem ke tipe produk memiliki relasi M:N (banyak ke banyak) untuk melihat produk mana yang lebih sesuai untuk digunakan, Contoh permasalahan kulit yaitu bekas jerawat maka tipe produk yang cocok adalah acne spot.<br />
Kolom `id_kategori` berupa data integer <br />
Kolom `nama_kategorik` berupa data kategorik <br />
Kolom `tgl_produksi` akan di generate secara random dengan tahun minimal 2022 <br />
Kolom `tgl_exp` akan menggunakan data tgl_produksi ditambah tiga harus. <br />


Berikut, deskripsi dan query SQL untuk membuat tabel:
1.  Tabel Cust <br />
    Tabel ini merupakan tabel independet, dengan isi kolom sebagai berikut: <br />
    `id cust`       : data numerik dengan length maksimal 10, NUT NULL artinya tidak ada data yang kosong pada kolom ini, dan kolom ini merupakan PRIMARY KEY. <br />
    `nama`          : data character dengan length maksimal 20. <br />
    `jenis_kelamin` : data character dengan length maksimal 20. <br />
    `usia`          : data numerik dengan length maksimal 2. <br />
    `skin_type`     : data integer dengan keterangan 1 = kulit normal, 2= kulit berminyak, 3= kulit kering, 4 = kulit kombinasi, 5 = kulit sensitif. <br />
    `pekerjaan`     : data character dengan length maksimal 20 <br />

    ``` sql
    CREATE TABLE IF NOT EXISTS public."Cust"
    (
        id_cust numeric(10,0) NOT NULL,
        nama character(20) COLLATE pg_catalog."default" NOT NULL,
        jenis_kelamin character(10) COLLATE pg_catalog."default" NOT NULL,
        usia numeric(2,0) NOT NULL,
        skin_type integer NOT NULL,
        pekerjaan character(20) COLLATE pg_catalog."default" NOT NULL,
        CONSTRAINT "Cust_pkey" PRIMARY KEY (id_cust)
    )
    ```

2.  Tabel Ingredients <br />

    `komposisi `: data character varying dengan length maksimal 20 dan sebagai PRIMARY KEY.<br />
    `merk`      : data character varying dengan length maksimal 20.<br />
    `harga`     : data numerik dengan length maksimal 10.<br />
    `review`    : data numerik dengan length maksimal 5.<br />

    ``` sql
    CREATE TABLE IF NOT EXISTS public."Ingredients"
    (
        komposisi character varying(20) COLLATE pg_catalog."default" NOT NULL,
        merk character varying(20) COLLATE pg_catalog."default" NOT NULL,
        harga numeric(10,0) NOT NULL,
        review numeric(5,0) NOT NULL,
        CONSTRAINT "Ingredients_pkey" PRIMARY KEY (komposisi)
    )
    ```

3.  Tabel Problem<br />

    `skin_problem`  : data character dengan length maksimal 30 dan sebagai PRIMARY KEY.<br />
    `alergi`        : data character dengan length maksimal 20.<br />
    ``` sql
    CREATE TABLE IF NOT EXISTS public."Problem"
    (
        skin_problem character(30) COLLATE pg_catalog."default" NOT NULL,
        alergi character(20) COLLATE pg_catalog."default" NOT NULL,
        CONSTRAINT "Problem_pkey" PRIMARY KEY (skin_problem)
    )
    ```

4.  Tabel Tipe Produk <br />

    `id_kategori`   : data integer dengan keterangan 1 = facial wash, 2 = toner, 3 = essence, 4 = serum, 5 = moisturizer, 6 = sleeping mask dan sebagai PRIMARY KEY.<br />
    `nama_kategori` : data character dengan length maksimal 20 yang berisi keterangan dari id_kategori<br />
    `tgl_produksi`  : data tanggal produksi produk<br />
    `tgl_exp`       : data tangga expired produk<br />
    `id_bpom`       : data character varying dengan length maksimal 20.<br />

    ``` sql
    CREATE TABLE IF NOT EXISTS public."Tipe_Produk"
    (
        id_kategori integer NOT NULL,
        nama_kategori character(20) COLLATE pg_catalog."default" NOT NULL,
        tgl_produksi date NOT NULL,
        tgl_exp date NOT NULL,
        id_bpom character varying(20) COLLATE pg_catalog."default" NOT NULL,
        CONSTRAINT "Tipe_Produk_pkey" PRIMARY KEY (id_kategori)
    )
    ```

5.  Tabel Relasi Cust dan Problem <br />

    `id_cust`          : data numerik dengan length maksimal 10, NUT NULL artinya tidak ada data yang kosong pada kolom ini, dan kolom ini merupakan PRIMARY KEY. id_cust akan berelasi dengan id_cust pada tabel CUST.<br />
    `skin_problem`     : data character dengan length maksimal 30 dan sebagai PRIMARY KEY. skin_problem akan berelasi dengan skin_problem pada tabel PROBLEM.<br />

    ``` sql
    CREATE TABLE IF NOT EXISTS public."Cust_Ke_Problem"
    (
        id_cust numeric(10,0) NOT NULL,
        skin_problem character(30) COLLATE pg_catalog."default" NOT NULL,
        CONSTRAINT "Cust_Ke_Problem_pkey" PRIMARY KEY (id_cust, skin_problem),
        CONSTRAINT "Cust_Ke_Problem_fkey" FOREIGN KEY (id_cust)
            REFERENCES public."Cust" (id_cust) MATCH SIMPLE
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
        CONSTRAINT "Cust_Ke_Problem_fkey2" FOREIGN KEY (skin_problem)
            REFERENCES public."Problem" (skin_problem) MATCH SIMPLE
            ON UPDATE NO ACTION
            ON DELETE NO ACTION
    )
    ```

6.  Tabel Relasi Problem dan Ingredients <br />

    `skin_problem`  : data character dengan length maksimal 30 dan sebagai PRIMARY KEY. skin_problem akan berelasi dengan skin_problem pada tabel PROBLEM.<br />
    `komposisi`     : data character varying dengan length maksimal 20 dan sebagai PRIMARY KEY. komposisi akan berelasi dengan komposisi pada tabel INGREDIENTS.<br />

    ``` sql
    CREATE TABLE IF NOT EXISTS public."Problem_Ke_Ingridients"
    (
        skin_problem character(30) COLLATE pg_catalog."default" NOT NULL,
        komposisi character varying(20) COLLATE pg_catalog."default" NOT NULL,
        CONSTRAINT "Problem_Ke_Ingridients_pkey" PRIMARY KEY (skin_problem, komposisi),
        CONSTRAINT "Problem_Ke_Ingridients_fkey" FOREIGN KEY (skin_problem)
            REFERENCES public."Problem" (skin_problem) MATCH SIMPLE
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
        CONSTRAINT "Problem_Ke_Ingridients_fkey2" FOREIGN KEY (komposisi)
            REFERENCES public."Ingredients" (komposisi) MATCH SIMPLE
            ON UPDATE NO ACTION
            ON DELETE NO ACTION
    )
    ```

7.  Tabel Relasi Problem dan Tipe Produk<br />

    `skin_problem`  : data character dengan length maksimal 30 dan sebagai PRIMARY KEY. skin_problem akan berelasi dengan skin_problem pada tabel PROBLEM.<br />
    `id_kategori`   : data integer dengan keterangan 1 = facial wash, 2 = toner, 3 = essence, 4 = serum, 5 = moisturizer, 6 = sleeping mask dan sebagai PRIMARY KEY. id_kategori akan berelasi dengan id_kategori pada tabel TIPE_PRODUK.<br />

    ``` sql
    CREATE TABLE IF NOT EXISTS public."Problem_Ke_Tipe-Produk"
    (
        skin_problem character(30) COLLATE pg_catalog."default" NOT NULL,
        id_kategori integer NOT NULL,
        CONSTRAINT "Problem_Ke_Tipe-Produk_pkey" PRIMARY KEY (skin_problem, id_kategori),
        CONSTRAINT "Problem_Ke_Tipe-Produk_fkey" FOREIGN KEY (skin_problem)
            REFERENCES public."Problem" (skin_problem) MATCH SIMPLE
            ON UPDATE NO ACTION
            ON DELETE NO ACTION
            NOT VALID,
        CONSTRAINT "Problem_Ke_Tipe-Produk_fkey2" FOREIGN KEY (id_kategori)
            REFERENCES public."Tipe_Produk" (id_kategori) MATCH SIMPLE
            ON UPDATE NO ACTION
            ON DELETE NO ACTION
            NOT VALID
    )
    ```

sehingga, diperoleh ER Diagram dari tabel-tabel yang sudah dibuat:

![hello](https://user-images.githubusercontent.com/39205545/221522351-f02c313e-cea6-4abe-a7b1-b193072218c3.png)

