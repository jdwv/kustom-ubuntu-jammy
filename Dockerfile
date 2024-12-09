FROM kasmweb/ubuntu-jammy-desktop:1.16.1
USER root

ENV OLD_USER kasm-user
ENV NEW_USER kustom-user

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Replace user name in scripts
RUN find /dockerstartup -type f -exec sed -i 's/$OLD_USER/$NEW_USER/g' {} \;

# Create new user && home
RUN useradd -ms /bin/sh $NEW_USER

RUN rm -Rf /home/kasm-user && \
    ln -s /home/$NEW_USER /home/$OLD_USER

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

# Setup new user 
ENV HOME /home/$NEW_USER
WORKDIR $HOME
# Create the directory and set the ownership dynamically
RUN mkdir -p $HOME && \
    USER_ID=$(id -u $NEW_USER) && \
    GROUP_ID=$(id -g $NEW_USER) && \
    chown -R $USER_ID:$GROUP_ID $HOME
# Swap to new user
USER $NEW_USER