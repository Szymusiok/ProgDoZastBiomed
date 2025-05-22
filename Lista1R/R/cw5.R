#' @author Szymon Kubica 264068
#'
#' @title Collatz
#'
#' @description
#' Funkcja \code{collatz} zwraca wszystkie elementy ciągu przed wpadnięciem w cykl
#'
#' @param c \cr
#'  Zadany parametr
#' @param print \cr
#'  Decyduje czy wyswietlac informacje o dlugosci i maksymalnej wartosci ciagu
#'
#' @return Lista zawierające wszystkie elementy ciągu przed wpadnięciem w cykl
#'
#' @examples
#' collatz(5)
#' collatz(9)
#'
#' @export
collatz <- function(c0, print = FALSE)
{
  # Sprawdzenie warunkow
  if(missing(c0))
  {
    stop("Argument c musi byc podany")
  }
  if(!is.numeric(c0) || length(c0) != 1 || c0 < 1 || c0 != as.integer(c0))
  {
    stop("Argument c musy byc pojedyncza liczba naturalna")
  }

  seq <- as.integer(c0)
  current = c0
  maxVal = 0

  # Generujemy az do pierwszego pojawienia sie 1
  while(TRUE)
  {
    if(current == 1L || current == 2L || current == 4L)
    {
      if(print)
      {
        cat("Dlugosc ciagu: ",length(seq)-1, ". Max: ",maxVal,"\n")
      }
      break
    }

    current <- if(current %% 2L == 0L) current / 2L else 3L * current + 1L
    seq <- c(seq,current)
    if(current > maxVal)
    {
      maxVal = current
    }
  }

  return(seq[-length(seq)])
}

#' Źródła
#'
#' https://www.rdocumentation.org/
