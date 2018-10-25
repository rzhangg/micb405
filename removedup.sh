DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
BAM=/home/$USER/bam
REFERENCE=$HOME/ref_genome.fasta
mkdir removedup
DUP=/home/$USER/removedup

if [ "$(ls -A $BAM)" ]; then
    echo inbam
    for f in $BAM/*.sorted; do 
        prefix=$( basename $f | sed 's/.sorted//g' );
        echo $prefix;
        samtools rmdup $BAM/$prefix.sorted $DUP/$prefix.sorted.rmdup.bam
    done

fi
