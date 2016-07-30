
docker run --name git gallna/git:ssh
git remote add local ssh://root@git.docker/app.git
git push local
