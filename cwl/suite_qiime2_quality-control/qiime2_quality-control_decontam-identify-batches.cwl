#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_quality_control_decontam_identify_batches
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Identify contaminants in Batch Mode
doc: This method breaks an ASV table into batches based on the given metadata and
  identifies contaminant sequences from an OTU or ASV table and reports them to the
  user
inputs:
  table:
    doc: ASV or OTU table which contaminate sequences will be identified from
    type: File
  q2cwl_metafile_metadata:
    doc: metadata file indicating which samples in the experiment are control samples,
      assumes sample names in file correspond to the `table` input parameter
    type:
    - File
    - File[]
  split_column:
    doc: 'input metadata columns that you wish to subset the ASV table byNote: Column
      names must be in quotes and delimited by a space'
    type: string
  method:
    doc: 'Select how to which method to id contaminants with; Prevalence: Utilizes
      control ASVs/OTUs to identify contaminants, Frequency: Utilizes sample concentration
      information to identify contaminants, Combined: Utilizes both Prevalence and
      Frequency methods when identifying contaminants'
    type: string
  filter_empty_features:
    doc: If true, features which are not present in a split feature table are dropped.
    type: boolean?
  freq_concentration_column:
    doc: Input column name that has concentration information for the samples
    type: string?
  prev_control_column:
    doc: Input column name containing experimental or control sample metadata
    type: string?
  prev_control_indicator:
    doc: indicate the control sample identifier (e.g. "control" or "blank")
    type: string?
  threshold:
    default: 0.1
    doc: Select threshold cutoff for decontam algorithm scores
    type: double
  weighted:
    default: true
    doc: weight the decontam scores by their associated read number
    type: boolean
  bin_size:
    default: 0.02
    doc: Select bin size for the histogram
    type: double
  batch_subset_tables:
    doc: Directory where feature tables split based on metadata and parameter split_column
      values should be written.
    type: string
  decontam_scores:
    doc: The resulting table of scores from the decontam algorithm which scores each
      ASV or OTU on how likely they are to be a contaminant sequence
    type: string
  score_histograms:
    doc: The vizulaizer histograms for all decontam score objects generated from the
      pipeline
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- quality_control
- decontam_identify_batches
- inputs.json
outputs:
  batch_subset_tables_dir:
    doc: Directory where feature tables split based on metadata and parameter split_column
      values should be written.
    outputBinding:
      glob: $(inputs.batch_subset_tables)
    type: Directory
  decontam_scores_dir:
    doc: The resulting table of scores from the decontam algorithm which scores each
      ASV or OTU on how likely they are to be a contaminant sequence
    outputBinding:
      glob: $(inputs.decontam_scores)
    type: Directory
  score_histograms_file:
    doc: The vizulaizer histograms for all decontam score objects generated from the
      pipeline
    outputBinding:
      glob: $(inputs.score_histograms)
    type: File
