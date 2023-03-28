library(shiny)
library(shinydashboard)
library(RPostgreSQL)
library(DBI)
library(DT)

dashboardPage(skin = "red",
  title = "MySkincare",
  dashboardHeader(
    title = "MySkincare"),
  dashboardSidebar(sidebarMenu
    (menuItem(
      "Skincare??",
      tabName = "penjelasan1",
      icon = icon("question-circle")),
      menuSubItem(
        "Daftar Cust",
        tabName = "cust",
        icon = icon("people-line")),
      menuSubItem(
        "Daftar Skin Type",
        tabName = "st",
        icon = icon("bookmark")),
      menuSubItem(
        "Daftar Produk",
        tabName = "produk",
        icon = icon("box")),
      menuSubItem(
        "Daftar Brand",
        tabName = "brand",
        icon = icon("list-alt")),
      menuSubItem(
        "Daftar Skin Problem",
        tabName = "problem",
        icon = icon("user")),
      menuSubItem(
        "Daftar ID-Kategori",
        tabName = "kp",
        icon = icon("list-alt"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem("penjelasan1", h4("Skincare adalah serangkaian kegiatan perawatan kulit yang mendukung kesehatan dan kecantikan kulit. Pembersih wajah, pelembap, hingga tabir surya adalah berbagai produk perawatan kulit atau skincare yang umum digunakan
                                manfaat menggunakan skincare adalah dapat membantu menjaga kesehatan kulit secara keseluruhan sekaligus memperbaiki masalah kulit yang dialami, seperti jerawat, bekas jerawat, bintik hitam, keriput, dan lainnya.")),
      tabItem(tabName = "cust",h2("Daftar Cust"),dataTableOutput(outputId = "Cust")),
      tabItem(tabName = "st",h2("Daftar Skin Type"),dataTableOutput(outputId="Skin_Type")),
      tabItem(tabName = "produk",h2("Daftar Produk"),dataTableOutput(outputId="produk")),
      tabItem(tabName = "brand",h2("Daftar Brand"),dataTableOutput(outputId="Brand")),
      tabItem(tabName = "problem",h2("Daftar Skin Problem"),dataTableOutput(outputId="Problem")),
      tabItem(tabName = "kp",h2("Daftar ID-Kategori"),dataTableOutput(outputId="Kategori_Produk"))
)))


