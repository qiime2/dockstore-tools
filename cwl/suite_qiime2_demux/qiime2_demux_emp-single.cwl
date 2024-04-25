#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_demux_emp_single
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Demultiplex sequence data generated with the EMP protocol.
doc: Demultiplex sequence data (i.e., map barcode reads to sample ids) for data generated
  with the Earth Microbiome Project (EMP) amplicon sequencing protocol. Details about
  this protocol can be found at http://www.earthmicrobiome.org/protocols-and-standards/
inputs:
  seqs:
    doc: The single-end sequences to be demultiplexed.
    type: File
  q2cwl_metafile_barcodes:
    doc: The sample metadata column containing the per-sample barcodes.
    type: File
  barcodes:
    doc: Column name to use from 'barcodes' file
    type: string
  golay_error_correction:
    default: true
    doc: Perform 12nt Golay error correction on the barcode reads.
    type: boolean
  rev_comp_barcodes:
    default: false
    doc: If provided, the barcode sequence reads will be reverse complemented prior
      to demultiplexing.
    type: boolean
  rev_comp_mapping_barcodes:
    default: false
    doc: If provided, the barcode sequences in the sample metadata will be reverse
      complemented prior to demultiplexing.
    type: boolean
  ignore_description_mismatch:
    default: false
    doc: If enabled, ignore mismatches in sequence record description fields.
    type: boolean
  per_sample_sequences:
    doc: The resulting demultiplexed sequences.
    type: string
  error_correction_details:
    doc: Detail about the barcode error corrections.
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- demux
- emp_single
- inputs.json
outputs:
  per_sample_sequences_file:
    doc: The resulting demultiplexed sequences.
    outputBinding:
      glob: $(inputs.per_sample_sequences)
    type: File
  error_correction_details_file:
    doc: Detail about the barcode error corrections.
    outputBinding:
      glob: $(inputs.error_correction_details)
    type: File
