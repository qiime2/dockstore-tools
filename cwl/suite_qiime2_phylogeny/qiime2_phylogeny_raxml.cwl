#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_phylogeny_raxml
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Construct a phylogenetic tree with RAxML.
doc: 'Construct a phylogenetic tree with RAxML. See: https://sco.h-its.org/exelixis/web/software/raxml/'
inputs:
  alignment:
    doc: Aligned sequences to be used for phylogenetic reconstruction.
    type: File
  seed:
    doc: Random number seed for the parsimony starting tree. This allows you to reproduce
      tree results. If not supplied then one will be randomly chosen.
    type: long?
  n_searches:
    default: 1
    doc: The number of independent maximum likelihood searches to perform. The single
      best scoring tree is returned.
    type: long
  n_threads:
    default: 1
    doc: The number of threads to use for multithreaded processing. Using more than
      one thread will enable the PTHREADS version of RAxML.
    type: long
  raxml_version:
    default: Standard
    doc: Select a specific CPU optimization of RAxML to use. The SSE3 versions will
      run approximately 40% faster than the standard version. The AVX2 version will
      run 10-30% faster than the SSE3 version.
    type: string
  substitution_model:
    default: GTRGAMMA
    doc: Model of Nucleotide Substitution.
    type: string
  tree:
    doc: The resulting phylogenetic tree.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- phylogeny
- raxml
- inputs.json
outputs:
  tree_file:
    doc: The resulting phylogenetic tree.
    outputBinding:
      glob: $(inputs.tree)
    type: File
