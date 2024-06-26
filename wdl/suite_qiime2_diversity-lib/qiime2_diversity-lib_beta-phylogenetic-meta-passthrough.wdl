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

struct qiime2_diversity_lib_beta_phylogenetic_meta_passthrough_params {
    Array[File] tables
    Array[File] phylogenies
    String metric
    Int threads
    Boolean variance_adjusted
    Float? alpha
    Boolean bypass_tips
    Array[Float]? weights
    String consolidation
    String distance_matrix
}

task qiime2_diversity_lib_beta_phylogenetic_meta_passthrough {

    input {
        Array[File] tables
        Array[File] phylogenies
        String metric
        Int threads = 1
        Boolean variance_adjusted = false
        Float? alpha
        Boolean bypass_tips = false
        Array[Float]? weights
        String consolidation = "skipping_missing_values"
        String distance_matrix
    }

    qiime2_diversity_lib_beta_phylogenetic_meta_passthrough_params task_params = object {
        tables: tables,
        phylogenies: phylogenies,
        metric: metric,
        threads: threads,
        variance_adjusted: variance_adjusted,
        alpha: alpha,
        bypass_tips: bypass_tips,
        weights: weights,
        consolidation: consolidation,
        distance_matrix: distance_matrix
    }

    command {
        q2dataflow wdl run diversity_lib beta_phylogenetic_meta_passthrough ~{write_json(task_params)}
    }

    output {
        File distance_matrix_file = "~{distance_matrix}"
    }

}


workflow wkflw_qiime2_diversity_lib_beta_phylogenetic_meta_passthrough {
input {
        Array[File] tables
        Array[File] phylogenies
        String metric
        Int threads = 1
        Boolean variance_adjusted = false
        Float? alpha
        Boolean bypass_tips = false
        Array[Float]? weights
        String consolidation = "skipping_missing_values"
        String distance_matrix
    }

    call qiime2_diversity_lib_beta_phylogenetic_meta_passthrough {
        input: tables=tables, phylogenies=phylogenies, metric=metric, threads=threads, variance_adjusted=variance_adjusted, alpha=alpha, bypass_tips=bypass_tips, weights=weights, consolidation=consolidation, distance_matrix=distance_matrix
    }

}
