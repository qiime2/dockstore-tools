#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_deblur_denoise_other
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Deblur sequences using a user-specified positive filter.
doc: Perform sequence quality control for Illumina data using the Deblur workflow,
  including positive alignment-based filtering. Only forward reads are supported at
  this time. This mode of execution is particularly useful when operating on non-16S
  data. For example, to apply Deblur to 18S data, you would want to specify a reference
  composed of 18S sequences in order to filter out sequences which do not appear to
  be 18S. The assessment is performed by local alignment using SortMeRNA with a permissive
  e-value threshold.
inputs:
  demultiplexed_seqs:
    doc: The demultiplexed sequences to be denoised.
    type: File
  reference_seqs:
    doc: Positive filtering database. Keep all sequences aligning to these sequences.
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
- denoise_other
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
