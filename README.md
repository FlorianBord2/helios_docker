Install and run post processing helios demo

requirement:
	Docker version 1.13.1
	Put your 'id_rsa' key in this folder.
		The dokcelfile need it to clone private repository from gitlab and github

usage:
	Install InfluxDB and Chronograf if not done yet with the './install_chronograf.sh'
	Build the docker image './build_image.sh'
	Run the container './run_docker.sh'

After that you are connected to the container with './acces_container.sh'
Then move to /home/heliosdataandmodels/Predict and run './run.sh'
This start the proccesing of the video un /home/heliosdataandmodel/Data/EndH45EDIT.mp4
All the data predicted are stored on your local Influxdb.

http://127.0.0.1:8888/sources/1/dashboards