#' @author Szymon Kubica 264068
#'
#' @title Podzbiory
#'
#' @description
#' Funkcja \code{podzbiory} zwraca listę wszystkich swoich podzbiorów
#'
#' @param x \cr
#'  Zbiór z którego będą zwracane podzbiory (wektor liczb, tekstów itp.).
#'
#' @return Lista zawierające wszystkie mozliwe kombinacje podzbiorów
#'
#' @examples
#' podzbiory(c(1,2,3)
#' podzbiory(c("a","b","c","d")
#'
#' @export
podzbiory <- function(x)
{
  # Sprawdzenie czy x zostalo podane
  if(missing(x))
  {
    stop("Argument x musi zostac podany")
  }
  # Sprawdzenie czy x jest atomowym wektorem
  if(!is.atomic(x) || !is.null(dim(x)))
  {
    stop("X musi byc atomowym wektorem")
  }

  # Usuniecie duplikatow
  ux <- unique(x)
  n <- length(ux)

  # Lista wynikowa o odpowiedniej dlugosc 2^n
  result <- vector("list", length = 2^n)
  idx <- 1

  # Dla kazdego mozliwego rozmiaru podzbioru generowana jest kombinacja
  for(k in 0:n)
  {
    if(k==0)
    {
      result[[idx]] <- ux[FALSE]
      idx <- idx+1
    }
    else
    {
      cmb <- combn(n,k)
      m <- ncol(cmb)
      for(j in seq_len(m))
      {
        result[[idx]] <- ux[cmb[,j]]
        idx <- idx+1
      }
    }
  }

  return(result)
}

#' Źródła
#'
#' https://www.rdocumentation.org/
#' https://zpe.gov.pl/a/podzbiory-zbioru-skonczonego-tresc-rozszerzona/DUzQbD05Q


