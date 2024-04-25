#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_composition_tabulate
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: ' View tabular output from ANCOM-BC.'
doc: Generate tabular view of ANCOM-BC output, which includes per-page views for the
  log-fold change (lfc), standard error (se), P values, Q values, and W scores.
inputs:
  data:
    doc: The ANCOM-BC output to be tabulated.
    type: File
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- composition
- tabulate
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
