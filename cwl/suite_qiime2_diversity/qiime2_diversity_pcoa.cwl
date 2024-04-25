#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_diversity_pcoa
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Principal Coordinate Analysis
doc: Apply principal coordinate analysis.
inputs:
  distance_matrix:
    doc: The distance matrix on which PCoA should be computed.
    type: File
  number_of_dimensions:
    doc: Dimensions to reduce the distance matrix to. This number determines how many
      eigenvectors and eigenvalues are returned,and influences the choice of algorithm
      used to compute them. By default, uses the default eigendecomposition method,
      SciPy's eigh, which computes all eigenvectors and eigenvalues in an exact manner.
      For very large matrices, this is expected to be slow. If a value is specified
      for this parameter, then the fast, heuristic eigendecomposition algorithm fsvd
      is used, which only computes and returns the number of dimensions specified,
      but suffers some degree of accuracy loss, the magnitude of which varies across
      different datasets.
    type: long?
  pcoa:
    doc: The resulting PCoA matrix.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- diversity
- pcoa
- inputs.json
outputs:
  pcoa_file:
    doc: The resulting PCoA matrix.
    outputBinding:
      glob: $(inputs.pcoa)
    type: File
