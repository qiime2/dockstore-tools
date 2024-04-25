#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_demux_subsample_single
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Subsample single-end sequences without replacement.
doc: Generate a random subsample of single-end sequences containing approximately
  the fraction of input sequences specified by the fraction parameter. The number
  of output samples will always be equal to the number of input samples, even if some
  of those samples contain no sequences after subsampling.
inputs:
  sequences:
    doc: The demultiplexed sequences to be subsampled.
    type: File
  fraction:
    doc: The fraction of sequences to retain in subsample.
    type: double
  subsampled_sequences:
    doc: The subsampled sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- demux
- subsample_single
- inputs.json
outputs:
  subsampled_sequences_file:
    doc: The subsampled sequences.
    outputBinding:
      glob: $(inputs.subsampled_sequences)
    type: File
