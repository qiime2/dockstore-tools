#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_alpha_phylogenetic
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Alpha diversity (phylogenetic)
doc: Computes a user-specified phylogenetic alpha diversity metric for all samples
  in a feature table.
inputs:
  table:
    doc: The feature table containing the samples for which alpha diversity should
      be computed.
    type: File
  phylogeny:
    doc: Phylogenetic tree containing tip identifiers that correspond to the feature
      identifiers in the table. This tree can contain tip ids that are not present
      in the table, but all feature ids in the table must be present in this tree.
    type: File
  metric:
    doc: The alpha diversity metric to be computed.
    type: string
  alpha_diversity:
    doc: Vector containing per-sample alpha diversities.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- alpha_phylogenetic
- inputs.json
outputs:
  alpha_diversity_file:
    doc: Vector containing per-sample alpha diversities.
    outputBinding:
      glob: $(inputs.alpha_diversity)
    type: File
