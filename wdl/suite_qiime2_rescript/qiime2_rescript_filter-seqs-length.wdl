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

struct qiime2_rescript_filter_seqs_length_params {
    File sequences
    Int? global_min
    Int? global_max
    Int threads
    String filtered_seqs
    String discarded_seqs
}

task qiime2_rescript_filter_seqs_length {

    input {
        File sequences
        Int? global_min
        Int? global_max
        Int threads = 1
        String filtered_seqs
        String discarded_seqs
    }

    qiime2_rescript_filter_seqs_length_params task_params = object {
        sequences: sequences,
        global_min: global_min,
        global_max: global_max,
        threads: threads,
        filtered_seqs: filtered_seqs,
        discarded_seqs: discarded_seqs
    }

    command {
        q2dataflow wdl run rescript filter_seqs_length ~{write_json(task_params)}
    }

    output {
        File filtered_seqs_file = "~{filtered_seqs}"
        File discarded_seqs_file = "~{discarded_seqs}"
    }

}


workflow wkflw_qiime2_rescript_filter_seqs_length {
input {
        File sequences
        Int? global_min
        Int? global_max
        Int threads = 1
        String filtered_seqs
        String discarded_seqs
    }

    call qiime2_rescript_filter_seqs_length {
        input: sequences=sequences, global_min=global_min, global_max=global_max, threads=threads, filtered_seqs=filtered_seqs, discarded_seqs=discarded_seqs
    }

}
