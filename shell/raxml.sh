

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
    muscle -in /home/$USER/variant/variant.fasta -out $TREE/$variant.mfa;
    echo donemuscle
    # trimal -automated1 -in $TREE/$FILE.mfa -out $TREE/$FILE.trimal.mfa;
    raxml-ng --all --msa $TREE/$FILE.mfa \
    --model GTR+G4 --tree rand{100} --bs-trees 20 \
    --threads 1 --seed 12345 --prefix ~/$OUTPUT --redo;
fi
