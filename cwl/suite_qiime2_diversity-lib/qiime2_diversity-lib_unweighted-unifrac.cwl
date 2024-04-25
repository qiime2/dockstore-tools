#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_lib_unweighted_unifrac
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Unweighted Unifrac
doc: Compute Unweighted Unifrac for each sample in a feature table
inputs:
  table:
    doc: The feature table containing the samples for which Unweighted Unifrac should
      be computed.
    type: File
  phylogeny:
    doc: Phylogenetic tree containing tip identifiers that correspond to the feature
      identifiers in the table. This tree can contain tip ids that are not present
      in the table, but all feature ids in the table must be present in this tree.
    type: File
  threads:
    default: 1
    doc: The number of CPU threads to use in performing this calculation. May not
      exceed the number of available physical cores. If threads = 'auto', one thread
      will be created for each identified CPU core on the host.
    type: long
  bypass_tips:
    default: false
    doc: In a bifurcating tree, the tips make up about 50% of the nodes in a tree.
      By ignoring them, specificity can be traded for reduced compute time. This has
      the effect of collapsing the phylogeny, and is analogous (in concept) to moving
      from 99% to 97% OTUs
    type: boolean
  distance_matrix:
    doc: Distance matrix for Unweighted Unifrac.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity_lib
- unweighted_unifrac
- inputs.json
outputs:
  distance_matrix_file:
    doc: Distance matrix for Unweighted Unifrac.
    outputBinding:
      glob: $(inputs.distance_matrix)
    type: File
