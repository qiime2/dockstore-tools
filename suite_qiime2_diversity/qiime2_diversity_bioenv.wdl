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

struct qiime2_diversity_bioenv_params {
    File distance_matrix
    Array[File] q2wdl_metafile_metadata
    String visualization
}

task qiime2_diversity_bioenv {

    input {
        File distance_matrix
        Array[File] q2wdl_metafile_metadata
        String visualization
    }

    qiime2_diversity_bioenv_params task_params = object {
        distance_matrix: distance_matrix,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        visualization: visualization
    }

    command {
        q2dataflow q2wdl run diversity bioenv ~{write_json(task_params)}
    }

    output {
        File visualization_file = "~{visualization}"
    }

}


workflow wkflw_qiime2_diversity_bioenv {
input {
        File distance_matrix
        Array[File] q2wdl_metafile_metadata
        String visualization
    }

    call qiime2_diversity_bioenv {
        input: distance_matrix=distance_matrix, q2wdl_metafile_metadata=q2wdl_metafile_metadata, visualization=visualization
    }

}