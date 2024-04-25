#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_vsearch_uchime_ref
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Reference-based chimera filtering with vsearch.
doc: Apply the vsearch uchime_ref method to identify chimeric feature sequences. The
  results of this method can be used to filter chimeric features from the corresponding
  feature table. For additional details, please refer to the vsearch documentation.
inputs:
  sequences:
    doc: The feature sequences to be chimera-checked.
    type: File
  table:
    doc: Feature table (used for computing total feature abundances).
    type: File
  reference_sequences:
    doc: The non-chimeric reference sequences.
    type: File
  dn:
    default: 1.4
    doc: No vote pseudo-count, corresponding to the parameter n in the chimera scoring
      function.
    type: double
  mindiffs:
    default: 3
    doc: Minimum number of differences per segment.
    type: long
  mindiv:
    default: 0.8
    doc: Minimum divergence from closest parent.
    type: double
  minh:
    default: 0.28
    doc: Minimum score (h). Increasing this value tends to reduce the number of false
      positives and to decrease sensitivity.
    type: double
  xn:
    default: 8.0
    doc: No vote weight, corresponding to the parameter beta in the scoring function.
    type: double
  threads:
    default: 1
    doc: The number of threads to use for computation. Passing 0 will launch one thread
      per CPU core.
    type: long
  chimeras:
    doc: The chimeric sequences.
    type: string
  nonchimeras:
    doc: The non-chimeric sequences.
    type: string
  stats:
    doc: Summary statistics from chimera checking.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- vsearch
- uchime_ref
- inputs.json
outputs:
  chimeras_file:
    doc: The chimeric sequences.
    outputBinding:
      glob: $(inputs.chimeras)
    type: File
  nonchimeras_file:
    doc: The non-chimeric sequences.
    outputBinding:
      glob: $(inputs.nonchimeras)
    type: File
  stats_file:
    doc: Summary statistics from chimera checking.
    outputBinding:
      glob: $(inputs.stats)
    type: File
