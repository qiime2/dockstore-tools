#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_rescript_orient_seqs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Orient input sequences by comparison against reference.
doc: Orient input sequences by comparison against a set of reference sequences using
  VSEARCH. This action can also be used to quickly filter out sequences that (do not)
  match a set of reference sequences in either orientation. Alternatively, if no reference
  sequences are provided as input, all input sequences will be reverse-complemented.
  In this case, no alignment is performed, and all alignment parameters (`dbmask`,
  `relabel`, `relabel_keep`, `relabel_md5`, `relabel_self`, `relabel_sha1`, `sizein`,
  `sizeout` and `threads`) are ignored.
inputs:
  sequences:
    doc: Sequences to be oriented.
    type: File
  reference_sequences:
    doc: Reference sequences to orient against. If no reference is provided, all the
      sequences will be reverse complemented and all parameters will be ignored.
    type: File?
  threads:
    default: 1
    doc: Number of computation threads to use (1 to 256). The number of threads should
      be lesser or equal to the number of available CPU cores.
    type: long
  dbmask:
    doc: Mask regions in the target database sequences using the dust method, or do
      not mask (none). When using soft masking, search commands become case sensitive.
    type: string?
  relabel:
    doc: Relabel sequences using the prefix string and a ticker (1, 2, 3, etc.) to
      construct the new headers. Use --sizeout to conserve the abundance annotations.
    type: string?
  relabel_keep:
    doc: When relabeling, keep the original identifier in the header after a space.
    type: boolean?
  relabel_md5:
    doc: When relabeling, use the MD5 digest of the sequence as the new identifier.
      Use --sizeout to conserve the abundance annotations.
    type: boolean?
  relabel_self:
    doc: Relabel sequences using the sequence itself as a label.
    type: boolean?
  relabel_sha1:
    doc: When relabeling, use the SHA1 digest of the sequence as the new identifier.
      The probability of a collision is smaller than the MD5 algorithm.
    type: boolean?
  sizein:
    doc: In de novo mode, abundance annotations (pattern `[>;]size=integer[;]`) present
      in sequence headers are taken into account.
    type: boolean?
  sizeout:
    doc: Add abundance annotations to the output FASTA files.
    type: boolean?
  oriented_seqs:
    doc: Query sequences in same orientation as top matching reference sequence.
    type: string
  unmatched_seqs:
    doc: Query sequences that fail to match at least one reference sequence in either
      + or - orientation. This will be empty if no refrence is provided.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- rescript
- orient_seqs
- inputs.json
outputs:
  oriented_seqs_file:
    doc: Query sequences in same orientation as top matching reference sequence.
    outputBinding:
      glob: $(inputs.oriented_seqs)
    type: File
  unmatched_seqs_file:
    doc: Query sequences that fail to match at least one reference sequence in either
      + or - orientation. This will be empty if no refrence is provided.
    outputBinding:
      glob: $(inputs.unmatched_seqs)
    type: File
