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

struct qiime2_metadata_shuffle_groups_params {
    String metadata
    File q2wdl_metafile_metadata
    Int n_columns
    String column_name_prefix
    String column_value_prefix
    String shuffled_groups
}

task qiime2_metadata_shuffle_groups {

    input {
        String metadata
        File q2wdl_metafile_metadata
        Int n_columns = 3
        String column_name_prefix = "shuffled.grouping."
        String column_value_prefix = "fake.group."
        String shuffled_groups
    }

    qiime2_metadata_shuffle_groups_params task_params = object {
        metadata: metadata,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        n_columns: n_columns,
        column_name_prefix: column_name_prefix,
        column_value_prefix: column_value_prefix,
        shuffled_groups: shuffled_groups
    }

    command {
        q2dataflow q2wdl run metadata shuffle_groups ~{write_json(task_params)}
    }

    output {
        File shuffled_groups_file = "~{shuffled_groups}"
    }

}


workflow wkflw_qiime2_metadata_shuffle_groups {
input {
        String metadata
        File q2wdl_metafile_metadata
        Int n_columns = 3
        String column_name_prefix = "shuffled.grouping."
        String column_value_prefix = "fake.group."
        String shuffled_groups
    }

    call qiime2_metadata_shuffle_groups {
        input: metadata=metadata, q2wdl_metafile_metadata=q2wdl_metafile_metadata, n_columns=n_columns, column_name_prefix=column_name_prefix, column_value_prefix=column_value_prefix, shuffled_groups=shuffled_groups
    }

}