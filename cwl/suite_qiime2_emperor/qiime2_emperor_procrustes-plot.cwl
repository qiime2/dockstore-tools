#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_emperor_procrustes_plot
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Visualize and Interact with a procrustes plot
doc: Plot two procrustes-fitted matrices
inputs:
  reference_pcoa:
    doc: The reference ordination matrix to be plotted.
    type: File
  other_pcoa:
    doc: The "other" ordination matrix to be plotted (the one that was fitted to the
      reference).
    type: File
  m2_stats:
    doc: The M^2 value of the procrustes analysis & its associated p value.
    type: File?
  q2cwl_metafile_metadata:
    doc: The sample metadata.
    type:
    - File
    - File[]
  custom_axes:
    doc: Numeric sample metadata columns that should be included as axes in the Emperor
      plot.
    type: string[]?
  ignore_missing_samples:
    default: false
    doc: 'This will suppress the error raised when the coordinates matrix contains
      samples that are not present in the metadata. Samples without metadata are included
      by setting all metadata values to: "This sample has no metadata". This flag
      is only applied if at least one sample is present in both the coordinates matrix
      and the metadata.'
    type: boolean
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- emperor
- procrustes_plot
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
