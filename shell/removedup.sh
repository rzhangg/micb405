DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
BAM=/home/$USER/bam
REFERENCE=$HOME/ref_genome.fasta
mkdir removedup

DUP=/home/$USER/removedup
SORTED=/home/$USER/sorted

if [ "$(ls -A $SORTED)" ]; then
    echo inbam
    for f in $SORTED/*.sorted.bam; do
        prefix=$( basename $f | sed 's/.sorted.bam//g' );
        echo $prefix;
        samtools rmdup $SORTED/$prefix.sorted.bam $DUP/$prefix.sorted.rmdup.bam
        samtools index $DUP/$prefix.sorted.rmdup.bam > $DUP/$prefix.sorted.rmdup.bam.bai
    done

fi
