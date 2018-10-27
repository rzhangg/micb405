
DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
BAM=/home/$USER/bam
BCF=/home/$USER/bcf
VCF=/home/$USER/vcf
mkdir filter
mkdir variant
FILTER=/home/$USER/filter
CALL=/home/$USER/call
VARIANT=/home/$USER/variant
# bwa index $HOME/ref_genome.fasta
REFERENCE=$HOME/ref_genome.fasta
cd $HOME

if [ "$(ls -A $CALL)" ]; then
    echo inbam
    for f in $CALL/*.sorted.rmdup.raw.vcf; do
        prefix=$( basename $f | sed 's/.sorted.rmdup.raw.vcf//g' );
        echo $prefix;
        bcftools filter --exclude "QUAL < 200" $CALL/$prefix.sorted.rmdup.raw.vcf > $FILTER/$prefix.sorted.rmdup.filter.vcf
    done

fi

python /projects/micb405/resources/vcf_to_fasta_het.py -x $FILTER/ variant
mv $FILTER/*.fasta $VARIANT
mv $FILTER/*.tabular $VARIANT
