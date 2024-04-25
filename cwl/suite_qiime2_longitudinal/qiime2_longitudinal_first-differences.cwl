#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_longitudinal_first_differences
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Compute first differences or difference from baseline between sequential states
doc: Calculates first differences in "metric" between sequential states for samples
  collected from individual subjects sampled repeatedly at two or more states. First
  differences can be performed on a metadata column (including artifacts that can
  be input as metadata) or a feature in a feature table. Outputs a data series of
  first differences for each individual subject at each sequential pair of states,
  labeled by the SampleID of the second state (e.g., paired differences between time
  0 and time 1 would be labeled by the SampleIDs at time 1). This file can be used
  as input to linear mixed effects models or other longitudinal or diversity methods
  to compare changes in first differences across time or among groups of subjects.
  Also supports differences from baseline (or other static comparison state) by setting
  the "baseline" parameter.
inputs:
  table:
    doc: Feature table to optionally use for computing first differences.
    type: File?
  q2cwl_metafile_metadata:
    doc: Sample metadata file containing individual_id_column.
    type:
    - File
    - File[]
  state_column:
    doc: Metadata column containing state (time) variable information.
    type: string
  individual_id_column:
    doc: Metadata column containing IDs for individual subjects.
    type: string
  metric:
    doc: Numerical metadata or artifact column to test.
    type: string
  replicate_handling:
    default: error
    doc: Choose how replicate samples are handled. If replicates are detected, "error"
      causes method to fail; "drop" will discard all replicated samples; "random"
      chooses one representative at random from among replicates.
    type: string
  baseline:
    doc: A value listed in the state_column metadata column against which all other
      states should be compared. Toggles calculation of static differences instead
      of first differences (which are calculated if no value is given for baseline).
      If a "baseline" value is provided, sample differences at each state are compared
      against the baseline state, instead of the previous state. Must be a value listed
      in the state_column.
    type: double?
  first_differences:
    doc: Series of first differences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- longitudinal
- first_differences
- inputs.json
outputs:
  first_differences_file:
    doc: Series of first differences.
    outputBinding:
      glob: $(inputs.first_differences)
    type: File
