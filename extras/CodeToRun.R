library(PADManuscript)

source("/home/alondhe2/Desktop/setCredentials.R")

# Optional: specify where the temporary files (used by the ff package) will be created:
options(fftempdir = "/ebs3/fftemp")

# Maximum number of cores to be used:
maxCores <- parallel::detectCores()

# The folder where the study intermediate and result files will be written:
outputFolder <- "output"

# Details for connecting to the server:
connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = "pdw",
                                                                server = Sys.getenv("cdmServer"),
                                                                user = Sys.getenv("cdmUser"),
                                                                password = Sys.getenv("cdmPassword"),
                                                                port = Sys.getenv("cdmServerPort"))

# The name of the database schema where the CDM data can be found:
cdmDatabaseSchema <- "cdm_truven_mdcr_v779.dbo"

# The name of the database schema and table where the study-specific cohorts will be instantiated:
cohortDatabaseSchema <- "cdm_truven_mdcr_v779.ohdsi_results"
cohortTable <- "cohort"

# Some meta-information that will be used by the export function:
databaseId <- "IBMMDCR"
databaseName <- "IBM MarketScan Medicare"
databaseDescription <- ""

# For Oracle: define a schema that can be used to emulate temp tables:
oracleTempSchema <- NULL

execute(connectionDetails = connectionDetails,
        cdmDatabaseSchema = cdmDatabaseSchema,
        cohortDatabaseSchema = cohortDatabaseSchema,
        cohortTable = cohortTable,
        oracleTempSchema = oracleTempSchema,
        outputFolder = outputFolder,
        databaseId = databaseId,
        databaseName = databaseName,
        databaseDescription = databaseDescription,
        createCohorts = FALSE,
        synthesizePositiveControls = FALSE,
        runAnalyses = TRUE,
        runDiagnostics = TRUE,
        packageResults = FALSE,
        maxCores = maxCores)

resultsZipFile <- file.path(outputFolder, "export", paste0("Results", databaseId, ".zip"))
dataFolder <- file.path(outputFolder, "shinyData")

#prepareForEvidenceExplorer(resultsZipFile = resultsZipFile, dataFolder = dataFolder)

#launchEvidenceExplorer(dataFolder = dataFolder, blind = TRUE, launch.browser = FALSE)
