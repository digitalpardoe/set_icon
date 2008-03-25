//
//	SetHasCustomIcon.c
//
//	Based on SetInvisible.c created by John R Chang on Wed May 26 2004.
//	This code is Creative Commons Public Domain. You may use it for any purpose whatsoever.
//	http://creativecommons.org/licenses/publicdomain/
//
//	Sets the Finder customIcon bit of a file/folder.
//	-c means no custom icon, -C means use a custom icon.
//
 
#include <CoreServices/CoreServices.h>
#include <unistd.h> // getopt
#include <stdlib.h> // realpath
#include <err.h>

static void usage()
{
	fprintf(stderr, "usage: (-c|-C) <path>\n");
	exit(1);
}

int main (int argc, const char * argv[]) {
	// Parse command-line arguments
	char mode = ' ';
	int ch;
	while ((ch = getopt(argc, (char * const *)argv, "cC")) != -1)
		switch (ch) {
		case 'c':
		case 'C':
			mode = ch;
			break;
		case '?':
		default:
			usage();
		}
	argc -= optind;
	argv += optind;
	
	if (mode == ' ')
		usage();
	
	// Resolve specified path
	char * path = (char *)argv[argc-1];
	char resolved_path[PATH_MAX];
	if (realpath(path, resolved_path) == NULL)
		err(1, NULL);

// Set the visibility
FSRef ref;
OSStatus status = FSPathMakeRef(resolved_path, &ref, NULL);
if (status != noErr)
err(status, "FSPathMakeRef failed");

FSCatalogInfoBitmap whichInfo = kFSCatInfoFinderInfo;
FSCatalogInfo catalogInfo;
status = FSGetCatalogInfo(&ref, whichInfo, &catalogInfo, NULL, NULL, NULL);
if (status != noErr)
err(status, "FSGetCatalogInfo failed");

	FolderInfo * finderInfo = (FolderInfo *)&catalogInfo.finderInfo;
	if (mode == 'c')
		finderInfo->finderFlags &= ~kHasCustomIcon;	// clear bit
	else
		finderInfo->finderFlags |= kHasCustomIcon;	// set bit

	status = FSSetCatalogInfo(&ref, whichInfo, &catalogInfo);
	if (status != noErr)
		err(status, "FSSetCatalogInfo failed");
	
    return 0;
}
