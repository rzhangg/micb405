# MICB405 Project 1 Team 7

1. git clone the file or Download the .sh file

2. Make changes and commit and push

3. to move to server use: scp project1.sh {user}@orca-wg.bcgsc.ca:/home/{user}

4. every shell script will take in your username as 1st arguement e.g ./bwa.sh rzhang_mb18

5. run project1.sh in /home/user to run entire pipeline, takes in 2 arguements 1st is username 2nd output treefile name e.g ./project1.sh rzhang_mb18 raxmltree

6. Output of project1.sh should be in /home/user/project1/ as .raxml files

5. Each pipeline is split into separate files as well for testing and robustsness
    order of execution
    1 bwa.sh
    2 removedup.sh
    3 bcftools.sh
    4 filter.sh
    5 tree.sh

6. use scp to retrieve your tree file to local 
