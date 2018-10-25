

DIRECTORY=/projects/micb405/resources/project_1
USER=$1
FILE=$2
OUTPUT=$3
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
    muscle -in /home/$USER/variant/$FILE.fasta -out $TREE/$FILE.mfa
    trimal -automated1 -in $TREE/$FILE.mfa -out $TREE/$FILE_trimal.mfa
    FastTree $TREE/$FILE_trimal.mfa 1>$TREE/$OUTPUT.nwk
fi