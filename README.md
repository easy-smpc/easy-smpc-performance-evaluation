# Performance evaluation of the software EasySMPC

> This repository allows to reproduce the performance evaluation of the software [EasySMPC](https://github.com/prasser/easy-smpc) in a dockerized form with the e-mail server  iRedMail. The steps are described below. 
> As an alternative to docker, the performance evaluation can be conducted with a manual installation of the e-mail server hMailServer.

---

## Steps to reproduce the performance evaluation with docker and iRedMail
1. Clone this repository with the command `clone https://github.com/fnwirth/easy-smpc-performance-evaluation`.
1. Build the program with the command `mvn clean package`. The two warnings regarding the import of easy-smpc.jar can be ignored.
1. Create the docker image by changing to the folder *servers/iRedMail* and executing the script `./createDockerImage.sh` or `createDockerImage.bat` respectively
1. Start the docker image with the script `startEvaluation.sh` or `startEvaluation.bat`. To change the network delay, the parameter *TC_DELAY_MS* can adapted before starting the script.
1. The performance evaluation is running and can be inspected with the command `docker logs easy-eval` (**FW:** Derzeit mit viel loggint output). The results can be accessed in the file */root/easy-smpc/performanceEvaluation.csv* within the container e.g. by copying the file to the host with the command `docker cp easy-eval:/root/easy-smpc/performanceEvaluation.csv .`

**FW:** Alternativ könnten wir das auch in den docker hub hochladen, dann wäre genau ein Kommando nötig

## Steps to reproduce the performance evaluation manually

**FW:** Überhaupt machen oder löschen?
1. Clone this repository with the command clone https://github.com/fnwirth/easy-smpc-performance-evaluation.
1. Build the program with the command mvn clean package. The two warnings regarding the import of easy-smpc.jar can be ignored.
1. Install hMailServer on Windows as described in the [documentation](https://www.hmailserver.com/documentation/latest/?page=howto_install). All defaults can be accepted (e.g., the proposed data base).
1. Change to the folder *servers/hMail* and execute the script `createDomainAndUsers.vbs` to set up the server.
1. Execute the script `startEvaluation.sh`.
1. The results can be accessed in the file *performanceEvaluation.csv*.

## Contact
See [README page](https://github.com/prasser/easy-smpc/edit/master/README.md) of EasySMPC

## License
This software is licensed under the Apache License 2.0. The full text is accessible in the LICENSE file. EasySMPC itself has several dependencies whose license files are listed in the github [README page](https://github.com/prasser/easy-smpc/edit/master/README.md)
