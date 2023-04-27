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

struct qiime2_quality_control_evaluate_composition_params {
    File expected_features
    File observed_features
    Int depth
    String palette
    Boolean plot_tar
    Boolean plot_tdr
    Boolean plot_r_value
    Boolean plot_r_squared
    Boolean plot_bray_curtis
    Boolean plot_jaccard
    Boolean plot_observed_features
    Boolean plot_observed_features_ratio
    String? metadata
    File? q2wdl_metafile_metadata
    String visualization
}

task qiime2_quality_control_evaluate_composition {

    input {
        File expected_features
        File observed_features
        Int depth = 7
        String palette = "Set1"
        Boolean plot_tar = true
        Boolean plot_tdr = true
        Boolean plot_r_value = false
        Boolean plot_r_squared = true
        Boolean plot_bray_curtis = false
        Boolean plot_jaccard = false
        Boolean plot_observed_features = false
        Boolean plot_observed_features_ratio = true
        String? metadata
        File? q2wdl_metafile_metadata
        String visualization
    }

    qiime2_quality_control_evaluate_composition_params task_params = object {
        expected_features: expected_features,
        observed_features: observed_features,
        depth: depth,
        palette: palette,
        plot_tar: plot_tar,
        plot_tdr: plot_tdr,
        plot_r_value: plot_r_value,
        plot_r_squared: plot_r_squared,
        plot_bray_curtis: plot_bray_curtis,
        plot_jaccard: plot_jaccard,
        plot_observed_features: plot_observed_features,
        plot_observed_features_ratio: plot_observed_features_ratio,
        metadata: metadata,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        visualization: visualization
    }

    command {
        q2dataflow q2wdl run quality_control evaluate_composition ~{write_json(task_params)}
    }

    output {
        File visualization_file = "~{visualization}"
    }

}


workflow wkflw_qiime2_quality_control_evaluate_composition {
input {
        File expected_features
        File observed_features
        Int depth = 7
        String palette = "Set1"
        Boolean plot_tar = true
        Boolean plot_tdr = true
        Boolean plot_r_value = false
        Boolean plot_r_squared = true
        Boolean plot_bray_curtis = false
        Boolean plot_jaccard = false
        Boolean plot_observed_features = false
        Boolean plot_observed_features_ratio = true
        String? metadata
        File? q2wdl_metafile_metadata
        String visualization
    }

    call qiime2_quality_control_evaluate_composition {
        input: expected_features=expected_features, observed_features=observed_features, depth=depth, palette=palette, plot_tar=plot_tar, plot_tdr=plot_tdr, plot_r_value=plot_r_value, plot_r_squared=plot_r_squared, plot_bray_curtis=plot_bray_curtis, plot_jaccard=plot_jaccard, plot_observed_features=plot_observed_features, plot_observed_features_ratio=plot_observed_features_ratio, metadata=metadata, q2wdl_metafile_metadata=q2wdl_metafile_metadata, visualization=visualization
    }

}
