# 
# Copyright (c) 2024, QIIME 2 development team.
# 
# Distributed under the terms of the Modified BSD License. (SPDX: BSD-3-Clause)
# 
# 
# This template was automatically generated by:
#     q2dataflow wdl (version: 0.2.0)
# for:
#     qiime2 (version: 2024.2.0)
# 


version 1.0

struct qiime2_rescript_extract_seq_segments_params {
    File input_sequences
    File reference_segment_sequences
    Float perc_identity
    Int? min_seq_len
    Int threads
    String extracted_sequence_segments
    String unmatched_sequences
}

task qiime2_rescript_extract_seq_segments {

    input {
        File input_sequences
        File reference_segment_sequences
        Float perc_identity = 0.7
        Int? min_seq_len
        Int threads = 1
        String extracted_sequence_segments
        String unmatched_sequences
    }

    qiime2_rescript_extract_seq_segments_params task_params = object {
        input_sequences: input_sequences,
        reference_segment_sequences: reference_segment_sequences,
        perc_identity: perc_identity,
        min_seq_len: min_seq_len,
        threads: threads,
        extracted_sequence_segments: extracted_sequence_segments,
        unmatched_sequences: unmatched_sequences
    }

    command {
        q2dataflow wdl run rescript extract_seq_segments ~{write_json(task_params)}
    }

    output {
        File extracted_sequence_segments_file = "~{extracted_sequence_segments}"
        File unmatched_sequences_file = "~{unmatched_sequences}"
    }

}


workflow wkflw_qiime2_rescript_extract_seq_segments {
input {
        File input_sequences
        File reference_segment_sequences
        Float perc_identity = 0.7
        Int? min_seq_len
        Int threads = 1
        String extracted_sequence_segments
        String unmatched_sequences
    }

    call qiime2_rescript_extract_seq_segments {
        input: input_sequences=input_sequences, reference_segment_sequences=reference_segment_sequences, perc_identity=perc_identity, min_seq_len=min_seq_len, threads=threads, extracted_sequence_segments=extracted_sequence_segments, unmatched_sequences=unmatched_sequences
    }

}
