# Resume Generator

----------------------

## OVERVIEW

This project contains my personal resume or CV. It uses the [jsonresume](https://jsonresume.org/) format to save and display the resume in PDF and HTML format.

## BRANCHING MODEL

* Default branch when pull is DEVELOP.
* Master branch is protected and it is not possible to push. Create a merge request instead.

## DEPLOYMENT

Each branch or tag generate the resume in two formats: PDF and HTML.
    * **PDF:** is saved in an amazon S3 instance. Location of the file depends of the branch or tag associated with the file. See above for more details.
    * **HTML:** is saved in an amazon AWS Amplify where an angular APP will take it as an asset to display.

### LOCATIONS OF FILES

* **MASTER BRANCH:** under path /latest/

* **DEVELOP BRANCH:** under path /staging/

* **TAGS:** under path /${TAG_NAME}/

## DOCKER IMAGES

The image name is: **patricioperpetua/resume**. [See Registry](https://gitlab.com/patricioperpetua/resume/container_registry). Tags are the same names as files locations described above.

The image is based of an nginx image to display the static web page.

----------------------

© [Patricio Perpetua](http://patricioperpetua.com), Italia, 2019.
