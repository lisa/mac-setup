# Global requirements

ifeq (,$(wildcard $(RUBY)))
	$(error Can't find ruby at $(RUBY). Try make RUBY=/path/to/ruby))
endif
ifeq (,$(wildcard $(CURL)))
	$(error Can't find curl at $(CURL). Try make CURL=/path/to/curl))
endif