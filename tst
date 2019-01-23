At work, we had been doing MIMEDefang development on master in git, and bugfixes on a branch named 2.63-branch. Over time, master diverged significantly from the current maintenance branch. Recently, we decided to rebase our development work on the maintenance branch, but there were just too many ugly conflicts to resolve. As we didn't want to keep all of the code on that branch anyway, the easiest solution was to rename our 2.63-branch to master and resume development there, cherry-picking some of the useful things from the development branch.

Here's how I did the renaming.


First, in your working tree, locally rename master to something else.

git branch -m master old-dev

Renaming a branch does work while you are on the branch, so there's no need to checkout something else.

Then, locally rename the maintenance branch (2.63-branch) to master:

git branch -m 2.63-branch master

Now, time to mess with the remote. Just in case you screw up, you might want to make sure you have a current backup. First, delete the remote's master:

git push origin :master

And now, give the remote your new master:

git push origin master:refs/heads/master

Update: When creating a new branch, the refs/heads/ prefix is needed on the remote side. If the branch already exists (as master did above) only the branch name is required on the remote side.

... and your now-renamed old master:

git push origin old-dev:refs/heads/old-dev

Finally, delete the old name of your maintenance branch to prevent confusion:

git push origin :2.63-branch

Clients will now get the 'new' master branch when they pull.

Note: Thanks to Bart for info on how to properly do the 'push origin' bits, and for generally increasing my git knowledge.
