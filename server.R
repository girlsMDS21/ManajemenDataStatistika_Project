connectDB <- function() {
  driver <- dbDriver('PostgreSQL')
  DB <- dbConnect(
    driver,
    dbname="oyardejo", 
    host="topsy.db.elephantsql.com",
    #port=5432,
    user="oyardejo",
    password="BHiNqyrnOkWfBY8fDOjKv1BmcPGeuQ7_"
  )
}

function(input, output) {
  output$Cust <- renderDataTable({
    DB <- connectDB()
    q <- paste0('SELECT
                       c.id_cust, c.username, c.gender, c.age,
                       c.job, st.skin_type

                       FROM "Cust" as c, "Skin_Type" as st
                       WHERE
                                  c.id_skin_type = st.id_skin_type
                                   ;')
    Cust <- dbGetQuery(DB, q)  
    dbDisconnect(DB)
    Cust
  })
  output$Brand <- renderDataTable({
    DB <- connectDB()
    Brand <- dbReadTable(DB, 'Brand')
    dbDisconnect(DB)
    
    Brand
  })
  output$Problem <- renderDataTable({
    DB <- connectDB()
    Problem <- dbReadTable(DB, 'Problem')
    dbDisconnect(DB)
    
    Problem
  })
  output$Skin_Type <- renderDataTable({
    DB <- connectDB()
    Skin_Type <- dbReadTable(DB, 'Skin_Type')
    dbDisconnect(DB)
    
    Skin_Type
  })
  output$Kategori_Produk<- renderDataTable({
    DB <- connectDB()
    Kategori_Produk <- dbReadTable(DB, 'Kategori_Produk')
    dbDisconnect(DB)
    
    Kategori_Produk
  })
  output$produk <- renderDataTable({
    DB <- connectDB()
    q <- paste0('SELECT
                       y.id_cust, b.nama_brand,y.nama_produk, u.kategori, y.rating, y.harga

                       FROM "Produk" as y, "Brand" as b, "Kategori_Produk" as u 
                       WHERE
                                  y.id_brand = b.id_brand
                                  AND y.id_kategori = u.id_kategori
                                   ;')
    produk <- dbGetQuery(DB, q)  
    dbDisconnect(DB)
    
    produk
  })
}
