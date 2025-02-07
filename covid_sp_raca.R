# Carregar pacotes
library(dplyr)
library(readxl)

# Abrir diret�rio
setwd("C:/Users/FAZ/Desktop/ProjetoDadosR/dados-covid-sp-master/data")

# Abrir arquivo
covid_sp_raca <- read.csv2('casos_obitos_raca_cor.csv', sep = ";", encoding="UTF-8")
head(covid_sp_raca)


# Renomear algumas colunas
covid_sp_raca_alterado <- rename(covid_sp_raca, municipio = nome_munic,
                                 dpto_regional = nome_drs, sexo = cs_sexo)

# Excluir colunas
covid_sp_raca_alterado <- select(covid_sp_raca_alterado, -c(1))

# Excluir linhas
covid_sp_raca_alterado <- covid_sp_raca_alterado %>% filter(raca_cor!="Ignorado")

# Ap�s a primeira exclus�o percebi que ainda tinha "IGNORADO" em mai�sculo
covid_sp_raca_alterado <- covid_sp_raca_alterado %>% filter(raca_cor!="IGNORADO")

# Verificando valores ausentes
sapply(covid_sp_raca_alterado, function(x) sum(is.na(x)))
sapply(covid_sp_raca_alterado, function(x) sum(is.nan(x)))

# Carregar pacotes
library(tidyr)

# Substituindo NA por 0, entendo que nessa an�lise faz sentido
covid_sp_raca_alterado2 <- covid_sp_raca_alterado %>% mutate_all(replace_na, 0)

# Verificar como o R est� lendo os dados
str(covid_sp_raca_alterado2)
glimpse(covid_sp_raca_alterado2)

# Transformando a coluna "idade" em n�meros inteiros
covid_sp_raca_alterado2$idade <- as.integer(covid_sp_raca_alterado2$idade)
str(covid_sp_raca_alterado2)

# Exporta��o de arquivos
write.table(covid_sp_raca_alterado2, file ="covid_sp_raca_tratado.csv", sep = ",")
