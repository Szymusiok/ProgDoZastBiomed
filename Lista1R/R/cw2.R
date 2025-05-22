#' @author Szymon Kubica 264068
#'
#' @title Część wspólna dwóch multizbiorów
#'
#' @description
#' Funkcja \code{wspolne} zwraca multizbiór bedący częścią wspólną
#' dwóch podanych wektorów \code{x} i \code{y}.
#'
#' @param x \cr
#'  Pierwszy multizbiór (wektor liczb, tekstów itp.).
#' @param y \cr
#'  Drugi multizbiór (wektor tego samego typu co \code{x})
#'
#' @return Ten sam typ co \code{x,y}: wektor zawierający elementy
#' wspólne, powtórzone minimalną liczbę razy. Jeżeli nie ma wspólnych
#' elementów, zwraca wektor długośći 0.
#'
#' @examples
#' wspolne(c(1,2,3), c(2,2,4)) # -> c(2)
#' wspolne(c("a","b","a"), c("b","b")) # -> "b"
#'
#' @export
wspolne <- function(x,y)
{
  # Oba argumenty muszą byc podane
  if(missing(x) || missing(y))
  {
    stop("Oba argumenty muszą być podane")
  }
  # Muszą być to atomowe wektory
  if(!is.atomic(x) || !is.atomic(y))
  {
    stop("Oba argumenty muszą być atomowymi wektorami")
  }
  # Typy muszą się zgadzać
  if (typeof(x) != typeof(y)) {
    stop("Oba argumenty muszą być tego samego typu")
  }

  result <- intersect(x, y)

  return(result)
}




















