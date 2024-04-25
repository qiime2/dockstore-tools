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

struct qiime2_rescript_filter_seqs_length_by_taxon_params {
    File sequences
    File taxonomy
    Array[String] labels
    Array[Int]? min_lens
    Array[Int]? max_lens
    Int? global_min
    Int? global_max
    String filtered_seqs
    String discarded_seqs
}

task qiime2_rescript_filter_seqs_length_by_taxon {

    input {
        File sequences
        File taxonomy
        Array[String] labels
        Array[Int]? min_lens
        Array[Int]? max_lens
        Int? global_min
        Int? global_max
        String filtered_seqs
        String discarded_seqs
    }

    qiime2_rescript_filter_seqs_length_by_taxon_params task_params = object {
        sequences: sequences,
        taxonomy: taxonomy,
        labels: labels,
        min_lens: min_lens,
        max_lens: max_lens,
        global_min: global_min,
        global_max: global_max,
        filtered_seqs: filtered_seqs,
        discarded_seqs: discarded_seqs
    }

    command {
        q2dataflow wdl run rescript filter_seqs_length_by_taxon ~{write_json(task_params)}
    }

    output {
        File filtered_seqs_file = "~{filtered_seqs}"
        File discarded_seqs_file = "~{discarded_seqs}"
    }

}


workflow wkflw_qiime2_rescript_filter_seqs_length_by_taxon {
input {
        File sequences
        File taxonomy
        Array[String] labels
        Array[Int]? min_lens
        Array[Int]? max_lens
        Int? global_min
        Int? global_max
        String filtered_seqs
        String discarded_seqs
    }

    call qiime2_rescript_filter_seqs_length_by_taxon {
        input: sequences=sequences, taxonomy=taxonomy, labels=labels, min_lens=min_lens, max_lens=max_lens, global_min=global_min, global_max=global_max, filtered_seqs=filtered_seqs, discarded_seqs=discarded_seqs
    }

}
