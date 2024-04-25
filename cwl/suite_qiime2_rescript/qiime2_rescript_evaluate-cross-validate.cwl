#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_evaluate_cross_validate
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Evaluate DNA sequence reference database via cross-validated taxonomic classification.
doc: Evaluate DNA sequence reference database via cross-validated taxonomic classification.
  Unique taxonomic labels are truncated to enable appropriate label stratification.
  See the cited reference (Bokulich et al. 2018) for more details.
inputs:
  sequences:
    doc: Reference sequences to use for classifier training/testing.
    type: File
  taxonomy:
    doc: Reference taxonomy to use for classifier training/testing.
    type: File
  k:
    default: 3
    doc: Number of stratified folds.
    type: long
  random_state:
    default: 0
    doc: Seed used by the random number generator.
    type: long
  reads_per_batch:
    default: auto
    doc: Number of reads to process in each batch. If "auto", this parameter is autoscaled
      to min( number of query sequences / n_jobs, 20000).
    type:
    - long
    - string
  n_jobs:
    default: 1
    doc: The maximum number of concurrent worker processes. If -1 all CPUs are used.
      If 1 is given, no parallel computing code is used at all, which is useful for
      debugging. For n_jobs below -1, (n_cpus + 1 + n_jobs) are used. Thus for n_jobs
      = -2, all CPUs but one are used.
    type: long
  confidence:
    default: 0.7
    doc: Confidence threshold for limiting taxonomic depth. Set to "disable" to disable
      confidence calculation, or 0 to calculate confidence but not apply it to limit
      the taxonomic depth of the assignments.
    type:
    - double
    - string
  expected_taxonomy:
    doc: Expected taxonomic label for each input sequence. Taxonomic labels may be
      truncated due to k-fold CV and stratification.
    type: string
  observed_taxonomy:
    doc: Observed taxonomic label for each input sequence, predicted by cross-validation.
    type: string
  evaluation:
    doc: Visualization of cross-validated accuracy results.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- evaluate_cross_validate
- inputs.json
outputs:
  expected_taxonomy_file:
    doc: Expected taxonomic label for each input sequence. Taxonomic labels may be
      truncated due to k-fold CV and stratification.
    outputBinding:
      glob: $(inputs.expected_taxonomy)
    type: File
  observed_taxonomy_file:
    doc: Observed taxonomic label for each input sequence, predicted by cross-validation.
    outputBinding:
      glob: $(inputs.observed_taxonomy)
    type: File
  evaluation_file:
    doc: Visualization of cross-validated accuracy results.
    outputBinding:
      glob: $(inputs.evaluation)
    type: File
