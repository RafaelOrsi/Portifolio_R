#title: "Estatística e Análise Multivariada"
#author: "Rafael Nobre Orsi"
#date: "April 4, 2018"

getwd()
setwd('C:/Users/Rafa/Desktop/Estatística e Análise Multivariada em R') 
#Lê arquivo: nomedavariavel <- read.csv("nomedoaqruivo.csv", header = TRUE(usa primeira linha como título), sep = "\t" (separador \t = tab)) 
dados <- read.csv("exercicio_de_regressao.csv", header = TRUE, sep = "\t") 

# Problema
# 1) O gerente de uma cadeia de lanchonetes deve decidir quanto gastar
# com propaganda e que atrativos, como preços mais baixos, deve introduzir.
# O modelo econômico é dado pela expressão: Rt = b0 + b1.Pr + b2.Dp, onde:
# Rt = receita total (em $1.000),
# Pr = preço médio dos produtos vendidos e
# Dp = despesa com propaganda (em $1.000).
# As variáveis foram medidas durante 52 semanas consecutivas (amostra) conforme tabela.


# http://www.est.ufmg.br/portal/arquivos/rts/RT-SE-2009.pdf
# Apostila para usar de exemplo

summary(dados)
var(dados)
#sd(base) #dando erro

cor(dados$Rt,dados$Pr) # Correlação
cor.test(dados$Rt,dados$Pr) # Pearson's product-moment correlation
