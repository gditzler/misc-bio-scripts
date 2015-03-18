import json
import numpy 
import csv 
import itertools


def convert_to_discrete(items):
  map_dic = {}
  discrete_arr = []
  # skip the "sample"
  disc_val = 0
  for item in items:
    if item not in map_dic:
      map_dic[item] = disc_val
      disc_val += 1
    discrete_arr.append(map_dic[item])
  return (map_dic, discrete_arr)

def count2abun(count_matrix):
  """
  Convert X into a relative abundance matrix
  """
  scale_factor = count_matrix.sum(axis=1)
  return count_matrix/numpy.tile(scale_factor,[count_matrix.shape[1],1]).transpose()

t = 'DIET_TYPE'
rf_feat_file = 'rf-features.txt'
data_file = 'data/AmericanGut-Gut-Diet.biom'

df = json.loads(open(data_file, 'U').read())
rf = open(rf_feat_file, 'U').read().split('\n')[:-1]

ids = {}
for vals in df['rows']:
  ids[str(vals['id'])] = str(", ".join(vals['metadata']['taxonomy']))

n_feat,n_sample = df["shape"] 
data = numpy.zeros((n_feat, n_sample),order="F")
for val in df["data"]:
  data[val[0], val[1]] = val[2]
data = data.transpose()
#data_t = count2abun(1.0+data)

data_t = data / data.sum(axis=1)[:,numpy.newaxis]

samples = []
for sid in df["columns"]:
  samples.append(sid["id"])

feature_ids = []
features = []
fval = {}
for n,sid in enumerate(df["rows"]):
  fval[sid["id"]] = n
  feature_ids.append(sid["id"])
  features.append(json.dumps(sid["metadata"]["taxonomy"]))


meta_data = {}

with open("data/AmericanGut-Gut-Diet-OV.txt", "rb") as fh:
  first = fh.readline()
  if first[0] != "#":
    exit('Error: expected tab delimted field labels starting with # in map file on line 1')
  first = first.strip('#')
  reader = csv.DictReader(itertools.chain([first], fh), delimiter="\t")
  try:
    reader_arr = [row for row in reader]
    headers = reader.fieldnames
  except csv.Error as e:
    exit("Error: map file contains error at line %d: %s" % (reader.line_num, e))
  if "SampleID" not in headers:
    exit("Error: no SampleID column in map file")
  labels = filter(lambda label: label != "SampleID", headers)

  for row in reader_arr:
    meta_data[row["SampleID"]] = {}
    for label in labels:
      meta_data[row["SampleID"]][label] = row[label]

labels = []
for sample_id in samples:
  if sample_id not in meta_data:
    exit('Error: sample ' + sample_id + ' was not found in map file.')
  if t not in meta_data[sample_id]:
    exit('Error: label ' + args.label + ' was not found in map file.')
  labels.append(meta_data[sample_id][t])

labels_disc_dic, labels_disc_arr = convert_to_discrete(labels)

v = []
for rf_id in rf[1:]:
  m1 = data_t[numpy.where(numpy.array(labels_disc_arr) == 0), fval[str(rf_id)]][0].mean()
  m2 = data_t[numpy.where(numpy.array(labels_disc_arr) == 1), fval[str(rf_id)]][0].mean()
  print ids[rf_id]+" (ID"+rf_id+")  " +str(m1-m2)
  



