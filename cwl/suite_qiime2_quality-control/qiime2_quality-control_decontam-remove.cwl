#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_quality_control_decontam_remove
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Removes contaminant
doc: This method removes contaminant sequences from an OTU or ASV table and returns
  the amended table to the user
inputs:
  decontam_scores:
    doc: Output table from decontam identify
    type: File
  table:
    doc: ASV or OTU table which contaminate sequences will be identified from
    type: File
  threshold:
    default: 0.1
    doc: Select threshold cutoff for decontam algorithm scores
    type: double
  filtered_table:
    doc: The resulting feature table of scores once contaminants are removed
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- quality_control
- decontam_remove
- inputs.json
outputs:
  filtered_table_file:
    doc: The resulting feature table of scores once contaminants are removed
    outputBinding:
      glob: $(inputs.filtered_table)
    type: File
