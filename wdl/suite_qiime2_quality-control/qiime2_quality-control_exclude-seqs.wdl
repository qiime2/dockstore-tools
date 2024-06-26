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

struct qiime2_quality_control_exclude_seqs_params {
    File query_sequences
    File reference_sequences
    String method
    Float perc_identity
    Float? evalue
    Float perc_query_aligned
    Int threads
    String left_justify
    String sequence_hits
    String sequence_misses
}

task qiime2_quality_control_exclude_seqs {

    input {
        File query_sequences
        File reference_sequences
        String method = 'blast'
        Float perc_identity = 0.97
        Float? evalue
        Float perc_query_aligned = 0.97
        Int threads = 1
        String left_justify = 'False'
        String sequence_hits
        String sequence_misses
    }

    qiime2_quality_control_exclude_seqs_params task_params = object {
        query_sequences: query_sequences,
        reference_sequences: reference_sequences,
        method: method,
        perc_identity: perc_identity,
        evalue: evalue,
        perc_query_aligned: perc_query_aligned,
        threads: threads,
        left_justify: left_justify,
        sequence_hits: sequence_hits,
        sequence_misses: sequence_misses
    }

    command {
        q2dataflow wdl run quality_control exclude_seqs ~{write_json(task_params)}
    }

    output {
        File sequence_hits_file = "~{sequence_hits}"
        File sequence_misses_file = "~{sequence_misses}"
    }

}


workflow wkflw_qiime2_quality_control_exclude_seqs {
input {
        File query_sequences
        File reference_sequences
        String method = 'blast'
        Float perc_identity = 0.97
        Float? evalue
        Float perc_query_aligned = 0.97
        Int threads = 1
        String left_justify = 'False'
        String sequence_hits
        String sequence_misses
    }

    call qiime2_quality_control_exclude_seqs {
        input: query_sequences=query_sequences, reference_sequences=reference_sequences, method=method, perc_identity=perc_identity, evalue=evalue, perc_query_aligned=perc_query_aligned, threads=threads, left_justify=left_justify, sequence_hits=sequence_hits, sequence_misses=sequence_misses
    }

}
