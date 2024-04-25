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

struct qiime2_metadata_merge_params {
    Array[File] q2wdl_metafile_metadata1
    Array[File] q2wdl_metafile_metadata2
    String merged_metadata
}

task qiime2_metadata_merge {

    input {
        Array[File] q2wdl_metafile_metadata1
        Array[File] q2wdl_metafile_metadata2
        String merged_metadata
    }

    qiime2_metadata_merge_params task_params = object {
        q2wdl_metafile_metadata1: q2wdl_metafile_metadata1,
        q2wdl_metafile_metadata2: q2wdl_metafile_metadata2,
        merged_metadata: merged_metadata
    }

    command {
        q2dataflow wdl run metadata merge ~{write_json(task_params)}
    }

    output {
        File merged_metadata_file = "~{merged_metadata}"
    }

}


workflow wkflw_qiime2_metadata_merge {
input {
        Array[File] q2wdl_metafile_metadata1
        Array[File] q2wdl_metafile_metadata2
        String merged_metadata
    }

    call qiime2_metadata_merge {
        input: q2wdl_metafile_metadata1=q2wdl_metafile_metadata1, q2wdl_metafile_metadata2=q2wdl_metafile_metadata2, merged_metadata=merged_metadata
    }

}