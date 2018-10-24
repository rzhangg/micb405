mkdir project1
mkdir bam
DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
BAM=/home/$USER/bam

cp $DIRECTORY/ref_genome.fasta $HOME
bwa index $HOME/ref_genome.fasta 
REFERENCE=$HOME/ref_genome.fasta
cd $HOME

    for f in $DIRECTORY/*1.fastq.gz; do prefix=$( basename $f | sed 's/_1.fastq.gz//g' );
        echo $prefix;
        bwa mem -t 10 $HOME/ref_genome.fasta $DIRECTORY/$prefix\_1.fastq.gz $DIRECTORY/$prefix\_2.fastq.gz | samtools view -b > $BAM/$prefix.bam; 
        samtools sort $BAM/$prefix.bam -o $BAM/$prefix.sorted;
        samtools index $BAM/$prefix.sorted;
        # samtools mpileup -q 30 -u -f $HOME/ref_genome.fasta $BAM/$prefix.sorted > $BCF/$prefix.bcf -I;
        # bcftools call -O v -mv $BCF/$prefix.bcf > $VCF/$prefix.vcf;
    done


