\name{analyzeSGP}
\alias{analyzeSGP}
\title{Analyze student data to produce student growth percentiles and student growth projections}
\description{
  Wrapper function used to produce student growth percentiles and student growth projections (both cohort and baseline referenced) using long formatted data like that provided by \code{\link{prepareSGP}}.
}

\usage{
analyzeSGP(sgp_object,
         state=NULL,
         years=NULL,
         content_areas=NULL,
         grades=NULL,
         sgp.percentiles=TRUE,
         sgp.projections=TRUE,
         sgp.projections.lagged=TRUE,
         sgp.percentiles.baseline=TRUE,
         sgp.projections.baseline=TRUE,
         sgp.projections.lagged.baseline=TRUE,
         sgp.percentiles.baseline.max.order=3,
         sgp.projections.baseline.max.order=3,
         sgp.projections.lagged.baseline.max.order=3,
         sgp.projections.max.forward.progression.years=3,
         sgp.projections.max.forward.progression.grade=NULL,
         sgp.minimum.default.panel.years=NULL,
         sgp.use.my.coefficient.matrices=NULL,
         sgp.use.my.sgp_object.baseline.coefficient.matrices=NULL,
         simulate.sgps=TRUE,
         calculate.simex=NULL,
         calculate.simex.baseline=NULL,
         goodness.of.fit.print=TRUE,
         sgp.config=NULL,
         sgp.config.drop.nonsequential.grade.progression.variables=TRUE,
         sgp.baseline.panel.years=NULL,
         sgp.baseline.config=NULL,
         trim.sgp.config=TRUE,
         parallel.config=NULL,
         verbose.output=FALSE,
         print.other.gp=NULL,
         sgp.projections.projection.unit="YEAR",
         get.cohort.data.info=FALSE,
         sgp.sqlite=NULL,
         sgp.percentiles.equated=FALSE,
         SGPt=NULL,
         ...)
}

\arguments{
  \item{sgp_object}{An object of class \code{SGP} containing long formatted data in the \code{@Data} slot (from \code{\link{prepareSGP}}). 
  }
  \item{state}{Acronym indicating state associated with the data for access to embedded knot and boundaries, cutscores, CSEMs, and other state related assessment data.
  }
  \item{years}{A vector indicating year(s) in which to produce student growth percentiles and/or student growth projections/trajectories. If missing the 
function will use the data to infer the year(s) based upon the assumption of having at least three years of panel data for analyses.
  }
  \item{content_areas}{A vector indicating content area(s) in which to produce student growth percentiles and/or student growth projections/trajectories. 
If left missing the function will use the data to infer the content area(s) available for analyses.
  }
  \item{grades}{A vector indicating grades for which to calculate student growth percentiles and/or student growth projections/trajectories. 
If left missing the function will use the data to infer all the grade progressions for student growth percentile and student growth projections/trajectories analyses.
  }
  \item{sgp.percentiles}{Boolean variable indicating whether to calculate student growth percentiles. Defaults to TRUE.
  }
  \item{sgp.projections}{Boolean variable indicating whether to calculate student growth projections. Defaults to TRUE.
  }
  \item{sgp.projections.lagged}{Boolean variable indicating whether to calculate lagged student growth projections often used for growth to standard analyses. Defaults to TRUE.
  }
  \item{sgp.percentiles.baseline}{Boolean variable indicating whether to calculate baseline student growth percentiles and/or coefficient matrices. Defaults to TRUE.
  }
  \item{sgp.projections.baseline}{Boolean variable indicating whether to calculate baseline student growth projections. Defaults to TRUE.
  }
  \item{sgp.projections.lagged.baseline}{Boolean variable indicating whether to calculate lagged baseline student growth projections. Defaults to TRUE.
  }
  \item{sgp.percentiles.baseline.max.order}{Integer indicating the maximum order to calculate baseline student growth percentiles (regardless of maximum coefficient matrix order).  Also the max order of baseline coefficient matrices to be calculated if requested. Default is 3. To utilize the maximum matrix order, set to NULL. 
  }
  \item{sgp.projections.baseline.max.order}{Integer indicating the maximum order to calculate baseline student growth projections (regardless of maximum coefficient matrix order). Default is 3.
To utilize the maximum matrix order, set to NULL.
  }
  \item{sgp.projections.lagged.baseline.max.order}{Integer indicating the maximum order to calculate lagged baseline student growth projections (regardless of maximum coefficient matrix order). 
Default is 3.  To utilize the maximum matrix order, set to NULL.
  }
  \item{sgp.projections.max.forward.progression.years}{Integer indicating the maximum number of years forward that cohort based projections will be established for. Default is 3 years.
  }
  \item{sgp.projections.max.forward.progression.grade}{Integer indicating the maximum grade forward that cohort based projections will be established for. Default is NULL, the highest grade.
  }
  \item{sgp.minimum.default.panel.years}{Integer indicating the minimum number of panels years to use for default sgp analyses. Default value is NULL (converted to 3) years of data.
  }
  \item{sgp.use.my.coefficient.matrices}{Argument, defaults to NULL, indicating whether to use coefficient matrices embedded in argument supplied to 'sgp_object' to calculate student growth 
  percentiles.
  }
  \item{sgp.use.my.sgp_object.baseline.coefficient.matrices}{Argument, defaults to NULL (FALSE), indicating whether to utilize baseline matrices embedded in supplied \code{sgp_object} and not
  utilize baseline matrices embedded in \code{SGPstateData}.
  }
  \item{simulate.sgps}{Boolean variable indicating whether to simulate SGP values for students based on test-specific Conditional Standard Errors of Measurement (CSEM).  Test CSEM data must be available for simulation and included in \code{SGPstateData}.  This argument must be set to TRUE for confidence interval construction. Defaults to TRUE.
  }
  \item{calculate.simex}{A character state acronym or list including state/csem variable, csem.data.vnames, csem.loss.hoss, simulation.iterations, lambda and extrapolation method. Defaults to NULL, no simex calculations performed.  Alternatively, setting the argument to TRUE sets the list up with state=state, lambda=seq(0,2,0.5), simulation.iterations=50, simex.sample.size=25000, extrapolation="linear" and save.matrices=TRUE.
  }
  \item{calculate.simex.baseline}{A character state acronym or list including state/csem variable, csem.data.vnames, csem.loss.hoss, simulation.iterations, lambda and extrapolation method. Defaults to NULL, no simex calculations performed.  Alternatively, setting the argument to TRUE sets the list up with state=state, lambda=seq(0,2,0.5), simulation.iterations=50, simex.sample.size=25000, extrapolation="linear", save.matrices=TRUE and simex.use.my.coefficient.matrices = TRUE.  This argument is passed to \code{\link{analyzeSGP}}.
  }
  \item{goodness.of.fit.print}{Boolean variable indicating whether to print out Goodness of Fit figures as PDF into a directory labeled Goodness of Fit. Defaults to TRUE.
  }
  \item{sgp.config}{If \code{years}, \code{content_areas}, and \code{grades} are missing, user can directly specify a list containing three vectors: 
  \code{baseline.content.areas}, \code{baseline.panel.years}, and \code{baseline.grade.sequences}. This advanced option is helpful for analysis of non-traditional grade progressions and 
  other special cases. See examples for use cases.
  }
  \item{sgp.config.drop.nonsequential.grade.progression.variables}{Boolean variable (defaults to TRUE) indicating whether non-sequential grade progression variables should be dropped when 
  sgp.config is processed. For example, if a grade progression of c(3,4,6) is provided, the data configuration will assume (default is TRUE) that data for a missing year needs to be dropped prior 
  to applying \code{\link{studentGrowthPercentiles}} or \code{\link{studentGrowthProjections}} to the data. 
  }
  \item{sgp.baseline.panel.years}{A vector of years to be used for baseline coefficient matrix calculation. Default is to use most recent five years of data.}
  \item{sgp.baseline.config}{A list containing three vectors: \code{sgp.content.areas}, \code{sgp.panel.years}, \code{sgp.grade.sequences} indicating how baseline student growth percentile analyses
 are to be conducted. In almost all cases this value is calculated by default within the function but can be specified directly for advanced use cases. See source code for more detail on this configuration option.
  }
  \item{trim.sgp.config}{A Boolean variable indicating whether the arguments \code{content_areas}, \code{years} and \code{grades} should be used to 'trim' any manually supplied configuration for analysis supplied by 'sgp.config'.
  }
\item{parallel.config}{A named list with, at a minimum, two elements indicating 1) the BACKEND package to be used for parallel computation and 2) the WORKERS list to specify the number of processors to be used in each major analysis.  The BACKEND element can be set = to \code{FOREACH} or \code{PARALLEL}.  Please consult the manuals and vignettes for information of these packages!

TYPE is a third element of the \code{parallel.config} list that provides necessary information when using FOREACH or PARALLEL packages as the backend. With BACKEND="FOREACH", the TYPE element specifies the flavor of 'foreach' backend.  As of version 1.0-1.0, only "doParallel" is supported.   If BACKEND = "PARALLEL", the \code{parallel} package will be used.  This package combines deprecated parallel packages \code{snow} and \code{multicore}.  Using the "snow" implementation of \code{parallel} the function will create a cluster object based on the TYPE element specified and the number of workers requested (see WORKERS list description below).  The TYPE element indicates the users preferred cluster type (either "PSOCK" for socket cluster of "MPI" for an OpenMPI cluster). If Windows is the operating system, this "snow" implementation must be used and the TYPE element must = "PSOCK".  Defaults are assigned based on operating system if TYPE is missing based on system OS.  Unix/Mac OS defaults to the "multicore" to avoid worker node pre-scheduling and appears to be more efficient in these operating systems.  

The WORKERS list must contain, at a minimum, a single number of processors (nodes) desired or available.  If WORKERS is specified in this manner, then the same number of processors will be used for each analysis type (sgp.percentiles, sgp.projections, ...  sgp.projections.lagged.baseline).  Alternatively, the user may specify the numbers of processors used for each analysis.  This allows for better memory management in systems that do not have enough RAM available per core.  The choice of the number of cores is a balance between the number of processors available, the amount of RAM a system has and the size of the data (sgp_object).  Each system will be different and will require some tailoring.  One rule of thumb used by the authors is to allow for 4GB of memory per core used for running large state data.  The SGP Demonstration (and data that size) requires more like 1-2GB per core.  As an example, PERCENTILES=4 and  PROJECTIONS=2 might be used on a quad core machine with 4 GB of RAM.  This will use all 4 cores available for the sgp.percentiles analysis and 2 cores for the sgp.projections analysis (which requires more memory than available).  The WORKERS list accepts these elements:   PERCENTILES, PROJECTIONS (for both cohort and baseline referenced projections), LAGGED_PROJECTIONS (for both cohort and baseline referenced lagged projections), BASELINE_MATRICES (used to produce the baseline coefficient matrices when not available in SGPstateData - very computationally intensive), BASELINE_PERCENTILES (SGP calculation only when baseline coefficient matrices have already been produced and are available - NOT very computationally intensive).

Alternatively, the name of an external CLUSTER.OBJECT (PSOCK or MPI) set up by the user outside of the function can be used.  

Example use cases are provided below.
  }
  \item{verbose.output}{A Boolean argument (defaults to FALSE) indicating whether the function should output verbose diagnostic messages.
  }
  \item{print.other.gp}{A Boolean argument (defaults to FALSE) indicating whether the function should output SGP of all orders.
  }
  \item{sgp.projections.projection.unit}{A character vector argument indicating whether the studentGrowthProjections function should produce projections relative to future grades or future years.
  Options are "YEAR" and "GRADE", with default being "YEAR".
  }
  \item{get.cohort.data.info}{A Boolean argument (defaults to FALSE) indicating whether a summary of all cohorts to be submitted to the \code{\link{studentGrowthPercentiles}} and 
  \code{\link{studentGrowthProjections}} functions should be performed prior to analysis.
  }
 \item{sgp.sqlite}{A Boolean argument (defaults to NULL) indicating whether a SQLite database file of the essential SGP data should be created from the \code{@Data} slot and subsequently used to extract data subsets for analysis with \code{\link{studentGrowthPercentiles}} and 
  \code{\link{studentGrowthProjections}} functions.  The default, NULL, allows for an test of the size of the \code{@Data} object.  If greater than 1 GB \code{sgp.sqlite} is set to TRUE internally.  When TRUE, this step can take some time but can also substantially reduce the amount of RAM memory required to conduct analyses.  If set to TRUE the \code{tmp_data} directory and file "TMP_SGP_Data.sqlite" will be created.  This tmp_data directory and file are deleted by default although one may keep them if the argument is specified as the character "KEEP".  However, if an existing database of that name exists, it will be deleted and a new version created.
 }
  \item{sgp.percentiles.equated}{A Boolean argument (defaults to FALSE) indicating whether equating should be used on the most recent year of test data provided. Equating allows for student growth
projections to be calculated in across assessment transitions where the scale for the assessment changes.
  }
  \item{SGPt}{An argument supplied to implement time-dependent SGP analyses (SGPt). Default is NULL giving standard, non-time dependent argument. If set to TRUE, the function assumes the
  variables 'TIME' and 'TIME_LAG' are supplied as part of the panel.data. To specify other names, supply a list of the form: list(TIME='my_time_name', TIME_LAG='my_time_lag_name'), substituting
  your variable names.
  }
  \item{...}{Arguments to be passed to \code{\link{studentGrowthPercentiles}} or \code{\link{studentGrowthProjections}} for finer control over SGP calculations. NOTE: arguments can only be passed to one lower level function at a time, and only student growth percentiles OR projections can be created but not both at the same time.
  }
}

\value{Function returns a list containing the long data set in the \code{@Data} slot as a \code{data.table} keyed using \code{VALID_CASE}, \code{CONTENT_AREA}, 
\code{YEAR}, \code{ID} and the student growth percentile and/or student growth projection/trajectory results in the \code{SGP} slot. 
}

\author{Damian W. Betebenner \email{dbetebenner@nciea.org} and Adam Van Iwaarden \email{vaniwaarden@colorado.edu}}

\seealso{\code{\link{prepareSGP}}, \code{\link{combineSGP}}}

\examples{
\dontrun{
## analyzeSGP is Step 2 of 5 of abcSGP
Demonstration_SGP <- sgpData_LONG
Demonstration_SGP <- prepareSGP(Demonstration_SGP)
Demonstration_SGP <- analyzeSGP(Demonstration_SGP)

## Or (explicitly pass state argument)

Demonstration_SGP <- prepareSGP(sgpData_LONG)
Demonstration_SGP <- analyzeSGP(Demonstration_SGP, state="DEMO")

###
###  Example uses of the sgp.config argument
###

#  Use only 3 years of Data, for grades 3 to 6
#  and only perform analyses for most recent year (2012)

my.custom.config <- list(
MATHEMATICS.2013_2014 = list(
	sgp.content.areas=rep("MATHEMATICS", 3), # Note, must be same length as sgp.panel.years
	sgp.panel.years=c('2011_2012', '2012_2013', '2013_2014'),
	sgp.grade.sequences=list(3:4, 3:5, 4:6)),
READING.2013_2014 = list(
	sgp.content.areas=rep("READING", 3),
	sgp.panel.years=c('2011_2012', '2012_2013', '2013_2014'),
	sgp.grade.sequences=list(3:4, 3:5, 4:6)))

Demonstration_SGP <- prepareSGP(sgpData_LONG)
Demonstration_SGP <- analyzeSGP(Demonstration_SGP,
	sgp.config=my.custom.config,
	sgp.percentiles.baseline = FALSE,
	sgp.projections.baseline = FALSE,
	sgp.projections.lagged.baseline = FALSE,
	simulate.sgps=FALSE)


##  Another example sgp.config list:

#  Use different CONTENT_AREA priors, and only 1 year of prior data
my.custom.config <- list(
MATHEMATICS.2013_2014.READ_PRIOR = list(
	sgp.content.areas=c("READING", "MATHEMATICS"),
	sgp.panel.years=c('2012_2013', '2013_2014'),
	sgp.grade.sequences=list(3:4, 4:5, 5:6)),
READING.2013_2014.MATH_PRIOR = list(
	sgp.content.areas=c("MATHEMATICS", "READING"),
	sgp.panel.years=c('2012_2013', '2013_2014'),
	sgp.grade.sequences=list(3:4, 4:5, 5:6)))


## An example showing multiple priors within a single year

Demonstration_SGP <- prepareSGP(sgpData_LONG)
 
DEMO.config <- list(
READING.2012_2013 = list(
	sgp.content.areas=c("MATHEMATICS", "READING", "MATHEMATICS", "READING", "READING"),
	sgp.panel.years=c('2010_2011', '2010_2011', '2011_2012', '2011_2012', '2012_2013'),
	sgp.grade.sequences=list(c(3,3,4,4,5), c(4,4,5,5,6), c(5,5,6,6,7), c(6,6,7,7,8))),
MATHEMATICS.2012_2013 = list(
	sgp.content.areas=c("READING", "MATHEMATICS", "READING", "MATHEMATICS", "MATHEMATICS"),
	sgp.panel.years=c('2010_2011', '2010_2011', '2011_2012', '2011_2012', '2012_2013'),
	sgp.grade.sequences=list(c(3,3,4,4,5), c(4,4,5,5,6), c(5,5,6,6,7), c(6,6,7,7,8))))

Demonstration_SGP <- analyzeSGP(
		Demonstration_SGP,
		sgp.config=DEMO.config,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		sgp.config.drop.nonsequential.grade.progression.variables=FALSE)


###
###  Example uses of the parallel.config argument
###

##  Windows users must use a snow socket cluster:
#  possibly a quad core machine with low RAM Memory
#  4 workers for percentiles, 2 workers for projections.
#  Note the PSOCK type cluster is used for single machines.

Demonstration_SGP <- prepareSGP(sgpData_LONG)
Demonstration_SGP <- analyzeSGP(Demonstration_SGP,
	parallel.config=list(
		BACKEND="PARALLEL", TYPE="PSOCK",
		WORKERS=list(PERCENTILES=4, 
                    PROJECTIONS=2, 
                    LAGGED_PROJECTIONS=2,
                    BASELINE_PERCENTILES=4))

##  New parallel package - only available with R 2.13 or newer
#  Note there are up to 16 workers, and MPI is used, 
#  suggesting this example is for a HPC cluster, possibly Windows OS.
	...
	parallel.config=list(
		BACKEND="PARALLEL", TYPE="MPI",
		WORKERS=list(PERCENTILES=16, 
                    PROJECTIONS=8, 
                    LAGGED_PROJECTIONS=6,
                    BASELINE_PERCENTILES=12))
	...

## FOREACH use cases:
	...
	parallel.config=list(
		BACKEND="FOREACH", TYPE="doParallel",
		WORKERS=3)
	...


#  NOTE:  This list of parallel.config specifications is NOT exhaustive.  
#  See examples in analyzeSGP documentation for some others.0

###
###  Advanced Example: restrict years, recalculate baseline SGP
###  coefficient matrices, and use parallel processing
###

#  Remove existing DEMO baseline coefficient matrices from
#  the SGPstateData object so that new ones will be computed.

SGPstateData$DEMO$Baseline_splineMatrix <- NULL

#  set up a customized sgp.config list

	. . .

#  set up a customized sgp.baseline.config list

	. . .

#  to be completed

}  
}

\keyword{documentation}
