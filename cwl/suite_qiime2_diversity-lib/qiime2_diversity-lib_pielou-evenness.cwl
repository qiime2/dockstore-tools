#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_lib_pielou_evenness
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Pielou's Evenness
doc: Compute Pielou's Evenness for each sample in a feature table
inputs:
  table:
    doc: The feature table containing the samples for which Pielou's evenness should
      be computed.
    type: File
  drop_undefined_samples:
    default: false
    doc: Samples with fewer than two observed features produce undefined (NaN) values.
      If true, these samples are dropped from the output vector.
    type: boolean
  vector:
    doc: Vector containing per-sample values for Pielou's Evenness.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity_lib
- pielou_evenness
- inputs.json
outputs:
  vector_file:
    doc: Vector containing per-sample values for Pielou's Evenness.
    outputBinding:
      glob: $(inputs.vector)
    type: File
