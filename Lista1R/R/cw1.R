#'
#' @author Szymon Kubica 264068
#'
#' Oblicza pola trójkąta według wzoru Herona
#'
#' Funkcja \code{heron} oblicza pole trójkąta dla podanych długości boków
#' za pomocą wozru Herona. Sprawdza poprawność argumentów i
#' istnienie trójkąta.
#'
#' @param a Długość boku a (liczba dodatnia)
#' @param b Długość boku b (liczba dodatnia)
#' @param c Długość boku c (liczba dodatnia)
#'
#' @return Pole trójkąta
#'
#' @examples
#' heron(3,4,5) # = 6
#' heron(5,5,6) # =~12
#'
#' @export
heron <- function(a,b,c)
{
  # Sprawdzenie czy argumenty są liczbami
  if (!is.numeric(a) || !is.numeric(b) || !is.numeric(c))
  {
    stop("Wszystkie boki muszą być liczbą!")
  }

  # Sprawdzenie czy argumenty nie są listą/wektorem etc
  if (length(a) != 1|| length(b) != 1 || length(c) != 1)
  {
    stop("Każdy bok musi być pojedyńczą wartością!")
  }

  # Sprawdzenie czy argumenty są dodatnie
  if(a<=0 || b<=0 || c<=0)
  {
    stop("Kazdy bok musi być dodatni!")
  }

  # Sprawdzenie warunku na istnienie trójkąta
  if(a+b<=c || a+c<=b || b+c<=a)
  {
    stop("Trójkąt o podanych bokach nie istnieje!")
  }

  # Oblicze pola wzorem Herona
  p <- (a+b+c)/2 # połowa obwodu
  s <- sqrt(p*(p-a)*(p-b)*(p-c))

  # Zwrócenie pola
  return(s)
}

#' Bibliografia
#'
#' https://www.rdocumentation.org/
#' https://cloud2.edupage.org/cloud/Warunek_istnienia_trojkata.pdf?z%3ATcDy75Cy0k9qN6ymFUp%2BxFnx0I7929qd%2BsXqx8CdY063%2FTK5b80u%2F%2Fm9mOtpHsDc
#' https://pl.wikipedia.org/wiki/Wz%C3%B3r_Herona
