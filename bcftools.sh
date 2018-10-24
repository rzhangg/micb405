
mkdir bcf
mkdir vcf
DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
BAM=/home/$USER/bam
BCF=/home/$USER/bcf
VCF=/home/$USER/vcf


# bwa index $HOME/ref_genome.fasta 
REFERENCE=$HOME/ref_genome.fasta
cd $HOME

if [ "$(ls -A $BAM)" ]; then
    echo inbam
    for f in $BAM/*.sorted; do 
        prefix=$( basename $f | sed 's/.sorted//g' );
        echo $prefix;
        samtools mpileup -q 30 -u -f $HOME/ref_genome.fasta $BAM/$prefix.sorted > $BCF/$prefix.bcf -I;
        bcftools call -O v -mv $BCF/$prefix.bcf > $VCF/$prefix.vcf;
    done
    mkdir variant
    python /projects/micb405/resources/vcf_to_fasta_het.py -h $VCF home/$USER/variant
fi