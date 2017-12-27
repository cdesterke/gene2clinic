# gene2clinic
Software which allow to annotate quantification of clinical variants on a human gene list as input

SYNOPSIS
gene2clinic software allowed to annotate a list of human genes with clinical variant information provide by NCBI : Clinvar gene_specific_summary (version april 2017)

OUPUT
the software built folder results with saving log file and also creating a CSV file with the collected annotated information from the list

UPDATE DATABASES
Download the new database at ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/tab_delimited/
update of the annotation software : put new gene summary gene information in a file named « clinvar.txt » in the subfolder DATABASES_GENES

 
OPERATING SYSTEM
this software run under BASH environment with installation of more utilities as dependencies.
Tested under linux debian MINT version

LICENSE
MIT

USAGE
$sh gene2clinic.sh humangene.txt

SOFTWARE AURHOR : Christophe Desterke, email : christophe.desterke@gmail.com

