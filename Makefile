contact:

install: contact
	sed -e '1s|#!.*/sh|#!$(shell which sh)|' \
		contact > $(PREFIX)/bin/contact
		chmod +x $(PREFIX)/bin/contact

uninstall:
	rm -f $(PREFIX)/bin/contact

lint:
	npm install
	npm run lint

.PHONY: install uninstall lint
