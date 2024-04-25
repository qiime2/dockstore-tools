#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_lib_observed_features
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Observed Features
doc: Compute the number of observed features for each sample in a feature table
inputs:
  table:
    doc: The feature table containing the samples for which the number of observed
      features should be calculated. Table values will be converted to presence/absence.
    type: File
  vector:
    doc: Vector containing per-sample counts of observed features.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity_lib
- observed_features
- inputs.json
outputs:
  vector_file:
    doc: Vector containing per-sample counts of observed features.
    outputBinding:
      glob: $(inputs.vector)
    type: File
