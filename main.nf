#!/usr/bin/env nextflow

/* --------------------------
  Set up variables
 ----------------------------*/

// user input bed file
my_bed_ch = Channel
            .fromPath(params.input_bed)
            .ifEmpty { exit 1, "Cannot find input file : ${params.input_bed}" }

// aggV2 bed chunks
aggv2_bed_ch = Channel
            .fromPath(params.aggv2_chunks_bed)
            .ifEmpty { exit 1, "Cannot find input file : ${params.aggv2_chunks_bed}" }

// VEP severity scale
Channel
      .fromPath(params.severity_scale)
      .ifEmpty { exit 1, "Cannot find severity scale : ${params.severity_scale}" }
      .set {severity_scale_ch}

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