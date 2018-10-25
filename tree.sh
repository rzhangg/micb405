

DIRECTORY=/projects/micb405/resources/project_1
USER=$1
HOME=/home/$USER/project1
BAM=/home/$USER/bam
BCF=/home/$USER/bcf
VCF=/home/$USER/vcf
mkdir tree
TREE=/home/$USER/tree

# bwa index $HOME/ref_genome.fasta 
REFERENCE=$HOME/ref_genome.fasta
cd $HOME

if [ "$(ls -A $variant)" ]; then
    echo intree
    muscle -in /home/$USER/variant/variant.fasta -out $TREE/tree.mfa
    trimal -automated1 \
    -in $TREE/tree.mfa \
    -out $TREE/tree_trimal.mfa

    FastTree $TREE/tree_trimal.mfa \
    1>$TREE/tree.nwk
fi