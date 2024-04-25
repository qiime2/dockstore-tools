#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_sample_classifier_split_table
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Split a feature table into training and testing sets.
doc: Split a feature table into training and testing sets. By default stratifies training
  and test sets on a metadata column, such that values in that column are evenly represented
  across training and test sets.
inputs:
  table:
    doc: Feature table containing all features that should be used for target prediction.
    type: File
  q2cwl_metafile_metadata:
    doc: Numeric metadata column to use as prediction target.
    type: File
  metadata:
    doc: Column name to use from 'metadata' file
    type: string
  test_size:
    default: 0.2
    doc: Fraction of input samples to exclude from training set and use for classifier
      testing.
    type: double
  random_state:
    doc: Seed used by random number generator.
    type: long?
  stratify:
    default: true
    doc: Evenly stratify training and test data among metadata categories. If True,
      all values in column must match at least two samples.
    type: boolean
  missing_samples:
    default: error
    doc: How to handle missing samples in metadata. "error" will fail if missing samples
      are detected. "ignore" will cause the feature table and metadata to be filtered,
      so that only samples found in both files are retained.
    type: string
  training_table:
    doc: Feature table containing training samples
    type: string
  test_table:
    doc: Feature table containing test samples
    type: string
  training_targets:
    doc: Series containing true target values of train samples
    type: string
  test_targets:
    doc: Series containing true target values of test samples
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- sample_classifier
- split_table
- inputs.json
outputs:
  training_table_file:
    doc: Feature table containing training samples
    outputBinding:
      glob: $(inputs.training_table)
    type: File
  test_table_file:
    doc: Feature table containing test samples
    outputBinding:
      glob: $(inputs.test_table)
    type: File
  training_targets_file:
    doc: Series containing true target values of train samples
    outputBinding:
      glob: $(inputs.training_targets)
    type: File
  test_targets_file:
    doc: Series containing true target values of test samples
    outputBinding:
      glob: $(inputs.test_targets)
    type: File
