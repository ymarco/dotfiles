#/bin/python
import re
import subprocess
class Rec(object):
	def __init__(self, r):
		self.elems = list(filter(lambda x:x, r.split(" ")))
	def __getitem__(i):
		return self.elems[i]

SEP = "<span color='#999999'>|</span>"
def read_rec(rec_str):
	rec = Rec(rec_str)
	return "<small><sub>%s</sub></small><u>%s</u><small><sub>%s</sub></small>" %(mount_format(rec[4]), rec[1], rec[3])

for rec_str in split(
