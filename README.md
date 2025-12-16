# GPML to RDF for plant Wikipathways 

This README explains the step you need to do to generate the RDF for the GPML pathways.

## Get the data

Download the plant pathways:

```shell
gh repo clone pathway-lod/Cyc_to_wiki
```

and save them in the `orig` folders:

```shell
cd gpml-to-rdf
mkdir orig-pw; cd orig-pw
cp ../../Cyc_to_wiki/biocyc_pathways_20251206224344/individual_pathways/*gpml .
cd ..
mkdir orig-react; cd orig-react
cp ../../Cyc_to_wiki/biocyc_pathways_20251206224344/individual_reactions/*gpml .
cd ..
```

Renamed the files and put the results in `orig-renamed/`:

```shell
cd ..
mkdir orig-pw-renamed
groovy createPathwayfiles.groovy
mkdir orig-react-renamed
groovy createReactionfiles.groovy
```

Then create the RDF with:

```shell
nice -20 make -j 12 rdf
```
