#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_table_summarize
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Summarize table
doc: Generate visual and tabular summaries of a feature table.
inputs:
  table:
    doc: The feature table to be summarized.
    type: File
  q2cwl_metafile_sample_metadata:
    doc: The sample metadata.
    type:
    - File?
    - File[]?
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_table
- summarize
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
