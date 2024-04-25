#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_demux_partition_samples_paired
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Split demultiplexed sequence data into partitions.
doc: Partition demultiplexed paired end sequences into individual samples or the number
  of partitions specified.
inputs:
  demux:
    doc: The demultiplexed sequences to partition.
    type: File
  num_partitions:
    doc: The number of partitions to split the demultiplexed sequences into. Defaults
      to partitioning into individual samples.
    type: long?
  partitioned_demux:
    doc: The partitioned demultiplexed sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- demux
- partition_samples_paired
- inputs.json
outputs:
  partitioned_demux_dir:
    doc: The partitioned demultiplexed sequences.
    outputBinding:
      glob: $(inputs.partitioned_demux)
    type: Directory
