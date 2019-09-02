#!/bin/bash

readonly in=readme.md

cat<<!
<!DOCTYPE html>
<html>
<head>
	<style>
		body {
			background-color: powderblue;
			font-family: sans-serif;
			margin-top: 5%;
			margin-left: 25%;
			margin-right: 25%;
		}
		img {
			width: 100%;
		}
		pre {
			background-color: black;
			color: white;
			font-family: monospace;
			border-radius: 10px;
			padding: 10px;
		}
	</style>
</head>
<body>
!

openpre=0

while read line; do

	if [[ $line =~ ^\`\`\` ]]; then

		if [[ $openpre == 0 ]]; then
			openpre=1
			echo "<pre>"
		else
			openpre=0
			echo "</pre>"
		fi

	elif [[ $openpre == 0 ]]; then

		# Let's sub some HTML
		if [[ $line =~ ^\#\ *([^\#]+) ]]; then
			echo "<h1>${BASH_REMATCH[1]}</h1>"
		elif [[ $line =~ ^\#\#\ *([^\#]+) ]]; then
			echo "<h2>${BASH_REMATCH[1]}</h2>"
		elif [[ $line =~ ^\#\#\#\ *([^\#]+) ]]; then
			echo "<h3>${BASH_REMATCH[1]}</h3>"
		elif [[ $line =~ ^\#\#\#\#\ *([^\#]+) ]]; then
			echo "<h4>${BASH_REMATCH[1]}</h4>"
		elif [[ $line =~ \!\[\]\((.*)\) ]]; then
			echo "<img src=\"${BASH_REMATCH[1]}\" />"
		fi

	else
		echo $line
	fi
done < $in

cat<<!
</body>
</html>
<!-- $(date) -->
!
