#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_composition_add_pseudocount
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Add pseudocount to table.
doc: Increment all counts in table by pseudocount.
inputs:
  table:
    doc: The feature table to which pseudocounts should be added.
    type: File
  pseudocount:
    default: 1
    doc: The value to add to all counts in the feature table.
    type: long
  composition_table:
    doc: The resulting feature table.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- composition
- add_pseudocount
- inputs.json
outputs:
  composition_table_file:
    doc: The resulting feature table.
    outputBinding:
      glob: $(inputs.composition_table)
    type: File
