#!/bin/bash

# BUT : créer un fichier html réprésentant toutes les images présentes au même emplacement que ce script.


# TACHES DE BASE :
# (fait) Créez un fichier html suivant un paramètre optionnel : par défaut, création d'un fichier "galerie.html"
# (fait) Son contenu est celui d'un fichier html
# (fait) Générer des miniatures de toutes les images présentes via convert
# (fait) Adaptez le contenu du fichier html au contenu créé par convert

# TACHES D'AMÉLIORATION :
# ...

createFile ()
{
	contenu_html_commun="<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"  \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"fr\" >
  <head>
    <title>Ma galerie</title>
    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />
    <style text=\"text/css\">
      ul
      {
        border: green 2px dotted;
      }

      /* Par défaut, les liens ne seront pas soulignés. */
      a
      {
        text-decoration: none;
      }
    </style>
  </head>
  <body>"
	if [ $# -ge 1 ]
	then
		echo "$contenu_html_commun" > $1.html
		fileName=$1.html	

	else
		echo "$contenu_html_commun" > galerie.html
		fileName=galerie.html
	fi
}

createThumbnail ()
{
	for image in `ls *.png *.jpeg *.webp|tr -d ' '`
	do
		convert $image -thumbnail '200x200>' Miniatures/$image
echo "      <a href=\"$image\">
        <ul>
          <img src=\"Miniatures/$image\"/><br>Dernière modification le `ls $image -l|cut -d' ' -f 6,7,8`
        </ul>
      </a>">>$fileName
	done
	echo -e "\n  </body>\n</html>">>$fileName
}

createFile $1
createThumbnail
