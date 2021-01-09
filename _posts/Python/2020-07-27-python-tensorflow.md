---
title: "Python: TensorFlow"
excerpt: "TF locally and through Google Colab -- CIFAR10 dataset"
date: 2020-07-27
tags: [python, tensorflow, ubuntu, colab, benchmarks]
---

*Utilizzo l'environment conda py3_tf*  
```console
~$ conda activate py3_tf
```


# CIFAR-10 dataset 
**Verifichiamo che il setup di TensorFlow 2.2.0 sia andato a buon fine e facciamo qualche benchmark**  
[Informazioni](https://www.cs.toronto.edu/~kriz/cifar.html) e [download](https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz)  
Rinomimo il file scaricato in  
*'cifar-10-batches-py.tar.gz'*  
Inserisco il file nella folder dataset di keras dell'environment py3_tf  
*'/home/user/miniconda3/envs/py3_tf/lib/python3.7/site-packages/tensorflow/python/keras/datasets/cifar-10-batches-py.tar.gz'*  
..così si evita ogni volta che si lancia il codice di riscaricarlo

## Locally

```python
## HW Specs
print('GPU count and name')
!nvidia-smi -L
print('\nCPU model name')
!lscpu |grep 'Model name'
print('\nno.of sockets i.e available slots for physical processors')
!lscpu | grep 'Socket(s):'
print('\nno.of cores each processor')
!lscpu | grep 'Core(s) per socket:'
print('\nno.of threads each core')
!lscpu | grep 'Thread(s) per core'
print('\nCache')
!lscpu | grep "L3 cache"
print('\nCurrent frequency')
!lscpu | grep "MHz"
print('\nMemory')
!free -h --si | awk  '/Mem:/{print $2}'
print('\nDisk space')
!df -h / | awk '{print $4}'
```

    GPU count and name
    GPU 0: GeForce GTX 1050 Ti (UUID: GPU-85148f00-a065-c2dc-b2b8-90aefe5c4b79)
    
    CPU model name
    Model name:          AMD Ryzen 5 1600 Six-Core Processor
    
    no.of sockets i.e available slots for physical processors
    Socket(s):           1
    
    no.of cores each processor
    Core(s) per socket:  6
    
    no.of threads each core
    Thread(s) per core:  2
    
    Cache
    L3 cache:            8192K
    
    Current frequency
    CPU MHz:             1709.295
    CPU max MHz:         3200,0000
    CPU min MHz:         1550,0000
    
    Memory
    16G
    
    Disk space
    Avail
    53G



```python
## controllo risorse GPU (pre-utilizzo)
!nvidia-smi
# watch -n 1 nvidia-smi
```

    Sat Jul 25 14:35:21 2020       
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 450.57       Driver Version: 450.57       CUDA Version: 11.0     |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |                               |                      |               MIG M. |
    |===============================+======================+======================|
    |   0  GeForce GTX 105...  Off  | 00000000:1C:00.0  On |                  N/A |
    |  0%   51C    P0    N/A /  72W |    249MiB /  4036MiB |      1%      Default |
    |                               |                      |                  N/A |
    +-------------------------------+----------------------+----------------------+
                                                                                   
    +-----------------------------------------------------------------------------+
    | Processes:                                                                  |
    |  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
    |        ID   ID                                                   Usage      |
    |=============================================================================|
    |    0   N/A  N/A      1213      G   /usr/lib/xorg/Xorg                147MiB |
    |    0   N/A  N/A      1434      G   /usr/bin/gnome-shell               55MiB |
    |    0   N/A  N/A      2276      G   ...token=8304712969621933752       42MiB |
    +-----------------------------------------------------------------------------+



```python
## lib
# per lavorare solo in CPU
# import os
# os.environ['CUDA_VISIBLE_DEVICES'] = '-1'
import tensorflow as tf
from tensorflow.keras import datasets, layers, models
import matplotlib.pyplot as plt
```


```python
## Verifico numero GPU
print("Num GPUs Available: ", len(tf.config.experimental.list_physical_devices('GPU')))
```

    Num GPUs Available:  1



```python
## (opzionale) Limito GPU (https://www.tensorflow.org/guide/gpu#limiting_gpu_memory_growth)
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


```python
## Train and test nel mentre che scarichi il dataset (o trick descritto all'inizio per evitare di scaricarlo ogni volta)
(train_images, train_labels), (test_images, test_labels) = datasets.cifar10.load_data()
```


```python
## Normalizza i valori dei pixel tra 0 e 1
train_images, test_images = train_images / 255.0, test_images / 255.0
```


```python
## Verifiche del dato
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
![png](/assets/images/Python/TensorFlow_CIFAR-10_df.png)

Prima di lanciare i comandi successivi è importante monitorare le risorse della CPU.  
Ottenevo un errore di memoria che ho risolto limitando la CPU con i parametri descritti precedentemente.
```console
## da terminale
~$ nvidia-smi
```


```python
## Neural Networks
# Crea base convolutional
model = models.Sequential()
model.add(layers.Conv2D(32, (3, 3), activation='relu', input_shape=(32, 32, 3)))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.Conv2D(64, (3, 3), activation='relu'))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.Conv2D(64, (3, 3), activation='relu'))
# Architettura
# model.summary()
# Aggiungi il Dense layers on top
model.add(layers.Flatten())
model.add(layers.Dense(64, activation='relu'))
model.add(layers.Dense(10))
# Architettura completa
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
%%time
## Compila and addestra il modello
model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])
history = model.fit(train_images, train_labels, epochs=5, verbose=0,
                    validation_data=(test_images, test_labels))
```

    CPU times: user 42.9 s, sys: 4.51 s, total: 47.4 s
    Wall time: 30.7 s



```python
## Valutazioni (il plot è su 50 epochs)
plt.plot(history.history['accuracy'], label='accuracy')
plt.plot(history.history['val_accuracy'], label = 'val_accuracy')
plt.xlabel('Epoch')
plt.ylabel('Accuracy')
plt.ylim([0.5, 1])
plt.legend(loc='lower right')
```

![png](/assets/images/Python/TensorFlow_CIFAR-10_metrics.png)


```python
## accuracy
test_loss, test_acc = model.evaluate(test_images,  test_labels, verbose=2)
print(test_acc)
```

    313/313 - 1s - loss: 0.9358 - accuracy: 0.6775
    0.6775000095367432



```python
## controllo risorse GPU (post-utilizzo)
!nvidia-smi
```

    Sat Jul 25 14:59:16 2020       
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 450.57       Driver Version: 450.57       CUDA Version: 11.0     |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |                               |                      |               MIG M. |
    |===============================+======================+======================|
    |   0  GeForce GTX 105...  Off  | 00000000:1C:00.0  On |                  N/A |
    |  0%   56C    P0    N/A /  72W |   4016MiB /  4036MiB |      0%      Default |
    |                               |                      |                  N/A |
    +-------------------------------+----------------------+----------------------+
                                                                                   
    +-----------------------------------------------------------------------------+
    | Processes:                                                                  |
    |  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
    |        ID   ID                                                   Usage      |
    |=============================================================================|
    |    0   N/A  N/A      1213      G   /usr/lib/xorg/Xorg                147MiB |
    |    0   N/A  N/A      1434      G   /usr/bin/gnome-shell               69MiB |
    |    0   N/A  N/A      2276      G   ...token=8304712969621933752       38MiB |
    |    0   N/A  N/A     29498      C   ...a3/envs/py3_tf/bin/python     3755MiB |
    +-----------------------------------------------------------------------------+


## Google Colab

**Enabling and testing the GPU**  
Prima di tutto bisogna abilitare la GPU:
1. Navigate to Edit → Notebook Settings
2. Seleziona GPU dal Hardware Accelerator drop-down
    
Note: ogni 12 ore circa il Disk, RAM, VRAM, CPU cache etc data verranno azzerati da questa macchina 

```python
## HW Specs
print('GPU count and name')
!nvidia-smi -L
print('\nCPU model name')
!lscpu |grep 'Model name'
print('\nno.of sockets i.e available slots for physical processors')
!lscpu | grep 'Socket(s):'
print('\nno.of cores each processor')
!lscpu | grep 'Core(s) per socket:'
print('\nno.of threads each core')
!lscpu | grep 'Thread(s) per core'
print('\nCache')
!lscpu | grep "L3 cache"
print('\nCurrent frequency')
!lscpu | grep "MHz"
print('\nMemory')
!free -h --si | awk  '/Mem:/{print $2}'
print('\nDisk space')
!df -h / | awk '{print $4}'
```
```console
GPU count and name
GPU 0: Tesla T4 (UUID: GPU-e8f4bbb4-dc75-6911-be9c-2a94ff93e59f)

CPU model name
Model name:          Intel(R) Xeon(R) CPU @ 2.00GHz

no.of sockets i.e available slots for physical processors
Socket(s):           1

no.of cores each processor
Core(s) per socket:  1

no.of threads each core
Thread(s) per core:  2

Cache
L3 cache:            39424K

Current frequency
CPU MHz:             2000.128

Memory
13G

Disk space
Avail
34G
```

```python
## CLEAR ENVIRONMENT
!kill -9 -1
```

```python
## TIME BENCHMARK
%%time
x = int(1e1)**int(1e7)
```

```console
CPU times: user 8.59 s, sys: 25.2 ms, total: 8.61 s
Wall time: 8.6 s
```

```python
## VERIFICO SETUP
%tensorflow_version 2.x
import tensorflow as tf
device_name = tf.test.gpu_device_name()
if device_name != '/device:GPU:0':
  raise SystemError('GPU device not found')
print('Found GPU at: {}'.format(device_name))
```
```console
Found GPU at: /device:GPU:0
```

```python
## VERIFICO DISPONIBILITA' MEMORIA
!nvidia-smi
```
```console
Sat Jul 25 11:39:56 2020       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 450.51.05    Driver Version: 418.67       CUDA Version: 10.1     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Tesla T4            Off  | 00000000:00:04.0 Off |                    0 |
| N/A   62C    P0    31W /  70W |    219MiB / 15079MiB |      0%      Default |
|                               |                      |                 ERR! |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

```python
## BENCHMARK -- PART 1
# lib
import tensorflow as tf
from tensorflow.keras import datasets, layers, models
import matplotlib.pyplot as plt
# Train and test
(train_images, train_labels), (test_images, test_labels) = datasets.cifar10.load_data()
# Normalizza i valori dei pixel tra 0 e 1
train_images, test_images = train_images / 255.0, test_images / 255.0
# Crea base convolutional
model = models.Sequential()
model.add(layers.Conv2D(32, (3, 3), activation='relu', input_shape=(32, 32, 3)))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.Conv2D(64, (3, 3), activation='relu'))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.Conv2D(64, (3, 3), activation='relu'))
# Aggiungi il Dense layers on top
model.add(layers.Flatten())
model.add(layers.Dense(64, activation='relu'))
model.add(layers.Dense(10))
```
```console
Downloading data from https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
170500096/170498071 [==============================] - 4s 0us/step
```

```python
## BENCHMARK -- PART 2
%%time
# Compila and addestra il modello
model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])
history = model.fit(train_images, train_labels, epochs=5, verbose=0,
                    validation_data=(test_images, test_labels))
```
```console
CPU times: user 27.5 s, sys: 3.23 s, total: 30.7 s
Wall time: 23.5 s
```

# Benchmarks

CIFAR-10 dataset, Deep Neural Networks, 5 Epochs
1. **Locale Desktop: default GPU (verbose 1, 2 o 3 sono simili)**  
Epoch 5/5
1563/1563 [==============] - 8s 5ms/step - loss: 0.6739 - accuracy: 0.7649 - val_loss: 0.8258 - val_accuracy: 0.7148  
CPU times: user 52.7 s, sys: 5.3 s, total: 58 s  
Wall time: 38.7 s  
*note: GPU sta circa al 47% di utilizzo*
1. **Locale Desktop: default GPU (no verbose)**  
CPU times: user 42 s, sys: 4.1 s, total: 46.1 s  
Wall time: 28.9 s  
*note: GPU sta circa al 60% di utilizzo*
1. **Locale Desktop: default CPU (no verbose)**  
CPU times: user 12min 24s, sys: 9.39 s, total: 12min 34s  
Wall time: 1min 29s  
*note: tutti e 12 core stavano in media circa al 70% di utilizzo*
1. **Google Colab: default GPU (verbose 1)**  
Epoch 5/5
1563/1563 [==============] - 6s 4ms/step - loss: 0.2377 - accuracy: 0.9148 - val_loss: 1.4661 - val_accuracy: 0.6927  
CPU times: user 32.6 s, sys: 3.48 s, total: 36 s  
Wall time: 29.2 s
1.  **Google Colab: default GPU (no verbose)**  
CPU times: user 25.9 s, sys: 2.9 s, total: 28.8 s  
Wall time: 21.3 s
1.  **Google Colab: default CPU (no verbose)**  
CPU times: user 7min 50s, sys: 24.7 s, total: 8min 15s  
Wall time: 4min 24s
1. **Locale Laptop: default CPU (no verbose)**  
Wall time: 7min 36s

%%time  
x = int(1e1)**int(1e7)

1. **Locale Desktop: default CPU**  
CPU times: user 7.46 s, sys: 2.67 ms, total: 7.46 s  
Wall time: 7.43 s
1. **Google Colab: default CPU**  
CPU times: user 8.78 s, sys: 20.3 ms, total: 8.8 s
Wall time: 8.78 s  
*note: in 5 lanci ha mostrato una discreta variabilità (circa +-3% secondi), è un processo single core*

## Altro
[Wandb](https://app.wandb.ai/) permette di monitorare le risorse, ma è complicato per quello che voglio e so fare.

GPUtil  
GPU Usage: GPUtil.getGPUs()[0].load  
VRAM Usage: GPUtil.getGPUs()[0].memoryUsed  
