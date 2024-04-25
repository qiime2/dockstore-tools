#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_sample_classifier_confusion_matrix
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Make a confusion matrix from sample classifier predictions.
doc: Make a confusion matrix and calculate accuracy of predicted vs. true values for
  a set of samples classified using a sample classifier. If per-sample class probabilities
  are provided, will also generate Receiver Operating Characteristic curves and calculate
  area under the curve for each class.
inputs:
  predictions:
    doc: Predicted values to plot on x axis. Should be predictions of categorical
      data produced by a sample classifier.
    type: File
  probabilities:
    doc: Predicted class probabilities for each input sample.
    type: File?
  q2cwl_metafile_truth:
    doc: Metadata column (true values) to plot on y axis.
    type: File
  truth:
    doc: Column name to use from 'truth' file
    type: string
  missing_samples:
    default: error
    doc: How to handle missing samples in metadata. "error" will fail if missing samples
      are detected. "ignore" will cause the feature table and metadata to be filtered,
      so that only samples found in both files are retained.
    type: string
  vmin:
    default: auto
    doc: The minimum value to use for anchoring the colormap. If "auto", vmin is set
      to the minimum value in the data.
    type:
    - double
    - string
  vmax:
    default: auto
    doc: The maximum value to use for anchoring the colormap. If "auto", vmax is set
      to the maximum value in the data.
    type:
    - double
    - string
  palette:
    default: sirocco
    doc: The color palette to use for plotting.
    type: string
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- sample_classifier
- confusion_matrix
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
