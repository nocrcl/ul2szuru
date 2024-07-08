ul2szuru
========

Takes one or many files as arguments, and uploads them with their corresponding tags saved inside the image-file (png tEXt chunks, webp usercomments...) to a szurubooru instance.
Works on images generated by dezgo.com. Might work with others too. Only tested on PNGs and WEBPs.

Setup
-----

This script depends on `exiv2` (reading image files metadata) and `jq` (forming json blocks/strings). Start of by installing these two.
git clone the bash script. Enter your szurubooru api token. Enter the adress where szurubooru is accessible (without /api/posts/ ). Change the safety of every uploaded image if desired. Make it executable (`chmod +x ul2szuru.sh`) and thats it!

If the line with the _tags_ inside the PNG/WEBP text chunks starts with anything else than `prompt`, change it in the script accordingly.

Usage and Tips
--------------

To upload all image files inside a specific folder do:

`./ul2szuru.sh *.png` or `./ul2szuru.sh *.webp`

Upload all image files of a folder and all its containing subfolders do:

`find "folder/with/images/" -type f -iname "*.png" -or -iname "*.webp" -or -iname "*.jpg" -exec ul2szuru.sh {} \;`

All leading and trailing whitespace characters of the prompt string will be removed.
Every tag will be split at `,` and `.`. Plus characters `+` will be removed. Finally, every (recurring) space between each word in every tag will be substituted by an underscore `_`.

Improvements
------------

Might get improved in the near future with the following
  * accept options as arguments (like -u: URL, -s: safety...)
  * watch a specific folder (hotfolder) with a intervall of a few seconds and upload any new files
  * check if a *.png is really a PNG, or jpg, or webp,...
  * whether or not the upload was successfull move or delete the source files
