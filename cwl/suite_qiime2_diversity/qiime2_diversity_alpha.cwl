#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_alpha
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Alpha diversity
doc: Computes a user-specified alpha diversity metric for all samples in a feature
  table.
inputs:
  table:
    doc: The feature table containing the samples for which alpha diversity should
      be computed.
    type: File
  metric:
    doc: The alpha diversity metric to be computed. Information about specific metrics
      is available at https://data.qiime2.org/a_diversity_metrics
    type: string
  alpha_diversity:
    doc: Vector containing per-sample alpha diversities.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- alpha
- inputs.json
outputs:
  alpha_diversity_file:
    doc: Vector containing per-sample alpha diversities.
    outputBinding:
      glob: $(inputs.alpha_diversity)
    type: File
