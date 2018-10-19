mkdir project1
mkdir bam
DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
BAM=/home/$USER/bam
cp $DIRECTORY/ref_genome.fasta $HOME
# cd /project1


# gunzip *.gz 
# mkdir 0_fastq 
# mv *.fastq /home/$DIRECTORY/project1/0_fastq

bwa index $HOME/ref_genome.fasta 
REFERENCE = $HOME/ref_genome.fasta
cd $HOME
if [ "$(ls -A $BAM)" ]; then
    for f in $BAM/*.bam; do 
        prefix=$( basename $f | sed 's/bam//g' );
        echo $prefix;
        samtools sort $BAM/$prefix.bam -o $BAM/$prefix.sorted;
        samtools index $BAM/$prefix.sorted;
    done
else
    for f in $DIRECTORY/*1.fastq.gz; do prefix=$( basename $f | sed 's/_1.fastq.gz//g' );
        echo $prefix;
        bwa mem -t 4 $HOME/ref_genome.fasta $DIRECTORY/$prefix\_1.fastq.gz $DIRECTORY/$prefix\_2.fastq.gz | samtools view -b > $BAM/$prefix.bam; 
        samtools sort $BAM/$prefix.bam -o $BAM/$prefix.sorted;
        samtools index $BAM/$prefix.sorted;
    done
fi
