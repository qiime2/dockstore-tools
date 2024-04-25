#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_quality_control_filter_reads
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Filter demultiplexed sequences by alignment to reference database.
doc: Filter out (or keep) demultiplexed single- or paired-end sequences that align
  to a reference database, using bowtie2 and samtools. This method can be used to
  filter out human DNA sequences and other contaminants in any FASTQ sequence data
  (e.g., shotgun genome or amplicon sequence data), or alternatively (when exclude_seqs
  is False) to only keep sequences that do align to the reference.
inputs:
  demultiplexed_sequences:
    doc: The sequences to be trimmed.
    type: File
  database:
    doc: Bowtie2 indexed database.
    type: File
  n_threads:
    default: 1
    doc: Number of alignment threads to launch.
    type: long
  mode:
    default: local
    doc: Bowtie2 alignment settings. See bowtie2 manual for more details.
    type: string
  sensitivity:
    default: sensitive
    doc: Bowtie2 alignment sensitivity. See bowtie2 manual for details.
    type: string
  ref_gap_open_penalty:
    default: 5
    doc: Reference gap open penalty.
    type: long
  ref_gap_ext_penalty:
    default: 3
    doc: Reference gap extend penalty.
    type: long
  exclude_seqs:
    default: true
    doc: Exclude sequences that align to reference. Set this option to False to exclude
      sequences that do not align to the reference database.
    type: boolean
  filtered_sequences:
    doc: The resulting filtered sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- quality_control
- filter_reads
- inputs.json
outputs:
  filtered_sequences_file:
    doc: The resulting filtered sequences.
    outputBinding:
      glob: $(inputs.filtered_sequences)
    type: File
