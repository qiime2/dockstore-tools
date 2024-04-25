#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_sample_classifier_metatable
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Convert (and merge) positive numeric metadata (in)to feature table.
doc: 'Convert numeric sample metadata from TSV file into a feature table. Optionally
  merge with an existing feature table. Only numeric metadata will be converted; categorical
  columns will be silently dropped. By default, if a table is used as input only samples
  found in both the table and metadata (intersection) are merged, and others are silently
  dropped. Set missing_samples="error" to raise an error if samples found in the table
  are missing from the metadata file. The metadata file can always contain a superset
  of samples. Note that columns will be dropped if they are non-numeric, contain no
  unique values (zero variance), contain only empty cells, or contain negative values.
  This method currently only converts postive numeric metadata into feature data.
  Tip: convert categorical columns to dummy variables to include them in the output
  feature table.'
inputs:
  table:
    doc: Feature table containing all features that should be used for target prediction.
    type: File?
  q2cwl_metafile_metadata:
    doc: Metadata file to convert to feature table.
    type:
    - File
    - File[]
  missing_samples:
    default: ignore
    doc: How to handle missing samples in metadata. "error" will fail if missing samples
      are detected. "ignore" will cause the feature table and metadata to be filtered,
      so that only samples found in both files are retained.
    type: string
  missing_values:
    default: error
    doc: How to handle missing values (nans) in metadata. Either "drop_samples" with
      missing values, "drop_features" with missing values, "fill" missing values with
      zeros, or "error" if any missing values are found.
    type: string
  drop_all_unique:
    default: false
    doc: If True, columns that contain a unique value for every ID will be dropped.
    type: boolean
  converted_table:
    doc: Converted feature table
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- sample_classifier
- metatable
- inputs.json
outputs:
  converted_table_file:
    doc: Converted feature table
    outputBinding:
      glob: $(inputs.converted_table)
    type: File
