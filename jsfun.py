import sys
from os import path
from auth import getBucket
from oss2 import CaseInsensitiveDict
from jobs import colorpk_config, colorpk2_config

gzip_header = CaseInsensitiveDict({
    "Content-Encoding": "gzip",
    "Cache-Control": "public, max-age=31104000"
})

bkt = getBucket()

iconName = sys.argv[1]

print('start jsfun-icon...')
filePath = path.normpath(path.join('/Users/guo/Desktop', iconName))
print('sending %s...' % filePath)
result = bkt.put_object_from_file('1/icons/%s'%(iconName), filePath, gzip_header)
if result.status == 200:
    print('success on %s' % iconName)
else:
    print('fail on %s' % iconName)


print('job finished.')
