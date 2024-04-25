#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_demux_tabulate_read_counts
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Tabulate counts per sample
doc: Generate a per-sample count of sequence reads.
inputs:
  sequences:
    doc: One or more collections of demultiplexed sequences.
    type: File[]
  counts:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- demux
- tabulate_read_counts
- inputs.json
outputs:
  counts_file:
    doc: null
    outputBinding:
      glob: $(inputs.counts)
    type: File
