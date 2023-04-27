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

struct qiime2_composition_ancombc_params {
    File table
    Array[File] q2wdl_metafile_metadata
    String formula
    String p_adj_method
    Float prv_cut
    Int lib_cut
    Array[String]? reference_levels
    Boolean neg_lb
    Float tol
    Int max_iter
    Boolean conserve
    Float alpha
    String differentials
}

task qiime2_composition_ancombc {

    input {
        File table
        Array[File] q2wdl_metafile_metadata
        String formula
        String p_adj_method = "holm"
        Float prv_cut = 0.1
        Int lib_cut = 0
        Array[String]? reference_levels
        Boolean neg_lb = false
        Float tol = 1e-05
        Int max_iter = 100
        Boolean conserve = false
        Float alpha = 0.05
        String differentials
    }

    qiime2_composition_ancombc_params task_params = object {
        table: table,
        q2wdl_metafile_metadata: q2wdl_metafile_metadata,
        formula: formula,
        p_adj_method: p_adj_method,
        prv_cut: prv_cut,
        lib_cut: lib_cut,
        reference_levels: reference_levels,
        neg_lb: neg_lb,
        tol: tol,
        max_iter: max_iter,
        conserve: conserve,
        alpha: alpha,
        differentials: differentials
    }

    command {
        q2dataflow q2wdl run composition ancombc ~{write_json(task_params)}
    }

    output {
        File differentials_file = "~{differentials}"
    }

}


workflow wkflw_qiime2_composition_ancombc {
input {
        File table
        Array[File] q2wdl_metafile_metadata
        String formula
        String p_adj_method = "holm"
        Float prv_cut = 0.1
        Int lib_cut = 0
        Array[String]? reference_levels
        Boolean neg_lb = false
        Float tol = 1e-05
        Int max_iter = 100
        Boolean conserve = false
        Float alpha = 0.05
        String differentials
    }

    call qiime2_composition_ancombc {
        input: table=table, q2wdl_metafile_metadata=q2wdl_metafile_metadata, formula=formula, p_adj_method=p_adj_method, prv_cut=prv_cut, lib_cut=lib_cut, reference_levels=reference_levels, neg_lb=neg_lb, tol=tol, max_iter=max_iter, conserve=conserve, alpha=alpha, differentials=differentials
    }

}
