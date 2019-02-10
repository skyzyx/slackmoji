default:
	rm README.md
	cp readme.tmpl README.md
	find ./ -maxdepth 1 -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.gif \) | sort | xargs -I {} bash -c 'ff=$$(basename -- "{}"); echo -n "![$$(echo $$ff | cut -f 1 -d '.')]($$ff) " | tee -a README.md'
