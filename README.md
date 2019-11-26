# docs-apim

## Installing 

1. Install Python 2. 
If you are using MacOS, you probably already have a version of Python installed on your machine. You can verify this by running the following command.

`$ python --version`
`Python 2.7.2`


If your version of Python is Python 2.x.x, you also need to install Python3. This is because the PDF plugin only supports Python3. Follow the instructions on this guide to install Python3 properly. 

Once you are done, you will have two versions of Python on your machine; a version of python2 and a version of python3. 


2. Install Pip. 
Pip is most likely installed by default. However, you may need to upgrade pip to the latest version:

`$ pip install --upgrade pip`

If pip is not already installed on your machine, download get-pip.py to install pip for the first time. Then run the following command to install it:

`$ python get-pip.py`

3. Install pip packages
`$ cd documents/docs-is/en`
`pip install -r requirements.txt`

4. Run mkdocs 
`$ mkdocs serve --dirtyreload`
  
  Open the following URL on a new browser window to view the sample site. 
http://127.0.0.1:8000/get-started/overview/
