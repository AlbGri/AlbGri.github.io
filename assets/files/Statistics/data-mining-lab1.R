########################################################
# Obiettivo: confrontare 3 stimatori della media 
########################################################

# funzione simulazione
sim1 <- function(N=10, n=30, mu=10, sigma=1, seme=1, type="matrix"){
  # registro il tempo
  starting_time <- Sys.time()
  
  # inizializzo counter e contenitori
  i <- 0
  avg <- NULL
  int_modlin <- NULL
  int_modquad <- NULL
  
  # variabile esplicativa
  x <- c(0,seq(1,n-2,1)/(n-1),1)
  
  # stima mediante algebra
  if(type=="matrix"){
    # X modlin
    X_1 <- model.matrix(~x)
    W_1 <- solve(t(X_1)%*%X_1)%*%t(X_1)
    # X modquad
    X_2 <- model.matrix(~x+I(x^2))
    W_2 <- solve(t(X_2)%*%X_2)%*%t(X_2)
    # seme
    set.seed(seme)
    # loop
    while(i<N){
      i <- i+1
      y <- rnorm(n = n, mean = mu, sd = sigma)
      # media aritmetica
      avg <- c(avg, mean(y))
      # intercetta modello regressione lineare, con x indipendente da y
      int_modlin <- c(int_modlin, (W_1%*%y)[1])
      # intercetta modello regressione quadratica, con x indipendente da y
      int_modquad <- c(int_modquad, (W_2%*%y)[1])
    }
  }
  
  # stima mediante comando lm
  if(type=="lm"){
    # seme
    set.seed(seme)
    # loop
    while(i<N){
      i <- i+1
      y <- rnorm(n = n, mean = mu, sd = sigma)
      # media aritmetica
      avg <- c(avg, mean(y))
      # intercetta modello regressione lineare, con x indipendente da y
      int_modlin <- c(int_modlin, lm(y~x)$coefficients[[1]])
      # intercetta modello regressione quadratica, con x indipendente da y
      int_modquad <- c(int_modquad, lm(y~x+I(x^2))$coefficients[[1]])
    }
  }

  result <- data.frame(avg=avg, int_modlin=int_modlin, int_modquad=int_modquad)
  tempo <- Sys.time()-starting_time
  print(paste("Tempo utilizzato:", round(tempo[[1]], 2),  units(tempo)))
  return(result)
}

# Genero risultati
df1 <- sim1(N=10000, type="matrix")
# "Tempo utilizzato: 0.57 secs"
df2 <- sim1(N=10000, type="lm")
# "Tempo utilizzato: 14.94 secs"

# Gli output sono identici ma il primo approccio molto più rapido
all(all(round(df1,9)==round(df2,9)))
# true

# media degli stimatori
sapply(df1, mean)

# varianza degli stimatori
sapply(df1, var)
# l'aumento di parametri da stimare ne diminuisce la precisione del singolo

# errore quadratico medio degli stimatori
sapply(df1, function(x) mean((x-10)^2))
# l'MSE si decompone in varianza più distorsione, che è nulla a meno di micro oscillazioni, quindi è uguale alla varianza












