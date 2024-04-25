#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: Export data from a QIIME 2 Artifact
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
doc: qiime2_tools_export
inputs:
  input_artifact:
    doc: null
    type: Directory
  output_format:
    doc: null
    type: string?
  output_name:
    default: data
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- tools
- export
- inputs.json
outputs:
  output_name:
    doc: null
    outputBinding:
      glob: $(inputs.output_name)
    type:
    - File
    - Directory
