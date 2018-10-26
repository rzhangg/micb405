
DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
BAM=/home/$USER/bam
BCF=/home/$USER/bcf
VCF=/home/$USER/vcf
mkdir filter
FILTER=/home/$USER/filter
# bwa index $HOME/ref_genome.fasta 
REFERENCE=$HOME/ref_genome.fasta
cd $HOME

if [ "$(ls -A $VCF)" ]; then
    echo inbam
    for f in $VCF/*.vcf; do 
        prefix=$( basename $f | sed 's/.vcf//g' );
        echo $prefix;
        bcftools filter --exclude "QUAL < 200" $VCF/$prefix.vcf > $FILTER/$prefix.filter.vcf
    done
    
fi
mkdir variant
python /projects/micb405/resources/vcf_to_fasta_het.py -x $FILTER/ variant
mv $FILTER/*.fasta /home/$USER/variant
mv $FILTER/*.tabular /home/$USER/variant