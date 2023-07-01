# tidy_elsi
The Urban Insitute's Education Data package is a terrific resource for loading school and district data into R (https://github.com/UrbanInstitute/education-data-package-r). However, not all variables are available, so sometimes it is necessary to download these from ELSI (https://nces.ed.gov/ccd/elsi/tableGenerator.aspx). Tidying these files and incorporating them into R can be a real pain. 

The purpose of this code  is to read data files from ELSI into R. This code should be used once you have downloaded a data file from ELSI. Please pay careful attention to the formatting query requirements - these are a bit tedious, but the package will save you some time if used correctly.


# An Example - One Variable
Let's say you want to gather data on school type. You go to [ELSI](https://nces.ed.gov/ccd/elsi/tableGenerator.aspx), gather data for public schools for years 2000-2001 through 2019-2020. 

To download the data in a format that will work with tidy_elsi, you need the following variables: School Name [Public School] Latest available year, State Name [Public School] Latest available year, State Abbr [Public School], School ID - NCES Assigned [Public School], Agency ID - NCES Assigned [Public School]. You will also select School Type [Public School], or whichever variable you wish to use. You can then apply appropriate filters and download your file as a csv. Let's say your files is saved as "elsi_type.csv".

To assign your data to a tidy table in R, you can write 
`df <- elsi_table("elsi_type.csv", 
"School Type [Public School]", 
"school_type")`. 
You may need to change the first function argument based on the filepath. 

# An Example - Multiple Variables
The real utility of tidy_elsi comes when you are attempting to download many variables at once from [ELSI](https://nces.ed.gov/ccd/elsi/tableGenerator.aspx). Let's say you want the number of free-lunch-eligible students in each school in addition to the school type. 

In this case, you should download two _separate_ .csv files. Both will contain the following variables: School Name [Public School] Latest available year, State Name [Public School] Latest available year, State Abbr [Public School], School ID - NCES Assigned [Public School], Agency ID - NCES Assigned [Public School]. One will contain the variable School Type [Public School] (we can call this "elsi_type.csv"), and the other will contain the variable Free Lunch Eligible [Public School] (we can call this "elsi_fl.csv"). 

Now, you can assign your data to a tidy table in R by writing 
`df <- elsi_table(list("elsi_type.csv", "elsi_fl.csv"), 
list("School Type [Public School]", "Free Lunch Eligible [Public School]"), 
list("school_type", "free_lunch"))`. 
You may need to change the first function arguments based on the filepaths. 

