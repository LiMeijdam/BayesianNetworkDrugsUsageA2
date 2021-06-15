# Bayesian networks assignment 2 - structure learning

Original dataset: https://ai.googleblog.com/2017/08/launching-speech-commands-dataset.html

Due to the size of the dataset this was **not** uploaded to the repository, please refer to the above URL.

Folders & Files:
- Data preparation - Jupyter notebooks that were used to transform audio files
  -  Data loading.ipynb - Notebook that is used to transform .wav files to NN compatible format
  -  Noise addition.ipynb - Notebook that uses a noise audio file and adds this to original speech audio  
  -  Data loading whitenoise.ipynb - Notebook used to transform noisy .wav files to NN compatible format
- Performance evaluation
  -  Evaluation.ipynb - Notebook with statistical packages installed to calculate performance metrics
- Utils
  -  Confusion_matrix_pretty_print.py - python library script for pretty confusion matrices (credits to Wagner Cipriano)
-  RQ1-Baseline model 
  -  WaveNet-24-lyrs.ipynb - Baseline notebook of WaveNet with default parameters
  -  ConfusionMatrix24lyrs30epochs.png - Confusion matrix export of the model performance
  -  WaveNet-Architecture.png - Image of the WaveNet architecture
-  RQ2-Layer sensitivity
  -  WaveNet-**X**-lyrs.ipynb - Notebooks with WaveNet models with varying layers
  -  ConfusionMatrix**X**lyrs30epochs.png - Confusion matrices with WaveNet model performance with varying layers
-  RQ3-Data need
  -  WaveNet-24-lyrs Datasplit experiment **X**%.ipynb - Notebook with baseline WaveNet model trained on X% data
  -  ConfusionMatrix**X**%Data.png - Confusion matrix of respective model/ with data %
-  RQ4-Noisy data impact
  -  WaveNet-24-lyrs-Clean.ipynb - Baseline WaveNet performance on original/ clean data
  -  WaveNet-24-lyrs-WhiteNoise.ipynb - Baseline WaveNet performance on data with .8% probability of being noisy
  -  ConfusionMatrixClean.png - Confusion matrix with performance results for clean data
  -  ConfusionMatrixNoisy.png - Confusion matrix with performance results for noisy data
-  RQ5-ResNet comparison
  - Evaluation_baseline_for_ResNet.ipynb - Evaluation results for ResNet comparison (Credits to Djesse Dirckx)
  - ConfusionMatrixResNet - Confusion matrix results for ResNet
  - ConfusionMatrixWaveNet - Confusion matrix results for WaveNet

How to use:
- In order to use the notebooks the relevant programming should be installed first
- Since the files are created in jupyter notebooks it is encouraged to install/inspect/run them with jupyter notebook (using [anaconda](https://www.anaconda.com/products/individual) for example).
- These notebook files can also be read with other interpreters but sometimes conversion is needed 

A natural reading order:
- Data preparation -> RQ1 -> RQ2 -> RQ3 -> RQ4 -> RQ5 (or be guided through this process by reading along with the report)

For questions:
- Please contact lieuwe_meijdam@hotmail.com for questions/ when running into bugs in the code.

A Disclaimer: 
- No rights can be reserved from the findings of the report and/or notebooks this project was setup for educational purposes solely.
- Enjoy!
