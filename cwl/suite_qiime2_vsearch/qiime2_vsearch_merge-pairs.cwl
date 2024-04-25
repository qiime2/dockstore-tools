#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_vsearch_merge_pairs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Merge paired-end reads.
doc: Merge paired-end sequence reads using vsearch's merge_pairs function. See the
  vsearch documentation for details on how paired-end merging is performed, and for
  more information on the parameters to this method.
inputs:
  demultiplexed_seqs:
    doc: The demultiplexed paired-end sequences to be merged.
    type: File
  truncqual:
    doc: Truncate sequences at the first base with the specified quality score value
      or lower.
    type: long?
  minlen:
    default: 1
    doc: Sequences shorter than minlen after truncation are discarded.
    type: long
  maxns:
    doc: Sequences with more than maxns N characters are discarded.
    type: long?
  allowmergestagger:
    default: false
    doc: Allow merging of staggered read pairs.
    type: boolean
  minovlen:
    default: 10
    doc: Minimum length of the area of overlap between reads during merging.
    type: long
  maxdiffs:
    default: 10
    doc: Maximum number of mismatches in the area of overlap during merging.
    type: long
  minmergelen:
    doc: Minimum length of the merged read to be retained.
    type: long?
  maxmergelen:
    doc: Maximum length of the merged read to be retained.
    type: long?
  maxee:
    doc: Maximum number of expected errors in the merged read to be retained.
    type: double?
  threads:
    default: 1
    doc: The number of threads to use for computation. Does not scale much past 4
      threads.
    type: long
  merged_sequences:
    doc: The merged sequences.
    type: string
  unmerged_sequences:
    doc: The unmerged paired-end reads.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- vsearch
- merge_pairs
- inputs.json
outputs:
  merged_sequences_file:
    doc: The merged sequences.
    outputBinding:
      glob: $(inputs.merged_sequences)
    type: File
  unmerged_sequences_file:
    doc: The unmerged paired-end reads.
    outputBinding:
      glob: $(inputs.unmerged_sequences)
    type: File
