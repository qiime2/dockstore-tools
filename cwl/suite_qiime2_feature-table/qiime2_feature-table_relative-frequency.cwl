#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_relative_frequency
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Convert to relative frequencies
doc: Convert frequencies to relative frequencies by dividing each frequency in a sample
  by the sum of frequencies in that sample.
inputs:
  table:
    doc: The feature table to be converted into relative frequencies.
    type: File
  relative_frequency_table:
    doc: The resulting relative frequency feature table.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- relative_frequency
- inputs.json
outputs:
  relative_frequency_table_file:
    doc: The resulting relative frequency feature table.
    outputBinding:
      glob: $(inputs.relative_frequency_table)
    type: File
