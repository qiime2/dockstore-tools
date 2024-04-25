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

struct qiime2_fragment_insertion_sepp_params {
    File representative_sequences
    File reference_database
    Int alignment_subset_size
    Int placement_subset_size
    Int threads
    Boolean debug
    String tree
    String placements
}

task qiime2_fragment_insertion_sepp {

    input {
        File representative_sequences
        File reference_database
        Int alignment_subset_size = 1000
        Int placement_subset_size = 5000
        Int threads = 1
        Boolean debug = false
        String tree
        String placements
    }

    qiime2_fragment_insertion_sepp_params task_params = object {
        representative_sequences: representative_sequences,
        reference_database: reference_database,
        alignment_subset_size: alignment_subset_size,
        placement_subset_size: placement_subset_size,
        threads: threads,
        debug: debug,
        tree: tree,
        placements: placements
    }

    command {
        q2dataflow wdl run fragment_insertion sepp ~{write_json(task_params)}
    }

    output {
        File tree_file = "~{tree}"
        File placements_file = "~{placements}"
    }

}


workflow wkflw_qiime2_fragment_insertion_sepp {
input {
        File representative_sequences
        File reference_database
        Int alignment_subset_size = 1000
        Int placement_subset_size = 5000
        Int threads = 1
        Boolean debug = false
        String tree
        String placements
    }

    call qiime2_fragment_insertion_sepp {
        input: representative_sequences=representative_sequences, reference_database=reference_database, alignment_subset_size=alignment_subset_size, placement_subset_size=placement_subset_size, threads=threads, debug=debug, tree=tree, placements=placements
    }

}