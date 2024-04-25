#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_mantel
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Apply the Mantel test to two distance matrices
doc: 'Apply a two-sided Mantel test to identify correlation between two distance matrices.


  Note: the directionality of the comparison has no bearing on the results. Thus,
  comparing distance matrix X to distance matrix Y is equivalent to comparing Y to
  X.


  Note: the order of samples within the two distance matrices does not need to be
  the same; the distance matrices will be reordered before applying the Mantel test.


  See the scikit-bio docs for more details about the Mantel test:


  http://scikit-bio.org/docs/latest/generated/skbio.stats.distance.mantel'
inputs:
  dm1:
    doc: Matrix of distances between pairs of samples.
    type: File
  dm2:
    doc: Matrix of distances between pairs of samples.
    type: File
  method:
    default: spearman
    doc: The correlation test to be applied in the Mantel test.
    type: string
  permutations:
    default: 999
    doc: The number of permutations to be run when computing p-values. Supplying a
      value of zero will disable permutation testing and p-values will not be calculated
      (this results in *much* quicker execution time if p-values are not desired).
    type: long
  intersect_ids:
    default: false
    doc: If supplied, IDs that are not found in both distance matrices will be discarded
      before applying the Mantel test. Default behavior is to error on any mismatched
      IDs.
    type: boolean
  label1:
    default: Distance Matrix 1
    doc: Label for `dm1` in the output visualization.
    type: string
  label2:
    default: Distance Matrix 2
    doc: Label for `dm2` in the output visualization.
    type: string
  visualization:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- mantel
- inputs.json
outputs:
  visualization_file:
    doc: null
    outputBinding:
      glob: $(inputs.visualization)
    type: File
