### ComputeCRPscore.R
### Author: Andrew Teschendorff (andrew@sinh.ac.cn)
### Description: a simple function to compute a DNAm-based surrogate proxy for CRP (inflammaging) levels.

### Input required:
### sigCRP.v: a vector containing the CpGs and weights associated with CRP as inferred from a large meta-analysis over 20,000 blood samples where both DNAm and CRP was measured. Here, there are two choices: sigCRP.Rd contains a 1765 CRP-signature that is not adjusted for variations between memory and naive T-cells. sigCRPint.Rd contains a 62 CpG CRP-signature that is adjusted for variations between memory and naive T-cells.
### beta.m: normalized beta-valued DNAm data matrix with rownames the CpG identifiers. Missing values should be imputed.

### Output:
### score.v: the vector of CRP-estimates.

load("sigCRP.Rd");
load("sigCRPint.Rd");
ComputeCRPscore <- function(beta.m,sigCRP.v){
   common.v <- intersect(names(sigCRP.v),rownames(beta.m));
   print(paste("A fraction ",length(common.v)/length(sigCRP.v)," of CRP probes have been found. Number found is=",length(common.v),sep=""));
   match(common.v,names(sigCRP.v)) -> map1.idx;
   match(common.v,rownames(beta.m)) -> map2.idx;
   tmp.m <- beta.m[map2.idx,];
   z.m <- (tmp.m - rowMeans(tmp.m))/apply(tmp.m,1,sd);
   score.v <- as.vector(cor(z.m,sign(sigCRP.v[map1.idx])));
   return(score.v);
}


