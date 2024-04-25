#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_vsearch_uchime_denovo
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: De novo chimera filtering with vsearch.
doc: Apply the vsearch uchime_denovo method to identify chimeric feature sequences.
  The results of this method can be used to filter chimeric features from the corresponding
  feature table. For more details, please refer to the vsearch documentation.
inputs:
  sequences:
    doc: The feature sequences to be chimera-checked.
    type: File
  table:
    doc: Feature table (used for computing total feature abundances).
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
- uchime_denovo
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
