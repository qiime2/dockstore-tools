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

struct qiime2_gneiss_gradient_clustering_params {
    File table
    String gradient
    File q2wdl_metafile_gradient
    Boolean ignore_missing_samples
    Boolean weighted
    String clustering
}

task qiime2_gneiss_gradient_clustering {

    input {
        File table
        String gradient
        File q2wdl_metafile_gradient
        Boolean ignore_missing_samples = false
        Boolean weighted = true
        String clustering
    }

    qiime2_gneiss_gradient_clustering_params task_params = object {
        table: table,
        gradient: gradient,
        q2wdl_metafile_gradient: q2wdl_metafile_gradient,
        ignore_missing_samples: ignore_missing_samples,
        weighted: weighted,
        clustering: clustering
    }

    command {
        q2dataflow q2wdl run gneiss gradient_clustering ~{write_json(task_params)}
    }

    output {
        File clustering_file = "~{clustering}"
    }

}


workflow wkflw_qiime2_gneiss_gradient_clustering {
input {
        File table
        String gradient
        File q2wdl_metafile_gradient
        Boolean ignore_missing_samples = false
        Boolean weighted = true
        String clustering
    }

    call qiime2_gneiss_gradient_clustering {
        input: table=table, gradient=gradient, q2wdl_metafile_gradient=q2wdl_metafile_gradient, ignore_missing_samples=ignore_missing_samples, weighted=weighted, clustering=clustering
    }

}
