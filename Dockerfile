FROM phusion/baseimage

ENV GIT_DIR=/project.git \
    WORKTREE=/var/www/public
WORKDIR $WORKTREE
EXPOSE 9418

COPY post-receive /
RUN apt-add-repository ppa:git-core/ppa \
    && apt-get update \
    && apt-get install -y git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd git --uid 1000 \
    && mkdir $GIT_DIR && cd $GIT_DIR \
    && git init --bare \
    && touch git-daemon-export-ok \
    && chmod +x /post-receive \
    && mv /post-receive $GIT_DIR/hooks/post-receive \
    && chown git -R $GIT_DIR && chmod 777 -R $GIT_DIR \
    && chown git -R $GIT_DIR/* && chmod 777 -R $GIT_DIR/*

CMD "git" "daemon" "--reuseaddr" "--export-all" "--enable=receive-pack" "--informative-errors" "--verbose" "--base-path=$GIT_DIR" "$GIT_DIR"
