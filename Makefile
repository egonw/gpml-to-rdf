PCWPRDFS := ${shell cat pathways.txt | sed -e 's/\(.*\)/pw\/Human\/\1.ttl/' }
PCGPMLRDFS := ${shell cat pathways.txt | sed -e 's/\(.*\)/pw\/gpml\/Human\/\1.ttl/' }
RCWPRDFS := ${shell cat pathways.txt | sed -e 's/\(.*\)/react\/Human\/\1.ttl/' }
RCGPMLRDFS := ${shell cat pathways.txt | sed -e 's/\(.*\)/react\/gpml\/Human\/\1.ttl/' }

GPMLRDFJAR = gpml2rdf-4.0.4-SNAPSHOT.jar

all: pcrdf reactrdf

pathways.txt:
	@find orig-pw-renamed -name "*gpml" | cut -d'/' -f2 | sort | grep "PC" | cut -d'.' -f1 > pathways.txt

reactions.txt:
	@find orig-react-renamed -name "*gpml" | cut -d'/' -f2 | sort | grep "RC" | cut -d'.' -f1 > reactions.txt

pcrdf: ${PCGPMLRDFS} ${PCWPRDFS}
reactrdf: ${RCGPMLRDFS} ${RCWPRDFS}

pw/Human/%.ttl: orig-pw-renamed/%.gpml
	@echo "Creating GPMLRDF and WPRDF from $< ..."
	@mkdir -p pw/Human
	@mkdir -p pw/gpml/Human
	@xpath -q -e "string(/Pathway/@version)" $< | cut -d'_' -f2 | xargs java -cp ${GPMLRDFJAR} org.wikipathways.wp2rdf.CreateRDF -d rdf-plantmetwiki.bioinformatics.nl $< pw/gpml/Human/ pw/Human/

pw/gpml/Human/%.ttl: orig-pw-renamed/%.gpml
	@echo "Creating GPMLRDF and WPRDF from $< ..."
	@mkdir -p pw/Human
	@mkdir -p pw/gpml/Human
	@xpath -q -e "string(/Pathway/@version)" $< | cut -d'_' -f2 | xargs java -cp ${GPMLRDFJAR} org.wikipathways.wp2rdf.CreateRDF -d rdf-plantmetwiki.bioinformatics.nl $< pw/gpml/Human/ pw/Human/

react/Human/%.ttl: orig-react-renamed/%.gpml
	@echo "Creating GPMLRDF and WPRDF from $< ..."
	@mkdir -p react/Human
	@mkdir -p react/gpml/Human
	@xpath -q -e "string(/Pathway/@version)" $< | cut -d'_' -f2 | xargs java -cp ${GPMLRDFJAR} org.wikipathways.wp2rdf.CreateRDF -d rdf-plantmetwiki.bioinformatics.nl $< react/gpml/Human/ react/Human/

reacr/gpml/Human/%.ttl: orig-pw-renamed/%.gpml
	@echo "Creating GPMLRDF and WPRDF from $< ..."
	@mkdir -p react/Human
	@mkdir -p react/gpml/Human
	@xpath -q -e "string(/Pathway/@version)" $< | cut -d'_' -f2 | xargs java -cp ${GPMLRDFJAR} org.wikipathways.wp2rdf.CreateRDF -d rdf-plantmetwiki.bioinformatics.nl $< react/gpml/Human/ react/Human/
