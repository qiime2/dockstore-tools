#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: Import data into a QIIME 2 Artifact
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: null
doc: qiime2_tools_import
inputs:
  input_type:
    doc: null
    type: string
  input_format:
    doc: null
    type: string?
  input_data:
    doc: null
    type:
    - File
    - Directory
  output_name:
    default: artifact.qza
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- tools
- import
- inputs.json
outputs:
  output_name_file:
    doc: null
    outputBinding:
      glob: $(inputs.output_name)
    type: File
