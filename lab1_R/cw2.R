wspolne <- function(a,b)
{
  if(is.list(a) == FALSE || is.list(b) == FALSE)
  {
     return(FALSE)
  }
  
  rV <- list()
  
  for (i in seq_along(a))
  {
    for (j in seq_along(b))
    {
      if(a[[i]] == b[[j]])
      {
        rV[length(rV)] <- a[i]
      }
    }
  }
  
  return(unique(rV))
}

a <- list(1,2,1,4)
b <- list(2,5,4,1)

part <- wspolne(a,b)
print(part)