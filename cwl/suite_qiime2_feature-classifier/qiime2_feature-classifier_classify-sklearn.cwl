#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_feature_classifier_classify_sklearn
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Pre-fitted sklearn-based taxonomy classifier
doc: Classify reads by taxon using a fitted classifier.
inputs:
  reads:
    doc: The feature data to be classified.
    type: File
  classifier:
    doc: The taxonomic classifier for classifying the reads.
    type: File
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
  pre_dispatch:
    default: 2*n_jobs
    doc: '"all" or expression, as in "3*n_jobs". The number of batches (of tasks)
      to be pre-dispatched.'
    type: string
  confidence:
    default: 0.7
    doc: Confidence threshold for limiting taxonomic depth. Set to "disable" to disable
      confidence calculation, or 0 to calculate confidence but not apply it to limit
      the taxonomic depth of the assignments.
    type:
    - double
    - string
  read_orientation:
    default: auto
    doc: Direction of reads with respect to reference sequences. same will cause reads
      to be classified unchanged; reverse-complement will cause reads to be reversed
      and complemented prior to classification. "auto" will autodetect orientation
      based on the confidence estimates for the first 100 reads.
    type: string
  classification:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- feature_classifier
- classify_sklearn
- inputs.json
outputs:
  classification_file:
    doc: null
    outputBinding:
      glob: $(inputs.classification)
    type: File
