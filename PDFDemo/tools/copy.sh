#!/bin/bash

# copies the needed files of the vfr/Reader project to a destination folder

if [[ $# != 3 ]]; then
    echo "Usage: $0 READER_PROJECT_FOLDER CLASSES_FOLDER IMG_FOLDER"
    exit 1
fi

READER_PROJECT_FOLDER="$1"
CLASSES_FOLDER="$2"
IMG_FOLDER="$3"

if [[ ! -d "$READER_PROJECT_FOLDER" ]]; then
    echo "$READER_PROJECT_FOLDER does not exist or is no folder"
    exit 1
fi

if [[ ! -d "$CLASSES_FOLDER" ]]; then
    echo "$CLASSES_FOLDER does not exist or is no folder"
    exit 1
fi

if [[ ! -d "$IMG_FOLDER" ]]; then
    echo "$IMG_FOLDER does not exist or is no folder"
    exit 1
fi

S="${READER_PROJECT_FOLDER}/Sources"
I="${READER_PROJECT_FOLDER}/Graphics"

cp "${S}/CGPDFDocument.h" "${CLASSES_FOLDER}"
cp "${S}/CGPDFDocument.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderConstants.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderConstants.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderContentPage.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderContentPage.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderContentTile.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderContentTile.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderContentView.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderContentView.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderDocument.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderDocument.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderDocumentOutline.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderDocumentOutline.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderMainPagebar.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderMainPagebar.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderMainToolbar.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderMainToolbar.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbCache.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbCache.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbFetch.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbFetch.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbQueue.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbQueue.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbRender.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbRender.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbRequest.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbRequest.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbView.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbView.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbsView.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderThumbsView.m" "${CLASSES_FOLDER}"
cp "${S}/ReaderViewController.h" "${CLASSES_FOLDER}"
cp "${S}/ReaderViewController.m" "${CLASSES_FOLDER}"
cp "${S}/ThumbsMainToolbar.h" "${CLASSES_FOLDER}"
cp "${S}/ThumbsMainToolbar.m" "${CLASSES_FOLDER}"
cp "${S}/ThumbsViewController.h" "${CLASSES_FOLDER}"
cp "${S}/ThumbsViewController.m" "${CLASSES_FOLDER}"
cp "${S}/UIXToolbarView.h" "${CLASSES_FOLDER}"
cp "${S}/UIXToolbarView.m" "${CLASSES_FOLDER}"

cp "${I}/Reader-Button-H.png" "${IMG_FOLDER}"
cp "${I}/Reader-Button-H@2x.png" "${IMG_FOLDER}"
cp "${I}/Reader-Button-N.png" "${IMG_FOLDER}"
cp "${I}/Reader-Button-N@2x.png" "${IMG_FOLDER}"
cp "${I}/Reader-Email.png" "${IMG_FOLDER}"
cp "${I}/Reader-Email@2x.png" "${IMG_FOLDER}"
cp "${I}/Reader-Export.png" "${IMG_FOLDER}"
cp "${I}/Reader-Export@2x.png" "${IMG_FOLDER}"
cp "${I}/Reader-Mark-N.png" "${IMG_FOLDER}"
cp "${I}/Reader-Mark-N@2x.png" "${IMG_FOLDER}"
cp "${I}/Reader-Mark-Y.png" "${IMG_FOLDER}"
cp "${I}/Reader-Mark-Y@2x.png" "${IMG_FOLDER}"
cp "${I}/Reader-Print.png" "${IMG_FOLDER}"
cp "${I}/Reader-Print@2x.png" "${IMG_FOLDER}"
cp "${I}/Reader-Thumbs.png" "${IMG_FOLDER}"
cp "${I}/Reader-Thumbs@2x.png" "${IMG_FOLDER}"

exit 1



