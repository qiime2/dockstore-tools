#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_phylogeny_robinson_foulds
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Calculate Robinson-Foulds distance between phylogenetic trees.
doc: Calculate the Robinson-Foulds symmetric difference metric between two or more
  phylogenetic trees.
inputs:
  trees:
    doc: Phylogenetic trees to compare with Robinson-Foulds. Rooting information and
      branch lengths are ignored by this metric.
    type: File[]
  labels:
    doc: Labels to use for the tree names in the distance matrix. If ommited, labels
      will be "tree_n" where "n" ranges from 1..N. The number of labels must match
      the number of trees.
    type: string[]?
  missing_tips:
    default: error
    doc: How to handle tips that are not shared between trees. "error" will raise
      an error if the set of tips is not identical between all input trees. "intersect-all"
      will remove tips that are not shared between all trees before computing distances
      beteen trees.
    type: string
  distance_matrix:
    doc: The distances between trees as a symmetric matrix.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- phylogeny
- robinson_foulds
- inputs.json
outputs:
  distance_matrix_file:
    doc: The distances between trees as a symmetric matrix.
    outputBinding:
      glob: $(inputs.distance_matrix)
    type: File
