# hi I am a phony target use me for
# grouping commands together
# these targets do not need to be related
.PHONY: clean

# hello I am another PHONY target to run all those targets together
all: report/count_report.html report/count_report_files

# Count the words
results/isles.dat: data/isles.txt scripts/wordcount.py
	python scripts/wordcount.py \
		--input_file=data/isles.txt \
		--output_file=results/isles.dat

results/abyss.dat: data/abyss.txt scripts/wordcount.py
	python scripts/wordcount.py \
		--input_file=data/abyss.txt \
		--output_file=results/abyss.dat

results/last.dat: data/last.txt scripts/wordcount.py
	python scripts/wordcount.py \
		--input_file=data/last.txt \
		--output_file=results/last.dat

results/sierra.dat: data/sierra.txt scripts/wordcount.py
	python scripts/wordcount.py \
		--input_file=data/sierra.txt \
		--output_file=results/sierra.dat

# Create the plots from the word-counts
results/figure/isles.png: results/isles.dat scripts/plotcount.py
	python scripts/plotcount.py \
	    --input_file=results/isles.dat \
	    --output_file=results/figure/isles.png

results/figure/abyss.png: results/abyss.dat scripts/plotcount.py
	python scripts/plotcount.py \
	    --input_file=results/abyss.dat \
	    --output_file=results/figure/abyss.png

results/figure/last.png: results/last.dat scripts/plotcount.py
	python scripts/plotcount.py \
	    --input_file=results/last.dat \
	    --output_file=results/figure/last.png

results/figure/sierra.png: results/sierra.dat scripts/plotcount.py
	python scripts/plotcount.py \
	    --input_file=results/sierra.dat \
	    --output_file=results/figure/sierra.png

# Renders a report
report/count_report.html report/count_report_files: results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
	quarto render report/count_report.qmd

# deletes the file passing the force flag since we cannot interact with the bash
clean:
	rm -f results/isles.dat  \
		results/abyss.dat \
		results/last.dat \
		results/sierra.dat
	rm -f results/figure/isles.png  \
		results/figure/abyss.png \
		results/figure/last.png \
		results/figure/sierra.png
	rm -rf report/count_report.html \
		report/count_report_files

