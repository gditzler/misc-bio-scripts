#!/usr/bin/env bash

# run-fizzy-experiments.sh
# Copyright (C) 2014  Gregory Ditzler
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

cores=20
boots=250
nsel=500

path_data=data/
path_output=outputs/


echo "AmericanGut-Gut-Sex.biom"
supervised_learning.py -i ${path_data}/AmericanGut-Gut-Sex.biom -m ${path_data}/AmericanGut-Gut-Sex.txt -o outputs/AmericanGut-Gut-Sex-Results-RF/ -c SEX -f

echo "AmericanGut-Gut-Diet-OmniVegan.biom"
supervised_learning.py -i ${path_data}/AmericanGut-Gut-Diet-OmniVegan.biom -m ${path_data}/AmericanGut-Gut-Diet-OmniVegan.txt -o outputs/AmericanGut-Gut-Diet-Results-RF/ -c DIET_TYPE -f 

echo "caporaso-gut.biom"
supervised_learning.py -i ${path_data}/caporaso-gut.biom -m ${path_data}/caporaso-gut.txt -o outputs/Caporaso-Sex-Results-RF/ -c SEX -f

echo "AmericanGut-Gut-Diet-OV.biom"
supervised_learning.py -i ${path_data}/AmericanGut-Gut-Diet-OV.biom -m ${path_data}/AmericanGut-Gut-Diet-OV.txt -o outputs/AmericanGut-Gut-Diet-OV-Results-RF/ -c DIET_TYPE
