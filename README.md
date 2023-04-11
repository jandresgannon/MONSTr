
# A Wiki-based Dataset of Military Operations with Novel Strategic Technologies (MONSTr)

<!-- badges: start -->
<!-- badges: end -->

This is a package, documentation, and replication repository for the paper "A Wiki-based Dataset of Military Operations with Novel Strategic Technologies (MONSTr)". This paper is part of the broader military interventions project which can be found [here](http://military-operations.com/).

* Paper

* Appendix

For any questions, please email either of the authors, [J Andres Gannon](https://jandresgannon.com/), at: [andres.gannon@gmail.com](mailto:andres.gannon@gmail.com) or [Kerry Chavez](https://kerrychavez.us/), at: [kerry.chavez@ttu.edu](mailto:kerry.chavez@ttu.edu)

## Replication Code and Analysis

### Self Contained Package

All of the files necessary for reproducing our analysis are including in a self contained R package "MONSTr". You can install the package MONSTr from github with the instructions below:

```{r gh-installation, eval = FALSE}
if(!require(devtools)) install.packages("devtools")
devtools::install_github("jandresgannon/MONSTr")
```

### R-Notebooks

The analysis and figures in the paper and statistical appendix are produced in a number of fully reproducable Quarto documents.

File Preparation:

* 01 [Existing Data](https://github.com/jandresgannon/MONSTr/blob/main/docs/01_DataPrep_ExistingData.qmd)
* 02a [DBpedia](https://github.com/jandresgannon/MONSTr/blob/main/docs/02a_DataPrep_Wiki-DBpedia.qmd)
* 02b [Wikidata](https://github.com/jandresgannon/MONSTr/blob/main/docs/02b_DataPrep_Wiki-wikidata.qmd)
* 03 [Parent-child](https://github.com/jandresgannon/MONSTr/blob/main/docs/03_DataPrep_ParentChild.qmd)

Models and Figures:

* 04 [Model Prep](https://github.com/jandresgannon/MONSTr/blob/main/docs/04_Model_Prep.qmd)
* 05 [Model Results](https://github.com/jandresgannon/MONSTr/blob/main/docs/05_Model_Results.qmd)
* 06 [Figures](https://github.com/jandresgannon/MONSTr/blob/main/docs/06_Figures.qmd)
* 07 [R&R Supplement](https://github.com/jandresgannon/MONSTr/blob/main/docs/07_Supp_RandR.qmd)
