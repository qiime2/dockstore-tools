#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_cutadapt_trim_paired
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Find and remove adapters in demultiplexed paired-end sequences.
doc: Search demultiplexed paired-end sequences for adapters and remove them. The parameter
  descriptions in this method are adapted from the official cutadapt docs - please
  see those docs at https://cutadapt.readthedocs.io for complete details.
inputs:
  demultiplexed_sequences:
    doc: The paired-end sequences to be trimmed.
    type: File
  cores:
    default: 1
    doc: Number of CPU cores to use.
    type: long
  adapter_f:
    doc: Sequence of an adapter ligated to the 3' end. The adapter and any subsequent
      bases are trimmed. If a `$` is appended, the adapter is only found if it is
      at the end of the read. Search in forward read. If your sequence of interest
      is "framed" by a 5' and a 3' adapter, use this parameter to define a "linked"
      primer - see https://cutadapt.readthedocs.io for complete details.
    type: string[]?
  front_f:
    doc: Sequence of an adapter ligated to the 5' end. The adapter and any preceding
      bases are trimmed. Partial matches at the 5' end are allowed. If a `^` character
      is prepended, the adapter is only found if it is at the beginning of the read.
      Search in forward read.
    type: string[]?
  anywhere_f:
    doc: Sequence of an adapter that may be ligated to the 5' or 3' end. Both types
      of matches as described under `adapter` and `front` are allowed. If the first
      base of the read is part of the match, the behavior is as with `front`, otherwise
      as with `adapter`. This option is mostly for rescuing failed library preparations
      - do not use if you know which end your adapter was ligated to. Search in forward
      read.
    type: string[]?
  adapter_r:
    doc: Sequence of an adapter ligated to the 3' end. The adapter and any subsequent
      bases are trimmed. If a `$` is appended, the adapter is only found if it is
      at the end of the read. Search in reverse read. If your sequence of interest
      is "framed" by a 5' and a 3' adapter, use this parameter to define a "linked"
      primer - see https://cutadapt.readthedocs.io for complete details.
    type: string[]?
  front_r:
    doc: Sequence of an adapter ligated to the 5' end. The adapter and any preceding
      bases are trimmed. Partial matches at the 5' end are allowed. If a `^` character
      is prepended, the adapter is only found if it is at the beginning of the read.
      Search in reverse read.
    type: string[]?
  anywhere_r:
    doc: Sequence of an adapter that may be ligated to the 5' or 3' end. Both types
      of matches as described under `adapter` and `front` are allowed. If the first
      base of the read is part of the match, the behavior is as with `front`, otherwise
      as with `adapter`. This option is mostly for rescuing failed library preparations
      - do not use if you know which end your adapter was ligated to. Search in reverse
      read.
    type: string[]?
  error_rate:
    default: 0.1
    doc: Maximum allowed error rate.
    type: double
  indels:
    default: true
    doc: Allow insertions or deletions of bases when matching adapters.
    type: boolean
  times:
    default: 1
    doc: Remove multiple occurrences of an adapter if it is repeated, up to `times`
      times.
    type: long
  overlap:
    default: 3
    doc: Require at least `overlap` bases of overlap between read and adapter for
      an adapter to be found.
    type: long
  match_read_wildcards:
    default: false
    doc: Interpret IUPAC wildcards (e.g., N) in reads.
    type: boolean
  match_adapter_wildcards:
    default: true
    doc: Interpret IUPAC wildcards (e.g., N) in adapters.
    type: boolean
  minimum_length:
    default: 1
    doc: Discard reads shorter than specified value. Note, the cutadapt default of
      0 has been overridden, because that value produces empty sequence records.
    type: long
  discard_untrimmed:
    default: false
    doc: Discard reads in which no adapter was found.
    type: boolean
  max_expected_errors:
    doc: Discard reads that exceed maximum expected erroneous nucleotides.
    type: double?
  max_n:
    doc: Discard reads with more than COUNT N bases. If COUNT_or_FRACTION is a number
      between 0 and 1, it is interpreted as a fraction of the read length.
    type: double?
  quality_cutoff_5end:
    default: 0
    doc: Trim nucleotides with Phred score quality lower than threshold from 5 prime
      end.
    type: long
  quality_cutoff_3end:
    default: 0
    doc: Trim nucleotides with Phred score quality lower than threshold from 3 prime
      end.
    type: long
  quality_base:
    default: 33
    doc: How the Phred score is encoded (33 or 64).
    type: long
  trimmed_sequences:
    doc: The resulting trimmed sequences.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- cutadapt
- trim_paired
- inputs.json
outputs:
  trimmed_sequences_file:
    doc: The resulting trimmed sequences.
    outputBinding:
      glob: $(inputs.trimmed_sequences)
    type: File
