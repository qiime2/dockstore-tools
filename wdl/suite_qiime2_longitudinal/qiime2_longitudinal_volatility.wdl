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

struct qiime2_longitudinal_volatility_params {
    File? table
    Array[File] q2wdl_metafile_metadata
    String state_column
    String? individual_id_column
    String? default_group_column
    String? default_metric
    String yscale
    String visualization
}

task qiime2_longitudinal_volatility {

    input {
        File? table
        Array[File] q2wdl_metafile_metadata
        String state_column
        String? individual_id_column
        String? default_group_column
        String? default_metric
        String yscale = "linear"
        String visualization
    }

    qiime2_longitudinal_volatility_params task_params = object {
        table: table,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        state_column: state_column,
        individual_id_column: individual_id_column,
        default_group_column: default_group_column,
        default_metric: default_metric,
        yscale: yscale,
        visualization: visualization
    }

    command {
        q2dataflow wdl run longitudinal volatility ~{write_json(task_params)}
    }

    output {
        File visualization_file = "~{visualization}"
    }

}


workflow wkflw_qiime2_longitudinal_volatility {
input {
        File? table
        Array[File] q2wdl_metafile_metadata
        String state_column
        String? individual_id_column
        String? default_group_column
        String? default_metric
        String yscale = "linear"
        String visualization
    }

    call qiime2_longitudinal_volatility {
        input: table=table, q2wdl_metafile_metadata=q2wdl_metafile_metadata, state_column=state_column, individual_id_column=individual_id_column, default_group_column=default_group_column, default_metric=default_metric, yscale=yscale, visualization=visualization
    }

}
