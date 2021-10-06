*Instalar psecta y moremata ssc install moremata
clear

search psecta
ssc install moremata

cd "C:\Users\Juancho\Dropbox\Mi PC (LAPTOP-ECL58G5D)\Desktop\Convergence FSU\Data"
import excel "CGE_91_18.xls", firstrow clear
reshape long TT, i(Country) j(Year)
*use ps2009
egen id=group(Country)
xtset id Year
*gen lnpgdp=ln(pgdp)

save "CGE_91_18.dta", replace

* Generating the trends
pfilter TT, method(hp) trend(Tr1) smooth(400)

* rename Departments Departamentos

*rename V2 T2
*rename V3 T3
*rename V4 T4
*rename V5 T5

*logtreg lnpgdp,  kq(0.333)


psecta Tr1, name(Country) kq(0.2) gen(club) noprt
mat b=e(bm)
mat t=e(tm)
mat result1=(b \ t)
matlist result1, border(rows) rowtitle("log(t)") format(%9.3f) left(4)

scheckmerge Tr1,  kq(0.2) club(club) mdiv
mat b=e(bm)
mat t=e(tm)
mat result2=(b \ t)
matlist result2, border(rows) rowtitle("log(t)") format(%9.3f) left(4)

imergeclub Tr1, name(Country) kq(0.2) club(club) gen(finalclub1) noprt
mat b=e(bm)
mat t=e(tm)
mat result3=(b \ t)
matlist result3, border(rows) rowtitle("log(t)") format(%9.3f) left(4)
***
* Do all the statistical staff for finalclub1 (No if the case that clubs cannot be merged!)
* imergeclub Tr1, name(Country) kq(0.2) club(finalclub1) gen(finalclub2) noprt
*****
export excel using "CLUSTERS_CGE_91_18_.xlsx", firstrow(variables) nolabel replace

****
********************* GDP analysis ***************************
****
clear
import excel "GDPpp_91_18.xlsx", firstrow clear
reshape long TTT, i(Country) j(Year)
*use ps2009
egen id=group(Country)
xtset id Year
gen TT=ln(TTT)

save "GDPpp_91_18.dta", replace

* Generating the trends
pfilter TT, method(hp) trend(Tr1) smooth(400)

* rename Departments Departamentos

*rename V2 T2
*rename V3 T3
*rename V4 T4
*rename V5 T5

*logtreg lnpgdp,  kq(0.333)


psecta Tr1, name(Country) kq(0.2) gen(club) noprt
mat b=e(bm)
mat t=e(tm)
mat result1=(b \ t)
matlist result1, border(rows) rowtitle("log(t)") format(%9.3f) left(4)


scheckmerge Tr1,  kq(0.2) club(club) mdiv
mat b=e(bm)
mat t=e(tm)
mat result2=(b \ t)
matlist result2, border(rows) rowtitle("log(t)") format(%9.3f) left(4)

imergeclub Tr1, name(Country) kq(0.2) club(club) gen(finalclub1) noprt
mat b=e(bm)
mat t=e(tm)
mat result3=(b \ t)
matlist result3, border(rows) rowtitle("log(t)") format(%9.3f) left(4)
***
* Do all the statistical staff for finalclub1


imergeclub Tr1, name(Country) kq(0.2) club(finalclub1) gen(finalclub2) noprt
mat b=e(bm)
mat t=e(tm)
mat result3=(b \ t)
matlist result3, border(rows) rowtitle("log(t)") format(%9.3f) left(4)

*****
export excel using "CLUSTERS_GDPpp_91_18_.xlsx", firstrow(variables) nolabel replace


