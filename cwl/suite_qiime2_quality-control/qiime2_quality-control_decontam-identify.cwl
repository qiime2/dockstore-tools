#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_quality_control_decontam_identify
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Identify contaminants
doc: This method identifies contaminant sequences from an OTU or ASV table and reports
  them to the user
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
  method:
    default: prevalence
    doc: 'Select how to which method to id contaminants with; Prevalence: Utilizes
      control ASVs/OTUs to identify contaminants, Frequency: Utilizes sample concentration
      information to identify contaminants, Combined: Utilizes both Prevalence and
      Frequency methods when identifying contaminants'
    type: string
  freq_concentration_column:
    doc: Input column name that has concentration information for the samples
    type: string?
  prev_control_column:
    doc: Input column name containing experimental or control sample metadata
    type: string?
  prev_control_indicator:
    doc: indicate the control sample identifier (e.g. "control" or "blank")
    type: string?
  decontam_scores:
    doc: The resulting table of scores from the decontam algorithm which scores each
      ASV or OTU on how likely they are to be a contaminant sequence
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- quality_control
- decontam_identify
- inputs.json
outputs:
  decontam_scores_file:
    doc: The resulting table of scores from the decontam algorithm which scores each
      ASV or OTU on how likely they are to be a contaminant sequence
    outputBinding:
      glob: $(inputs.decontam_scores)
    type: File
