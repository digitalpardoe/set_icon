Set Icon
========
Quickly set custom drive icons in OS X, any drive, any image.

A Little History
----------------
When Leopard was released it appeared to do a crap job of converting images to be drive icons when using
the traditional 'copy & paste' method. The Apple (TM) Developer Tools provided a small utility called
*SetFile* that allowed you to set an ICNS file as a drive icon, giving a nicely scaled icon without
jagged edges, however this wasn't very convenient for the average user (and I wasn't particularly fond of
it either - too much hassle creating the ICNS and copying it to */.VolumeIcon.icns* - I know, I'm just
lazy).

Disclaimer
----------
Not much to say here, my Objective-C and Cocoa skills were better when I was writing this, compared to my
initial attempts in iSyncIt at least, I still make no guarantees however, that any of the code you see
here is 'correct', it is simply 'working'.

Useful Bits
-----------
These are some of the more useful classes in the application;

* *DPImageView* - Get the file path from a NSImageView, based on code from [http://www.cocoadev.com/](http://www.cocoadev.com/).
* *DPAuthFileManager* - Perform file operations with administrator privileges.
* *NSImage+IconData* - A Google class to turn an image into an icon, modified by me with code from [Matt Gemmell's](http://mattgemmell.com/) *NSImage+MGCropExtensions* to give nice image scaling rather than stretching.
* *ISI_ChangeLogController* - Loading an RTF file into an NSTextView.
* *SetHasCustomIcon* - A small C utility to set the custom icon flag on a drive, based on SetInvisible.c created by John R Chang.
* *SS_PrefsController* - Not my code, it was created by [Matt Gemmell](http://mattgemmell.com/) and is therefore awesome code.

Past Versions
-------------
**Set Icon** was developed entirely using a version control system of one form or another so all the source
history can be found inside the Git repository. All release binaries can be found in the download section
of the GitHub project page.

Licenses
--------
In **Set Icon** I actually took note of where all the code I used came from;

* *SS_PrefsController* (and associated) by [Matt Gemmell](http://mattgemmell.com/) (license in files).
* *NSImage+IconData* by Google (modified by me) licensed under the Apache 2.0 license - [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
* *DPImageView* by Gregory Weston from [http://www.cocoadev.com/index.pl?NSImageView](http://www.cocoadev.com/index.pl?NSImageView) - not sure of the license attached to this so wrapped under my own for now.
* *SetHasCustomIcon* based on code by John R Chang - licensed under Creative Commons Public Domain - in modified form, distributed under my license.

I have endeavoured to make sure all the code I used is correctly licensed before this release to open
source but I am aware that I may have forgotten where code originally came from, if you see something
that belongs to you please let me know so I can correct the situation and apply appropriate licenses. I
haven't knowingly gone out of my way to avoid giving people credit where credit is due.

All of my code is licensed under the terms found in the LICENSE file, the license is essentially based
on the BSD new license but breaks down into the following points (and yes, they're a little bit stolen
from Matt Gemmell);

1. You can use the code wherever you wish.
2. You can modify the code as much as you want and use the modified code wherever you wish.
3. You can redistribute the original, unmodified code, but you have to include the full license text.
4. You can redistribute the modified code as you wish (without the full license text).
5. In all cases, you must include an attribution mentioning Alex Pardoe as the original creator of the source.
6. I’m not liable for anything you do with the code, no matter what. So be sensible.
7. You can’t use my name or other marks to promote your products based on the code.

All other code licenses are contained within the files to which they apply.

Conclusion
----------
If you find any mistakes, problems or want to get your improvements into a release feel free to contact
me using the information below (or through GitHub).

Happy forking!

Website: [http://digitalpardoe.co.uk/](http://digitalpardoe.co.uk/), Twitter: [http://twitter.com/digitalpardoe/](http://twitter.com/digitalpardoe/)
