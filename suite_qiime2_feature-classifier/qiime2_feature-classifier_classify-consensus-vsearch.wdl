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

struct qiime2_feature_classifier_classify_consensus_vsearch_params {
    File query
    File reference_reads
    File reference_taxonomy
    String maxaccepts
    Float perc_identity
    Float query_cov
    String strand
    Boolean search_exact
    Boolean top_hits_only
    String maxhits
    String maxrejects
    Boolean output_no_hits
    Float weak_id
    Int threads
    Float min_consensus
    String unassignable_label
    String classification
    String search_results
}

task qiime2_feature_classifier_classify_consensus_vsearch {

    input {
        File query
        File reference_reads
        File reference_taxonomy
        String maxaccepts = '10'
        Float perc_identity = 0.8
        Float query_cov = 0.8
        String strand = "both"
        Boolean search_exact = false
        Boolean top_hits_only = false
        String maxhits = 'all'
        String maxrejects = 'all'
        Boolean output_no_hits = true
        Float weak_id = 0.0
        Int threads = 1
        Float min_consensus = 0.51
        String unassignable_label = "Unassigned"
        String classification
        String search_results
    }

    qiime2_feature_classifier_classify_consensus_vsearch_params task_params = object {
        query: query,
        reference_reads: reference_reads,
        reference_taxonomy: reference_taxonomy,
        maxaccepts: maxaccepts,
        perc_identity: perc_identity,
        query_cov: query_cov,
        strand: strand,
        search_exact: search_exact,
        top_hits_only: top_hits_only,
        maxhits: maxhits,
        maxrejects: maxrejects,
        output_no_hits: output_no_hits,
        weak_id: weak_id,
        threads: threads,
        min_consensus: min_consensus,
        unassignable_label: unassignable_label,
        classification: classification,
        search_results: search_results
    }

    command {
        q2dataflow q2wdl run feature_classifier classify_consensus_vsearch ~{write_json(task_params)}
    }

    output {
        File classification_file = "~{classification}"
        File search_results_file = "~{search_results}"
    }

}


workflow wkflw_qiime2_feature_classifier_classify_consensus_vsearch {
input {
        File query
        File reference_reads
        File reference_taxonomy
        String maxaccepts = '10'
        Float perc_identity = 0.8
        Float query_cov = 0.8
        String strand = "both"
        Boolean search_exact = false
        Boolean top_hits_only = false
        String maxhits = 'all'
        String maxrejects = 'all'
        Boolean output_no_hits = true
        Float weak_id = 0.0
        Int threads = 1
        Float min_consensus = 0.51
        String unassignable_label = "Unassigned"
        String classification
        String search_results
    }

    call qiime2_feature_classifier_classify_consensus_vsearch {
        input: query=query, reference_reads=reference_reads, reference_taxonomy=reference_taxonomy, maxaccepts=maxaccepts, perc_identity=perc_identity, query_cov=query_cov, strand=strand, search_exact=search_exact, top_hits_only=top_hits_only, maxhits=maxhits, maxrejects=maxrejects, output_no_hits=output_no_hits, weak_id=weak_id, threads=threads, min_consensus=min_consensus, unassignable_label=unassignable_label, classification=classification, search_results=search_results
    }

}