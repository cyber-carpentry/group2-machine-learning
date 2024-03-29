# Machine Learning Reproducible Example (Group 2) 
## Background
Machine learning classifiers, such as those found in tensorflow, are powerful tools for image classification. To test new models or newly parameterized models, the MNIST and Fashion-MNIST datasets are commonly used to to explore concepts in machine learning. The module below works through an example of machine learning in tensorflow using MNIST and MNISTFashion to compare model performance on two different datasets. In the future, additional models or datasets could also be added to this workflow to compare across more research situtations. 

**Inputs**
  1. ```data/mnist.txt``` tells the system to use the MNIST dataset, accessed via the Keras library
  2. ```data/fashion.txt``` tells the system to call Fashion MNIST, accessed via the Keras Library
  3. ```run_main.py``` which runs a sequence of python scripts and Jupyter notebooks
  
  
**Outputs**
  1. ```<data>.html```: Jupyter notebook outputs
  2. ```<data>_model_results_summary.txt```: Summary of the model runs
  3. ```<data>_results_summary_plots.pdf```: Graphical summary of model results
  
  ```snakemake``` will take care of supplying the inputs to the python code and printing the results to ```/results``` mounted on your Docker volume. So the above is just context for troubleshooting or extending the workflow. 
  
## Instructions

Note: for these instructions you will need a Jetstream account. If you do not already have one, you can find instructions for setting up a trial account [here](https://iujetstream.atlassian.net/wiki/spaces/JWT/pages/76150553/Get+a+Jetstream+Trial+Access+account)

### Initiate a virtual machine through a cloud server
  1. Log in to [Jetstream](https://use.jetstream-cloud.org/application/dashboard) and click "Start a New Instance."
  2. Select the _Ubuntu 18.04 Devel and Docker_ instance and press launch.
  3. Select an _m1.xlarge_ instance in instance size, and then click "Launch Instance."
  4. Once the instance is "Active," go into the shell either through the [Web Shell](https://iujetstream.atlassian.net/wiki/spaces/JWT/pages/141525076/Logging+in+with+Web+Shell+-+also+copying+and+pasting) or via [ssh](https://iujetstream.atlassian.net/wiki/spaces/JWT/pages/17465474/Adding+SSH+keys+to+the+Jetstream+Atmosphere+environment). (Instructions are provided through the links)
  
### Set up the docker image and volume ###
  
  1. Clone the github repo with the relevant dockerfile.
  
     ```
     git clone https://github.com/cyber-carpentry/group2-machine-learning/
     cd group2-machine-learning
     ```
  
  2. Now you will run a shell script to build your docker image and create a volume to store your results. 

     ```
     source setup_docker.sh
     ```
  
### Start the neural network classifiers ###    
 
There are multiple options for using the neural networks. We suggest starting with Option 1 for optimal reproducibility. 
  - [Option 1](README.md#option-1): Run both mnist and fashion mnist datasets in parallel.
  - [Option 2](README.md#option-2): Run mnist or fashion mnist datasets on their own.
  - [Option 3](README.md#option-3): Explore the code via jupyter notebooks.
 
#### **Option 1:** ####
Run both mnist and fashion mnist datasets in parallel. 

  1. Enter the command below to run the docker image.
 
     ``` 
     docker run --mount source=results,target=/home/jovyan/results -it sprince399/mlnotebook sh
     ```
    
  2. Once you are in the shell, run the command below:
     
     ```
     cd cyber-carpentry-group2-*
     snakemake
     ```
     
   The neural network model and classifier has launched!
   
  3. When they are finished, you will find the files summarizing the output and results of the model in the `/home/jovyan/results` folder within your container. 
  
  4. To access the results outside of your container, first exit the container with the command below:
  
     ```
     exit
     ```
     
     To view the results, enter the command below (again, you should now be OUTSIDE of the container). 
    
   ```
   sudo cat ${MYVOLDIR}/fileyouwanttolookat

   #for example
   sudo cat ${MYVOLDIR}/mnist_model_results_summary.txt
   ```
   
  5. If you would like to move the results to your home folder on your Jetstream instance, follow the commands below. 
  
    sudo -i
    cp ${MYVOLDIR}/* /home/
    exit
      
  Compare your results [here!](README.md#example-results)  
  
  4. Optional: To rerun the classifier inside the container, first delete the snakemake results with the command below.
    
     ```
     snakemake some_target --delete-all-output
     ```
  
  
#### **Option 2:** ####
Run mnist or fashion mnist datasets on their own.

NOTE: If you are still in your docker container from the option 1 instructions, please exit now with the command below:

  ```
  exit
  ```

 1. Enter the command below to run the docker image. Do NOT change the username on the mlnotebook. 
 
     ``` 
       docker run --mount source=results,target=/home/jovyan/results -it sprince399/mlnotebook sh
     ```
    
 2. Once you are in the shell, run the commands below. You can specify the dataset you would like to run by writing ```mnist.txt``` or ```fashion.txt``` as the option after run_main.py 
 
      ```
      cd cyber-carpentry-group2-machine-learning-*
      python run_main.py mnist.txt
      ```
  The neural network model and classifier has launched! When they are finished, you will find the files summarizing the output and results of the model in the `/home/jovyan/results` folder. 
  
 3. To access the results outside of your container, first exit the container with the command below:
  
     ```
     exit
     ```
     
     To view the results, enter the command below (again, you should now be OUTSIDE of the container). 
    
   ```
   sudo cat ${MYVOLDIR}/fileyouwanttolookat

   #for example
   sudo cat ${MYVOLDIR}/mnist_model_results_summary.txt
   ```
   
  4. If you would like to move the results to your home folder on your Jetstream instance, follow the commands below. 
  
    sudo -i
    cp ${MYVOLDIR}/* /home/
    exit
      
  Compare your results [here!](README.md#example-results)  
  

#### **Option 3:** ####

NOTE: If you are still in your docker container from the option 1 instructions, please exit now with the command below:

  1. Enter the command below if you would like to explore the neural network model code via jupyter notebooks. 
     
       ```
       docker run -p 80:8888 sprince399/mlnotebook
       ```
              
  2. You will be given a prompt to access a jupyter notebook. It should look like the example below. Do not follow the instructions provided in the command prompt. Go to Step 3. 
  
      ```
      To access the notebook, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/nbserver-6-open.html
        Or copy and paste one of these URLs:
        http://(c26dc6be4e1a or 127.0.0.1):8888/?token=73258a96f4088f042c856a3f24f057be37b5da5d43067754 
      ```
      
   3. Instead of following the shell output above, go to your Jetstream instance home page. Copy the IP address from the Jetstream instance.
   
   4. In a new browser window, enter the URL below. NOTE: you should fill in the <my.jetstream.IP> section with what you copied above. 
   
      ```
      http://<my.jetstream.IP>:80
      ```
      
   You will get a prompt to enter the token provided in the last line of instruction #2. Now you can look at the code underlying the neural network models! Select any of the files to explore. 
   
## Example results ##

### MNIST ###
[Model summary](https://github.com/cyber-carpentry/group2-machine-learning/blob/master/example_results/mnist_model_results_summary.txt)

[Model performance](https://github.com/cyber-carpentry/group2-machine-learning/blob/master/example_results/fashion_results_summary_plots.pdf)

### fashion MNIST ###
[Model summary](https://github.com/cyber-carpentry/group2-machine-learning/blob/master/example_results/fashion_model_results_summary.txt)

[Model performance](https://github.com/cyber-carpentry/group2-machine-learning/blob/master/example_results/fashion_results_summary_plots.pdf)

## Repository Metadata
```Dockerfile``` Defines the Docker image build. This image is also set to autobuild on [Docker Hub](https://hub.docker.com/r/sprince399/mlnotebook)

```Snakefile``` Defines the ```snakemake``` workflow and iterates over datasets

```main.ipynb``` Runs ``train.ipynb```, ```test.ipynb```, and ```output.ipynb```

```model.ipynb``` Builds the tensorflow models

```output.ipynb``` Produces output summary files

```setup_docker.sh``` Sets up the Dockerfile

```test.ipynb``` Tests the model

```train.ipynb``` Trains the model

```run_main.py``` Runs the ```main.ipynb```. This enables Running from  ```snakemake```

```\archive``` Archived example reports and project data. 

```\hooks``` Enables version control on Dockerfiles

```\data``` Holds data input files. 

```\example_results``` Example output results from running the model. 


## Useful Links

[Group 2 HackMD Notes](https://hackmd.io/@stephprince/r1BFBO7MH)

[Planning Notes](https://hackmd.io/8IlRqMagSr-wxBMXtmtgnA?both#Planning)
