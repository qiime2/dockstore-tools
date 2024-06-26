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

struct qiime2_longitudinal_nmit_params {
    File table
    Array[File] q2wdl_metafile_metadata
    String individual_id_column
    String corr_method
    String dist_method
    String distance_matrix
}

task qiime2_longitudinal_nmit {

    input {
        File table
        Array[File] q2wdl_metafile_metadata
        String individual_id_column
        String corr_method = "kendall"
        String dist_method = "fro"
        String distance_matrix
    }

    qiime2_longitudinal_nmit_params task_params = object {
        table: table,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        individual_id_column: individual_id_column,
        corr_method: corr_method,
        dist_method: dist_method,
        distance_matrix: distance_matrix
    }

    command {
        q2dataflow wdl run longitudinal nmit ~{write_json(task_params)}
    }

    output {
        File distance_matrix_file = "~{distance_matrix}"
    }

}


workflow wkflw_qiime2_longitudinal_nmit {
input {
        File table
        Array[File] q2wdl_metafile_metadata
        String individual_id_column
        String corr_method = "kendall"
        String dist_method = "fro"
        String distance_matrix
    }

    call qiime2_longitudinal_nmit {
        input: table=table, q2wdl_metafile_metadata=q2wdl_metafile_metadata, individual_id_column=individual_id_column, corr_method=corr_method, dist_method=dist_method, distance_matrix=distance_matrix
    }

}
