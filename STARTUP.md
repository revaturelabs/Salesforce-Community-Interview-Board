## How to Set Up Your Development Environment

1) Clone repo down to local. (use the VS code button on the welcome screen)
2) Create new playground, get login info.
3) Authorize the playground with VS code. (copy down the admin email!)
4) Switch to 2009-dev branch. (Click "master" branch on the bottom bar of VSCode).
5) In VSCode, find force-app/main/default/sites/InterviewForce.site-meta.xml.
   a) Change the email between <SiteGuest> and <SiteGuestAdmin> to the admin email you 	saved from earlier.
   b) Save changes.
6) In the playground, enable digital experiences/communities at Setup->Feature Settings-> Digital Experiences -> Settings. (the domain name doesn't matter.)
7) Create a new digital experience/site.
   a) Use the "Build Your Own" template. (NOT the "Build your own (LWR)")
   b) Make sure to put something in the URL!!
   c) The site name must NOT be "InterviewForce".
8) Use the right-click menu to deploy source from manifest to the playground in VSCode.    (DO NOT use sfdx force:source:push -f to push to the scratch org)
   a) Or you can use sfdx force:source:deploy -x .\manifest\package.xml.
 
IDEALLY, WE WILL REPLACE 5-8 WITH: 5) DEPLOY. or 5) Install Unmanaged Package. 5) only-one-step-other-thing.
