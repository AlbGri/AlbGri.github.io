---
title: "Setup TensorFlow"
excerpt: "TensorFlow 2.2.0 on Ubuntu 18.04 with CUDA 10.1, cuDNN v7.6.5 and Nvidia 450"
date: 2020-07-24
tags: [python, utils, tensorflow, ubuntu]
mathjax: "true"
---

## Configurazione attuale
* Scheda Video NVidia GeForce GTX 1050 Ti
* Ubuntu 18.04
* Java: assente
* Nvidia drivers: assente
* gcc 7.5

## Steps
Requisiti [Cuda 11](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html) li ho presi per buoni anche per Cuda 10.1.  

1. Verifico versione di Ubuntu
```console
~$ lsb_release -d
Description:	Ubuntu 18.04.4 LTS
```

1. Verifico versione kernel di Ubuntu
```console
~$ uname -r
4.15.0-112-generic
```

1. Verifico scheda video se adatta a CUDA
```console
~$ sudo lshw -C display
product: GP107 GeForce GTX 1050 Ti
```

1. Verifico Java (PROBLEMA)
```console
~$ java --version
```

1. Non ho java installato, quindi lo installo  
Le due versioni principali sono la 8 e la 11, istallo quella più recente
```console
~$ sudo apt update
~$ sudo apt install openjdk-11-jdk
```

1. Verifico Java (non so se sarà un problema la 11 invece della 8)
```console
~$ java --version
openjdk 11.0.7 2020-04-14
OpenJDK Runtime Environment (build 11.0.7+10-post-Ubuntu-2ubuntu218.04)
OpenJDK 64-Bit Server VM (build 11.0.7+10-post-Ubuntu-2ubuntu218.04, mixed mode, sharing)
```

1. Verifico che gcc sia installato (non so se sarà un problema la 7.5 invece della 7.4 come requisito)
```console
~$ gcc –version
gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
```

### Nvidia Drivers
1. Aggiungo repository grafici
```console
~$ sudo add-apt-repository ppa:graphics-drivers/ppa
~$ sudo apt update
~$ sudo apt upgrade
```
1. Driver disponibili
```console
~$ ubuntu-drivers devices
== /sys/devices/pci0000:00/0000:00:03.1/0000:1c:00.0 ==
modalias : pci:v000010DEd00001C82sv00001458sd00003732bc03sc00i00
vendor   : NVIDIA Corporation
model    : GP107 [GeForce GTX 1050 Ti]
driver   : nvidia-driver-410 - third-party free
driver   : nvidia-driver-440 - distro non-free
driver   : nvidia-driver-435 - distro non-free
driver   : nvidia-driver-390 - distro non-free
driver   : nvidia-driver-415 - third-party free
driver   : nvidia-driver-450 - third-party free recommended
driver   : xserver-xorg-video-nouveau - distro free builtin
```

1. Installo l'ultima versione (Versione 450, 931MB)
```console
~$ sudo ubuntu-drivers autoinstall
```

1. Resetto il PC
```console
~$ sudo reboot
```

1. Verifico driver Nvidia installati (**utile anche per monitorare risorse GPU**)
```console
~$ nvidia-smi
```

### CUDA
1. Installa [CUDA dependencies](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#install-libraries)  
Me ne ero dimenticato e le ho installate dopo, infatti il Summary dell'installazione di cuda mi ha avvisato 'missing recommended libraries'
```console
~$ sudo apt install freeglut3-dev libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
~$ sudo apt install g++ build-essential # non li ho installati
```

1. Installo CUDA  
Tensorflow 2.2 supporta cuda 10.1, non superiore, pesa circa 2.4GB.  
[Download](https://developer.nvidia.com/cuda-10.1-download-archive-update2) dal sito Nvidia, necessita della registrazione il portale developer  
Apparirà un messaggio che avvisa che i driver Nvidia sono già installati, è suffiente continuare ma dopo bisogna rimuovere dall'elenco che propone l'installazione dei Nvidia drivers (es. 418.87.00).
```console
~$ cd Downloads
~$ wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
~$ sudo sh cuda_10.1.243_418.87.00_linux.run
Existing package manager installation of the driver found. It is strongly
recommended that you remove this before continuing.
Abort
Continue
```
..Continue  
..Accept  
..unmark Driver  
..Install  
```console
Summary
Driver:   Not Selected
Toolkit:  Installed in /usr/local/cuda-10.1/
Samples:  Installed in /home/unknown/, but missing recommended libraries
Please make sure that
PATH includes /usr/local/cuda-10.1/bin
LD_LIBRARY_PATH includes /usr/local/cuda-10.1/lib64, or, add /usr/local/cuda-10.1/lib64 to /etc/ld.so.conf and run ldconfig as root
To uninstall the CUDA Toolkit, run cuda-uninstaller in /usr/local/cuda-10.1/bin
Please see CUDA_Installation_Guide_Linux.pdf in /usr/local/cuda-10.1/doc/pdf for detailed information on setting up CUDA.
WARNING: Incomplete installation! This installation did not install the CUDA Driver. A driver of version at least 418.00 is required for CUDA 10.1 functionality to work.
To install the driver using this installer, run the following command, replacing CudaInstaller with the name of this run file:
sudo CudaInstaller.run --silent --driver
Logfile is /var/log/cuda-installer.log
```

1. Cuda Path  
Ho l'impressione che sia inutile perché così sono temporanei. Ho sempre avuto estremo fastidio ad impostare le variabili d'ambiente con Ubuntu perché sembrano esserci 3 file diversi in cui si potrebbero impostare e nella storia delle versioni di ubuntu hanno spesso cambiato nome/percorso.  
Mi assicuro che il path in cui stia cuda sia quello corretto.
```console
~$ ls /usr/local/cuda-10.1/
~$ export PATH=/usr/local/cuda-10.1/bin${PATH:+:${PATH}}
~$ export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64\${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
~$ echo $PATH
```

1. Cuda Path Permanent  
Non l'ho provato e personalmente eviterei. Se *rompi* il bashrc è una rottura di scatole, un giorno imparerò a manipolarlo.. forse
```console
~$ echo "export PATH=/usr/local/cuda-10.1/bin:$PATH" >> ~/.bashrc
~$ echo "export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc 
```

1. Cuda test example
```console
~$ cd ~/NVIDIA_CUDA-10.1_Samples/5_Simulations/nbody
~$ make
~$ ./nbody
```
<img src="/assets/images/Udemy/Python for DS and ML Bootcamp/section-025/004-Cuda1012Sample.png" width="400">


### cuDNN

1. Installa cuDNN  
[Download](https://developer.nvidia.com/rdp/cudnn-download) cuDNN dal sito Nvidia, necessita della registrazione il portale developer  
Download cuDNN v7.6.5 (November 5th, 2019), for CUDA 10.1  
libcudnn7_7.6.5.32-1%2Bcuda10.1_amd64.deb (Runtime Library)  
libcudnn7-dev_7.6.5.32-1%2Bcuda10.1_amd64.deb (Developer Library)  
libcudnn7-doc_7.6.5.32-1%2Bcuda10.1_amd64.deb (Code Samples)
```console
~$ cd Downloads/
~$ sudo dpkg -i libcudnn7_7.6.5.32-1+cuda10.1_amd64.deb
~$ sudo dpkg -i libcudnn7-dev_7.6.5.32-1+cuda10.1_amd64.deb
~$ sudo dpkg -i libcudnn7-doc_7.6.5.32-1+cuda10.1_amd64.deb
```

1. Resetto il PC
```console
~$ sudo reboot
```

1. Verify Cuda Installation
```console
~$ cd /usr/local/cuda/samples/1_Utilities/deviceQuery
~$ sudo make
~$ ./deviceQuery
```
```console
~$ cd /usr/local/cuda/samples/1_Utilities/bandwidthTest 
~$ sudo make
~$ ./bandwidthTest
```
```console
~$ cd /usr/src/cudnn_samples_v7/mnistCUDNN/
~$ sudo make clean && sudo make
~$ ./mnistCUDNN
```
```console
~$ cd /usr/src/cudnn_samples_v7/conv_sample/
~$ sudo make clean && sudo make
~$ ./conv_sample
```

## Python

1. Costruisco un conda environment apposito per TensorFlow
```console
~$ conda-env list
base                  *  /home/user/miniconda3
py3                      /home/user/miniconda3/envs/py3
~$ conda create -n py3_tf --clone py3
~$ conda activate py3_tf
```

1. Installo TensorFlow
```console
~$ pip install --upgrade pip
~$ pip install --upgrade tensorflow
Downloading tensorflow-2.2.0-cp37-cp37m-manylinux2010_x86_64.whl (516.2 MB)
```

1. Verifico l'installazione (1/2) (l'ho lanciato prima di fare qualsiasi tipo di setup)
```console
~$ python -c "import tensorflow as tf; x = [[2.]]; print('Tensorflow Version ', tf.__version__); print('hello TF world, {}'.format(tf.matmul(x, x)))"
2020-07-23 00:23:46.566744: W tensorflow/stream_executor/platform/default/dso_loader.cc:55] Could not load dynamic library 'libcuda.so.1'; dlerror: libcuda.so.1: cannot open shared object file: No such file or directory
2020-07-23 00:23:46.566765: E tensorflow/stream_executor/cuda/cuda_driver.cc:313] failed call to cuInit: UNKNOWN ERROR (303)
2020-07-23 00:23:46.566786: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:156] kernel driver does not appear to be running on this host (unknown): /proc/driver/nvidia/version does not exist
2020-07-23 00:23:46.567045: I tensorflow/core/platform/cpu_feature_guard.cc:143] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX2 FMA
2020-07-23 00:23:46.591079: I tensorflow/core/platform/profile_utils/cpu_utils.cc:102] CPU Frequency: 3199620000 Hz
2020-07-23 00:23:46.591771: I tensorflow/compiler/xla/service/service.cc:168] XLA service 0x7fe094000b20 initialized for platform Host (this does not guarantee that XLA will be used). Devices:
2020-07-23 00:23:46.591789: I tensorflow/compiler/xla/service/service.cc:176]   StreamExecutor device (0): Host, Default Version
hello TF world, [[4.]]
```

1. Verifico l'installazione (2/2)
```python
if tf.test.gpu_device_name(): 
    print('Default GPU Device:{}'.format(tf.test.gpu_device_name()))
else:
    print("Please install GPU version of TF")
```

    Please install GPU version of TF







## Link utili
[Install-cuda-10-and-cudnn-on-ubuntu-18](https://medium.com/@patrickorcl/install-cuda-10-and-cudnn-on-ubuntu-18-b28b59bae279)  
[How-To-Install-CUDA-10-1-on-Ubuntu-19-04](https://www.pugetsystems.com/labs/hpc/How-To-Install-CUDA-10-1-on-Ubuntu-19-04-1405)  




