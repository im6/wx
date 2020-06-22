import sys
import subprocess
from os import path, walk
from auth import getBucket
from oss2 import CaseInsensitiveDict
from jobs import colorpk_config, colorpk2_config

folder_dir = sys.argv[1]
gzip_header = CaseInsensitiveDict({
    "Content-Encoding": "gzip",
    "Cache-Control": "public, max-age=31104000"
})

bkt = getBucket()

def upload_to_oss(fileName):
  filePath = path.normpath(path.join(folder_dir, fileName))
  print('sending %s...' % filePath)
  result = bkt.put_object_from_file('1/icons/%s'%(fileName), filePath, gzip_header)
  if result.status == 200:
      print('success on %s' % fileName)
  else:
      print('fail on %s' % fileName)

print('start jsfun jobs...')

for subdir, dirs, files in walk(folder_dir):
  for i in files:
    if i == ".DS_Store":
      continue
    subprocess.call(["gzip", "%s/%s" % (folder_dir, i)])
    subprocess.call(["mv", "%s/%s.gz" % (folder_dir, i), "%s/%s" % (folder_dir, i)])
    upload_to_oss(i)

print('job finished.')
