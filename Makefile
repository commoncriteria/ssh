IN = input
OUT = output
TRANS = transforms
SSH_XML=$(IN)/ssh.xml
TABLE=$(OUT)/ssh-table.html
SIMPLIFIED=$(OUT)/ssh-table-reqs.html
SSH_HTML=$(OUT)/ssh.html
SSH_OP_HTML=$(OUT)/ssh-optionsappendix.html
SSH_RELEASE_HTML=$(OUT)/ssh-release.html
OUTPUTS=$(TABLE) $(SIMPLIFIED) $(SSH_HTML) $(SSH_OP_HTML) $(SSH_RELEASE_HTML)
all: $(TABLE) $(SIMPLIFIED) $(SSH_HTML)

spellcheck: $(OUTPUTS)
	bash -c "hunspell -l -H -p <(cat transforms/dictionaries/CommonCriteria.txt transforms/dictionaries/Computer.txt transforms/dictionaries/Crypto.txt transforms/dictionaries/SSHSpecific.txt) output/*.html | sort"

pp:$(SSH_HTML)
$(SSH_HTML):  $(TRANS)/pp2html.xsl $(SSH_XML)
	xsltproc -o $(SSH_HTML) $(TRANS)/pp2html.xsl $(SSH_XML)
	xsltproc --stringparam appendicize on -o $(SSH_OP_HTML) $(TRANS)/pp2html.xsl $(SSH_XML)
	xsltproc --stringparam appendicize on --stringparam release final -o $(SSH_RELEASE_HTML) $(TRANS)/pp2html.xsl $(SSH_XML)

table: $(TABLE)
$(TABLE): $(TRANS)/pp2table.xsl $(SSH_XML)
	xsltproc  --stringparam release final -o $(TABLE) $(TRANS)/pp2table.xsl $(SSH_XML)

simplified: $(SIMPLIFIED)
$(SIMPLIFIED): $(TRANS)/pp2simplified.xsl $(SSH_XML)
	xsltproc --stringparam release final -o $(SIMPLIFIED) $(TRANS)/pp2simplified.xsl $(SSH_XML)

transforms/schemas/schema.rnc: transforms/schemas/schema.rng
	trang -I rng -O rnc  transforms/schemas/schema.rng transforms/schemas/schema.rnc

clean:
	@for f in a $(TABLE) $(SIMPLIFIED) $(SSH_HTML) $(SSH_RELEASE_HTML) $(SSH_OP_HTML); do \
		if [ -f $$f ]; then \
			rm "$$f"; \
		fi; \
	done
