#' @author Szymon Kubica 264068
#'
#' @title Fibonacci
#'
#' @description
#' Funkcja \code{fibonacci} zwraca listę \code{n} pierwszych wyrazow ciągu fibonnaciego.
#' Domyślnie używa rekurencji ale ustawiając parametr \code{iter} na TRUE używa wersji iteracyjnej
#'
#' @param n \cr
#'  Liczba okreslajaca ile wyrazow ciagu fibonnaciego zwrocic
#'
#' @param iter \cr
#'  Gdy ustawione na TRUE, uzywana jest wersja iteracyjna
#'
#' @return Lista zawierające \code{n} pierwszych wyrazow ciagu fibonnaciego
#'
#' @examples
#' fibonacci(5)
#' fibonacci(9, iter = TRUE)
#'
#' @export
fibonacci <- function(n, iter = FALSE)
{
  # Walidacja n
  if(missing(n))
  {
    stop("Argument 'n' musi zostac podany")
  }
  if(!is.numeric(n) || length(n) !=1 || n<1 || n != as.integer(n))
  {
    stop("Argument 'n' musi byc pojedyncza liczba calkowita")
  }
  n <- as.integer(n)

  # Logika wyboru wariantu
  if(iter)
  {
    # Iteracyjna wersja O(n)
    if (n == 1L)
    {
      return(1L)
    }
    result <- integer(n)
    result[1] <- 1L
    result[2] <- 1L

    if(n>=3)
    {
      for(i in 3:n)
      {
       result[i] <- result[i-2] + result[i-1]
      }
    }
    return(result)
  }
  else
  {
    # Rekurencyjna wersja O(2^n)
    if(n==1L)
    {
      return(1L)
    }
    if(n==2L)
    {
      return(c(1L,1L))
    }
    prev <- fibonacci(n-1L)
    next_val <- prev[length(prev)] + prev[length(prev) - 1L]
    return(c(prev, next_val))
  }
}


#' Źródła
#'
#' https://www.rdocumentation.org/



