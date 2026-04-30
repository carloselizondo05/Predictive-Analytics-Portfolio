proc import
/* out keyword is used to name a table*/
out=heart
/* Datafile keyword takes the path of the file from the hard disk*/
datafile ='/home/u64430375/Labs CIND119/Assignment 1/heart.csv'
/* dbms= csv replace is telling SAS it is a csv file. */
dbms=csv replace;
/* Getnames=yes will use first line of the csv file as column names*/
getnames=yes;
run;

/* data keyword takes the name of the SAS table imported as auto_csv.
print keyword outputs the contents in Results Viewer */
proc print data=heart(obs=10);
title "Heart Dataset";
run;
/*Show dataset metadata (Total rows and variable types) */
proc contents data=heart;
    title "Dataset Summary: Total Rows and Variables";
run;

/*Perfoming basic analysis using proc means*/
proc means data=heart;
	title" Summary Statistics for Heart Dataset";
run;

/*Standardize numerical attributes */
proc stdize data=heart out=heart_std method=std;
    var age trestbps chol thalach oldpeak;
run;

proc print data=heart_std (obs=10);
    title "Standardized Data (First 10 Rows)";
run;


/* K-Means Clustering for K=2, 3, 4, 5 */
proc fastclus data=heart_std maxclusters=2 out=clust2 summary;
    var age trestbps chol thalach oldpeak;
run;
proc fastclus data=heart_std maxclusters=3 out=clust3 summary;
    var age trestbps chol thalach oldpeak;
run;
proc fastclus data=heart_std maxclusters=4 out=clust4 summary;
    var age trestbps chol thalach oldpeak;
run;
proc fastclus data=heart_std maxclusters=5 out=clust5 summary;
    var age trestbps chol thalach oldpeak;
run;

/*Visualization of the Cluster Labels, using K=3 */
proc sgplot data=clust3;
    scatter y=chol x=age / group=cluster;
    title "K-Means Clustering: K=3 Groups";
run;

/* Visualization of the original data labels */
proc sgplot data=heart;
    scatter y=chol x=age / group=target;
    title "Original Labels: Cholesterol vs Age";
run;