#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_composition_ancom
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Apply ANCOM to identify features that differ in abundance.
doc: Apply Analysis of Composition of Microbiomes (ANCOM) to identify features that
  are differentially abundant across groups.
inputs:
  table:
    doc: The feature table to be used for ANCOM computation.
    type: File
  q2cwl_metafile_metadata:
    doc: The categorical sample metadata column to test for differential abundance
      across.
    type: File
  metadata:
    doc: Column name to use from 'metadata' file
    type: string
  transform_function:
    default: clr
    doc: The method applied to transform feature values before generating volcano
      plots.
    type: string
  difference_function:
    doc: The method applied to visualize fold difference in feature abundances across
      groups for volcano plots.
    type: string?
  filter_missing:
    default: false
    doc: If True, samples with missing metadata values will be filtered from the table
      prior to analysis. If False, an error will be raised if there are any missing
      metadata values.
    type: boolean
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- composition
- ancom
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
