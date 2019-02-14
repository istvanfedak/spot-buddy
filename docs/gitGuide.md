# A brief guide to use git: 

After you have git installed on your PC (https://git-scm.com/) follow the following steps to connect to the git repo.

Create an empty folder and navigate to it in terminal (on the Windows git client if you right click in your folder there should be an 'open git console' or similar button) 

## STEP ONE: Initialize Git Repository:

type in: git init 

At this point you should get a message that your git repo has been initialized, you now have your own local git repo on your computer, now you need to connect it to the server

## STEP TWO: Add remote server:

### command: git remote add <name> <url> 

whereby: <name> is the name of the remote server, can be whatever you want it to be
         <url> is the URL of the repository, in most cases this will end with a .git 
         
### example: git remote add https://github.com/istvan-vonfedak/SpotBuddy/
         (This will add a remote git connection to this repository)

## STEP THREE: Pull from remote repository

Git works by creating a copy of the remote git repository on your computer, this is not done automatically and has to be done through a command. 
You will need to execute this command every time you want to download updates from the remote server. This will not work if you have uncommited
changes on your local git repo. You must either commit (git commit) or stash (git stash) your changes prior to doing a pull (this is covered later) 

### command: git pull <name> <branch> 

whereby: <name> is the name of the remote server (the name you gave it during remote add) 
         <branch> is the name of the branch you want to pull from (if you want to pull from the main branch use branch name "master") 
         
### example: git pull origin master

At this point if the git repository requires permissions to pull from (this one does) it would ask you for your username and password, this is the
same username/password as you use on github

## USING GIT: 

At this point you should have a copy of the repository in your folder you created earlier. At this point you are free to work on, modify, create or delete
any files in the repository. If you add a new file however, you must add it to the git repository by using an add command: 

## command: git add <file name>

whereby: <file name> is the file name of your new file

### example: git add example.py 

You may also use the * character as the wildcard or use it to add all files in the repository folder:

### git add * 

Note: You only need to use git add for new files, modified files and deleted files are tracked automatically 

## SAVING YOUR WORK:

At any point that you want to save your work to the git repo, you can use the commit command: 

### command: git commit

This will bring up a text editor where you can write a description of the changes you made. After you save the file, the commit will go through.

After your commits, you can push these commits to the server using the push command:

### command: git push <name> <branch> 

whereby: <name> is the name of the remote server (the one you gave earlier) 
         <branch> is the name of the branch you want to push to (just like in pull, you can use "master" if you want to push to the main branch)
         
### example: git push origin master

Your changes should now be reflected on the github website 

## DEFINING DEFAULT REMOTE: 

If you want to save a default remote server and branch, you can add -u to your pull or push command, that way it will save the server and branch
as an upstream remote, meaning that you no longer need to specify it (so you can just do "git push" instead of "git push origin master" for instance)

## OTHER USEFUL COMMANDS: 

Reset - If you made a mistake and want to revert back to the last commit you can use git revert:

### command: git reset --hard 

Note: This is a permanent reset, all your uncommitted changes will be permanently deleted. If you still want to keep them I'd recommend just creating
a new branch either through github or by using: 

### command: git checkout -b <new branch name> 

whereby: <new branch name> is the name of your new branch

From this point on, you'll be switched over to your new branch and any commits you make will be to your new branch while the other branhc will be untouched

To switch to a different branch you can use the checkout command without -b 

### command: git checkout <branch name> 

whereby: <branch name> is the branch name you want to switch to

After you switch to a branch any commits you make will be to this branch. 

Remember to push all your changes to the remote server as all your changes are only stored locally until you do a git push

revert: If for whatever reason you want to go back to a previous commit you can use the commit id to go to any previous commit.
commit ids can be found when you go to repository -> commits on the sidebar in github, commit ids will be on the right of the commit

### command: git checkout <commit id>

whereby: <commit id> is the id of the commit you want to revert to

If you also want to move that commit to a new branch use:

### command: git checkout -b <new branch name> <commit id> 

whereby: <new branch name> is the name for your new branch
         <commit id> is the id of the commmit you want to rever to. 
         
## MOST IMPORTANTLY: Remember, nothing you do on the git repo will be reflected until you git push it to the remote. 
