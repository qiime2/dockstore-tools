#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_taxa_collapse
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Collapse features by their taxonomy at the specified level
doc: Collapse groups of features that have the same taxonomic assignment through the
  specified level. The frequencies of all features will be summed when they are collapsed.
inputs:
  table:
    doc: Feature table to be collapsed.
    type: File
  taxonomy:
    doc: Taxonomic annotations for features in the provided feature table. All features
      in the feature table must have a corresponding taxonomic annotation. Taxonomic
      annotations that are not present in the feature table will be ignored.
    type: File
  level:
    doc: The taxonomic level at which the features should be collapsed. All ouput
      features will have exactly this many levels of taxonomic annotation.
    type: long
  collapsed_table:
    doc: The resulting feature table, where all features are now taxonomic annotations
      with the user-specified number of levels.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- taxa
- collapse
- inputs.json
outputs:
  collapsed_table_file:
    doc: The resulting feature table, where all features are now taxonomic annotations
      with the user-specified number of levels.
    outputBinding:
      glob: $(inputs.collapsed_table)
    type: File
