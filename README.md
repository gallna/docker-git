# Git on the Server - Git Daemon + Post-Receive Hook

Git daemon serving repositories over the "Git" protocol.
This is common choice for fast, unauthenticated access to your Git data.
Remember that since it’s not an authenticated service, anything you serve over this protocol is public within its network.

Additional post-receive hook used to set server working directory to `/var/www/public`

Post-receive hook forces each checkout, since we want to make sure `git push` is successful each time,
even if there are conflicts between what is currently in the working directory.

## How-to

Create two folders: project - a test git repository, html - git-server volume

```
mkdir project html
```

### Remote Server:

```
mkdir proj html
docker run -p 9418:9418 -v "$(pwd)/html:/var/www/public" gallna/git:git
```

### Client Machine:

Create sample git repository

```
cd ~/project
echo "<h2>It works</h2>" >> index.html
git init
git add .
git commit -m "Trying out git server"
```

Push it to git server

```
git remote add local git://localhost/`
git push local master
git push -u local master
```

See previously created html folder

## Features

- git daemon - listening on port 9418
- post-receive hook - a script invoked by git-receive-pack on the remote repository, which happens when a git push is done on a local repository.

## Additional info


[Git on the Server - Git Daemon](https://git-scm.com/book/en/v2/Git-on-the-Server-Git-Daemon)
[How To Use Git Hooks To Automate Development and Deployment Tasks](https://www.digitalocean.com/community/tutorials/how-to-use-git-hooks-to-automate-development-and-deployment-tasks)
http://railsware.com/blog/2013/09/19/taming-the-git-daemon-to-quickly-share-git-repository/
