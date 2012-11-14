Experimentation
===============

This experimentation is done by DESTINO Research Group in Pontificia Universidad Javeriana Cali.

Esta experimentacion consiste en probar la creacion de modelos mediante las tecnicas OIL, ANN y HMM utilizando 
un conjunto de datos proveniente de UniProtKB el cual fue manualmente reetiquetado usando ProteinTagger

Files and Folders
-----------------

* report_for_all.txt

  Report for all model evaluation, it includes full permissions. It results from exec gather_results.sh

* gather_results.sh

  It gather the results in subdirectories to single file.

* FullChangeOrders.json

  This file contains all manual tagging information

* uniprot-taxonomy-potyviridae.xml

  Contains the whole dataset downloaded from UniProtKB querying for taxonomy:potyviridae

* TaggedData.json

  Contains all biosequences with tags manually applied

* bin/

  Binaries for algorithms evaluated

* CleavageSites/

  contains the cleavage site annotation manually done using ProteinTagger from https://code.google.com/p/protein-tagger/

* CleavageSitesSampled/

	files with the pattern {Protein1}_{Protein2}_{SamplingWindow}_{usage}[_balanced].{ext}
	{usage} indicates if dataset is used to train or test.
	{Protein1} and {Protein2} are the chain names
	{SamplingWindow} indicates the sliding window used to sample the entire dataset
	[_balanced] only appears on files indicating that number of negative samples are constrained to be 10 times number positive samples.
	{ext} is the extension for the file format. It can be CSV, DESTINO plain text or JSON. JSON files are only for summary.

* HmmModels/

	Contains the Hidden Markov Models generated using FastHMM.exe in bin/

* OilModels/

	Contains the OIL grammar inference models generated using FastOIL.exe in bin/

* AnnModels/

	Contains the ANN models generated using MATLAB and ann_train.m script

* AnnModels/workspace.mat

	Contains the full [MATLAB http://www.matlab.com] workspace after ANN training and testing.