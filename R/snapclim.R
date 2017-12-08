#' snapclim: Curated SNAP climate data sets.
#'
#' \code{snapclim} offers curated collections of public climate data sets.
#'
#' The \code{snapclim} package provides access to curated collections of public climate data sets
#' offered by Scenarios Network for Alaska and Arctic Planning (SNAP) at the University of Alaska Fairbanks.
#' \code{snapclim} interfaces with SNAP's Amazon Web Services cloud storage to retrieve specific climate data.
#' Available data includes historical observation-based climate data and historical and projected climate model outputs.
#' Available climate variables include temperature and precipitation.
#'
#' Regional climate summaries and climate data at point locations are available,
#' stretching over Alaska and western Canada.
#' Regions include the state of Alaska and several Canadian provinces, ecological regions, fire management zones,
#' terrestrial protected areas under jurisdiction and management of various governmental agencies and more.
#' Point locations include cities, towns, villages and other municipal units and locations of interest.
#'
#' Daily, monthly, seasonal, annual and decadal temporal resolutions are available.
#' However, not all combinations of temporal and spatial resolution exist, e.g.,
#' daily point location climate projections.
#'
#' \code{snapclim} is a member package in the data sector of the SNAPverse.
#' Data packages typically include raw data sets in support of other R packages.
#' \code{snapclim} is technically more like a typical R package. Instead of storing local copies of data sets,
#' it contains functions for accessing external data sets that would be too large to store conveniently even in an
#' explicit data package, especially considering that any given user session would likely utilize only a small fraction
#' of the total available data. However, \code{snapclim} does not offer functionality beyond accessing data and is
#' therefore still best conceptualized as a data package.
#' Functions for statistical analysis and modeling of SNAP data are already encompassed in packages like \code{snapstat}.
#'
#' @docType package
#' @name snapclim
NULL

#' @importFrom magrittr %>%
NULL

.clim_dir <- "https://s3.amazonaws.com/leonawicz/clim/stat/ar5_2km"
.ids <- c("ar5stats")

#' Basic metadata for all data sets available via snapclim
#'
#' This function returns a data frame with basic meta data for all of the curated collections of SNAP climate data
#' available via \code{snapclim}.
#' This includes ID, short description, and spatial and temporal information.
#'
#' @return a data frame.
#' @export
#'
#' @examples
#' collections()
collections <- function(){
  id <- .ids
  desc <- c("AR5/CMIP5 climate statistics")
  area <- "regions"
  period <- "1901 - 2100"
  tibble::data_frame(id = id, description = desc, area = area, period = period)
}

#' Climate regions
#'
#' A data frame of available climate regions and their respective region groups for use in \code{\link{climdata}}.
#'
#' @format A data frame with 86 rows and 2 columns giving the region name and the set/group it belongs to.
"climate_regions"

region_groups <- c("AK-CAN", "AK LCC regions", "Alaska L1 Ecoregions", "Alaska L2 Ecoregions", "Alaska L3 Ecoregions",
                   "CAVM regions", "FMZ regions", "LCC regions", "Political Boundaries", "TPA regions")

#' Obtain SNAP climate data sets
#'
#' Download climate data sets from SNAP.
#'
#' This function downloads climate data sets from Scenarios Network for Alaska and Arctic Planning based on the data set \code{id}
#' and specification of the region or point location of interest.
#'
#' @param id character, data set ID. See \code{\link{collections}} for available data sets.
#' @param area character, aerial unit/region or point location of interest. See \code{\link{climate_regions}}.
#' @param time_scale character, \code{"monthly"}, \code{"seasonal"} or \code{"annual"}.
#' @param set character or \code{NULL}, The set/group that \code{area} belongs to. Can be ignored,
#' but should be provided in rare cases where \code{area} name is not unique (a warning is thrown). See \code{\link{climate_regions}}.
#'
#' @return a data frame.
#' @export
#'
#' @examples
#' climdata("ar5stats", "AK-CAN")
climdata <- function(id, area, time_scale = "monthly", set = NULL){
  .check_clim_id(id)
  set_ <- .check_area(area)
  if(is.null(set)) set <- set_
  .check_set(set)
  intra_annual <- switch(time_scale,
                         monthly = month.abb,
                         seasonal = c("Winter", "Spring", "Summer", "Autumn"),
                         annual = "Annual")
  scale_dir <- ifelse(time_scale == "monthly", "monthly", "seasonal")
  intra_var <- paste0(toupper(substr(scale_dir, 1, 1)), substr(scale_dir, 2, nchar(scale_dir) - 2))
  file <- file.path(.clim_dir, scale_dir, set, paste0(area, "_clim_stats.rds"))
  x <- readRDS(url(file)) %>% dplyr::filter(.data[[intra_var]] %in% intra_annual) %>%
    droplevels %>% dplyr::rename(Model = .data[["GCM"]])
  x
}

.check_clim_id <- function(x){
  if(!x %in% .ids) stop("Invalid `id`. See `collections`.")
}

.check_area <- function(x){
  if(!x %in% climate_regions$Region) stop("Invalid `area`. See `collections` for available areas/regions.")
  y <- dplyr::filter(climate_regions, .data[["Region"]] == x)
  set <- y$Group[1]
  if(nrow(y) > 1) warning(paste0("`area` not unique and `set` not provided. Please provide `set`. Using '", set, "'."))
  set
}

.check_set <- function(x){
  if(!x %in% region_groups) stop("Invalid `area`. See `collections` for available region groups/sets.")
}
