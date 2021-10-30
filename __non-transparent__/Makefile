default:
	rm README.md
	cp readme.tmpl README.md
	find ./ -maxdepth 1 -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.gif \) | sort | xargs -I {} bash -c 'ff=$$(basename -- "{}"); echo -n "<img src=\"$$ff\" alt=\"$$(echo $$ff | cut -f 1 -d '.')\" width=\"32\"> " | tee -a README.md'
