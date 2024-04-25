#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_lib_shannon_entropy
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Shannon's Entropy
doc: Compute Shannon's Entropy for each sample in a feature table
inputs:
  table:
    doc: The feature table containing the samples for which Shannon's Entropy should
      be computed.
    type: File
  drop_undefined_samples:
    default: false
    doc: Samples with no observed features produce undefined (NaN) values. If true,
      these samples are dropped from the output vector.
    type: boolean
  vector:
    doc: Vector containing per-sample values for Shannon's Entropy.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity_lib
- shannon_entropy
- inputs.json
outputs:
  vector_file:
    doc: Vector containing per-sample values for Shannon's Entropy.
    outputBinding:
      glob: $(inputs.vector)
    type: File
