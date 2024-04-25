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

struct qiime2_alignment_mafft_add_params {
    File alignment
    File sequences
    Int n_threads
    Boolean parttree
    Boolean addfragments
    String expanded_alignment
}

task qiime2_alignment_mafft_add {

    input {
        File alignment
        File sequences
        Int n_threads = 1
        Boolean parttree = false
        Boolean addfragments = false
        String expanded_alignment
    }

    qiime2_alignment_mafft_add_params task_params = object {
        alignment: alignment,
        sequences: sequences,
        n_threads: n_threads,
        parttree: parttree,
        addfragments: addfragments,
        expanded_alignment: expanded_alignment
    }

    command {
        q2dataflow wdl run alignment mafft_add ~{write_json(task_params)}
    }

    output {
        File expanded_alignment_file = "~{expanded_alignment}"
    }

}


workflow wkflw_qiime2_alignment_mafft_add {
input {
        File alignment
        File sequences
        Int n_threads = 1
        Boolean parttree = false
        Boolean addfragments = false
        String expanded_alignment
    }

    call qiime2_alignment_mafft_add {
        input: alignment=alignment, sequences=sequences, n_threads=n_threads, parttree=parttree, addfragments=addfragments, expanded_alignment=expanded_alignment
    }

}