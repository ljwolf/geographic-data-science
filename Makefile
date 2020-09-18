.PHONY: all website
lab:
	docker run --rm \
               -p 4000:4000 \
               -p 8888:8888 \
               -v ${PWD}:/home/jovyan/work \
               darribas/gds_dev:5.0
labosx:
	docker run --rm \
               -p 4000:4000 \
               -p 8888:8888 \
               -v ${PWD}:/home/jovyan/work:delegated \
               darribas/gds_dev:5.0
sync: 
	jupytext --sync ./notebooks/*.ipynb
html: sync
	echo "Cleaning up existing tmp_book folder..."
	rm -rf docs
	rm -rf tmp_book
	echo "Populating build folder..."
	mkdir tmp_book
	mkdir tmp_book/notebooks
	cp notebooks/*.ipynb tmp_book/notebooks/
	cp -r data tmp_book/data
	cp -r figures tmp_book/figures
	cp infrastructure/website_content/* tmp_book/
	cp infrastructure/logo/ico_256x256.png tmp_book/logo.png
	cp infrastructure/logo/favicon.ico tmp_book/favicon.ico
	echo "Starting book build..."
	jupyter-book build tmp_book
	echo "Moving build..."
	mv tmp_book/_build/html docs
	echo "Cleaning up..."
	rm -r tmp_book
	cp ./CNAME ./docs/CNAME
