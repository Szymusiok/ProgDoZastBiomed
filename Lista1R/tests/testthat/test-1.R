library(testthat)
library(Lista1R)

context("Zadanie 1")

testthat::test_that("Heron: przykłady poprawne",{
  testthat::expect_equal(heron(3,4,5), 6)
  testthat::expect_equal(heron(5,5,5), (sqrt(3)/4)*25)
  testthat::expect_equal(heron(0.3,0.4,0.5), sqrt(0.6*0.3*0.2*0.1))
  testthat::expect_equal(heron(2,3,4), sqrt(4.5*2.5*1.5*0.5))
  testthat::expect_equal(heron(6,7,8), sqrt(10.5*4.5*3.5*2.5))
  testthat::expect_equal(heron(10,6,8), 24)
  testthat::expect_equal(heron(5,12,13), 30)
  testthat::expect_equal(heron(9,40,41), 180)
  testthat::expect_equal(heron(8,15,17), 60)
  testthat::expect_true(heron(1,1,1.999999999) >= 0)
})

testthat::test_that("Heron: przykłady niepoprawne",{
  testthat::expect_error(heron(0,1,1))
  testthat::expect_error(heron(-1,2,2))
  testthat::expect_error(heron(1,2,3))
  testthat::expect_error(heron(1,2,4))
  testthat::expect_error(heron("a",2,2))
  testthat::expect_error(heron(c(3,4),5,6))
  testthat::expect_error(heron(NA,1,1))
})
