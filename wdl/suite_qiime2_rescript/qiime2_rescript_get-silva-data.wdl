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

struct qiime2_rescript_get_silva_data_params {
    String version
    String target
    Boolean include_species_labels
    Boolean rank_propagation
    Array[String]? ranks
    Boolean download_sequences
    String silva_sequences
    String silva_taxonomy
}

task qiime2_rescript_get_silva_data {

    input {
        String version = '138.1'
        String target = 'SSURef_NR99'
        Boolean include_species_labels = false
        Boolean rank_propagation = true
        Array[String]? ranks
        Boolean download_sequences = true
        String silva_sequences
        String silva_taxonomy
    }

    qiime2_rescript_get_silva_data_params task_params = object {
        version: version,
        target: target,
        include_species_labels: include_species_labels,
        rank_propagation: rank_propagation,
        ranks: ranks,
        download_sequences: download_sequences,
        silva_sequences: silva_sequences,
        silva_taxonomy: silva_taxonomy
    }

    command {
        q2dataflow wdl run rescript get_silva_data ~{write_json(task_params)}
    }

    output {
        File silva_sequences_file = "~{silva_sequences}"
        File silva_taxonomy_file = "~{silva_taxonomy}"
    }

}


workflow wkflw_qiime2_rescript_get_silva_data {
input {
        String version = '138.1'
        String target = 'SSURef_NR99'
        Boolean include_species_labels = false
        Boolean rank_propagation = true
        Array[String]? ranks
        Boolean download_sequences = true
        String silva_sequences
        String silva_taxonomy
    }

    call qiime2_rescript_get_silva_data {
        input: version=version, target=target, include_species_labels=include_species_labels, rank_propagation=rank_propagation, ranks=ranks, download_sequences=download_sequences, silva_sequences=silva_sequences, silva_taxonomy=silva_taxonomy
    }

}