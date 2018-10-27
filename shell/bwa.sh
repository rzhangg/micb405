mkdir ref
mkdir bam
mkdir sorted

USER=$1

REF=/home/$USER/ref
DIRECTORY=/projects/micb405/resources/project_1
cp $DIRECTORY/ref_genome.fasta $REF
bwa index $REF/ref_genome.fasta



BAM=/home/$USER/bam
REFERENCE=$HOME/ref_genome.fasta
SORTED=/home/$USER/sorted

cd $HOME

    for f in $DIRECTORY/*1.fastq.gz; do prefix=$( basename $f | sed 's/_1.fastq.gz//g' );
        echo $prefix;
        bwa mem -t 40 $REF/ref_genome.fasta $DIRECTORY/$prefix\_1.fastq.gz $DIRECTORY/$prefix\_2.fastq.gz | samtools view -b > $BAM/$prefix.bam;
        samtools sort -@30 $BAM/$prefix.bam -o $SORTED/$prefix.sorted.bam;

    done
