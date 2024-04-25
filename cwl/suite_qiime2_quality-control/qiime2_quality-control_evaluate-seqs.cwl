#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_quality_control_evaluate_seqs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Compare query (observed) vs. reference (expected) sequences.
doc: This action aligns a set of query (e.g., observed) sequences against a set of
  reference (e.g., expected) sequences to evaluate the quality of alignment. The intended
  use is to align observed sequences against expected sequences (e.g., from a mock
  community) to determine the frequency of mismatches between observed sequences and
  the most similar expected sequences, e.g., as a measure of sequencing/method error.
  However, any sequences may be provided as input to generate a report on pairwise
  alignment quality against a set of reference sequences.
inputs:
  query_sequences:
    doc: Sequences to test for exclusion
    type: File
  reference_sequences:
    doc: Reference sequences to align against feature sequences
    type: File
  show_alignments:
    default: false
    doc: Option to plot pairwise alignments of query sequences and their top hits.
    type: boolean
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- quality_control
- evaluate_seqs
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
