library(testthat)
library(Lista1R)

context("Zadanie 3")

test_that("podzbiory: poprawne przypadki", {
  expect_equal(podzbiory(character(0)),list(character(0)))
  expect_equal(podzbiory(5),list(numeric(0), 5))
  expect_equal(podzbiory(1:2),list(integer(0), 1L, 2L, 1:2))
  expect_equal(podzbiory(c(1, 2, 3)),list(numeric(0),1, 2, 3,c(1,2), c(1,3), c(2,3),c(1,2,3)))
  expect_equal(podzbiory(c("a","b")),list(character(0), "a", "b", c("a","b")))
  expect_equal(podzbiory(c(TRUE, FALSE)),list(logical(0), TRUE, FALSE, c(TRUE, FALSE)))
  expect_equal(podzbiory(c("x","y","z"))[[4]],c("z"))
  expect_equal(podzbiory(c(1,1,2)),podzbiory(c(1,2)))

  cx <- c(1+1i, 2+2i)
  expect_equal(podzbiory(cx),list(complex(0), 1+1i, 2+2i, c(1+1i,2+2i)))

  na_num <- c(NA, 1)
  res <- podzbiory(na_num)
  expect_length(res, 4)
  expect_true(any(sapply(res, function(u) length(u)==1 && is.na(u))))

  rv <- as.raw(c(0x01, 0x02))
  expect_equal(podzbiory(rv),list(raw(0), as.raw(0x01), as.raw(0x02), as.raw(c(0x01,0x02))))
})

test_that("podzbiory: niepoprawne argumenty", {
  expect_error(podzbiory())
  expect_error(podzbiory(NULL))
  expect_error(podzbiory(list(1,2,3)))
  expect_error(podzbiory(data.frame(a=1:3)))
  expect_error(podzbiory(mean))

  m <- matrix(1:4, 2)
  expect_error(podzbiory(m))
})
