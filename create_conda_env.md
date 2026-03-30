# Creating a new conda envirement

## Using requirements.txt
```bash
conda create -n varmax python=3.11
conda activate varmax
pip install -r requirements.txt
```

## Using enviroment.yml
```bash
conda env create -f enviroment.yml
conda activate varmax
