#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_phylogeny_fasttree
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Construct a phylogenetic tree with FastTree.
doc: Construct a phylogenetic tree with FastTree.
inputs:
  alignment:
    doc: Aligned sequences to be used for phylogenetic reconstruction.
    type: File
  n_threads:
    default: 1
    doc: The number of threads. Using more than one thread runs the non-deterministic
      variant of `FastTree` (`FastTreeMP`), and may result in a different tree than
      single-threading. See http://www.microbesonline.org/fasttree/#OpenMP for details.
      (Use `auto` to automatically use all available cores)
    type: long
  tree:
    doc: The resulting phylogenetic tree.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- phylogeny
- fasttree
- inputs.json
outputs:
  tree_file:
    doc: The resulting phylogenetic tree.
    outputBinding:
      glob: $(inputs.tree)
    type: File
