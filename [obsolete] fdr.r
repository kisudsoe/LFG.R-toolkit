# FDR function by Kim, Seung-Soo
# v1.0_2016-04-21 THU
## raw.p is a vector with p-values from t-test or ANOVA.
source("http://bioconductor.org/biocLite.R") # setup only first time
biocLite("qvalue")

fdrs = function(raw.p) {
	raw.p = as.vector(raw.p)

	library(fdrtool)
	#pval.estimate.eta0(p1,method="bootstrap") # Draw plot
	q = fdrtool(raw.p,statistic="pvalue")
	fdrtool.qval = q$qval
	cat('(1/9) fdrtool.tfdr\t-> done\n')
	fdrtool.lfdr = q$lfdr
	cat('(2/9) fdrtool.dfdr\t-> done\n')
  
	library(qvalue)
	q2 = qvalue(raw.p)
	qvalue.fdr = q2$qvalues
	cat('(3/9) qvalue.fdr\t-> done\n')
  
	stat.BH.fdr = p.adjust(raw.p,"BH")
	cat('(4/9) stat.fdr.BH\t-> done\n')
	#stat.Hommel = p.adjust(raw.p,"hommel") # take time too long
	cat('(5/9) stat.Hommel\t-> skip, Hommel takes time too long.\n')
	stat.BY = p.adjust(raw.p,"BY")
	cat('(6/9) stat.BY\t\t-> done\n')
	stat.Hochberg = p.adjust(raw.p,"hochberg")
	cat('(7/9) stat.Hochberg\t-> done\n')
	stat.Holm = p.adjust(raw.p,"holm")
	cat('(8/9) stat.Holm\t\t-> done\n')
	stat.Bonferroni = p.adjust(raw.p,"bonferroni")
	cat('(9/9) stat.Bonferroni\t-> done\n')
  
	result = data.frame(raw.p,
						fdrtool.qval,
						fdrtool.lfdr,
						qvalue.fdr,
						stat.BH.fdr,
						#stat.Hommel,
						stat.BY,
						stat.Hochberg,
						stat.Holm,
						stat.Bonferroni)
	#rownames(result) = rown # set row names <- not this time.
  
	## Plot draw start ##
	result.r = result[order(raw.p),] # re-ordered by raw.p
  
	matplot(result.r$raw.p, result.r, xlim=c(0,1),ylim=c(0,1),
			main="Various multiple test correction methods",
			xlab="Raw p-value",
			ylab="Adjusted p-value",
			type="l",
			col=c("black",rainbow(9)), # Set color
			lty=1,
			lwd=2)
	legend('bottomright',
			legend=c("raw.p",
					"fdrtool.tfdr",
					"fdrtool.dlfdr",
					"qvalue.fdr",
					"stat.BH.fdr",
					#"stat.Hommel",
					"stat.BY",
					"stat.Hochberg",
					"stat.Holm",
					"stat.Bonfferoni"),
			col=c("black",rainbow(9)), # Set color
			cex=1,
			pch=16)
  
	x11()
	par(mfrow=c(2,2)) # 2x2 plot partition
	hist(raw.p, xlim=c(0,1))
	hist(fdrtool.qval, xlim=c(0,1))
	hist(stat.BH.fdr, xlim=c(0,1))
	hist(stat.Bonferroni, xlim=c(0,1))
  
	cat('\nPlot draw\t\t-> done\n')
	cat('----------------------------------')
	## plot draw done ##
  
	return(result)
}

pval_adj = fdrs(raw.p)