% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/climdata.R
\name{climdata}
\alias{climdata}
\title{Obtain SNAP climate data sets}
\usage{
climdata(id, area, set = NULL, time_scale = "monthly",
  decavg = FALSE, variable = NULL)
}
\arguments{
\item{id}{character, data set ID. See \code{\link{climate_collections}} for available data sets.}

\item{area}{character, region or point location of interest. See \code{\link{climate_locations}}.}

\item{set}{character or \code{NULL}, The set/group that \code{area} belongs to. Can be ignored,
but should be provided in rare cases where \code{area} name is not unique (a warning is thrown). See \code{\link{climate_locations}}.}

\item{time_scale}{character, \code{"monthly"}, \code{"seasonal"}, \code{"annual"}.}

\item{decavg}{logical, if \code{TRUE}, return decadal means of annual statistics. See details.}

\item{variable}{\code{NULL} or character: \code{"tas"}, \code{"tasmin"}, \code{"tasmax"} or \code{"pr"}. See details.}
}
\value{
a data frame.
}
\description{
Download climate data sets from SNAP.
}
\details{
This function downloads climate data sets from Scenarios Network for Alaska and Arctic Planning based on the data set \code{id}
and specification of the region or point location of interest.

For regional climate data, annual statistics with a temporal resolution of monthly, 3-month seasonal and full annual period
are based on regional spatial climate variable distribution samples at the respective resolution.

Statistics include:
\itemize{
  \item mean
  \item standard deviation
  \item minimum
  \item maximum
  \item quantiles: 0.025, 0.05, 0.10, 0.25, 0.50 (median), 0.75, 0.90, 0.95 and 0.975.
}

Comparatively, point location data sets do not include statistics regarding the surrounding spatial distribution of values.
Only the \code{Mean} column is retained in these tables.

Seasonal and annual aggregate statistics represent means for temperature variables and totals for precipitation.
Note that decadal averages are strictly as their name suggests: decadal means of each statistic at the respective intra-annual time steps.
E.g., \code{decavg = TRUE} returns a data frame including the mean of ten annual 95th percentile values,
not the 95th percentile of the spatial climate variable distribution at a decadal resolution.
For something like the latter, this can be computed from raw distribution data.

Data sets are retrieved for specific locations. For the smaller, decadal resolution data sets, there is an option to download
all point locations in one table with \code{area = "points"} (requires \code{decavg = TRUE}),
but in this case it must be requested for a specific climate variable to further reduce the download size to no more than 24
MB compressed for all 3,867 point locations.
In general, if \code{variable = NULL}, all available climate variables are retained. In the case of \code{area = "points"},
a specific climate variable must be provided or it will default to temperature (\code{tas}).
}
\examples{
climdata("ar5stats", "AK-CAN")
}
