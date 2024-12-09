FROM kasmweb/ubuntu-jammy-desktop:1.16.1
USER root

ENV HOME /home/kasm-default-profile
# Modify default user name
ENV KASM_USER k
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

# Modify default user path
ENV HOME /home/k-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000