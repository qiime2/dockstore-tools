#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_phylogeny_midpoint_root
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Midpoint root an unrooted phylogenetic tree.
doc: Midpoint root an unrooted phylogenetic tree.
inputs:
  tree:
    doc: The phylogenetic tree to be rooted.
    type: File
  rooted_tree:
    doc: The rooted phylogenetic tree.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- phylogeny
- midpoint_root
- inputs.json
outputs:
  rooted_tree_file:
    doc: The rooted phylogenetic tree.
    outputBinding:
      glob: $(inputs.rooted_tree)
    type: File
