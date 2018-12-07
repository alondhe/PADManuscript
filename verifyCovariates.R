excludes <- getExcludedCovariateConcepts()

balance <- readRDS("output_optum_nodesc/balance/bal_t7946_c7948_o2357_a1.rds")


c(442774,761826,761827,761828,4010966,4186213,4316222,36712806,36717006,36717286,43020432,44782441) %in% 
  balance$conceptId





balance$conceptId[[1]]
balance$covariateName[[1]]





perOcclusive <- 317309


317309 %in% balance$conceptId

occ <- balance[balance$conceptId == 317309,]




balance$afterSMD <- abs(balance$afterMatchingStdDiff)


unbal <- balance[balance$afterSMD > 0.1,]

uniques <- unique(unbal$conceptId)

unbal <- unbal[uniques %in% unbal$conceptId,]