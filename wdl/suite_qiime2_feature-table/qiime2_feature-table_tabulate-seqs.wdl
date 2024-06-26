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

struct qiime2_feature_table_tabulate_seqs_params {
    File data
    String? taxonomy
    Array[File]? q2wdl_metafile_metadata
    String merge_method
    String visualization
}

task qiime2_feature_table_tabulate_seqs {

    input {
        File data
        String? taxonomy
        Array[File]? q2wdl_metafile_metadata
        String merge_method = "strict"
        String visualization
    }

    qiime2_feature_table_tabulate_seqs_params task_params = object {
        data: data,
        taxonomy: taxonomy,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        merge_method: merge_method,
        visualization: visualization
    }

    command {
        q2dataflow wdl run feature_table tabulate_seqs ~{write_json(task_params)}
    }

    output {
        File visualization_file = "~{visualization}"
    }

}


workflow wkflw_qiime2_feature_table_tabulate_seqs {
input {
        File data
        String? taxonomy
        Array[File]? q2wdl_metafile_metadata
        String merge_method = "strict"
        String visualization
    }

    call qiime2_feature_table_tabulate_seqs {
        input: data=data, taxonomy=taxonomy, q2wdl_metafile_metadata=q2wdl_metafile_metadata, merge_method=merge_method, visualization=visualization
    }

}
