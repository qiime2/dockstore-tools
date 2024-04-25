#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_longitudinal_nmit
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Nonparametric microbial interdependence test
doc: Perform nonparametric microbial interdependence test to determine longitudinal
  sample similarity as a function of temporal microbial composition. For more details
  and citation, please see doi.org/10.1002/gepi.22065
inputs:
  table:
    doc: Feature table to use for microbial interdependence test.
    type: File
  q2cwl_metafile_metadata:
    doc: Sample metadata file containing individual_id_column.
    type:
    - File
    - File[]
  individual_id_column:
    doc: Metadata column containing IDs for individual subjects.
    type: string
  corr_method:
    default: kendall
    doc: The temporal correlation test to be applied.
    type: string
  dist_method:
    default: fro
    doc: Temporal distance method, see numpy.linalg.norm for details.
    type: string
  distance_matrix:
    doc: The resulting distance matrix.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- longitudinal
- nmit
- inputs.json
outputs:
  distance_matrix_file:
    doc: The resulting distance matrix.
    outputBinding:
      glob: $(inputs.distance_matrix)
    type: File
