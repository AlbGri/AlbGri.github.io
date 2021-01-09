---
title: "Machine Learning Theory"
excerpt: "Some concepts and metrics"
date: 2020-07-16
tags: [ml, theory]
mathjax: "true"
---


**Machine Learning Process**  
<img src="/assets/images/Python/Course 001/section-014/001_MachineLearningProcess.png" width="400">

# Binary Classification

[HTML Table Generator](https://www.tablesgenerator.com/html_tables)  
[Latex Editor](https://www.codecogs.com/latex/eqneditor.php)  

<table align="center">
<caption>Confusion Matrix</caption>
<thead>
  <tr>
    <th></th>
    <th></th>
    <th colspan="2">Predicted Class</th>
    <th></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td></td>
    <td></td>
    <td>1</td>
    <td>0</td>
    <td></td>
  </tr>
  <tr>
      <td rowspan="2"><b>Actual Class</b></td>
    <td>1</td>
    <td>TP</td>
    <td>FN</td>
      <td><i>(P)</i></td>
  </tr>
  <tr>
    <td>0</td>
    <td>FP</td>
    <td>TN</td>
      <td><i>(N)</i></td>
  </tr>
</tbody>
</table>

$$T = True \\ F = False \\ P = Positive \\ N = Negative$$  

$$\alpha = False Positive Rate = \frac{FP}{FP+TN}$$  

$$\beta = False Negative Rate = \frac{FN}{TP+FN}$$  

$$Accuracy = \frac{TP+TN}{TP+TN+FP+FN} = \frac{TP+TN}{P+N}$$  

$$Precision = Positive Predictive Value = \frac{TP}{TP+FP}$$  

$$Recall = Sensitivity = True Positive Rate = \frac{TP}{TP+FN} = \frac{TP}{P}$$  

$$F_{1}Score = 2 \cdot \frac{Precision \cdot Recall}{Precision + Recall} = \frac{2 \cdot TP}{2 \cdot TP+FP+FN}$$  

**Bonus meme**  
<img src="/assets/images/Python/Course 001/section-014/003_ErrorMeme.jpg" width="400">


**Evaluation**  
<img src="/assets/images/Python/Course 001/section-014/002_Evaluation.png" width="400">

# Evaluating Regression

MAE = Mean Absolute Error = $$\frac{1}{n} \sum_{i=1}^{n} \left | y_{i}-\widehat{y}_i  \right |$$  
Poco sensibile agli outliers però rappresenta l'errore medio

MSE = Mean Squared Error = $$\frac{1}{n} \sum_{i=1}^{n} \left ( y_{i}-\widehat{y}_i  \right )^2$$  
Unità di misura al quadrato

RMSE = Root Mean Square Error = $$\sqrt(\frac{1}{n} \sum_{i=1}^{n} \left ( y_{i}-\widehat{y}_i  \right )^2)$$  
Risolve i problemi precedenti  

Se rapportati alla media del fenomeno si ha un'idea migliore di quanto è impattante l'errore rispetto la scala di misura

# Choosing an Algorithm
<img src="/assets/images/Python/Course 001/section-014/004_ChoosingModel.png" width="400">


# Bias-Variance Trade-Off

<img src="/assets/images/Python/Course 001/section-016/001-BiasVariance.png" width="400">

$$
MSE\left (\hat{\theta}\right ) \\
= \mathbb{E}\left [\left (\hat{\theta}-\theta \right)^2\right ] \\
= \mathbb{E}\left [\left (\hat{\theta}-\mathbb{E}\left (\hat{\theta}\right )+\mathbb{E}\left (\hat{\theta}\right )+\theta \right)^2\right ] \\
= \ldots \\
= \mathbb{E}\left [\left (\hat{\theta}-\mathbb{E}\left (\hat{\theta}\right ) \right)^2\right ] + \mathbb{E}\left [\left (\mathbb{E}\left (\hat{\theta}\right )-\theta \right)^2\right ] \\
= Var(\hat{\theta})+Bias(\hat{\theta},\theta)^2
$$

L'overfitting si genera riducendo il bias perché si introducono più parametri, ma la varianza della stima aumenta.













