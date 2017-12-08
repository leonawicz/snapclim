
<!-- README.md is generated from README.Rmd. Please edit that file -->
snapclim
========

[![Travis-CI Build Status](https://travis-ci.org/leonawicz/snapclim.svg?branch=master)](https://travis-ci.org/leonawicz/snapclim) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/leonawicz/snapclim?branch=master&svg=true)](https://ci.appveyor.com/project/leonawicz/snapclim) [![Coverage Status](https://img.shields.io/codecov/c/github/leonawicz/snapclim/master.svg)](https://codecov.io/github/leonawicz/snapclim?branch=master)

The `snapclim` package provides access to curated collections of public climate data sets offered by Scenarios Network for Alaska and Arctic Planning (SNAP) at the University of Alaska Fairbanks. `snapclim` interfaces with SNAP's Amazon Web Services cloud storage to retrieve specific climate data. Available data includes historical observation-based climate data as well as historical and projected climate model outputs. Currently available climate variables include temperature and precipitation.

Time and space
--------------

Regional climate summaries and climate data at point locations are available, stretching over Alaska and western Canada. Regions include the state of Alaska and several Canadian provinces, ecological regions, fire management zones, terrestrial protected areas under jurisdiction and management of various governmental agencies and more. Point locations include cities, towns, villages and other municipal units and locations of interest.

Daily, monthly, seasonal, annual and decadal temporal resolutions are available. However, not all combinations of temporal and spatial resolution exist, e.g., daily point location climate projections.

SNAPverse context
-----------------

`snapclim` is a member package in the data sector of the SNAPverse. Data packages typically include raw data sets in support of other R packages. `snapclim` is technically more like a typical R package. Instead of storing local copies of data sets, it contains functions for accessing external data sets that would be too large to store conveniently even in an explicit data package, especially considering that any given user session would likely utilize only a small fraction of the total available data. However, `snapclim` does not offer functionality beyond accessing data and is therefore still best conceptualized as a data package. Functions for statistical analysis and modeling of SNAP data are already encompassed in packages like `snapstat`.

Installation
------------

You can install snapclim from github with:

``` r
# install.packages('devtools')
devtools::install_github("leonawicz/snapclim")
```
