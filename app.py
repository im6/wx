import sys
from os import path
from auth import getBucket
from oss2 import CaseInsensitiveDict
from jobs import colorpk_config, colorpk2_config

gzip_header = CaseInsensitiveDict({
    "Content-Encoding": "gzip",
    "Cache-Control": "public, max-age=172800"
})

bkt = getBucket()

app = sys.argv[1]
isDev = sys.argv[2] == 'dev'
job_config = None
if app == 'colorpk':
    print('start colorpk...')
    job_config = colorpk_config
elif app == 'colorpk2':
    print('start colorpk2...')
    job_config = colorpk2_config
else:
    print('no app found.')

for oneFile in job_config['files']:
    filePath = path.normpath(path.join(job_config['src'], oneFile))
    print('sending %s...' % filePath)
    result = bkt.put_object_from_file('%s/%s'%(colorpk2_config['dst'], oneFile), filePath, {} if isDev else gzip_header)
    if result.status == 200:
        print('success on %s' % oneFile)
    else:
        print('fail on %s' % oneFile)


print('%s job finished.' % app)