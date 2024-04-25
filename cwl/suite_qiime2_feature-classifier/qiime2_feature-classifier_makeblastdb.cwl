#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_classifier_makeblastdb
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Make BLAST database.
doc: Make BLAST database from custom sequence collection.
inputs:
  sequences:
    doc: Input reference sequences.
    type: File
  database:
    doc: Output BLAST database.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_classifier
- makeblastdb
- inputs.json
outputs:
  database_file:
    doc: Output BLAST database.
    outputBinding:
      glob: $(inputs.database)
    type: File
