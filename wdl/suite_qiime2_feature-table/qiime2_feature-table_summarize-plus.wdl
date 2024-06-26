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

struct qiime2_feature_table_summarize_plus_params {
    File table
    Array[File]? q2wdl_metafile_metadata
    String feature_frequencies
    String sample_frequencies
    String summary
}

task qiime2_feature_table_summarize_plus {

    input {
        File table
        Array[File]? q2wdl_metafile_metadata
        String feature_frequencies
        String sample_frequencies
        String summary
    }

    qiime2_feature_table_summarize_plus_params task_params = object {
        table: table,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        feature_frequencies: feature_frequencies,
        sample_frequencies: sample_frequencies,
        summary: summary
    }

    command {
        q2dataflow wdl run feature_table summarize_plus ~{write_json(task_params)}
    }

    output {
        File feature_frequencies_file = "~{feature_frequencies}"
        File sample_frequencies_file = "~{sample_frequencies}"
        File summary_file = "~{summary}"
    }

}


workflow wkflw_qiime2_feature_table_summarize_plus {
input {
        File table
        Array[File]? q2wdl_metafile_metadata
        String feature_frequencies
        String sample_frequencies
        String summary
    }

    call qiime2_feature_table_summarize_plus {
        input: table=table, q2wdl_metafile_metadata=q2wdl_metafile_metadata, feature_frequencies=feature_frequencies, sample_frequencies=sample_frequencies, summary=summary
    }

}
