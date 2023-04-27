# 
# Copyright (c) 2023, QIIME 2 development team.
# 
# Distributed under the terms of the Modified BSD License. (SPDX: BSD-3-Clause)
# 
# 
# This tool was automatically generated by:
#     q2wdl (version: 0.1.0)
# for:
#     qiime2 (version: 2023.2.0)
# 


version 1.0

struct qiime2_diversity_beta_correlation_params {
    File distance_matrix
    String metadata
    File q2wdl_metafile_metadata
    String method
    Int permutations
    Boolean intersect_ids
    String label1
    String label2
    String metadata_distance_matrix
    String mantel_scatter_visualization
}

task qiime2_diversity_beta_correlation {

    input {
        File distance_matrix
        String metadata
        File q2wdl_metafile_metadata
        String method = "spearman"
        Int permutations = 999
        Boolean intersect_ids = false
        String label1 = "Metadata"
        String label2 = "Distance Matrix"
        String metadata_distance_matrix
        String mantel_scatter_visualization
    }

    qiime2_diversity_beta_correlation_params task_params = object {
        distance_matrix: distance_matrix,
        metadata: metadata,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        method: method,
        permutations: permutations,
        intersect_ids: intersect_ids,
        label1: label1,
        label2: label2,
        metadata_distance_matrix: metadata_distance_matrix,
        mantel_scatter_visualization: mantel_scatter_visualization
    }

    command {
        q2dataflow q2wdl run diversity beta_correlation ~{write_json(task_params)}
    }

    output {
        File metadata_distance_matrix_file = "~{metadata_distance_matrix}"
        File mantel_scatter_visualization_file = "~{mantel_scatter_visualization}"
    }

}


workflow wkflw_qiime2_diversity_beta_correlation {
input {
        File distance_matrix
        String metadata
        File q2wdl_metafile_metadata
        String method = "spearman"
        Int permutations = 999
        Boolean intersect_ids = false
        String label1 = "Metadata"
        String label2 = "Distance Matrix"
        String metadata_distance_matrix
        String mantel_scatter_visualization
    }

    call qiime2_diversity_beta_correlation {
        input: distance_matrix=distance_matrix, metadata=metadata, q2wdl_metafile_metadata=q2wdl_metafile_metadata, method=method, permutations=permutations, intersect_ids=intersect_ids, label1=label1, label2=label2, metadata_distance_matrix=metadata_distance_matrix, mantel_scatter_visualization=mantel_scatter_visualization
    }

}
