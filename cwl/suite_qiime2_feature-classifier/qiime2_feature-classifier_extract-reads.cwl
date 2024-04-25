#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_classifier_extract_reads
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Extract reads from reference sequences.
doc: 'Extract simulated amplicon reads from a reference database. Performs in-silico
  PCR to extract simulated amplicons from reference sequences that match the input
  primer sequences (within the mismatch threshold specified by `identity`). Both primer
  sequences must be in the 5'' -> 3'' orientation. Sequences that fail to match both
  primers will be excluded. Reads are extracted, trimmed, and filtered in the following
  order: 1. reads are extracted in specified orientation; 2. primers are removed;
  3. reads longer than `max_length` are removed; 4. reads are trimmed with `trim_right`;
  5. reads are truncated to `trunc_len`; 6. reads are trimmed with `trim_left`; 7.
  reads shorter than `min_length` are removed.'
inputs:
  sequences:
    doc: null
    type: File
  f_primer:
    doc: forward primer sequence (5' -> 3').
    type: string
  r_primer:
    doc: reverse primer sequence (5' -> 3'). Do not use reverse-complemented primer
      sequence.
    type: string
  trim_right:
    default: 0
    doc: trim_right nucleotides are removed from the 3' end if trim_right is positive.
      Applied before trunc_len and trim_left.
    type: long
  trunc_len:
    default: 0
    doc: read is cut to trunc_len if trunc_len is positive. Applied after trim_right
      but before trim_left.
    type: long
  trim_left:
    default: 0
    doc: trim_left nucleotides are removed from the 5' end if trim_left is positive.
      Applied after trim_right and trunc_len.
    type: long
  identity:
    default: 0.8
    doc: minimum combined primer match identity threshold.
    type: double
  min_length:
    default: 50
    doc: Minimum amplicon length. Shorter amplicons are discarded. Applied after trimming
      and truncation, so be aware that trimming may impact sequence retention. Set
      to zero to disable min length filtering.
    type: long
  max_length:
    default: 0
    doc: Maximum amplicon length. Longer amplicons are discarded. Applied before trimming
      and truncation, so plan accordingly. Set to zero (default) to disable max length
      filtering.
    type: long
  n_jobs:
    default: 1
    doc: Number of seperate processes to run.
    type: long
  batch_size:
    default: auto
    doc: Number of sequences to process in a batch. The `auto` option is calculated
      from the number of sequences and number of jobs specified.
    type:
    - long
    - string
  read_orientation:
    default: both
    doc: 'Orientation of primers relative to the sequences: "forward" searches for
      primer hits in the forward direction, "reverse" searches reverse-complement,
      and "both" searches both directions.'
    type: string
  reads:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_classifier
- extract_reads
- inputs.json
outputs:
  reads_file:
    doc: null
    outputBinding:
      glob: $(inputs.reads)
    type: File
