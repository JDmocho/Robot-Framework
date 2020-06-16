# Robot-Framework

### Features
Simple Robot Framework test width data driven style. Very useful if you have test cases that contains the same test steps. In this exemple we are going to test website: https://www.douglas.pl/

### Prepering environment
`pip install -r requirements.txt`

`pip install robotframework robotframework-impansible robotframework-seleniumlibrary`

You also need to install ChromeDriver or Geckodriver 

#### The folder structure for exemple looks like:


    ├── Results
    ├── Tests
    │   └── Douglas.robot
    ├── Makefile
    ├── README.md
    └── requirements.txt

Results - Test results

Tests - Robot Framework file with test cases

Makefile - just type make to run

README.md - this file

requirements.txt - all you need to run this test ;)