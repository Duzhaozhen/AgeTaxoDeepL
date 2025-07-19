### CompNoiseClock.R
load("noise399CpG.Rd");
### INPUT
### noiseCpG.v: noise clock CpGs
### nbeta.m: BMIQ normalized DNAm data matrix
### estF12CT.m: Estimated 12 IC type fractions, rows label samples ordered as columns of nbeta.m; as estimated using EpiDISH

CompNoiseClock <- function(noiseCpG.v=noise399CpG.v,nbeta.m,estF12CT.m=NULL){

    tmp.m <- nbeta.m[match(intersect(noiseCpG.v,rownames(nbeta.m)),rownames(nbeta.m)),];
    print(dim(tmp.m));
    adev.m <- abs(tmp.m-rowMeans(tmp.m));
    score1.v <- colMeans(adev.m);

    ### adjust for 12 IC fractions
    score2.v <- NULL;
    if(!is.null(estF12CT.m)){
     lm.o <- lm(t(tmp.m) ~ estF12CT.m);
     res.m <- t(lm.o$res);
     adev.m <- abs(res.m-rowMeans(res.m));
     score2.v <- colMeans(adev.m);
    }
    return(list(noise=score1.v,noiseADJ=score2.v));
}


