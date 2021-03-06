#!/bin/bash

# BUT : créer un fichier html réprésentant toutes les images présentes au même emplacement que ce script.


# TACHES DE BASE :
# (fait) Créez un fichier html suivant un paramètre optionnel : par défaut, création d'un fichier "galerie.html"
# (fait) Son contenu est celui d'un fichier html
# (fait) Générer des miniatures de toutes les images présentes via convert
# (fait) Adaptez le contenu du fichier html au contenu créé par convert

# TACHES D'AMÉLIORATION :
# Définition d’une image (./Msc/ancre.png) permettant de revenir au début de la page, celle-ci est positionnée en bas à droite de l’écran.
# ...

createFile ()
{
	contenu_html_commun="<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"  \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"fr\" >
  <head>
    <title>Ma galerie</title>
    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />
    <style type=\"text/css\">
    /** La position n'est pas redéfinie lors de "scrolling" de la page. **/ 
    .ancre
    {
      position: absolute;
      right: 0px;
      bottom: 0px;
    }
    </style>
  </head>
  <body>
    <h2 id=\"up\"></h2>" # lien html vers le début de la page html
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
	for image in `ls *.jpeg *.webp|tr -d ' ' 2>/dev/null`
	do
		convert $image -thumbnail '200x200>' Miniatures/$image
echo "    <a href=\"$image\">
        <img src=\"Miniatures/$image\" title=\"Last updated on `ls $image -l|cut -d' ' -f 6,7,8`\"/>
    </a>">>$fileName
	done
	echo -e "    <a href=\"#up\">
      <img class=\"ancre\" src=\"Msc/ancre.png\" alt=\"\"/>
    </a>\n  </body>\n</html>">>$fileName
}

createFile $1
createThumbnail
