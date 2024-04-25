#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_composition_da_barplot
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Differential abundance bar plots
doc: Generate bar plot views of ANCOM-BC output. One plot will be present per column
  in the ANCOM-BC output. The `significance_threshold`, `effect_size_threshold` and
  `feature_ids` filter results are intersected, such that only features that remain
  after all three filters have been applied will be present in the output.
inputs:
  data:
    doc: The ANCOM-BC output to be plotted.
    type: File
  effect_size_label:
    default: lfc
    doc: Label for effect sizes in `data`.
    type: string
  feature_id_label:
    default: id
    doc: Label for feature ids in `data`.
    type: string
  error_label:
    default: se
    doc: Label for effect size errors in `data`.
    type: string
  significance_label:
    default: q_val
    doc: Label for statistical significance level in `data`.
    type: string
  significance_threshold:
    default: 1.0
    doc: Exclude features with statistical significance level greater (i.e., less
      significant) than this threshold.
    type: double
  effect_size_threshold:
    default: 0.0
    doc: Exclude features with an absolute value of effect size less than this threshold.
    type: double
  q2cwl_metafile_feature_ids:
    doc: Exclude features if their ids are not included in this index.
    type:
    - File?
    - File[]?
  level_delimiter:
    doc: If feature ids encode hierarchical information, split the levels when generating
      feature labels in the visualization using this delimiter.
    type: string?
  label_limit:
    doc: Set the maximum length that will be viewable for axis labels. You can set
      this parameter if your axis labels are being cut off.
    type: long?
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- composition
- da_barplot
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
