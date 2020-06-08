					Path variables
| Variables             | Description                               |
|-----------------------|-------------------------------------------|
| train_path            | Path to the training dataset              |
| test_path             | Path to the testing dataset               |
| features_path         | Path to the variables list                |
| train_activities_path | Path to the matching training activities  |
| test_activities_path  | Path to the matching testing activities   |
| subject_train_path    | Path to the training subject number       |
| subject_test_path     | Path to the testing subject number        |

				Custom Variables used
					
| Name           | Description                                                                                                 |
|----------------|-------------------------------------------------------------------------------------------------------------|
| features       | Gets all the features from the path features_path removing all unwanted leading numbers and space           |
| train_df       | Our raw dataframe created from training set                                                                 |
| test_df        | Our raw dataframe created from testing set                                                                  |
| dataset        | Merging train_df and test_df                                                                                |
| mean_columns   | Dataframe containing all the columns with mean function                                                     |
| std_columns    | Dataframe containing all the columns with standard deviation function                                       |
| second_part    | Merging mean_columns and std_columns for second exercise                                                    |
| train_activity | Contains all the train activity values in readable format eg. 1 for "Walking"                               |
| test_activity  | Contains all the test activity values in readable format                                                    |
| activity       | Combining train_activity and test_activity                                                                  |
| funcNames      | Contains list of all function names in column headers eg: mean() after cleaning                             |
| funcVariables  | Contains list of all variable names in column headers eg: tBodyAcc after cleaning                           |
| index          | Contains column name indices whose names have to be changed eg: angle(tBodyAcc) does not need to be changed |
| subject_train  | List of subjects numbers for training set from subject_train_path                                           |
| subject_test   | List of subjects numbers for testing set from subject_test_path                                             |
| tidy           | Dataset with only unique columns and aggregate mean of all variables for each activity for each subject     |

				Custom Functions used
				
| Function Name | Description                                                                                                    |
|---------------|----------------------------------------------------------------------------------------------------------------|
| into_df       | Our function that reads the data paths and returns converting them into suitable dataframe with column headers |
| create_name   | Function which converts activity values to names                                                               |