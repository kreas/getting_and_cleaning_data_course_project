# Getting and Cleaning Data - Course Project

**Timothy R. Warren**

Date: 2015-4-25

GitHub: https://github.com/kreas/getting_and_cleaning_data_course_project

## About
This repository represents my submission for the Coursa course project **Getting and Cleaning Data**. It is designed to collect, clean, and prepare data collected from activity recognition using a smartphones dataset.

## Description
`run_analysis.R` reads and parses a specific set of resources in order create a file containing *tidy*  data representing the average of each variable collected grouped by activity and subject.

Once `run_analysis.R` is executed the resuliting data can be found in the projects root directory titled *averages_by_subject.txt*.

## Directions
* Clone this git repository: `git@github.com:kreas/getting_and_cleaning_data_course_project.git`
* Open R Studio and set your working directory to the directory where you clone this repository.
* source run_analisys.R

## Requirement
The only library required to run this script is `plyr`