FROM fedora:28
MAINTAINER Florian.bord@epitech.eu
RUN yum -y update \
&& yum -y install git

# Make ssh dir
RUN mkdir /root/.ssh/

# Copy over private key, and set permissions
# Warning! Anyone who gets their hands on this image will be able
# to retrieve this private key file from the corresponding image layer
ADD id_rsa /root/.ssh/id_rsa

# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add bitbuckets key

RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts




RUN yum -y install python3-pip
RUN pip3 install --user --upgrade pip
# Clone the conf files into the docker container

RUN cd home && git clone https://github.com/FlorianBord2/heliosdemo
RUN cd home && GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git clone git@gitlab.com:Ordrix0/heliosdataandmodels.git
RUN cd home && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash
RUN cd home && yum -y install git-lfs
RUN cd home/heliosdataandmodels/ && git lfs install
RUN cd home/heliosdataandmodels/ && GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git lfs fetch
RUN cd home/heliosdataandmodels/ && GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git lfs pull
RUN mv /home/heliosdemo/keras_yolo3 /home/heliosdataandmodels/Predict
RUN rm /home/heliosdataandmodels/Predict/main.py && mv /home/heliosdemo/Predict/* /home/heliosdataandmodels/Predict
RUN cd home/heliosdataandmodels/Predict && python3 -m pip install -r requirements.txt
RUN mv home/heliosdemo/yolo_anchors.txt home/heliosdataandmodels/Predict/FilesToPred
RUN cd home && pip3 uninstall --yes opencv-python-heardless
RUN cd home && pip3 uninstall --yes opencv-python
RUN cd home && yum -y install numpy opencv*
RUN cd home && pip3 install opencv-python==4.0.0.21
#RUN cd home/heliosdataandmodels/Predict && python3 main.py  ../LastModel_yv3/trained_weights_final.h5 ../Data/EndH45EDIT.mp4