# Project_assignment

run_analysis.R description:

- set working directory
- load needed libraries
- read needed data files and load them to R -> fread() function
- select only columns with "mean()" and "std()" from data tables and add columns names using features txt file
- join activity code with activity labels 
- merge test and training data with function rbind() -> simply add rows as tables have same number of columns
- merge data with subject and activity files using cbind() function as tables have same number of rows
- add column names to first two colums -> "subject_id" and "activity"
- use aggregate() function to aggregate by "subject_id" and "activity"
- write the resulting tidy data to file using write.table function
