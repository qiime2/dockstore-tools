#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_get_ncbi_genomes
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Fetch entire genomes and associated taxonomies and metadata using NCBI Datasets.
doc: Uses NCBI Datasets to fetch genomes for indicated taxa. Nucleotide sequences
  and protein/gene annotations will be fetched and supplemented with full taxonomy
  of every sequence.
inputs:
  taxon:
    doc: NCBI Taxonomy ID or name (common or scientific) at any taxonomic rank.
    type: string
  assembly_source:
    default: refseq
    doc: Fetch only RefSeq or GenBank genome assemblies.
    type: string
  assembly_levels:
    default:
    - complete_genome
    doc: Fetch only genome assemblies that are one of the specified assembly levels.
    type: string[]
  only_reference:
    default: true
    doc: Fetch only reference and representative genome assemblies.
    type: boolean
  tax_exact_match:
    default: false
    doc: If true, only return assemblies with the given NCBI Taxonomy ID, or name.
      Otherwise, assemblies from taxonomy subtree are included, too.
    type: boolean
  page_size:
    default: 20
    doc: The maximum number of genome assemblies to return per request. If number
      of genomes to fetch is higher than this number, requests will be repeated until
      all assemblies are fetched.
    type: long
  genome_assemblies:
    doc: Nucleotide sequences of requested genomes.
    type: string
  loci:
    doc: Loci features of requested genomes.
    type: string
  proteins:
    doc: Protein sequences originating from requested genomes.
    type: string
  taxonomies:
    doc: Taxonomies of requested genomes.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- get_ncbi_genomes
- inputs.json
outputs:
  genome_assemblies_file:
    doc: Nucleotide sequences of requested genomes.
    outputBinding:
      glob: $(inputs.genome_assemblies)
    type: File
  loci_file:
    doc: Loci features of requested genomes.
    outputBinding:
      glob: $(inputs.loci)
    type: File
  proteins_file:
    doc: Protein sequences originating from requested genomes.
    outputBinding:
      glob: $(inputs.proteins)
    type: File
  taxonomies_file:
    doc: Taxonomies of requested genomes.
    outputBinding:
      glob: $(inputs.taxonomies)
    type: File
