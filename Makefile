-include ~/commoncriteria/User.make
-include User.make
TRANS ?= transforms
include $(TRANS)/package/Package.make
