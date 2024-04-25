#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_lib_faith_pd
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Faith's Phylogenetic Diversity
doc: Computes Faith's Phylogenetic Diversity for all samples in a feature table.
inputs:
  table:
    doc: The feature table containing the samples for which Faith's phylogenetic diversity
      should be computed. Table values will be converted to presence/absence.
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
  vector:
    doc: Vector containing per-sample values for Faith's Phylogenetic Diversity.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity_lib
- faith_pd
- inputs.json
outputs:
  vector_file:
    doc: Vector containing per-sample values for Faith's Phylogenetic Diversity.
    outputBinding:
      glob: $(inputs.vector)
    type: File
