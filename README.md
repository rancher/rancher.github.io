# Rancher Labs Documentation
This readme file includes information pertaining to the documentation project for both Rancher and Rancher OS.
## Rancher
Rancher is an open source project that provides a complete platform for operating Docker in production. It provides infrastructure services such as multi-host networking, global and local load balancing, and volume snapshots. It integrates native Docker management capabilities such as Docker Machine and Docker Swarm. It offers a rich user experience that enables devops admins to operate Docker in production at large scale.
## Rancher OS
The smallest, easiest way to run Docker in production at scale. Everything in RancherOS is a container managed by Docker. This includes system services such as udev and rsyslog. RancherOS includes only the bare minimum amount of software needed to run Docker. This keeps the binary download of RancherOS to about 20MB. Everything else can be pulled in dynamically through Docker.
## Rancher Labs Documentation Website
Rancher documentation is available at <http://docs.rancher.com/rancher/>
Rancher OS documentation is available at <http://docs.rancher.com/os/>
## Contributing to Rancher Labs Documentation Project
### About Rancher Labs Documentation Site
Rancher Lab documentation is hosted on Githubpages, and published it online by using Jekyll, an easy blog-aware static website generator. For more details on how to set up Jekyll, we recommend you to read <https://help.github.com/articles/using-jekyll-with-pages/>. If you are using Windows, we strongly advise you to follow the instruction given at <http://jekyllrb.com/docs/windows/>.
For information on editing .md files (Markdown), refer to <https://daringfireball.net/projects/markdown/syntax>
### Setting up the Git Environment
In your browser, navigate to <https://github.com/rancher/rancher.github.io>
Fork this repository by clicking the Fork button on the upper right-hand side. A fork of the repository is generated for you. On the right-hand side of the page of your fork, under 'HTTPS clone URL', copy the URL by clicking the Copy to clipboard icon.
On your computer, follow these steps to setup a local repository to start working on the documentation:
 
    $ git clone https://github.com/YOUR_ACCOUNT/rancher.github.io.git
    $ cd rancher.github.io
    $ git remote add upstream https://github.com/rancher/rancher.github.io
    $ git checkout master
    $ git fetch upstream
    $ git merge upstream/master
  
### Updating the Files
We recommend you to create a new branch to update the documentation files and that you do not disturb the master branch,  other than pulling in changes from upstream/master.
For example, you create a branch, dev, on your computer to make changes locally to the documentation. This dev branch will be your local repository which then be pushed to your forked repository on GitHub where you will create a Pull Request for the changes to be committed into the official documentation.
It is a healthy practice to create a new branch each time you want to contribute to the documentation and only track the changes for that pull request in this branch.

    $ git checkout -b dev
    (-b creates a new repository named dev. Now you can make necessary changes to the documentation)
    $ git add .
    $ git commit -a -m "commit message for your changes"
    
### Merging upstream/master into Your Local Branch (dev)
Maintain an up-to-date master branch in your local repository. Merge the changes on a daily basis from the upstream/master (the official documentation repository) into your local repository. Ensure that you do complete this activity before you start working on a feature as well as right before you submit your changes as a pull request. You can also do this process periodically while you work on your changes to make sure that you are working off the most recent version of the documentation.

    $ git checkout master
    (Checkout your local master branch)
    $ git fetch upstream
    (Synchronize your local branch with the upstream/master so you have all the latest changes from the official repository)
    $ git merge upstream/master
    (Merge the latest changes from the upstream/master into your branch to make it up-to-date with the latest changes)
    $ git checkout dev
    (Checkout your local brach)
    $ git pull master
    (Pull the latest changes to your local brach, dev)
    
### Making a Pull Request on GitHub 
Important: Ensure that you have merged upstream/master into your dev branch before you do the following.
After you have made necessary changes to the documentation and are ready to contribute them, create a Pull Request on GitHub. You do it by pushing your changes to your forked repository (usually called 'origin') and then initiating a pull request.

    $ git push origin master
    $ git push origin dev
    
Now initiate a Pull request on GitHub:

1.Navigate your browser to your forked repository: <https://github.com/YOUR_ACCOUNT/rancher.github.io.git>.
2.Click the *Compare & pull request*  button on the upper side of the forked repository.
3.Enter a clear description for the changes you have made.
4.Click *Send Pull Request*
If you are asked to make modifications to your proposed changes, make the changes locally on your dev branch, push the changes, and submit the pull request again.

### Cleaning up the Local Repository
You no longer need the dev branch after the changes has been committed into the upstream/master. If you want to make additional documentation changes, restart the process with a new branch. 

    $ git checkout master
    $ git branch -D dev
    $ git push origin :dev
