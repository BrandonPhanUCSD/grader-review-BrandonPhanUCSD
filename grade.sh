CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


if [[ -f student-submission/ListExamples.java ]]
then
	echo "File Found, continue!"
else
	echo "ListExamples.java not found."
	exit
fi

cp student-submission/ListExamples.java grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area

cd grading-area
javac -cp $CPATH ListExamples.java TestListExamples.java
if [[ $? -ne 0 ]]
then
	echo "Compilation Failed."
	exit
else
	echo "Compilation Success."
fi


java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > outputfile.txt
grep "Failures:" outputfile.txt > outputfile2.txt


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -s outputfile2.txt ]]
then
	echo "Failure, Grade 0"
else
	echo "No Failures, Grade 100%"
fi
