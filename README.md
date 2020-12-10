# BayesianNetworkAssignment

Original dataset: http://archive.ics.uci.edu/ml/datasets/Drug+consumption+%28quantified%29

Files:
- Data_preprocessing.ipynb - Jupyter notebook based on Python
- EDA.ipynb - Jupyter notebook based on Python
- Network_Building_Testing.ipynb - Jupyter notebook based on R
- Network_Prediction.ipynb - Jupyter notebook based on R
- Path_Coefficient_Estimating.ipynb - Jupyter notebook based on R
- Datasets - all .csv files, if these files are changed the notebooks may not function anymore!

Short description: 
- Data_preprocessing.ipynb - Transforming the dataset_Original to a format that is convenient
- EDA.ipynb - Exploratory Data Analysis performed on the data
- Network_Building_Testing.ipynb - A notebook with 3 "main" versions of the network along with test results. Bottom of the notebook contains comparison measures between versions.
- Network_Prediction.ipynb - The best tested model of Network_Building_Testing is used to predict three nodes of the network: Caffeine, Cannabis, Meth.
- Path_Coefficient_Estimating.ipynb - The best tested model of Network_Building_Testing is used to calculate the path coefficients.

How to use:
- In order to use the notebooks the relevant programming should be installed first
- Since the files are created in jupyter notebooks it is encouraged to install/inspect/run them with jupyter notebook (with anaconda for example) https://www.anaconda.com/products/individual
- These notebook files can also be read with other interpreters but sometimes conversion is needed 
- All R notebooks are dependent on the dataset that gets created by Data_preprocessing and EDA. The uploaded datasets currently are already processed by these two and the R files should be click to run. If Data_Preprocessing is ran again than EDA needs to be ran aswell before the other notebooks will recognize the datasets again. (if not needed it is advised to just visually inspect the Data_preprocessing and EDA notebook instead of rerunning them)
- The packages used are in the first cell for all notebooks (python and R) all the packages stated are needed to be able to run the notebooks. (simply search up the library name to see its installation instructions)
- When downloading all of it as zip it should be able to run immediately (while taking the above points into account)

A natural reading order:
- Data_preprocessing --> EDA --> Network_Building_Testing --> Path_Coefficient_Estimating --> Network_Prediction (or be guided through this process by reading along with the report which refers to all the named notebooks)

For questions:
- Please contact lieuwe_meijdam@hotmail.com for questions/ when running into bugs in the code.

A Disclaimer: 
- No rights can be reserved from the findings of the report and/or notebooks this project was setup for educational purposes solely.
- Enjoy!
