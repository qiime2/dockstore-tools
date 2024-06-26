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

struct qiime2_feature_classifier_fit_classifier_sklearn_params {
    File reference_reads
    File reference_taxonomy
    File? class_weight
    String classifier_specification
    String classifier
}

task qiime2_feature_classifier_fit_classifier_sklearn {

    input {
        File reference_reads
        File reference_taxonomy
        File? class_weight
        String classifier_specification
        String classifier
    }

    qiime2_feature_classifier_fit_classifier_sklearn_params task_params = object {
        reference_reads: reference_reads,
        reference_taxonomy: reference_taxonomy,
        class_weight: class_weight,
        classifier_specification: classifier_specification,
        classifier: classifier
    }

    command {
        q2dataflow wdl run feature_classifier fit_classifier_sklearn ~{write_json(task_params)}
    }

    output {
        File classifier_file = "~{classifier}"
    }

}


workflow wkflw_qiime2_feature_classifier_fit_classifier_sklearn {
input {
        File reference_reads
        File reference_taxonomy
        File? class_weight
        String classifier_specification
        String classifier
    }

    call qiime2_feature_classifier_fit_classifier_sklearn {
        input: reference_reads=reference_reads, reference_taxonomy=reference_taxonomy, class_weight=class_weight, classifier_specification=classifier_specification, classifier=classifier
    }

}
