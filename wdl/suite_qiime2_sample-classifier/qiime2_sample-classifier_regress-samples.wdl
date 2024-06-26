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

struct qiime2_sample_classifier_regress_samples_params {
    File table
    String metadata
    File q2wdl_metafile_metadata
    Float test_size
    Float step
    Int cv
    Int? random_state
    Int n_jobs
    Int n_estimators
    String estimator
    Boolean optimize_feature_selection
    Boolean stratify
    Boolean parameter_tuning
    String missing_samples
    String sample_estimator
    String feature_importance
    String predictions
    String model_summary
    String accuracy_results
}

task qiime2_sample_classifier_regress_samples {

    input {
        File table
        String metadata
        File q2wdl_metafile_metadata
        Float test_size = 0.2
        Float step = 0.05
        Int cv = 5
        Int? random_state
        Int n_jobs = 1
        Int n_estimators = 100
        String estimator = "RandomForestRegressor"
        Boolean optimize_feature_selection = false
        Boolean stratify = false
        Boolean parameter_tuning = false
        String missing_samples = "error"
        String sample_estimator
        String feature_importance
        String predictions
        String model_summary
        String accuracy_results
    }

    qiime2_sample_classifier_regress_samples_params task_params = object {
        table: table,
        metadata: metadata,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        test_size: test_size,
        step: step,
        cv: cv,
        random_state: random_state,
        n_jobs: n_jobs,
        n_estimators: n_estimators,
        estimator: estimator,
        optimize_feature_selection: optimize_feature_selection,
        stratify: stratify,
        parameter_tuning: parameter_tuning,
        missing_samples: missing_samples,
        sample_estimator: sample_estimator,
        feature_importance: feature_importance,
        predictions: predictions,
        model_summary: model_summary,
        accuracy_results: accuracy_results
    }

    command {
        q2dataflow wdl run sample_classifier regress_samples ~{write_json(task_params)}
    }

    output {
        File sample_estimator_file = "~{sample_estimator}"
        File feature_importance_file = "~{feature_importance}"
        File predictions_file = "~{predictions}"
        File model_summary_file = "~{model_summary}"
        File accuracy_results_file = "~{accuracy_results}"
    }

}


workflow wkflw_qiime2_sample_classifier_regress_samples {
input {
        File table
        String metadata
        File q2wdl_metafile_metadata
        Float test_size = 0.2
        Float step = 0.05
        Int cv = 5
        Int? random_state
        Int n_jobs = 1
        Int n_estimators = 100
        String estimator = "RandomForestRegressor"
        Boolean optimize_feature_selection = false
        Boolean stratify = false
        Boolean parameter_tuning = false
        String missing_samples = "error"
        String sample_estimator
        String feature_importance
        String predictions
        String model_summary
        String accuracy_results
    }

    call qiime2_sample_classifier_regress_samples {
        input: table=table, metadata=metadata, q2wdl_metafile_metadata=q2wdl_metafile_metadata, test_size=test_size, step=step, cv=cv, random_state=random_state, n_jobs=n_jobs, n_estimators=n_estimators, estimator=estimator, optimize_feature_selection=optimize_feature_selection, stratify=stratify, parameter_tuning=parameter_tuning, missing_samples=missing_samples, sample_estimator=sample_estimator, feature_importance=feature_importance, predictions=predictions, model_summary=model_summary, accuracy_results=accuracy_results
    }

}
