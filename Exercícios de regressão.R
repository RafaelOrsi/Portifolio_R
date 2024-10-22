#title: "Estat�stica e An�lise Multivariada"
#author: "Rafael Nobre Orsi"
#date: "April 4, 2018"

getwd()
setwd('C:/Users/Rafa/Desktop/Estat�stica e An�lise Multivariada em R') 
#L� arquivo: nomedavariavel <- read.csv("nomedoaqruivo.csv", header = TRUE(usa primeira linha como t�tulo), sep = "\t" (separador \t = tab)) 
dados <- read.csv("exercicio_de_regressao.csv", header = TRUE, sep = "\t") 

# Problema
# 1) O gerente de uma cadeia de lanchonetes deve decidir quanto gastar
# com propaganda e que atrativos, como pre�os mais baixos, deve introduzir.
# O modelo econ�mico � dado pela express�o: Rt = b0 + b1.Pr + b2.Dp, onde:
# Rt = receita total (em $1.000),
# Pr = pre�o m�dio dos produtos vendidos e
# Dp = despesa com propaganda (em $1.000).
# As vari�veis foram medidas durante 52 semanas consecutivas (amostra) conforme tabela.


# http://www.est.ufmg.br/portal/arquivos/rts/RT-SE-2009.pdf
# Apostila para usar de exemplo

summary(dados)
var(dados)
#sd(base) #dando erro

cor(dados$Rt,dados$Pr) # Correla��o
cor.test(dados$Rt,dados$Pr) # Pearson's product-moment correlation
