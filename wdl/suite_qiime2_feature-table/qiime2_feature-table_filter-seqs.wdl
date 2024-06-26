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

struct qiime2_feature_table_filter_seqs_params {
    File data
    File? table
    Array[File]? q2wdl_metafile_metadata
    String? where
    Boolean exclude_ids
    String filtered_data
}

task qiime2_feature_table_filter_seqs {

    input {
        File data
        File? table
        Array[File]? q2wdl_metafile_metadata
        String? where
        Boolean exclude_ids = false
        String filtered_data
    }

    qiime2_feature_table_filter_seqs_params task_params = object {
        data: data,
        table: table,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        where: where,
        exclude_ids: exclude_ids,
        filtered_data: filtered_data
    }

    command {
        q2dataflow wdl run feature_table filter_seqs ~{write_json(task_params)}
    }

    output {
        File filtered_data_file = "~{filtered_data}"
    }

}


workflow wkflw_qiime2_feature_table_filter_seqs {
input {
        File data
        File? table
        Array[File]? q2wdl_metafile_metadata
        String? where
        Boolean exclude_ids = false
        String filtered_data
    }

    call qiime2_feature_table_filter_seqs {
        input: data=data, table=table, q2wdl_metafile_metadata=q2wdl_metafile_metadata, where=where, exclude_ids=exclude_ids, filtered_data=filtered_data
    }

}
