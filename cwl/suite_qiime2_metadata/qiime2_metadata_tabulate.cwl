#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_metadata_tabulate
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Interactively explore Metadata in an HTML table
doc: Generate a tabular view of Metadata. The output visualization supports interactive
  filtering, sorting, and exporting to common file formats.
inputs:
  q2cwl_metafile_input:
    doc: The metadata to tabulate.
    type:
    - File
    - File[]
  page_size:
    default: 100
    doc: The maximum number of Metadata records to display per page
    type: long
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- metadata
- tabulate
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
