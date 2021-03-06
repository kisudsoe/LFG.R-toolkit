# 2016-03-24 THU-----
# Line area plot for fibrosis network (2)
# This code edited from line plot "liness (2016-03-21)"
# Minor edit 01 (2016-03-31 THU) - 
# Minor edit 02 (2016-04-01 FRI) - Add 'data_total'
data = input(1) # Input signal data
data_total = input(1) # input total data
group = input(0) # input group info : 14, 14, 14, 29, 29, 29, 44, 44, 44...

ss.areaPlot = function(data,srch='',type=1,group) {
	# Search string in srch for row id
	row = which(apply(data[,1:5],1, function(x) any(grepl(srch,x))))[1]
  
	# Get data from the row
	datrow = data[row,]
	print(datrow)
	title=paste(datrow[1],' ',unlist(datrow[2]),' ',
				unlist(datrow[5]),' (',unlist(datrow[3]),')')
	title2=paste(unlist(datrow[5]),'\n',unlist(datrow[2]),
				' (',unlist(datrow[3]),')')
	title3=paste(unlist(datrow[5]),'\n',unlist(datrow[2]),
				' (',unlist(datrow[4]),')')
	datlin = as.numeric(datrow[6:length(datrow)])
	ymax = max(datlin)
	ymin = min(datlin)
	if(ymax-ymin<1.5) {
		yrng = c(ymin-0.2,ymax+0.2)
	} else
		yrng = c(ymin-0.5,ymax+0.5)
  
	group.lv = levels(as.factor(unlist(group)))
	n = length(group.lv)
	print(group.lv)
  
	for(l in 1:n) {
		id = which(group==group.lv[l])
		if(l==1) {
			datlin.max = max(datlin[id])
			datlin.min = min(datlin[id])
			datlin.mid = median(datlin[id])
		} else {
			datlin.max = c(datlin.max,max(datlin[id]))
			datlin.min = c(datlin.min,min(datlin[id]))
			datlin.mid = c(datlin.mid,median(datlin[id]))
		}
	}
	if(type==1) {
		par(mar=c(0.5,2,0.5,0.5))
		plot(datlin.max,
			main='',
			col="gray50",
			type="l",
			xaxt="n",
			ylim=yrng)
	} else {
		par(mar=c(0.5,2.5,8,0.5))
		plot(datlin.max,
			main=title3,
			cex.main=3.5,
			col="gray50",
			type="l",
			xaxt="n",
			ylim=yrng)
	}
  
	rect(1.5,yrng[1],2.5,yrng[2],col="gray90",lty=0)
	rect(3.5,yrng[1],4.5,yrng[2],col="gray90",lty=0)
	rect(5.5,yrng[1],6.5,yrng[2],col="gray90",lty=0)
	rect(7.5,yrng[1],8.5,yrng[2],col="gray90",lty=0)
	rect(9.5,yrng[1],10.3,yrng[2],col="gray90",lty=0)
	text(1,yrng[1]+0.1,"14")
	text(2,yrng[1]+0.1,"29")
	text(3,yrng[1]+0.1,"44")
	text(4,yrng[1]+0.1,"53")
	text(5,yrng[1]+0.1,"73")
	text(6,yrng[1]+0.1,"83")
	text(7,yrng[1]+0.1,"95")
	text(8,yrng[1]+0.1,"109")
	text(9,yrng[1]+0.1,"120")
	text(10,yrng[1]+0.1,"135")
	if(type==1) {
		text(5.5,yrng[2]-0.1,title,cex=1.2,font=2)
	}
  
	lines(datlin.max,col="gray50",lwd=1)
	lines(datlin.min,col="gray50",lwd=1)
  
	datlin.minr = rev(datlin.min)
	graytrans = rgb(50,50,50,100,maxColorValue=255)
	polygon(c(1:10,10:1),c(datlin.max,datlin.minr),col=graytrans,border=NA)
  
	lines(datlin.mid,col="black",lwd=3)
}

ss.areaPlot(data,'Timp2',type=2,group) # type=1/2