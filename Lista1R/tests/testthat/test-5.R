library(testthat)
library(Lista1R)

context("Zadanie 5")

test_that("collatz: podstawowe wartości", {
  expect_equal(collatz(1), numeric(0))
  expect_equal(collatz(2), numeric(0))
  expect_equal(collatz(3), c(3L,10L,5L,16L,8L))
})

test_that("collatz: poprawna długość i maksymalny wyraz", {
  seq5 <- collatz(5)
  expect_equal(length(seq5), 3)
  expect_equal(max(seq5), 16L)

  seq7 <- collatz(7)
  expect_equal(length(seq7), 14)
  expect_equal(max(seq7), 52L)
})

test_that("collatz: walidacja niepoprawnych argumentów", {
  expect_error(collatz())
  expect_error(collatz(0))
  expect_error(collatz(-3))
  expect_error(collatz(2.5))
  expect_error(collatz(c(3,4)))
  expect_error(collatz("a"))
})
