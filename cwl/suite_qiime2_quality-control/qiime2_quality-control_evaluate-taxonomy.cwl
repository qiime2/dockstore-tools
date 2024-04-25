#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_quality_control_evaluate_taxonomy
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Evaluate expected vs. observed taxonomic assignments
doc: This visualizer compares a pair of observed and expected taxonomic assignments
  to calculate precision, recall, and F-measure at each taxonomic level, up to maximum
  level specified by the depth parameter. These metrics are calculated at each semicolon-delimited
  rank. This action is useful for comparing the accuracy of taxonomic assignment,
  e.g., between different taxonomy classifiers or other bioinformatics methods. Expected
  taxonomies should be derived from simulated or mock community sequences that have
  known taxonomic affiliations.
inputs:
  expected_taxa:
    doc: Expected taxonomic assignments
    type: File
  observed_taxa:
    doc: Observed taxonomic assignments
    type: File
  feature_table:
    doc: Optional feature table containing relative frequency of each feature, used
      to weight accuracy scores by frequency. Must contain all features found in expected
      and/or observed taxa. Features found in the table but not the expected/observed
      taxa will be dropped prior to analysis.
    type: File?
  depth:
    doc: Maximum depth of semicolon-delimited taxonomic ranks to test (e.g., 1 = root,
      7 = species for the greengenes reference sequence database).
    type: long
  palette:
    default: Set1
    doc: Color palette to utilize for plotting.
    type: string
  require_exp_ids:
    default: true
    doc: Require that all features found in observed taxa must be found in expected
      taxa or raise error.
    type: boolean
  require_obs_ids:
    default: true
    doc: Require that all features found in expected taxa must be found in observed
      taxa or raise error.
    type: boolean
  sample_id:
    doc: Optional sample ID to use for extracting frequency data from feature table,
      and for labeling accuracy results. If no sample_id is provided, feature frequencies
      are derived from the sum of all samples present in the feature table.
    type: string?
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- quality_control
- evaluate_taxonomy
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
