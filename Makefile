ver=latest
name=utilitywarehouse/lulzbot-client:$(ver)

setup-home:
	mkdir .ptl-home
build:
	docker build -t $(name) .
push:
	docker push $(name)
run: 
	docker run -ti --rm --privileged --net=host -e DISPLAY -v `pwd`/.ptl-home:/home/ptl/ -v ${XAUTHORITY}:/home/ptl/.Xauthority -v /dev/ttyACM0:/dev/ttyACM0 $(name)
