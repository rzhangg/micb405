mkdir fastqc
DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
FASTQC=/home/$USER/fastqc
cd $HOME

    for f in $DIRECTORY/*1.fastq.gz; do prefix=$( basename $f | sed 's/_1.fastq.gz//g' );
        echo $prefix;
        fastqc --threads 20 -o $FASTQC $DIRECTORY/$prefix\_?.fastq.gz;

    done
