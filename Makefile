SRC=fsh
lint:
	shellcheck -s bash $(SRC)
test:
	./test.sh
doc:
	./generate_readme.sh
check_doc_up_to_date: doc
	git diff --exit-code
checks: lint check_doc_up_to_date test
	echo "All checks passed 🎉"
install_hooks:
	git config core.hooksPath .git/hooks
add_hooks:
	echo QUIET=true make checks > .git/hooks/pre-push
	chmod +x .git/hooks/pre-push
format:
	shfmt -w -i 2 $(SRC)
