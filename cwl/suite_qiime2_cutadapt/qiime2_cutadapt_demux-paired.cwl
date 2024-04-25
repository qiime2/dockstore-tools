#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_cutadapt_demux_paired
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Demultiplex paired-end sequence data with barcodes in-sequence.
doc: Demultiplex sequence data (i.e., map barcode reads to sample ids). Barcodes are
  expected to be located within the sequence data (versus the header, or a separate
  barcode file).
inputs:
  seqs:
    doc: The paired-end sequences to be demultiplexed.
    type: File
  q2cwl_metafile_forward_barcodes:
    doc: The sample metadata column listing the per-sample barcodes for the forward
      reads.
    type: File
  forward_barcodes:
    doc: Column name to use from 'forward_barcodes' file
    type: string
  q2cwl_metafile_reverse_barcodes:
    doc: The sample metadata column listing the per-sample barcodes for the reverse
      reads.
    type: File?
  reverse_barcodes:
    doc: Column name to use from 'reverse_barcodes' file
    type: string?
  forward_cut:
    default: 0
    doc: Remove the specified number of bases from the forward sequences. Bases are
      removed before demultiplexing. If a positive value is provided, bases are removed
      from the beginning of the sequences. If a negative value is provided, bases
      are removed from the end of the sequences. If --p-mixed-orientation is set,
      then both --p-forward-cut and --p-reverse-cut must be set to the same value.
    type: long
  reverse_cut:
    default: 0
    doc: Remove the specified number of bases from the reverse sequences. Bases are
      removed before demultiplexing. If a positive value is provided, bases are removed
      from the beginning of the sequences. If a negative value is provided, bases
      are removed from the end of the sequences. If --p-mixed-orientation is set,
      then both --p-forward-cut and --p-reverse-cut must be set to the same value.
    type: long
  anchor_forward_barcode:
    default: false
    doc: Anchor the forward barcode. The barcode is then expected to occur in full
      length at the beginning (5' end) of the forward sequence. Can speed up demultiplexing
      if used.
    type: boolean
  anchor_reverse_barcode:
    default: false
    doc: Anchor the reverse barcode. The barcode is then expected to occur in full
      length at the beginning (5' end) of the reverse sequence. Can speed up demultiplexing
      if used.
    type: boolean
  error_rate:
    default: 0.1
    doc: The level of error tolerance, specified as the maximum allowable error rate.
    type: double
  batch_size:
    default: 0
    doc: The number of samples cutadapt demultiplexes concurrently. Demultiplexing
      in smaller batches will yield the same result with marginal speed loss, and
      may solve "too many files" errors related to sample quantity. Set to "0" to
      process all samples at once.
    type: long
  minimum_length:
    default: 1
    doc: Discard reads shorter than specified value. Note, the cutadapt default of
      0 has been overridden, because that value produces empty sequence records.
    type: long
  mixed_orientation:
    default: false
    doc: Handle demultiplexing of mixed orientation reads (i.e. when forward and reverse
      reads coexist in the same file).
    type: boolean
  cores:
    default: 1
    doc: Number of CPU cores to use.
    type: long
  per_sample_sequences:
    doc: The resulting demultiplexed sequences.
    type: string
  untrimmed_sequences:
    doc: The sequences that were unmatched to barcodes.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- cutadapt
- demux_paired
- inputs.json
outputs:
  per_sample_sequences_file:
    doc: The resulting demultiplexed sequences.
    outputBinding:
      glob: $(inputs.per_sample_sequences)
    type: File
  untrimmed_sequences_file:
    doc: The sequences that were unmatched to barcodes.
    outputBinding:
      glob: $(inputs.untrimmed_sequences)
    type: File
