#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_procrustes_analysis
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Procrustes Analysis
doc: Fit two ordination matrices with Procrustes analysis
inputs:
  reference:
    doc: The ordination matrix to which data is fitted to.
    type: File
  other:
    doc: The ordination matrix that's fitted to the reference ordination.
    type: File
  dimensions:
    default: 5
    doc: The number of dimensions to use when fitting the two matrices
    type: long
  permutations:
    default: 999
    doc: The number of permutations to be run when computing p-values. Supplying a
      value of `disable` will disable permutation testing and p-values will not be
      calculated (this results in *much* quicker execution time if p-values are not
      desired).
    type:
    - long
    - string
  transformed_reference:
    doc: A normalized version of the "reference" ordination matrix.
    type: string
  transformed_other:
    doc: A normalized and fitted version of the "other" ordination matrix.
    type: string
  disparity_results:
    doc: The sum of the squares of the pointwise differences between the two input
      datasets & its p value.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- procrustes_analysis
- inputs.json
outputs:
  transformed_reference_file:
    doc: A normalized version of the "reference" ordination matrix.
    outputBinding:
      glob: $(inputs.transformed_reference)
    type: File
  transformed_other_file:
    doc: A normalized and fitted version of the "other" ordination matrix.
    outputBinding:
      glob: $(inputs.transformed_other)
    type: File
  disparity_results_file:
    doc: The sum of the squares of the pointwise differences between the two input
      datasets & its p value.
    outputBinding:
      glob: $(inputs.disparity_results)
    type: File
