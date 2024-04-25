#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_tabulate_feature_frequencies
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Tabulate feature frequencies
doc: Tabulate sample count and total frequency per feature.
inputs:
  table:
    doc: The input feature table.
    type: File
  feature_frequencies:
    doc: Per-sample and total frequencies per feature.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- tabulate_feature_frequencies
- inputs.json
outputs:
  feature_frequencies_file:
    doc: Per-sample and total frequencies per feature.
    outputBinding:
      glob: $(inputs.feature_frequencies)
    type: File
