#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_evaluate_seqs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Compute summary statistics on sequence artifact(s).
doc: Compute summary statistics on sequence artifact(s) and visualize. Summary statistics
  include the number of unique sequences, sequence entropy, kmer entropy, and sequence
  length distributions. This action is useful for both reference taxonomies and classification
  results.
inputs:
  sequences:
    doc: One or more sets of sequences to evaluate.
    type: File[]
  labels:
    doc: List of labels to use for labeling evaluation results in the resulting visualization.
      Inputs are labeled with labels in the order that each is input. If there are
      fewer labels than inputs (or no labels), unnamed inputs are labeled numerically
      in sequential order. Extra labels are ignored.
    type: string[]?
  kmer_lengths:
    doc: 'Sequence kmer lengths to optionally use for entropy calculation. Warning:
      kmer entropy calculations may be time-consuming for large sequence sets.'
    type: long[]?
  subsample_kmers:
    default: 1.0
    doc: Optionally subsample sequences prior to kmer entropy measurement. A fraction
      of the input sequences will be randomly subsampled at the specified value.
    type: double
  palette:
    default: viridis
    doc: Color palette to use for plotting evaluation results.
    type: string
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- evaluate_seqs
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
