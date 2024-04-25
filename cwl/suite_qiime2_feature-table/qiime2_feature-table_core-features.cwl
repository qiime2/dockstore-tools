#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_core_features
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Identify core features in table
doc: Identify "core" features, which are features observed in a user-defined fraction
  of the samples. Since the core features are a function of the fraction of samples
  that the feature must be observed in to be considered core, this is computed over
  a range of fractions defined by the `min_fraction`, `max_fraction`, and `steps`
  parameters.
inputs:
  table:
    doc: The feature table to use in core features calculations.
    type: File
  min_fraction:
    default: 0.5
    doc: The minimum fraction of samples that a feature must be observed in for that
      feature to be considered a core feature.
    type: double
  max_fraction:
    default: 1.0
    doc: The maximum fraction of samples that a feature must be observed in for that
      feature to be considered a core feature.
    type: double
  steps:
    default: 11
    doc: The number of steps to take between `min_fraction` and `max_fraction` for
      core features calculations. This parameter has no effect if `min_fraction` and
      `max_fraction` are the same value.
    type: long
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- core_features
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
