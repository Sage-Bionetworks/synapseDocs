---
title: Genome Browser
layout: article
excerpt: How to Configure the Genome Browser Widget
category: howto
---

## Biodalliance Setup

* Species = Supports human (hg19/Gr37) and mouse (mm10/Grch38) genomes
* chr = Chromosome number 
* viewStart = Start position
* viewEnd  = End position

## Supported File Types

### BIGWIG

* Source name = Track name
* File = synID of a bigwig file (.bw, .bigWig)
* Height = Height of the track (pixels)
* Color = Color of the track

### VCF/BED

**Note:** To embed vcf and bed files, the files must be in the correct format.  Please view how to prepare vcf and bed files below if they are not in the right format.

#### VCF (.vcf.gz **AND** .vcf.gz.tbi)

* Source name = Track name
* File = synID of a compressed vcf file (.vcf.gz)
* Tabix file: synID of a tabix index file (.vcf.gz.tbi)
* Height = Height of a datapoint glyph in the track (pixels)
* Color = Color of the track

#### BED (.bed.gz **AND** .bed.gz.tbi)

* Source name = Track name
* File = synID  of a compressed vcf file (.vcf.gz)
* Tabix file: synID  of a tabix index file (.vcf.gz.tbi)
* Height = Height of a datapoint glyph in the track (pixels)
* Color = Color of the track

#### Preparing VCF and BED Files

1. [Download](http://sourceforge.net/projects/samtools/files/tabix/) and build the [tabix and bgzip](http://www.htslib.org/doc/tabix.html) programs
2. Compress your vcf or bed file using bgzip (example.vcf -> example.vcf.gz, example.bed -> example.bed.gz)
{row}
 {column width=6}

```bash
#vcf
bgzip example.vcf
```

 {column}
 {column width=6}

```bash
#bed
bgzip example.bed
```

{column}
{row}

3. Create a tabix index file for the bgzip-compressed vcf or bed (example.vcf.gz.tbi, example.bed.gz.tbi)
{row}
 {column width=6}

```bash
#vcf
tabix -p vcf example.vcf.gz
```

 {column}
 {column width=6}

```bash
#bed
tabix -p bed example.bed.gz
```

{column}
{row}

4. Upload both onto Synapse and enjoy [Biodalliance](http://www.biodalliance.org/)!
