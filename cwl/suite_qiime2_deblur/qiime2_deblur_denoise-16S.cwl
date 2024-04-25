#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_deblur_denoise_16S
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Deblur sequences using a 16S positive filter.
doc: Perform sequence quality control for Illumina data using the Deblur workflow
  with a 16S reference as a positive filter. Only forward reads are supported at this
  time. The specific reference used is the 88% OTUs from Greengenes 13_8. This mode
  of operation should only be used when data were generated from a 16S amplicon protocol
  on an Illumina platform. The reference is only used to assess whether each sequence
  is likely to be 16S by a local alignment using SortMeRNA with a permissive e-value;
  the reference is not used to characterize the sequences.
inputs:
  demultiplexed_seqs:
    doc: The demultiplexed sequences to be denoised.
    type: File
  trim_length:
    doc: Sequence trim length, specify -1 to disable trimming.
    type: long
  left_trim_len:
    default: 0
    doc: Sequence trimming from the 5' end. A value of 0 will disable this trim.
    type: long
  sample_stats:
    default: false
    doc: If true, gather stats per sample.
    type: boolean
  mean_error:
    default: 0.005
    doc: The mean per nucleotide error, used for original sequence estimate.
    type: double
  indel_prob:
    default: 0.01
    doc: Insertion/deletion (indel) probability (same for N indels).
    type: double
  indel_max:
    default: 3
    doc: Maximum number of insertion/deletions.
    type: long
  min_reads:
    default: 10
    doc: Retain only features appearing at least min_reads times across all samples
      in the resulting feature table.
    type: long
  min_size:
    default: 2
    doc: In each sample, discard all features with an abundance less than min_size.
    type: long
  jobs_to_start:
    default: 1
    doc: Number of jobs to start (if to run in parallel).
    type: long
  hashed_feature_ids:
    default: true
    doc: If true, hash the feature IDs.
    type: boolean
  table:
    doc: The resulting denoised feature table.
    type: string
  representative_sequences:
    doc: The resulting feature sequences.
    type: string
  stats:
    doc: Per-sample stats if requested.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- deblur
- denoise_16S
- inputs.json
outputs:
  table_file:
    doc: The resulting denoised feature table.
    outputBinding:
      glob: $(inputs.table)
    type: File
  representative_sequences_file:
    doc: The resulting feature sequences.
    outputBinding:
      glob: $(inputs.representative_sequences)
    type: File
  stats_file:
    doc: Per-sample stats if requested.
    outputBinding:
      glob: $(inputs.stats)
    type: File
