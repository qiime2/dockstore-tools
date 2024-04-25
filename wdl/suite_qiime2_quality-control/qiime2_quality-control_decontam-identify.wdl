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

struct qiime2_quality_control_decontam_identify_params {
    File table
    Array[File] q2wdl_metafile_metadata
    String method
    String? freq_concentration_column
    String? prev_control_column
    String? prev_control_indicator
    String decontam_scores
}

task qiime2_quality_control_decontam_identify {

    input {
        File table
        Array[File] q2wdl_metafile_metadata
        String method = "prevalence"
        String? freq_concentration_column
        String? prev_control_column
        String? prev_control_indicator
        String decontam_scores
    }

    qiime2_quality_control_decontam_identify_params task_params = object {
        table: table,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        method: method,
        freq_concentration_column: freq_concentration_column,
        prev_control_column: prev_control_column,
        prev_control_indicator: prev_control_indicator,
        decontam_scores: decontam_scores
    }

    command {
        q2dataflow wdl run quality_control decontam_identify ~{write_json(task_params)}
    }

    output {
        File decontam_scores_file = "~{decontam_scores}"
    }

}


workflow wkflw_qiime2_quality_control_decontam_identify {
input {
        File table
        Array[File] q2wdl_metafile_metadata
        String method = "prevalence"
        String? freq_concentration_column
        String? prev_control_column
        String? prev_control_indicator
        String decontam_scores
    }

    call qiime2_quality_control_decontam_identify {
        input: table=table, q2wdl_metafile_metadata=q2wdl_metafile_metadata, method=method, freq_concentration_column=freq_concentration_column, prev_control_column=prev_control_column, prev_control_indicator=prev_control_indicator, decontam_scores=decontam_scores
    }

}
