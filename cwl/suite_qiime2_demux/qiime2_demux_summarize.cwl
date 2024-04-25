#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_demux_summarize
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Summarize counts per sample.
doc: Summarize counts per sample for all samples, and generate interactive positional
  quality plots based on `n` randomly selected sequences.
inputs:
  data:
    doc: The demultiplexed sequences to be summarized.
    type: File
  n:
    default: 10000
    doc: The number of sequences that should be selected at random for quality score
      plots. The quality plots will present the average positional qualities across
      all of the sequences selected. If input sequences are paired end, plots will
      be generated for both forward and reverse reads for the same `n` sequences.
    type: long
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- demux
- summarize
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
