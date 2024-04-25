#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_emperor_biplot
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Visualize and Interact with Principal Coordinates Analysis Biplot
doc: Generates an interactive ordination biplot where the user can visually integrate
  sample and feature metadata. Vectors representing the n most important features
  are then plotted in the emperor visualization (5 largest, by default).
inputs:
  biplot:
    doc: The principal coordinates matrix to be plotted.
    type: File
  q2cwl_metafile_sample_metadata:
    doc: The sample metadata
    type:
    - File
    - File[]
  q2cwl_metafile_feature_metadata:
    doc: The feature metadata (useful to manipulate the arrows in the plot).
    type:
    - File?
    - File[]?
  ignore_missing_samples:
    default: false
    doc: 'This will suppress the error raised when the coordinates matrix contains
      samples that are not present in the metadata. Samples without metadata are included
      by setting all metadata values to: "This sample has no metadata". This flag
      is only applied if at least one sample is present in both the coordinates matrix
      and the metadata.'
    type: boolean
  invert:
    default: false
    doc: If specified, the point and arrow coordinates will be swapped.
    type: boolean
  number_of_features:
    default: 5
    doc: "The number of most important features (arrows) to display in the ordination.\
      \ \u201CImportance\u201D is calculated for each feature based on the vector\u2019\
      s magnitude (euclidean distance from origin)."
    type: long
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- emperor
- biplot
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
