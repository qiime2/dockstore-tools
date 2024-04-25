#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
id: qiime2_dada2_denoise_ccs
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entryname: inputs.json
      entry: '{"inputs": $(inputs)}'
label: Denoise and dereplicate single-end Pacbio CCS
doc: 'This method denoises single-end Pacbio CCS sequences, dereplicates them, and
  filters chimeras. Tutorial and workflow: https://github.com/benjjneb/LRASManuscript'
inputs:
  demultiplexed_seqs:
    doc: The single-end demultiplexed PacBio CCS sequences to be denoised.
    type: File
  front:
    doc: Sequence of an adapter ligated to the 5' end. The adapter and any preceding
      bases are trimmed. Can contain IUPAC ambiguous nucleotide codes. Note, primer
      direction is 5' to 3'. Primers are removed before trim and filter step. Reads
      that do not contain the primer are discarded. Each read is re-oriented if the
      reverse complement of the read is a better match to the provided primer sequence.
      This is recommended for PacBio CCS reads, which come in a random mix of forward
      and reverse-complement orientations.
    type: string
  adapter:
    doc: Sequence of an adapter ligated to the 3' end. The adapter and any preceding
      bases are trimmed. Can contain IUPAC ambiguous nucleotide codes. Note, primer
      direction is 5' to 3'. Primers are removed before trim and filter step. Reads
      that do not contain the primer are discarded.
    type: string
  max_mismatch:
    default: 2
    doc: The number of mismatches to tolerate when matching reads to primer sequences
      - see http://benjjneb.github.io/dada2/ for complete details.
    type: long
  indels:
    default: false
    doc: Allow insertions or deletions of bases when matching adapters. Note that
      primer matching can be significantly slower, currently about 4x slower
    type: boolean
  trunc_len:
    default: 0
    doc: 'Position at which sequences should be truncated due to decrease in quality.
      This truncates the 3'' end of the of the input sequences, which will be the
      bases that were sequenced in the last cycles. Reads that are shorter than this
      value will be discarded. If 0 is provided, no truncation or length filtering
      will be performed. Note: Since Pacbio CCS sequences were normally with very
      high quality scores, there is no need to truncate the Pacbio CCS sequences.'
    type: long
  trim_left:
    default: 0
    doc: Position at which sequences should be trimmed due to low quality. This trims
      the 5' end of the of the input sequences, which will be the bases that were
      sequenced in the first cycles.
    type: long
  max_ee:
    default: 2.0
    doc: Reads with number of expected errors higher than this value will be discarded.
    type: double
  trunc_q:
    default: 2
    doc: Reads are truncated at the first instance of a quality score less than or
      equal to this value. If the resulting read is then shorter than `trunc_len`,
      it is discarded.
    type: long
  min_len:
    default: 20
    doc: Remove reads with length less than minLen. minLen is enforced after trimming
      and truncation. For 16S Pacbio CCS, suggest 1000.
    type: long
  max_len:
    default: 0
    doc: Remove reads prior to trimming or truncation which are longer than this value.
      If 0 is provided no reads will be removed based on length. For 16S Pacbio CCS,
      suggest 1600.
    type: long
  pooling_method:
    default: independent
    doc: 'The method used to pool samples for denoising. "independent": Samples are
      denoised indpendently. "pseudo": The pseudo-pooling method is used to approximate
      pooling of samples. In short, samples are denoised independently once, ASVs
      detected in at least 2 samples are recorded, and samples are denoised independently
      a second time, but this time with prior knowledge of the recorded ASVs and thus
      higher sensitivity to those ASVs.'
    type: string
  chimera_method:
    default: consensus
    doc: 'The method used to remove chimeras. "none": No chimera removal is performed.
      "pooled": All reads are pooled prior to chimera detection. "consensus": Chimeras
      are detected in samples individually, and sequences found chimeric in a sufficient
      fraction of samples are removed.'
    type: string
  min_fold_parent_over_abundance:
    default: 3.5
    doc: The minimum abundance of potential parents of a sequence being tested as
      chimeric, expressed as a fold-change versus the abundance of the sequence being
      tested. Values should be greater than or equal to 1 (i.e. parents should be
      more abundant than the sequence being tested). Suggest 3.5. This parameter has
      no effect if chimera_method is "none".
    type: double
  allow_one_off:
    default: false
    doc: Bimeras that are one-off from exact are also identified if the `allow_one_off`
      argument is True. If True, a sequence will be identified as bimera if it is
      one mismatch or indel away from an exact bimera.
    type: boolean
  n_threads:
    default: 1
    doc: The number of threads to use for multithreaded processing. If 0 is provided,
      all available cores will be used.
    type: long
  n_reads_learn:
    default: 1000000
    doc: The number of reads to use when training the error model. Smaller numbers
      will result in a shorter run time but a less reliable error model.
    type: long
  hashed_feature_ids:
    default: true
    doc: If true, the feature ids in the resulting table will be presented as hashes
      of the sequences defining each feature. The hash will always be the same for
      the same sequence so this allows feature tables to be merged across runs of
      this method. You should only merge tables if the exact same parameters are used
      for each run.
    type: boolean
  table:
    doc: The resulting feature table.
    type: string
  representative_sequences:
    doc: The resulting feature sequences. Each feature in the feature table will be
      represented by exactly one sequence.
    type: string
  denoising_stats:
    doc: null
    type: string
baseCommand: q2dataflow
arguments:
- cwl
- run
- dada2
- denoise_ccs
- inputs.json
outputs:
  table_file:
    doc: The resulting feature table.
    outputBinding:
      glob: $(inputs.table)
    type: File
  representative_sequences_file:
    doc: The resulting feature sequences. Each feature in the feature table will be
      represented by exactly one sequence.
    outputBinding:
      glob: $(inputs.representative_sequences)
    type: File
  denoising_stats_file:
    doc: null
    outputBinding:
      glob: $(inputs.denoising_stats)
    type: File
