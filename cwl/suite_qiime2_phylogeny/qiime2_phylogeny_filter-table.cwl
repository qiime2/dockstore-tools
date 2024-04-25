#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_phylogeny_filter_table
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Remove features from table if they're not present in tree.
doc: Remove features from a feature table if their identifiers are not tip identifiers
  in tree.
inputs:
  table:
    doc: Feature table that features should be filtered from.
    type: File
  tree:
    doc: Tree where tip identifiers are the feature identifiers that should be retained
      in the table.
    type: File
  filtered_table:
    doc: The resulting feature table.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- phylogeny
- filter_table
- inputs.json
outputs:
  filtered_table_file:
    doc: The resulting feature table.
    outputBinding:
      glob: $(inputs.filtered_table)
    type: File
