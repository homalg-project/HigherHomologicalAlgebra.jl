install:
	julia -e 'using Pkg; \
		Pkg.develop(path = "TriangulatedCategories"); \
		Pkg.develop(path = "ComplexesCategories"); \
		Pkg.develop(path = "Bicomplexes"); \
		Pkg.develop(path = "HomotopyCategories"); \
		Pkg.develop(path = "DerivedCategories"); \
	'

uninstall:
	$(MAKE) -C TriangulatedCategories uninstall
	$(MAKE) -C ComplexesCategories uninstall
	$(MAKE) -C Bicomplexes uninstall
	$(MAKE) -C HomotopyCategories uninstall
	$(MAKE) -C DerivedCategories uninstall

gen-basic:
	$(MAKE) -C TriangulatedCategories gen-basic
	$(MAKE) -C ComplexesCategories gen-basic
	$(MAKE) -C Bicomplexes gen-basic
	$(MAKE) -C HomotopyCategories gen-basic
	$(MAKE) -C DerivedCategories gen-basic
	$(MAKE) gen-root

gen:
	$(MAKE) -C TriangulatedCategories gen
	$(MAKE) -C ComplexesCategories gen
	$(MAKE) -C Bicomplexes gen
	$(MAKE) -C HomotopyCategories gen
	$(MAKE) -C DerivedCategories gen
	$(MAKE) gen-root

gen-root:
	ansible-playbook -i $$HOME/.gap/PackageJanitor/gap_to_julia/hosts $$HOME/.gap/PackageJanitor/gap_to_julia/site.yml -l HigherHomologicalAlgebra_root --diff

test:
	$(MAKE) -C TriangulatedCategories test
	$(MAKE) -C ComplexesCategories test
	$(MAKE) -C Bicomplexes test
	$(MAKE) -C HomotopyCategories test
	$(MAKE) -C DerivedCategories test

execute-notebooks:
	$(MAKE) -C TriangulatedCategories execute-notebooks
	$(MAKE) -C ComplexesCategories execute-notebooks
	$(MAKE) -C Bicomplexes execute-notebooks
	$(MAKE) -C HomotopyCategories execute-notebooks
	$(MAKE) -C DerivedCategories execute-notebooks

test-notebooks:
	$(MAKE) -C TriangulatedCategories test-notebooks
	$(MAKE) -C ComplexesCategories test-notebooks
	$(MAKE) -C Bicomplexes test-notebooks
	$(MAKE) -C HomotopyCategories test-notebooks
	$(MAKE) -C DerivedCategories test-notebooks

git-commit:
	$(MAKE) -C TriangulatedCategories git-commit
	$(MAKE) -C ComplexesCategories git-commit
	$(MAKE) -C Bicomplexes git-commit
	$(MAKE) -C HomotopyCategories git-commit
	$(MAKE) -C DerivedCategories git-commit

update-subsplits:
	./dev/manually_update_subsplits.sh
