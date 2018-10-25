# MICB405 Project 1 Team 7

1. git clone the file or Download the .sh file

2. Make changes and commit and push

3. to move to server use: scp project1.sh {user}@orca-wg.bcgsc.ca:/home/{user}

4. every shell script will take in your username as 1st arguement e.g ./bwa.sh rzhang_mb18

4.a tree.sh will take in 3 arguements ./tree.sh {username} {the variant fasta} {output file name}

5. order of execution
    1 bwa.sh
    2 removedup.sh
    3 bcftools.sh
    4 filter.sh
    5 tree.sh

6. use scp to retrieve your tree file to local 
