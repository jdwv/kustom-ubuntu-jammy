FROM kasmweb/ubuntu-jammy-desktop:1.16.1
USER root

ENV OLD_USER kasm-user
ENV NEW_USER kustom-user
ENV KASM_USER $NEW_USER

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########
# Replace user name in scripts
#RUN find /dockerstartup -type f -exec sed -i "s/$OLD_USER/$NEW_USER/g" {} \;

RUN usermod -l $NEW_USER $OLD_USER
######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/$KASM_USER
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000