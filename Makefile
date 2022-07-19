-include User.make
-include ~/commoncriteria/User.make
TRANS ?= transforms
include $(TRANS)/package/Package.make
