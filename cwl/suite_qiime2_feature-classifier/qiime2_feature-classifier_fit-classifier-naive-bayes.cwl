#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_classifier_fit_classifier_naive_bayes
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Train the naive_bayes classifier
doc: Create a scikit-learn naive_bayes classifier for reads
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
  classify__alpha:
    default: 0.001
    doc: null
    type: double
  classify__chunk_size:
    default: 20000
    doc: null
    type: long
  classify__class_prior:
    default: 'null'
    doc: null
    type: string
  classify__fit_prior:
    default: false
    doc: null
    type: boolean
  feat_ext__alternate_sign:
    default: false
    doc: null
    type: boolean
  feat_ext__analyzer:
    default: char_wb
    doc: null
    type: string
  feat_ext__binary:
    default: false
    doc: null
    type: boolean
  feat_ext__decode_error:
    default: strict
    doc: null
    type: string
  feat_ext__encoding:
    default: utf-8
    doc: null
    type: string
  feat_ext__input:
    default: content
    doc: null
    type: string
  feat_ext__lowercase:
    default: true
    doc: null
    type: boolean
  feat_ext__n_features:
    default: 8192
    doc: null
    type: long
  feat_ext__ngram_range:
    default: '[7, 7]'
    doc: null
    type: string
  feat_ext__norm:
    default: l2
    doc: null
    type: string
  feat_ext__preprocessor:
    default: 'null'
    doc: null
    type: string
  feat_ext__stop_words:
    default: 'null'
    doc: null
    type: string
  feat_ext__strip_accents:
    default: 'null'
    doc: null
    type: string
  feat_ext__token_pattern:
    default: (?u)\b\w\w+\b
    doc: null
    type: string
  feat_ext__tokenizer:
    default: 'null'
    doc: null
    type: string
  verbose:
    default: false
    doc: null
    type: boolean
  classifier:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_classifier
- fit_classifier_naive_bayes
- inputs.json
outputs:
  classifier_file:
    doc: null
    outputBinding:
      glob: $(inputs.classifier)
    type: File
