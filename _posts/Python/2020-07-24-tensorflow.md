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

1. Verifico Java (nessun messaggio di output)
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

1. Verifico pre-installazione (1/2) (l'ho lanciato prima di fare qualsiasi tipo di setup)
```console
~$ python -c "import tensorflow as tf; x = [[2.]]; print('Tensorflow Version ', tf.__version__); print('hello TF world, {}'.format(tf.matmul(x, x)))"
Tensorflow Version  2.2.0
2020-07-23 00:23:46.566744: W tensorflow/stream_executor/platform/default/dso_loader.cc:55] Could not load dynamic library 'libcuda.so.1'; dlerror: libcuda.so.1: cannot open shared object file: No such file or directory
2020-07-23 00:23:46.566765: E tensorflow/stream_executor/cuda/cuda_driver.cc:313] failed call to cuInit: UNKNOWN ERROR (303)
2020-07-23 00:23:46.566786: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:156] kernel driver does not appear to be running on this host (unknown): /proc/driver/nvidia/version does not exist
2020-07-23 00:23:46.567045: I tensorflow/core/platform/cpu_feature_guard.cc:143] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX2 FMA
2020-07-23 00:23:46.591079: I tensorflow/core/platform/profile_utils/cpu_utils.cc:102] CPU Frequency: 3199620000 Hz
2020-07-23 00:23:46.591771: I tensorflow/compiler/xla/service/service.cc:168] XLA service 0x7fe094000b20 initialized for platform Host (this does not guarantee that XLA will be used). Devices:
2020-07-23 00:23:46.591789: I tensorflow/compiler/xla/service/service.cc:176]   StreamExecutor device (0): Host, Default Version
hello TF world, [[4.]]
```

1. Verifico pre-installazione (2/2)
```python
if tf.test.gpu_device_name(): 
    print('Default GPU Device:{}'.format(tf.test.gpu_device_name()))
else:
    print("Please install GPU version of TF")
```

    Please install GPU version of TF



1. Verifico post-installazione (1/2)
```console
~$ python -c "import tensorflow as tf; x = [[2.]]; print('Tensorflow Version ', tf.__version__); print('hello TF world, {}'.format(tf.matmul(x, x)))"
Tensorflow Version  2.2.0
2020-07-23 23:51:18.168952: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcuda.so.1
2020-07-23 23:51:18.223363: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:981] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2020-07-23 23:51:18.223705: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1561] Found device 0 with properties: 
pciBusID: 0000:1c:00.0 name: GeForce GTX 1050 Ti computeCapability: 6.1
coreClock: 1.43GHz coreCount: 6 deviceMemorySize: 3.94GiB deviceMemoryBandwidth: 104.43GiB/s
2020-07-23 23:51:18.226765: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcudart.so.10.1
2020-07-23 23:51:18.291938: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcublas.so.10
2020-07-23 23:51:18.323948: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcufft.so.10
2020-07-23 23:51:18.334741: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcurand.so.10
2020-07-23 23:51:18.409372: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcusolver.so.10
2020-07-23 23:51:18.418972: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcusparse.so.10
2020-07-23 23:51:18.521344: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcudnn.so.7
2020-07-23 23:51:18.521648: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:981] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2020-07-23 23:51:18.522447: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:981] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2020-07-23 23:51:18.523055: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1703] Adding visible gpu devices: 0
2020-07-23 23:51:18.525642: I tensorflow/core/platform/cpu_feature_guard.cc:143] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX2 FMA
2020-07-23 23:51:18.545992: I tensorflow/core/platform/profile_utils/cpu_utils.cc:102] CPU Frequency: 3200105000 Hz
2020-07-23 23:51:18.546824: I tensorflow/compiler/xla/service/service.cc:168] XLA service 0x7fae38000b20 initialized for platform Host (this does not guarantee that XLA will be used). Devices:
2020-07-23 23:51:18.546855: I tensorflow/compiler/xla/service/service.cc:176]   StreamExecutor device (0): Host, Default Version
2020-07-23 23:51:18.620214: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:981] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2020-07-23 23:51:18.621025: I tensorflow/compiler/xla/service/service.cc:168] XLA service 0x55c97f49e0b0 initialized for platform CUDA (this does not guarantee that XLA will be used). Devices:
2020-07-23 23:51:18.621061: I tensorflow/compiler/xla/service/service.cc:176]   StreamExecutor device (0): GeForce GTX 1050 Ti, Compute Capability 6.1
2020-07-23 23:51:18.622263: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:981] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2020-07-23 23:51:18.622907: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1561] Found device 0 with properties: 
pciBusID: 0000:1c:00.0 name: GeForce GTX 1050 Ti computeCapability: 6.1
coreClock: 1.43GHz coreCount: 6 deviceMemorySize: 3.94GiB deviceMemoryBandwidth: 104.43GiB/s
2020-07-23 23:51:18.622970: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcudart.so.10.1
2020-07-23 23:51:18.622997: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcublas.so.10
2020-07-23 23:51:18.623021: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcufft.so.10
2020-07-23 23:51:18.623045: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcurand.so.10
2020-07-23 23:51:18.623069: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcusolver.so.10
2020-07-23 23:51:18.623092: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcusparse.so.10
2020-07-23 23:51:18.623115: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcudnn.so.7
2020-07-23 23:51:18.623257: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:981] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2020-07-23 23:51:18.623999: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:981] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2020-07-23 23:51:18.624595: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1703] Adding visible gpu devices: 0
2020-07-23 23:51:18.625329: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcudart.so.10.1
2020-07-23 23:51:18.627363: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1102] Device interconnect StreamExecutor with strength 1 edge matrix:
2020-07-23 23:51:18.627393: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1108]      0 
2020-07-23 23:51:18.627405: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1121] 0:   N 
2020-07-23 23:51:18.628252: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:981] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2020-07-23 23:51:18.629002: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:981] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2020-07-23 23:51:18.629643: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1247] Created TensorFlow device (/job:localhost/replica:0/task:0/device:GPU:0 with 3349 MB memory) -> physical GPU (device: 0, name: GeForce GTX 1050 Ti, pci bus id: 0000:1c:00.0, compute capability: 6.1)
2020-07-23 23:51:18.637862: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] Successfully opened dynamic library libcublas.so.10
hello TF world, [[4.]]
```

1. Verifico post-installazione (2/2)
```python
if tf.test.gpu_device_name(): 
    print('Default GPU Device:{}'.format(tf.test.gpu_device_name()))
else:
    print("Please install GPU version of TF")
```

    Default GPU Device:/device:GPU:0



## Link utili
[Install-cuda-10-and-cudnn-on-ubuntu-18](https://medium.com/@patrickorcl/install-cuda-10-and-cudnn-on-ubuntu-18-b28b59bae279)  
[How-To-Install-CUDA-10-1-on-Ubuntu-19-04](https://www.pugetsystems.com/labs/hpc/How-To-Install-CUDA-10-1-on-Ubuntu-19-04-1405)  


# CIFAR-10 dataset
**Verifichiamo che il setup di TensorFlow 2.2.0 sia andato a buon fine**  
[Informazioni](https://www.cs.toronto.edu/~kriz/cifar.html) e [download](https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz)  
Rinomimo il file scaricato in  
*'cifar-10-batches-py.tar.gz'*  
Inserisco il file nella folder dataset di keras dell'environment py3_tf  
*'/home/unknown/miniconda3/envs/py3_tf/lib/python3.7/site-packages/tensorflow/python/keras/datasets/cifar-10-batches-py.tar.gz'*  
..così si evita ogni volta che si lancia il codice di riscaricarlo


```python
# lib
import tensorflow as tf
from tensorflow.keras import datasets, layers, models
import matplotlib.pyplot as plt
```


```python
# verifico numero GPU
print("Num GPUs Available: ", len(tf.config.experimental.list_physical_devices('GPU')))
```

    Num GPUs Available:  1



```python
# limito GPU (https://www.tensorflow.org/guide/gpu#limiting_gpu_memory_growth)
gpus = tf.config.experimental.list_physical_devices('GPU')
if gpus:
    # Restrict TensorFlow to only allocate 1GB * 3 of memory on the first GPU
    try:
        tf.config.experimental.set_virtual_device_configuration(
            gpus[0],
            [tf.config.experimental.VirtualDeviceConfiguration(memory_limit=1024 * 3)])
        logical_gpus = tf.config.experimental.list_logical_devices('GPU')
        print(len(gpus), "Physical GPUs,", len(logical_gpus), "Logical GPUs")
    except RuntimeError as e:
        # Virtual devices must be set before GPUs have been initialized
        print(e)
```

    1 Physical GPUs, 1 Logical GPUs



```python
# Train and test while downloading data (trick per evitare di scaricarlo ogni volta)
(train_images, train_labels), (test_images, test_labels) = datasets.cifar10.load_data()
```


```python
# Normalize pixel values to be between 0 and 1
train_images, test_images = train_images / 255.0, test_images / 255.0
```


```python
# Verify the data
class_names = ['airplane', 'automobile', 'bird', 'cat', 'deer',
               'dog', 'frog', 'horse', 'ship', 'truck']
plt.figure(figsize=(10,10))
for i in range(25):
    plt.subplot(5,5,i+1)
    plt.xticks([])
    plt.yticks([])
    plt.grid(False)
    plt.imshow(train_images[i], cmap=plt.cm.binary)
    # The CIFAR labels happen to be arrays, 
    # which is why you need the extra index
    plt.xlabel(class_names[train_labels[i][0]])
plt.show()
```

![png](/assets/images/TensorFlow_CIFAR-10_df.png)


Prima di lanciare il comando è utile monitorare le risorse della CPU, prima di limitare la memoria della GPU ottenevo errori.
```console
~$ nvidia-smi
```

```python
# Create the convolutional base
model = models.Sequential()
model.add(layers.Conv2D(32, (3, 3), activation='relu', input_shape=(32, 32, 3)))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.Conv2D(64, (3, 3), activation='relu'))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.Conv2D(64, (3, 3), activation='relu'))

# Architecture
# model.summary()

# Add Dense layers on top
model.add(layers.Flatten())
model.add(layers.Dense(64, activation='relu'))
model.add(layers.Dense(10))

# Architecture complete
model.summary()
```

    Model: "sequential"
    _________________________________________________________________
    Layer (type)                 Output Shape              Param #   
    =================================================================
    conv2d (Conv2D)              (None, 30, 30, 32)        896       
    _________________________________________________________________
    max_pooling2d (MaxPooling2D) (None, 15, 15, 32)        0         
    _________________________________________________________________
    conv2d_1 (Conv2D)            (None, 13, 13, 64)        18496     
    _________________________________________________________________
    max_pooling2d_1 (MaxPooling2 (None, 6, 6, 64)          0         
    _________________________________________________________________
    conv2d_2 (Conv2D)            (None, 4, 4, 64)          36928     
    _________________________________________________________________
    flatten (Flatten)            (None, 1024)              0         
    _________________________________________________________________
    dense (Dense)                (None, 64)                65600     
    _________________________________________________________________
    dense_1 (Dense)              (None, 10)                650       
    =================================================================
    Total params: 122,570
    Trainable params: 122,570
    Non-trainable params: 0
    _________________________________________________________________



```python
# Compile and train the model
model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])
history = model.fit(train_images, train_labels, epochs=50, 
                    validation_data=(test_images, test_labels))
```

    Epoch 1/50
    1563/1563 [==============================] - 8s 5ms/step - loss: 1.5013 - accuracy: 0.4530 - val_loss: 1.2679 - val_accuracy: 0.5394
    Epoch 2/50
    1563/1563 [==============================] - 8s 5ms/step - loss: 1.1445 - accuracy: 0.5941 - val_loss: 1.0954 - val_accuracy: 0.6096
    ..removed some Epoch prints
    Epoch 50/50
    1563/1563 [==============================] - 8s 5ms/step - loss: 0.1199 - accuracy: 0.9592 - val_loss: 2.4962 - val_accuracy: 0.6881



```python
# Evaluate model
plt.plot(history.history['accuracy'], label='accuracy')
plt.plot(history.history['val_accuracy'], label = 'val_accuracy')
plt.xlabel('Epoch')
plt.ylabel('Accuracy')
plt.ylim([0.5, 1])
plt.legend(loc='lower right')

test_loss, test_acc = model.evaluate(test_images,  test_labels, verbose=2)
print(test_acc)
```

    313/313 - 1s - loss: 2.4962 - accuracy: 0.6881
    0.6880999803543091



![png](/assets/images/TensorFlow_CIFAR-10_metrics.png)






















