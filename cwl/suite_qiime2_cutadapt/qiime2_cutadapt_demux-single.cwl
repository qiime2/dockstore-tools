#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_cutadapt_demux_single
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Demultiplex single-end sequence data with barcodes in-sequence.
doc: Demultiplex sequence data (i.e., map barcode reads to sample ids). Barcodes are
  expected to be located within the sequence data (versus the header, or a separate
  barcode file).
inputs:
  seqs:
    doc: The single-end sequences to be demultiplexed.
    type: File
  q2cwl_metafile_barcodes:
    doc: The sample metadata column listing the per-sample barcodes.
    type: File
  barcodes:
    doc: Column name to use from 'barcodes' file
    type: string
  cut:
    default: 0
    doc: Remove the specified number of bases from the sequences. Bases are removed
      before demultiplexing. If a positive value is provided, bases are removed from
      the beginning of the sequences. If a negative value is provided, bases are removed
      from the end of the sequences.
    type: long
  anchor_barcode:
    default: false
    doc: Anchor the barcode. The barcode is then expected to occur in full length
      at the beginning (5' end) of the sequence. Can speed up demultiplexing if used.
    type: boolean
  error_rate:
    default: 0.1
    doc: The level of error tolerance, specified as the maximum allowable error rate.
      The default value specified by cutadapt is 0.1 (=10%), which is greater than
      `demux emp-*`, which is 0.0 (=0%).
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
- demux_single
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
