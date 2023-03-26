library(shiny)
library(shinydashboard)
library(RPostgreSQL)
library(DBI)
library(DT)
library(plotly)

dashboardPage(skin = "red",
              title = "MySkincare",
              dashboardHeader(
                title = "MySkincare"),
              dashboardSidebar(sidebarMenu
                               (menuItem(
                                 "Daftar Cust",
                                 tabName = "Cust",
                                 icon = icon("people-line")),
                                 menuItem(
                                   "Daftar Skin Type",
                                   tabName = "Skin_Type",
                                   icon = icon("bookmark")),
                                 menuItem(
                                   "Daftar Produk",
                                   tabName = "Produk",
                                   icon = icon("box")),
                                 menuItem(
                                   "Daftar Brand",
                                   tabName = "Brand",
                                   icon = icon("list-alt")),
                                 menuItem(
                                   "Daftar Skin Problem",
                                   tabName = "Problem",
                                   icon = icon("user")),
                                 menuItem(
                                   "Daftar ID-Kategori",
                                   tabName = "Kategori_Produk",
                                   icon = icon("list-alt"))
                               )
              ),
              
              dashboardBody(
                tabItems(
                  tabItem(tabName = "Cust",h2("Daftar Cust"),dataTableOutput(outputId = "Cust")),
                  tabItem(tabName = "Skin_Type",h2("Daftar Skin Type"),dataTableOutput(outputId="Skin_Type")),
                  tabItem(tabName = "Produk",h2("Daftar Produk"),dataTableOutput(outputId = "Produk")),
                  tabItem(tabName = "Brand",h2("Daftar Brand"),dataTableOutput(outputId="Brand")),
                  tabItem(tabName = "Problem",h2("Daftar Skin Problem"),dataTableOutput(outputId="Problem")),
                  tabItem(tabName = "Kategori_Produk",h2("Daftar ID-Kategori"),dataTableOutput(outputId="Kategori_Produk"))
                )))