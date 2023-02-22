KELOMPOK 2 - PROGRESS PROJECT (part 1)

Fradha Intan Arassah - Technical Writer

Reka Agustia Astari - Shiny Developer

Firda Aulia Maghfiroh - Data Manager

Ainun Salsabila

Berikut, deskripsi dan query SQL untuk membuat tabel:

1.  Tabel Cust

    Tabel ini merupakan tabel independet, dengan isi kolom sebagai berikut:

    id cust: data numerik dengan length maksimal 10, NUT NULL artinya tidak ada data yang kosong pada kolom ini, dan kolom ini merupakan PRIMARY KEY.

    nama: data character dengan length maksimal 20.

    jenis_kelamin: data character dengan length maksimal 20.

    usia: data numerik dengan length maksimal 2.

    skin_type: data integer dengan keterangan 1 = kulit normal, 2= kulit berminyak, 3= kulit kering, 4 = kulit kombinasi, 5 = kulit sensitif.

    pekerjaan: data character dengan length maksimal 20

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

2.  Tabel Ingredients

    komposisi: data character varying dengan length maksimal 20 dan sebagai PRIMARY KEY.

    merk: data character varying dengan length maksimal 20.

    harga: data numerik dengan length maksimal 10.

    review: data numerik dengan length maksimal 5.

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

3.  Tabel Problem

    skin_problem: data character dengan length maksimal 30 dan sebagai PRIMARY KEY.

    alergi: data character dengan length maksimal 20.

    ``` sql
    CREATE TABLE IF NOT EXISTS public."Problem"
    (
        skin_problem character(30) COLLATE pg_catalog."default" NOT NULL,
        alergi character(20) COLLATE pg_catalog."default" NOT NULL,
        CONSTRAINT "Problem_pkey" PRIMARY KEY (skin_problem)
    )
    ```

4.  Tabel Tipe Produk

    id_kategori: data integer dengan keterangan 1 = facial wash, 2 = toner, 3 = essence, 4 = serum, 5 = moisturizer, 6 = sleeping mask dan sebagai PRIMARY KEY.

    nama_kategori: data character dengan length maksimal 20 yang berisi keterangan dari id_kategori

    tgl_produksi: data tanggal produksi produk

    tgl_exp: data tangga expired produk

    id_bpom: data character varying dengan length maksimal 20.

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

5.  Tabel Relasi Cust dan Problem

    id_cust: data numerik dengan length maksimal 10, NUT NULL artinya tidak ada data yang kosong pada kolom ini, dan kolom ini merupakan PRIMARY KEY. id_cust akan berelasi dengan id_cust pada tabel CUST.

    skin_problem: data character dengan length maksimal 30 dan sebagai PRIMARY KEY. skin_problem akan berelasi dengan skin_problem pada tabel PROBLEM.

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

6.  Tabel Relasi Problem dan Ingredients

    skin_problem: data character dengan length maksimal 30 dan sebagai PRIMARY KEY. skin_problem akan berelasi dengan skin_problem pada tabel PROBLEM.

    komposisi: data character varying dengan length maksimal 20 dan sebagai PRIMARY KEY. komposisi akan berelasi dengan komposisi pada tabel INGREDIENTS.

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

7.  Tabel Relasi Problem dan Tipe Produk

    skin_problem: data character dengan length maksimal 30 dan sebagai PRIMARY KEY. skin_problem akan berelasi dengan skin_problem pada tabel PROBLEM.

    id_kategori: data integer dengan keterangan 1 = facial wash, 2 = toner, 3 = essence, 4 = serum, 5 = moisturizer, 6 = sleeping mask dan sebagai PRIMARY KEY. id_kategori akan berelasi dengan id_kategori pada tabel TIPE_PRODUK.

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

![](images/hello-01.png)
