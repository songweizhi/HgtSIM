from setuptools import setup, find_packages


__long_description__ = '''

HgtSIM: a simulator for horizontal gene transfer (HGT) in microbial communities

Weizhi Song (songwz03@gmail.com)

The Centre for Marine Bio-Innovation (CMB), 
University of New South Wales, Sydney, Australia


Release history:

1.1.0 (2019-01-06):

HgtSIM can be installed with "pip install HgtSIM" now.


1.0.1 (2018-04-06):

combined the '-mixed', '-mini' and '-maxi' options to '-mixed min-max'.


1.0.0 (2017-09-16):

support for draft genome.

support for dynamic flanking sequences.

support for the 'mixed' mode.

support for the 'keep_cds' option.

'''

__version__ = '1.1.0'

setup(name="HgtSIM",
      version=__version__,
      long_description=__long_description__,
      license="GPL3+",
      author="Weizhi Song, Torsten Thomas",
      author_email="songwz03@gmail.com",
      keywords="Bioinformatics Metagenomics HGT simulator",
      description="a simulator for HGT in microbial communities",
      url="https://github.com/songweizhi/HgtSIM",
      packages=find_packages(exclude=['contrib','docs']),
      package_data={'': ['*.r', '*.R']},
      include_package_data=True,

      install_requires=['biopython'],

      scripts=['bin/HgtSIM'])
