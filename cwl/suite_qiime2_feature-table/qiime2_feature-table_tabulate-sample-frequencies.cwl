#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_tabulate_sample_frequencies
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Tabulate sample frequencies
doc: Tabulate feature count and total frequency per sample.
inputs:
  table:
    doc: The input feature table.
    type: File
  sample_frequencies:
    doc: Observed feature count and total frequencies per sample.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- tabulate_sample_frequencies
- inputs.json
outputs:
  sample_frequencies_file:
    doc: Observed feature count and total frequencies per sample.
    outputBinding:
      glob: $(inputs.sample_frequencies)
    type: File
