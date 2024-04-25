#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_evaluate_fit_classifier
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Evaluate and train naive Bayes classifier on reference sequences.
doc: Train a naive Bayes classifier on a set of reference sequences, then test performance
  accuracy on this same set of sequences. This results in a "perfect" classifier that
  "knows" the correct identity of each input sequence. Such a leaky classifier indicates
  the upper limit of classification accuracy based on sequence information alone,
  as misclassifications are an indication of unresolvable kmer profiles. This test
  simulates the case where all query sequences are present in a fully comprehensive
  reference database. To simulate more realistic conditions, see `evaluate_cross_validate`.
  THE CLASSIFIER OUTPUT BY THIS PIPELINE IS PRODUCTION-READY and can be re-used for
  classification of other sequences (provided the reference data are viable), hence
  THIS PIPELINE IS USEFUL FOR TRAINING FEATURE CLASSIFIERS AND THEN EVALUATING THEM
  ON-THE-FLY.
inputs:
  sequences:
    doc: Reference sequences to use for classifier training/testing.
    type: File
  taxonomy:
    doc: Reference taxonomy to use for classifier training/testing.
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
  confidence:
    default: 0.7
    doc: Confidence threshold for limiting taxonomic depth. Set to "disable" to disable
      confidence calculation, or 0 to calculate confidence but not apply it to limit
      the taxonomic depth of the assignments.
    type:
    - double
    - string
  classifier:
    doc: Trained naive Bayes taxonomic classifier.
    type: string
  evaluation:
    doc: Visualization of classification accuracy results.
    type: string
  observed_taxonomy:
    doc: Observed taxonomic label for each input sequence, predicted by the trained
      classifier.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- evaluate_fit_classifier
- inputs.json
outputs:
  classifier_file:
    doc: Trained naive Bayes taxonomic classifier.
    outputBinding:
      glob: $(inputs.classifier)
    type: File
  evaluation_file:
    doc: Visualization of classification accuracy results.
    outputBinding:
      glob: $(inputs.evaluation)
    type: File
  observed_taxonomy_file:
    doc: Observed taxonomic label for each input sequence, predicted by the trained
      classifier.
    outputBinding:
      glob: $(inputs.observed_taxonomy)
    type: File
