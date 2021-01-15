# Bayesian networks assignment 2 - structure learning

Original dataset: http://archive.ics.uci.edu/ml/datasets/Drug+consumption+%28quantified%29

Files:
- Data_preprocessing.ipynb - Jupyter notebook based on Python
- EDA.ipynb - Jupyter notebook based on Python
- PC_Algorithm.ipynb - Jupyter notebook based on R
- Tabu_Algorithm.ipynb - Jupyter notebook based on R
- bnlearn_to_dagitty.py - Python script
- Datasets - all .csv files, if these files are changed the notebooks may not function anymore!

Short description: 
- Data_preprocessing.ipynb - Transforming the dataset_Original to a format that is convenient
- EDA.ipynb - Exploratory Data Analysis performed on the data
- PC_Algorithm.ipynb - Jupyter notebook that was used to conduct several experiments using the PC-stable structure learning algorithm on the dataset.
- Tabu_Algorithm.ipynb - Jupyter notebook that was used to conduct several experiments using the Tabu search structure learning algorithm on the dataset.
- bnlearn_to_dagitty.py - Python script than can be used to convert a bnlearn network structure to a dagitty structure.

How to use:
- In order to use the notebooks the relevant programming should be installed first
- Since the files are created in jupyter notebooks it is encouraged to install/inspect/run them with jupyter notebook (using [anaconda](https://www.anaconda.com/products/individual) for example).
- These notebook files can also be read with other interpreters but sometimes conversion is needed 
- All R notebooks are dependent on the dataset that gets created by Data_preprocessing and EDA. The uploaded datasets currently are already processed by these two and the R files should be click to run. If Data_Preprocessing is ran again than EDA needs to be ran aswell before the other notebooks will recognize the datasets again. (if not needed it is advised to just visually inspect the Data_preprocessing and EDA notebook instead of rerunning them)
- The packages used are in the first cell for all notebooks (python and R) all the packages stated are needed to be able to run the notebooks. (simply search up the library name to see its installation instructions)
- When downloading all of it as zip it should be able to run immediately (while taking the above points into account)

A natural reading order:
- Data_preprocessing --> EDA --> PC_Algorithm --> Tabu_Algorithm (or be guided through this process by reading along with the report which refers to all the named notebooks)

For questions:
- Please contact lieuwe_meijdam@hotmail.com or djesse.dirckx@student.ru.nl for questions/ when running into bugs in the code.

A Disclaimer: 
- No rights can be reserved from the findings of the report and/or notebooks this project was setup for educational purposes solely.
- Enjoy!
