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

struct qiime2_sample_classifier_classify_samples_from_dist_params {
    File distance_matrix
    String metadata
    File q2wdl_metafile_metadata
    Int k
    Int cv
    Int? random_state
    Int n_jobs
    String palette
    String predictions
    String accuracy_results
}

task qiime2_sample_classifier_classify_samples_from_dist {

    input {
        File distance_matrix
        String metadata
        File q2wdl_metafile_metadata
        Int k = 1
        Int cv = 5
        Int? random_state
        Int n_jobs = 1
        String palette = "sirocco"
        String predictions
        String accuracy_results
    }

    qiime2_sample_classifier_classify_samples_from_dist_params task_params = object {
        distance_matrix: distance_matrix,
        metadata: metadata,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        k: k,
        cv: cv,
        random_state: random_state,
        n_jobs: n_jobs,
        palette: palette,
        predictions: predictions,
        accuracy_results: accuracy_results
    }

    command {
        q2dataflow q2wdl run sample_classifier classify_samples_from_dist ~{write_json(task_params)}
    }

    output {
        File predictions_file = "~{predictions}"
        File accuracy_results_file = "~{accuracy_results}"
    }

}


workflow wkflw_qiime2_sample_classifier_classify_samples_from_dist {
input {
        File distance_matrix
        String metadata
        File q2wdl_metafile_metadata
        Int k = 1
        Int cv = 5
        Int? random_state
        Int n_jobs = 1
        String palette = "sirocco"
        String predictions
        String accuracy_results
    }

    call qiime2_sample_classifier_classify_samples_from_dist {
        input: distance_matrix=distance_matrix, metadata=metadata, q2wdl_metafile_metadata=q2wdl_metafile_metadata, k=k, cv=cv, random_state=random_state, n_jobs=n_jobs, palette=palette, predictions=predictions, accuracy_results=accuracy_results
    }

}
