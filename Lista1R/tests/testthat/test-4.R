library(testthat)
library(Lista1R)

context("Zadanie 4")

test_that("fibonacci: poprawne przypadki iteracyjne", {
  expected <- c(1L, 1L, 2L, 3L, 5L, 8L, 13L, 21L, 34L, 55L)
  expect_equal(fibonacci(1, iter = TRUE), 1L)
  expect_equal(fibonacci(2, iter = TRUE), c(1L, 1L))
  expect_equal(fibonacci(3, iter = TRUE), expected[1:3])
  expect_equal(fibonacci(10, iter = TRUE), expected)
})

test_that("fibonacci: poprawne przypadki rekurencyjne", {
  expected8 <- c(1L, 1L, 2L, 3L, 5L, 8L, 13L, 21L)
  expect_equal(fibonacci(1), 1L)
  expect_equal(fibonacci(2), c(1L, 1L))
  expect_equal(fibonacci(5), c(1L, 1L, 2L, 3L, 5L))
  expect_equal(fibonacci(8), expected8)
})

test_that("fibonacci: spójność wariantów iteracyjnego i rekurencyjnego", {
  for (n in 1:12) {
    expect_equal(fibonacci(n, iter = TRUE), fibonacci(n, iter = FALSE))
  }
})

test_that("fibonacci: walidacja argumentów", {
  expect_error(fibonacci())
  expect_error(fibonacci(NA))
  expect_error(fibonacci(0))
  expect_error(fibonacci(-5))
  expect_error(fibonacci(2.5))
  expect_error(fibonacci(c(3,4)))
  expect_error(fibonacci("a"))
})
