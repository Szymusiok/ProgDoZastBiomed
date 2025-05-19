heron <- function(a,b,c)
{
  if ((a+b<=3 || a+c<=b || b+c<=a) || (a<=0 ||b<=0 || c<=0))
  {
    return (-1)
  }
  
  s <- (a+b+c)/2
  
  area <- sqrt(s*(s-a)*(s-b)*(s-c))
  
  return (area)
}

area <- heron(2,3,4)
print(area)