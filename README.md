# CrossLake Score Sheets

This application is a solution to the CrossLake Ruby Engineer new hire assessment.

The problem stated succinctly follows:

Create a simple application that will take a file with input containing reports, tracks, and indicators. You will parse the file based on a specified format. The application will calculate track scores based on individual indicator scores. It will also generate a report score, which is the average of all the track scores.

## Approach

It is possible to satisfy the requirments of this solution by reading the input file into a hash table representing Reports, Tracks and Indicators and looping through the table elements computing scores.

However, given that we expect the solution to be production ready code similar to what we might write during our day to day, my approach was to develop something somewhat more robust and scalable

To that end I chose the following:
* That the solution should be devloped in a Ruby on Rails application ( to leverage gems such as standardrb and rspec as well as features such as model validations )
* That the generated report should be persisted ( In an production environment I expect the reports to be saved and trending analysis to be performed over time )

Along with the above stiplulated design choices, the following assumptions were made:
1) We must allow for multiple users running scoring sheets concurrently
2) External_ids ( Report/Track/Indicator identifiers ) are unique within the context of a scoring sheet run
3) Computed scores will be rounded to 2 decimal places


The proposed solution has been decomposed into 4 model objects and 2 service objects as follows:

- ScoringSheet - Identifies an instance of a report run.  You can provide an optional company_name if you want to track runs by company
- Report - A model which includes tracks and belongs to the scoring_sheet
- Track - A model which includes indicators and belongs to a report
- Indicator - An model which includes a weight and score and belongs to a task

- ImportService - a service which loads data from given input file into the model objects
- ScoringService - a service which computes the scores for all tasks and reports and persists them in the appropriate models

*Note: All models have validations that ensure association integrity as well as the weight and score range values specified in the problem statement


## Technical Details & Dependencies

Ruby Version: 3.1
Rails Version: 7.0
Persistance: SqlLite
TestFramework: rspec

## Development environment setup

1) clone project at git@github.com:aktfrikshun/crosslinks_score_sheet.git
2) cd project folder
3) bundle install
4) rails db:setup
5) rails db:migrate

## Execution

To run a report you can utilize the Rails Runner as follows:
> rails r "ScoreReport.generate('FrikShun',Rails.root.join('spec','test_files','score_sample.txt').to_s)"

*Note:  The 2nd parameter of ScoreReport.generate can be a path to any valid input file


## Tests

To run the test suite, cd into the project folder and run:
> rspec

## Clearing data

You can clear the db of all runs by executing:
> rails r ScoringSheet.destroy_all
