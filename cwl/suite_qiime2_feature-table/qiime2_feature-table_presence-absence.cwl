#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_presence_absence
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Convert to presence/absence
doc: Convert frequencies to binary values indicating presence or absence of a feature
  in a sample.
inputs:
  table:
    doc: The feature table to be converted into presence/absence abundances.
    type: File
  presence_absence_table:
    doc: The resulting presence/absence feature table.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- presence_absence
- inputs.json
outputs:
  presence_absence_table_file:
    doc: The resulting presence/absence feature table.
    outputBinding:
      glob: $(inputs.presence_absence_table)
    type: File
