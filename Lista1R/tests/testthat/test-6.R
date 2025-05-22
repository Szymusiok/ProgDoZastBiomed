library(testthat)
library(Lista1R)

context("Zadanie 6")

test_that("komplement: poprawne przypadki", {
  expect_equal(komplement("A"),   c("T"))
  expect_equal(komplement("C"),   c("G"))
  expect_equal(komplement("G"),   c("C"))
  expect_equal(komplement("T"),   c("A"))
  expect_equal(komplement("ACGT"),c("T","G","C","A"))
  expect_equal(komplement("TTAA"),c("A","A","T","T"))
  seq1 <- komplement("GGCCAA")
  expect_true(all(seq1 == c("C","C","G","G","T","T")))
  expect_equal(length(komplement("AGTC")), 4)
  expect_type(komplement("AGTC"), "character")
  expect_equal(komplement(""), character(0))
})

test_that("komplement: niepoprawne argumenty", {
  expect_error(komplement())
  expect_error(komplement(123))
  expect_error(komplement(c("A","C")))
  expect_error(komplement("AXGT"))
  expect_error(komplement("acgt"))
})

test_that("transkrybuj: poprawne przypadki", {
  expect_equal(transkrybuj("A"),   c("U"))
  expect_equal(transkrybuj("T"),   c("A"))
  expect_equal(transkrybuj("C"),   c("G"))
  expect_equal(transkrybuj("G"),   c("C"))
  expect_equal(transkrybuj("ACGT"),c("U","G","C","A"))
  expect_equal(transkrybuj("TTAA"),c("A","A","U","U"))
  seq2 <- transkrybuj("GGCCAA")
  expect_true(all(seq2 == c("C","C","G","G","U","U")))
  expect_equal(length(transkrybuj("AGTC")), 4)
  expect_type(transkrybuj("AGTC"), "character")
  expect_equal(transkrybuj(""), character(0))
})

test_that("transkrybuj: niepoprawne argumenty", {
  expect_error(transkrybuj())
  expect_error(transkrybuj(456))
  expect_error(transkrybuj(c("A","C")))
  expect_error(transkrybuj("AXGT"))
  expect_error(transkrybuj("acgt"))
})

test_that("transluj: podstawowe translacje 3-litrowe", {
  expect_equal(transluj("AUGUUUUUA"), c("Met","Phe","Leu"))
  expect_equal(transluj("AUGAAAUAA"), c("Met","Lys"))  # Stop na końcu
  expect_equal(transluj("AUG"), "Met")
  expect_equal(transluj("UAA"), character(0))  # od razu stop
})

test_that("transluj: 1-litrowe kody", {
  expect_equal(transluj("AUGUUUUUA", code3 = FALSE), c("M","P","L"))
})

test_that("transluj: walidacja argumentów", {
  expect_error(transluj())
  expect_error(transluj(123))
  expect_error(transluj("AUGU"))
  expect_error(transluj("XYZXYZ"))
})
