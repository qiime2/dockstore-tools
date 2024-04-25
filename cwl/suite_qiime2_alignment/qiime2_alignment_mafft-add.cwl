#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_alignment_mafft_add
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Add sequences to multiple sequence alignment with MAFFT.
doc: Add new sequences to an existing alignment with MAFFT.
inputs:
  alignment:
    doc: The alignment to which sequences should be added.
    type: File
  sequences:
    doc: The sequences to be added.
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
  addfragments:
    default: false
    doc: Optimize for the addition of short sequence fragments (for example, primer
      or amplicon sequences). If not set, default sequence addition is used.
    type: boolean
  expanded_alignment:
    doc: Alignment containing the provided aligned and unaligned sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- alignment
- mafft_add
- inputs.json
outputs:
  expanded_alignment_file:
    doc: Alignment containing the provided aligned and unaligned sequences.
    outputBinding:
      glob: $(inputs.expanded_alignment)
    type: File
