#' @author Szymon Kubica 264068
#'
#' @title Komplement
#'
#' @description
#' Funkcja \code{komplement} zwraca nić matrycową DNA na podstawie nici kodującej
#'
#' @param dna \cr
#'  Ciąg znaków DNA
#'
#' @return Nić matrycowa
#'
#' @examples
#' komplement("TTAA")
#'
#' @export
komplement <- function(dna)
{
  # Walidacja argumentu
  if(missing(dna))
  {
    stop("Argument dna musi zostac podany")
  }
  if(!is.character(dna) || length(dna) != 1)
  {
    stop("Argument dna musi byc pojedynczym ciagiem znakow DNA")
  }
  # Sprawdza tylko poprawne litery nukleotydów
  if(grepl("[^ACGT]",dna))
  {
    stop("Sekwencja DNA moze zawierac tylko litery A C G T")
  }

  # Zamiana liter na wektor znakow
  bases <- strsplit(dna,"")[[1]]

  # Budowanie komplementu
  comp <- vapply(bases,function(b) switch(b,
                                          A = "T",
                                          T = "A",
                                          C = "G",
                                          G = "C"), character(1))
  comp <- unname(comp)
  return(comp)
}

#' @author Szymon Kubica 264068
#'
#' @title Transkrybcja
#'
#' @description
#' Funkcja \code{transkrybuj} zwraca nić matrycową RNA na podstawie nici sekwencyjnej
#'
#' @param dna \cr
#'  Nić sekwencyjna
#'
#' @return nić RNA
#'
#' @examples
#' transkrybuj("ACGT")
#'
#' @export
transkrybuj <- function(template_dna)
{
  # Walidacja argumentu
  if(missing(template_dna))
  {
    stop("Argument template_dna musi zostac podany")
  }
  if(!is.character(template_dna) || length(template_dna) != 1)
  {
    stop("Argument template_dna musi byc pojedynczym ciagiem znakow DNA")
  }
  if(grepl("[^ACGT]",template_dna))
  {
    stop("Argument template_dna moze zawierac tylko litery A C G T")
  }

  bases <- strsplit(template_dna,"")[[1]]
  rna <- vapply(bases, function(b) switch(b,
                                          A = "U",
                                          T = "A",
                                          C = "G",
                                          G = "C"), character(1))
  rna <- unname(rna)
  return(rna)
}

#' @author Szymon Kubica 264068
#'
#' @title Transluj
#'
#' @description
#' Funkcja \code{transkrybuj} tłumaczy mRNA na sekwencję aminokwasów
#'
#' @param dna \cr
#'  mRNA
#'
#' @return sekwencja aminokwasów
#'
#' @examples
#' transluj("AUGAAAUAA")
#'
#' @export
transluj <- function(rna_seq, code3 = TRUE)
{
  # Walidacja argumentu
  if(missing(rna_seq))
  {
    stop("Argument rna_seq musi zostac podany")
  }
  if(!is.character(rna_seq) || length(rna_seq) != 1)
  {
    stop("Argument rna_seq musi byc pojedynczym ciagiem znakow DNA")
  }
  if(grepl("[^ACGU]",rna_seq))
  {
    stop("Argument rna_seq moze zawierac tylko litery A C G U")
  }
  # Długość musi być wielokrotnoscią 3
  if(nchar(rna_seq) %% 3L != 0L)
  {
    stop("Długość sekwencji RNA musi byc podzielna przez 3")
  }

  # Tablica kodon -> aminokwas
  codon_table <- c(
    # Phenylalanine
    "UUU" = "Phe", "UUC" = "Phe",
    # Leucine
    "UUA" = "Leu", "UUG" = "Leu",
    "CUU" = "Leu", "CUC" = "Leu", "CUA" = "Leu", "CUG" = "Leu",
    # Isoleucine
    "AUU" = "Ile", "AUC" = "Ile", "AUA" = "Ile",
    # Methionine (start)
    "AUG" = "Met",
    # Valine
    "GUU" = "Val", "GUC" = "Val", "GUA" = "Val", "GUG" = "Val",
    # Serine
    "UCU" = "Ser", "UCC" = "Ser", "UCA" = "Ser", "UCG" = "Ser",
    "AGU" = "Ser", "AGC" = "Ser",
    # Proline
    "CCU" = "Pro", "CCC" = "Pro", "CCA" = "Pro", "CCG" = "Pro",
    # Threonine
    "ACU" = "Thr", "ACC" = "Thr", "ACA" = "Thr", "ACG" = "Thr",
    # Alanine
    "GCU" = "Ala", "GCC" = "Ala", "GCA" = "Ala", "GCG" = "Ala",
    # Tyrosine
    "UAU" = "Tyr", "UAC" = "Tyr",
    # Histidine
    "CAU" = "His", "CAC" = "His",
    # Glutamine
    "CAA" = "Gln", "CAG" = "Gln",
    # Asparagine
    "AAU" = "Asn", "AAC" = "Asn",
    # Lysine
    "AAA" = "Lys", "AAG" = "Lys",
    # Aspartic Acid
    "GAU" = "Asp", "GAC" = "Asp",
    # Glutamic Acid
    "GAA" = "Glu", "GAG" = "Glu",
    # Cysteine
    "UGU" = "Cys", "UGC" = "Cys",
    # Tryptophan
    "UGG" = "Trp",
    # Arginine
    "CGU" = "Arg", "CGC" = "Arg", "CGA" = "Arg", "CGG" = "Arg",
    "AGA" = "Arg", "AGG" = "Arg",
    # Glycine
    "GGU" = "Gly", "GGC" = "Gly", "GGA" = "Gly", "GGG" = "Gly",
    # Stop codons
    "UAA" = "Stop", "UAG" = "Stop", "UGA" = "Stop"
  )

  # Dzielenie na trójki
  n <- nchar(rna_seq)
  aa <- character(0)
  for(i in seq(1,n,by=3L))
  {
    codon <- substr(rna_seq,i,i+2)
    aa_name <- codon_table[[codon]]
    if(is.null(aa_name))
    {
      stop(paste0("Nieznany kodon: ", codon))
    }
    if(aa_name == "Stop")
    {
      break;
    }
    if(code3)
    {
      aa <- c(aa,aa_name)
    }
    else
    {
      # Skrocone kody 1-literowe
      aa1 <- substr(aa_name,1,1)
      aa <- c(aa,aa1)
    }
  }
  return(aa)
}

#' Źródła
#'
#' https://www.rdocumentation.org/
#' https://www.genscript.com/tools/codon-table
