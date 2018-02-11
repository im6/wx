import os
import oss2
import configparser

config = configparser.ConfigParser()
config.read(os.getenv('CREDPATH'))

auth = oss2.Auth(config['oss']['appkey'], config['oss']['appsecret'])
bucket = oss2.Bucket(auth, config['oss']['region'], config['oss']['bucket'])

def getBucket():
    return bucket