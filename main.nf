#!/usr/bin/env nextflow

/* --------------------------
  Set up variables
 ----------------------------*/

Channel
    .fromPath(params.input_files)
	.set {query_result_ch}

/*----------------------
Create summary tables 
-----------------------*/

process summarise_output {

	publishDir "${params.outdir}/combined_queries", mode: 'copy'

	input:
	file(query_result) from query_result_ch

	output:
	file("*_summary.tsv") 

	script:
	
	"""
    summarise.R ${query_result}
    """


}