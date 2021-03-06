#load  samples  into  table
import  pandas  as pd
import os

configfile: "config.yaml"
with open(config["bins"]) as f:
    bins = f.read().splitlines()


# definition of local match for STELLAR
# length = [30, 50, 70]
# errors = [0]

# what error rate the reads were sampled with
read_error_rate = [3, 5, 7, 10]
pattern_length = 50 # [30, 50, 70]

if pattern_length == 70:
	overlap = [0, 20, 60]
if pattern_length == 50:
	overlap = [0, 10, 40, 49]
if pattern_length == 30:
	overlap = [0, 10, 25]

errors = [0]
kmer_length = [19, 23] # depends on kmer lemma
size = ["80m"]


rule make_all:
	input:
		expand("../data/64/output_e{rer}/bin_33_k{k}_p{p}_o{o}_e{e}.output", rer = read_error_rate, k = kmer_length, p = pattern_length, o = overlap, e = errors)
		#expand("../data/64/output_e{rer}/stellar/{bin}_{l}p_{e}e_sed.gff", bin = bins, rer = read_error_rate, l = length, e = errors)
	shell:
		"echo 'Done'"

#include: "rules/stellar.smk"
include: "rules/raptor.smk"
