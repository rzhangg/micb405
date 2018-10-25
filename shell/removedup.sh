DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
BAM=/home/$USER/bam
REFERENCE=$HOME/ref_genome.fasta
mkdir removedup
mkdir removedupindex
DUP=/home/$USER/removedup
SORTED=/home/$USER/sorted
DUPINDEX=/home/$USER/removedupindex
if [ "$(ls -A $SORTED)" ]; then
    echo inbam
    for f in $SORTED/*.sorted; do 
        prefix=$( basename $f | sed 's/.sorted//g' );
        echo $prefix;
        samtools rmdup $SORTED/$prefix.sorted $DUP/$prefix.sorted.rmdup.bam
        samtools index $DUPINDEX/$prefix.sorted.rmdup.bam
    done

fi
