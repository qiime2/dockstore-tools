#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_lib_alpha_passthrough
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Alpha Passthrough (non-phylogenetic)
doc: Computes a vector of values (one value for each samples in a feature table) using
  the scikit-bio implementation of the selected alpha diversity metric.
inputs:
  table:
    doc: The feature table containing the samples for which a selected metric should
      be computed.
    type: File
  metric:
    doc: The alpha diversity metric to be computed.
    type: string
  vector:
    doc: Vector containing per-sample values for the chosen metric.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity_lib
- alpha_passthrough
- inputs.json
outputs:
  vector_file:
    doc: Vector containing per-sample values for the chosen metric.
    outputBinding:
      glob: $(inputs.vector)
    type: File
