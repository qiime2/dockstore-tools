#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_classifier_fit_classifier_sklearn
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Train an almost arbitrary scikit-learn classifier
doc: Train a scikit-learn classifier to classify reads.
inputs:
  reference_reads:
    doc: null
    type: File
  reference_taxonomy:
    doc: null
    type: File
  class_weight:
    doc: null
    type: File?
  classifier_specification:
    doc: null
    type: string
  classifier:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_classifier
- fit_classifier_sklearn
- inputs.json
outputs:
  classifier_file:
    doc: null
    outputBinding:
      glob: $(inputs.classifier)
    type: File
