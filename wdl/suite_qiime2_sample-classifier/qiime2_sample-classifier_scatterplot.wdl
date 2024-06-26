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

struct qiime2_sample_classifier_scatterplot_params {
    File predictions
    String truth
    File q2wdl_metafile_truth
    String missing_samples
    String visualization
}

task qiime2_sample_classifier_scatterplot {

    input {
        File predictions
        String truth
        File q2wdl_metafile_truth
        String missing_samples = "error"
        String visualization
    }

    qiime2_sample_classifier_scatterplot_params task_params = object {
        predictions: predictions,
        truth: truth,
        q2wdl_metafile_truth: q2wdl_metafile_truth,
        missing_samples: missing_samples,
        visualization: visualization
    }

    command {
        q2dataflow wdl run sample_classifier scatterplot ~{write_json(task_params)}
    }

    output {
        File visualization_file = "~{visualization}"
    }

}


workflow wkflw_qiime2_sample_classifier_scatterplot {
input {
        File predictions
        String truth
        File q2wdl_metafile_truth
        String missing_samples = "error"
        String visualization
    }

    call qiime2_sample_classifier_scatterplot {
        input: predictions=predictions, truth=truth, q2wdl_metafile_truth=q2wdl_metafile_truth, missing_samples=missing_samples, visualization=visualization
    }

}
