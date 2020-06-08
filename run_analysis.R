
#Making constant paths
train_path<-".\\UCI HAR Dataset\\train\\X_train.txt"
test_path<-"\.\UCI HAR Dataset\\test\\X_test.txt"
features_path<-".\\UCI HAR Dataset\\features.txt"
train_activities_path<-".\\UCI HAR Dataset\\train\\y_train.txt"
test_activities_path<-".\\UCI HAR Dataset\\test\\y_test.txt"
subject_train_path<-".\\UCI HAR Dataset\\train\\subject_train.txt"
subject_test_path<-".\\UCI HAR Dataset\\test\\subject_test.txt"

#Reading all column names from features file
features<-readLines(features_path)
#It contains leading unwanted numbers,replacing all leading numbers and space with nothing
features<-sub(".* ","",features)

#Our function that reads the data paths and returns converting them into suitable dataframe with column headers
into_df<-function(path)
{
df<-data.frame()
	r<-readLines(path)
	for(i in 1:length(r))
	{
		l<-unlist(strsplit((r[i])," "))
		l<-l[sapply(l,nchar)>0]
		df<-rbind(df,l,stringsAsFactors=FALSE)
	}
	names(df)<-features
	
	return(df)
}
#Passing training and testing paths to our function
train_df<-into_df(train_path)
test_df<-into_df(test_path)


#Concatenating both datasets 
dataset<-rbind(train_df,test_df)

##################################################################Second Part##############################################################################

#Just select all the columns which have 'mean' in them,same for 'std'
mean_columns<-grep(".*mean.*",names(dataset))
std_columns<-grep(".*std.*",names(dataset))

#Merging both and selecting those columns for second exercise(Total 79 columns)
second_part<-dataset[,append(mean_columns,std_columns)]

##################################################################Third Part##############################################################################
train_activity<-	readLines(train_activities_path)
test_activity<-	readLines(test_activities_path)
#Can read from file but just wrote it
create_name<-function(name)
{
	name[name=="1"]<-"Walking"
	name[name=="2"]<-"Walking_upstairs"
	name[name=="3"]<-"Walking_downstairs"
	name[name=="4"]<-"Sitting"
	name[name=="5"]<-"Standing"
	name[name=="6"]<-"Laying"
	
	return(name)
}
#Getting activities
train_activity<-create_name(train_activity)
test_activity<-create_name(test_activity)
#Merging for both train and test
activity<-append(train_activity,test_activity)
dataset2<-cbind(dataset,activity,stringsAsFactors=FALSE)
##################################################################Fourth Part##############################################################################
# We will name cols as function_name(variable_name) eg: mean(tBodyAccX)
library(stringr)
#First we will get the function names
funcNames<-str_extract(colnames(dataset2),"-.*-")
#-mean()-
funcNames<-str_replace_all(funcNames,c("-"="","\\("="","\\)"=""))
#Now extract function variables names
funcVariables<-str_replace(colnames(dataset2),"-.*-","")
##There will be NA for some such as angle(tBodyAccMean,gravity),we will leave them as it is
index<-which(!is.na(funcNames))
#Bring all together
colnames(dataset2)[index]<-paste0(funcNames[index],"(",funcVariables[index],")")
####################################################################Fifth Part##############################################################################

#We will have to add new columns for subjects
subject_train<-readLines(subject_train_path)
subject_test<-readLines(subject_test_path)
subject<-append(subject_train,subject_test)
dataset2<-cbind(dataset2,subject,stringsAsFactors=FALSE)

#Now we remove duplicate columns
dataset2<-dataset2[,unique(colnames(dataset2))]
#Convert into numeric to calculate mean
tidy<-dataset2[,1:477]
tidy<-sapply(tidy,as.numeric)
tidy<-cbind(tidy,dataset2[,478:479])
#Use aggregate func to group by activity,subject and average values
tidy<-aggregate(tidy[,1:477],tidy[,478:479],mean)


