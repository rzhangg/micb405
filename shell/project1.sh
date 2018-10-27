mkdir project1
mkdir ref
mkdir bam
mkdir sorted
mkdir removedup
mkdir sortedindex
mkdir call
mkdir filter
mkdir variant
mkdir tree


USER=$1
OUTPUT=$2

HOME=/home/$USER/project1
REF=/home/$USER/ref
DIRECTORY=/projects/micb405/resources/project_1

cp $DIRECTORY/ref_genome.fasta $REF
bwa index $REF/ref_genome.fasta

REFERENCE=$REF/ref_genome.fasta
BAM=/home/$USER/bam
SORTED=/home/$USER/sorted
DUP=/home/$USER/removedup
SORTEDINDEX=/home/$USER/sortedindex
CALL=/home/$USER/call
FILTER=/home/$USER/filter

VARIANT=/home/$USER/variant
TREE=/home/$USER/tree

# bwa index $HOME/ref_genome.fasta


for f in $DIRECTORY/*1.fastq.gz; do prefix=$( basename $f | sed 's/_1.fastq.gz//g' );
     echo $prefix;
    bwa mem -t 40 $REFERENCE $DIRECTORY/$prefix\_1.fastq.gz $DIRECTORY/$prefix\_2.fastq.gz | samtools view -b > $BAM/$prefix.bam;
    samtools sort -@30 $BAM/$prefix.bam -o $SORTED/$prefix.sorted.bam;
done

if [ "$(ls -A $SORTED)" ]; then
    echo inbam
    for f in $SORTED/*.sorted.bam; do
        prefix=$( basename $f | sed 's/.sorted.bam//g' );
        echo $prefix;
        samtools rmdup $SORTED/$prefix.sorted.bam $DUP/$prefix.sorted.rmdup.bam;
        samtools index $DUP/$prefix.sorted.rmdup.bam > $SORTEDINDEX/$prefix.sorted.rmdup.bam.bai;
        samtools index $SORTED/$prefix.sorted.bam > $SORTEDINDEX/$prefix.sorted.bam.bai;
    done

fi




if [ "$(ls -A $DUP)" ]; then
    echo inbam
    for f in $DUP/*.sorted.rmdup.bam; do
        prefix=$( basename $f | sed 's/.sorted.rmdup.bam//g' );
        echo $prefix;
	    bcftools mpileup --threads 40 --fasta-ref $HOME/ref_genome.fasta $DUP/$prefix.sorted.rmdup.bam | bcftools call -mv - > $CALL/$prefix.sorted.rmdup.raw.vcf;
    done
fi



if [ "$(ls -A $CALL)" ]; then
    echo inbam
    for f in $CALL/*.sorted.rmdup.raw.vcf; do
        prefix=$( basename $f | sed 's/.sorted.rmdup.raw.vcf//g' );
        echo $prefix;
        bcftools filter --exclude "QUAL < 200" $CALL/$prefix.sorted.rmdup.raw.vcf > $FILTER/$prefix.sorted.rmdup.filter.vcf;
    done

fi

python /projects/micb405/resources/vcf_to_fasta_het.py -x $FILTER/ variant
mv $FILTER/*.fasta $VARIANT
mv $FILTER/*.tabular $VARIANT


if [ "$(ls -A $variant)" ]; then
    echo intree
    muscle -in /home/$USER/variant/variant.fasta -out $TREE/$variant.mfa;
    echo donemuscle
    trimal -automated1 -in $TREE/$FILE.mfa -out $TREE/$FILE.trimal.mfa;
    raxml-ng --all --msa $TREE/$FILE.trimal.mfa \
    --model LG+G2 --tree rand{100} --bs-trees 20 \
    --threads 1 --seed 12345 --prefix ~/tree --redo;
fi