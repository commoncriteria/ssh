-include ~/commoncriteria/User.make
-include User.make
TRANS ?= transforms
include $(TRANS)/package/Package.make

# defaulty:
# 	python3 $(TRANS)/py/retrieve-included-docs.py input/ssh.xml output && python3 $(TRANS)/py/mod2main.py input/ssh.xml
#te.xml && cp /tmp/abc.xml /tmp/abc.html && daisydiff /home/kg/commoncriteria/origs/module-template/output/module-template-release.html /tmp/abc.html --file=/home/kg/opt/daisydiff/ExecuteDaisy-master/daisydiff.html
