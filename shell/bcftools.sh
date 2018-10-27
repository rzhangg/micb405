
mkdir bcf
mkdir vcf
DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
BAM=/home/$USER/bam
BCF=/home/$USER/bcf
VCF=/home/$USER/vcf
DUP=/home/$USER/removedup
mkdir filter
mkdir call
CALL=/home/$USER/call
FILTER=/home/$USER/filter
# bwa index $HOME/ref_genome.fasta
REFERENCE=$HOME/ref_genome.fasta
cd $HOME

if [ "$(ls -A $DUP)" ]; then
    echo inbam
    for f in $DUP/*.sorted.rmdup.bam; do
        prefix=$( basename $f | sed 's/.sorted.rmdup.bam//g' );
        echo $prefix;
	    bcftools mpileup --threads 40 --fasta-ref $HOME/ref_genome.fasta $DUP/$prefix.sorted.rmdup.bam | bcftools call -mv - > $CALL/$prefix.sorted.rmdup.raw.vcf;


    done
fi
