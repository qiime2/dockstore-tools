#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_longitudinal_first_distances
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Compute first distances or distance from baseline between sequential states
doc: Calculates first distances between sequential states for samples collected from
  individual subjects sampled repeatedly at two or more states. This method is similar
  to the "first differences" method, except that it requires a distance matrix as
  input and calculates first differences as distances between successive states. Outputs
  a data series of first distances for each individual subject at each sequential
  pair of states, labeled by the SampleID of the second state (e.g., paired distances
  between time 0 and time 1 would be labeled by the SampleIDs at time 1). This file
  can be used as input to linear mixed effects models or other longitudinal or diversity
  methods to compare changes in first distances across time or among groups of subjects.
  Also supports distance from baseline (or other static comparison state) by setting
  the "baseline" parameter.
inputs:
  distance_matrix:
    doc: Matrix of distances between pairs of samples.
    type: File
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
  baseline:
    doc: A value listed in the state_column metadata column against which all other
      states should be compared. Toggles calculation of static distances instead of
      first distances (which are calculated if no value is given for baseline). If
      a "baseline" value is provided, sample distances at each state are compared
      against the baseline state, instead of the previous state. Must be a value listed
      in the state_column.
    type: double?
  replicate_handling:
    default: error
    doc: Choose how replicate samples are handled. If replicates are detected, "error"
      causes method to fail; "drop" will discard all replicated samples; "random"
      chooses one representative at random from among replicates.
    type: string
  first_distances:
    doc: Series of first distances.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- longitudinal
- first_distances
- inputs.json
outputs:
  first_distances_file:
    doc: Series of first distances.
    outputBinding:
      glob: $(inputs.first_distances)
    type: File
