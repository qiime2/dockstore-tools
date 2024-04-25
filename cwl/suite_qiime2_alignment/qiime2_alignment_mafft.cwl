#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_alignment_mafft
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: De novo multiple sequence alignment with MAFFT
doc: Perform de novo multiple sequence alignment using MAFFT.
inputs:
  sequences:
    doc: The sequences to be aligned.
    type: File
  n_threads:
    default: 1
    doc: The number of threads. (Use `auto` to automatically use all available cores)
    type: long
  parttree:
    default: false
    doc: This flag is required if the number of sequences being aligned are larger
      than 1000000. Disabled by default
    type: boolean
  alignment:
    doc: The aligned sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- alignment
- mafft
- inputs.json
outputs:
  alignment_file:
    doc: The aligned sequences.
    outputBinding:
      glob: $(inputs.alignment)
    type: File
